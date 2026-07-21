package com.lucy.lms.controller;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.entity.PodcastEpisode;
import com.lucy.lms.repository.AppUserRepository;
import com.lucy.lms.repository.PodcastEpisodeRepository;
import com.lucy.lms.service.PodcastFavoriteService;
import com.lucy.lms.service.PodcastStorageService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@SuppressWarnings("null")
public class PodcastWebController {

    private final PodcastEpisodeRepository podcastRepository;
    private final AppUserRepository userRepository;
    private final PodcastFavoriteService favoriteService;
    private final PodcastStorageService storageService;

    @Value("${podcast.upload.dir:uploads/podcasts}")
    private String podcastUploadDir;

    public PodcastWebController(PodcastEpisodeRepository podcastRepository,
                                AppUserRepository userRepository,
                                PodcastFavoriteService favoriteService,
                                PodcastStorageService storageService) {
        this.podcastRepository = podcastRepository;
        this.userRepository = userRepository;
        this.favoriteService = favoriteService;
        this.storageService = storageService;
    }

    /**
     * Check if the user has podcast creator privileges.
     */
    private boolean canCreatePodcast(AppUser user) {
        if (user == null) return false;
        String role = user.getRole();
        return "CONTENT_CREATOR".equals(user.getAccountType())
                || "SUPER_CREATOR".equals(role) || "ADMIN".equals(role);
    }

    private boolean canManagePodcast(AppUser user, PodcastEpisode podcast) {
        if (user == null || podcast == null) return false;
        if ("ADMIN".equals(user.getRole())) return true;
        return canCreatePodcast(user)
                && podcast.getCreator() != null
                && user.getId().equals(podcast.getCreator().getId());
    }

    @GetMapping("/podcasts")
    public String podcasts(Model model, HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";
        boolean isAdmin = "ADMIN".equals(currentUser.getRole());

        if (isAdmin) {
            // Only administrators can manage every creator's podcasts.
            List<PodcastEpisode> podcasts = podcastRepository.findAll();
            backfillFileSizes(podcasts);
            model.addAttribute("podcasts", podcasts);
            model.addAttribute("canManage", true);
            model.addAttribute("managementMode", "admin");
            return "podcasts";
        } else {
            return podcastPlayer(model, currentUser,
                    podcastRepository.findByStatusOrderByCreatedAtDesc("PUBLISHED"), "search", "");
        }
    }

    @GetMapping("/podcasts/mine")
    public String myPodcasts(Model model, HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";
        if (!canCreatePodcast(currentUser)) {
            return "redirect:/podcasts?error=access_denied";
        }

        AppUser freshUser = storageService.ensureDefaultQuota(currentUser.getId());
        if (freshUser == null) return "redirect:/login";
        List<PodcastEpisode> podcasts = podcastRepository
                .findByCreatorIdOrderByCreatedAtDesc(freshUser.getId());
        synchronizeStorageUsage(freshUser, podcasts);
        session.setAttribute("currentUser", freshUser);

        model.addAttribute("currentUser", freshUser);
        model.addAttribute("podcasts", podcasts);
        model.addAttribute("canManage", true);
        model.addAttribute("managementMode", "own");
        addStorageModel(model, freshUser);
        return "podcasts";
    }

    @PostMapping("/podcasts/storage/buy")
    public String buyPodcastStorage(HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (!canCreatePodcast(currentUser)) {
            return "redirect:/podcasts?error=access_denied";
        }

        PodcastStorageService.PurchaseResult result = storageService
                .purchaseExpansion(currentUser.getId());
        if (result == PodcastStorageService.PurchaseResult.USER_NOT_FOUND) {
            return "redirect:/login";
        }

        AppUser freshUser = userRepository.findById(currentUser.getId()).orElse(currentUser);
        session.setAttribute("currentUser", freshUser);
        if (result == PodcastStorageService.PurchaseResult.INSUFFICIENT_CREDITS) {
            return "redirect:/podcasts/mine?error=insufficient_credits";
        }
        return "redirect:/podcasts/mine?success=storage_added";
    }

    @GetMapping("/podcasts/search")
    public String searchPodcasts(@RequestParam(required = false, defaultValue = "") String keyword,
                                 Model model,
                                 HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        String normalizedKeyword = keyword.trim();
        return podcastPlayer(model, currentUser,
                podcastRepository.searchPublished(normalizedKeyword), "search", normalizedKeyword);
    }

    @GetMapping("/podcasts/library")
    public String podcastLibrary(Model model, HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        return podcastPlayer(model, currentUser,
                favoriteService.getLibrary(currentUser.getId()), "library", "");
    }

    @PostMapping("/podcasts/{id}/favorite")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleFavorite(@PathVariable Long id,
                                                               HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) {
            return ResponseEntity.status(401).body(Map.of("error", "login_required"));
        }

        AppUser user = userRepository.findById(currentUser.getId()).orElse(null);
        PodcastEpisode podcast = podcastRepository.findById(id).orElse(null);
        if (user == null || podcast == null || !"PUBLISHED".equals(podcast.getStatus())) {
            return ResponseEntity.notFound().build();
        }

        boolean favorite = favoriteService.toggle(user, podcast);
        return ResponseEntity.ok(Map.of("podcastId", id, "favorite", favorite));
    }

    private String podcastPlayer(Model model,
                                 AppUser currentUser,
                                 List<PodcastEpisode> podcasts,
                                 String viewMode,
                                 String keyword) {
        AppUser freshUser = userRepository.findById(currentUser.getId()).orElse(currentUser);
        model.addAttribute("currentUser", freshUser);
        model.addAttribute("podcasts", podcasts);
        model.addAttribute("viewMode", viewMode);
        model.addAttribute("keyword", keyword);
        model.addAttribute("favoritePodcastIds", favoriteService.getFavoritePodcastIds(freshUser.getId()));
        model.addAttribute("canCreatePodcast", canCreatePodcast(freshUser));
        return "podcast-player";
    }

    @GetMapping("/podcasts/create")
    public String createPodcastPage(Model model, HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (!canCreatePodcast(currentUser)) {
            return "redirect:/podcasts?error=access_denied";
        }
        model.addAttribute("podcast", new PodcastEpisode());
        model.addAttribute("manageUrl", managementPath(currentUser));
        return "podcast-form";
    }

    @PostMapping("/podcasts/save")
    public String savePodcast(@RequestParam(required = false) Long id,
                              @RequestParam String title,
                              @RequestParam(required = false) String description,
                              @RequestParam(required = false, name = "audioFile") MultipartFile audioFile,
                              @RequestParam String status,
                              @RequestParam(required = false) String isPremium,
                              HttpSession session) {

        AppUser sessionUser = (AppUser) session.getAttribute("currentUser");
        AppUser currentUser = sessionUser == null ? null
                : userRepository.findById(sessionUser.getId()).orElse(null);
        if (!canCreatePodcast(currentUser)) {
            return "redirect:/podcasts?error=access_denied";
        }

        PodcastEpisode podcast;
        if (id != null) {
            podcast = podcastRepository.findById(id).orElse(null);
            if (podcast == null) return "redirect:/podcasts?error=not_found";
            if (!canManagePodcast(currentUser, podcast)) {
                return "redirect:/podcasts?error=access_denied";
            }
        } else {
            podcast = new PodcastEpisode();
        }

        podcast.setTitle(title);
        podcast.setDescription(description);
        podcast.setStatus(status);
        podcast.setIsPremium(isPremium != null);
        podcast.setPrice(0);
        podcast.setRoom(null);

        AppUser storageOwner = podcast.getCreator() != null
                ? storageService.ensureDefaultQuota(podcast.getCreator().getId())
                : storageService.ensureDefaultQuota(currentUser.getId());
        if (storageOwner == null) return "redirect:/login";

        List<PodcastEpisode> ownerPodcasts = podcastRepository
                .findByCreatorIdOrderByCreatedAtDesc(storageOwner.getId());
        synchronizeStorageUsage(storageOwner, ownerPodcasts);

        String previousAudioUrl = podcast.getAudioUrl();
        long previousSize = podcastFileSize(podcast);
        boolean audioReplaced = false;
        if (audioFile != null && !audioFile.isEmpty()) {
            try {
                validateMp3(audioFile, storageOwner, podcast);
                String audioUrl = saveAudioFile(audioFile);
                podcast.setAudioUrl(audioUrl);
                podcast.setFileSizeBytes(audioFile.getSize());
                audioReplaced = true;
            } catch (IOException e) {
                return podcastFormError(id, "upload_failed");
            } catch (IllegalArgumentException e) {
                return podcastFormError(id, e.getMessage());
            }
        } else if (podcast.getAudioUrl() == null || podcast.getAudioUrl().isBlank()) {
            return podcastFormError(id, "mp3_required");
        }

        // Auto-set creator to current user for new podcasts
        if (podcast.getCreator() == null) {
            podcast.setCreator(currentUser);
        }

        podcastRepository.save(podcast);
        if (audioReplaced) {
            long used = storageOwner.getStorageUsedBytes() == null ? 0L : storageOwner.getStorageUsedBytes();
            storageOwner.setStorageUsedBytes(Math.max(0L, used - previousSize + audioFile.getSize()));
            userRepository.save(storageOwner);
            if (previousAudioUrl != null && !previousAudioUrl.equals(podcast.getAudioUrl())) {
                deleteAudioFile(previousAudioUrl);
            }
        }
        if (storageOwner.getId().equals(currentUser.getId())) {
            session.setAttribute("currentUser", storageOwner);
        }
        return managementRedirect(currentUser);
    }

    /**
     * Save uploaded audio file and return the URL path.
     */
    private String saveAudioFile(MultipartFile file) throws IOException {
        Path uploadPath = Paths.get(podcastUploadDir).toAbsolutePath().normalize();
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        String originalFilename = file.getOriginalFilename();
        String safeFilename = System.currentTimeMillis() + "_" +
                (originalFilename != null ? originalFilename.replaceAll("[^a-zA-Z0-9._-]", "_") : "audio.mp3");

        Path filePath = uploadPath.resolve(safeFilename);
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        return "/uploads/podcasts/" + safeFilename;
    }

    private void validateMp3(MultipartFile file, AppUser user, PodcastEpisode podcast) {
        String filename = file.getOriginalFilename() == null ? "" : file.getOriginalFilename().toLowerCase();
        String contentType = file.getContentType() == null ? "" : file.getContentType().toLowerCase();
        if (!filename.endsWith(".mp3")
                || !(contentType.equals("audio/mpeg") || contentType.equals("audio/mp3")
                || contentType.equals("application/octet-stream"))) {
            throw new IllegalArgumentException("invalid_mp3");
        }
        if (file.getSize() > 20L * 1024 * 1024) {
            throw new IllegalArgumentException("audio_too_large");
        }
        long previousSize = podcastFileSize(podcast);
        long used = user.getStorageUsedBytes() == null ? 0L : user.getStorageUsedBytes();
        long limit = user.getStorageLimitBytes() == null
                ? PodcastStorageService.BASE_STORAGE_BYTES : user.getStorageLimitBytes();
        if (Math.max(0L, used - previousSize) + file.getSize() > limit) {
            throw new IllegalArgumentException("storage_limit");
        }
    }

    private long existingFileSize(String audioUrl) {
        Path file = resolveAudioFile(audioUrl);
        if (file == null) return 0L;
        try {
            return Files.exists(file) ? Files.size(file) : 0L;
        } catch (IOException e) {
            return 0L;
        }
    }

    private Path resolveAudioFile(String audioUrl) {
        if (audioUrl == null || !audioUrl.startsWith("/uploads/podcasts/")) return null;
        String filename = audioUrl.substring("/uploads/podcasts/".length());
        if (filename.isBlank() || filename.contains("/") || filename.indexOf((char) 92) >= 0) return null;

        Path uploadPath = Paths.get(podcastUploadDir).toAbsolutePath().normalize();
        Path file = uploadPath.resolve(filename).normalize();
        return file.startsWith(uploadPath) ? file : null;
    }

    private void deleteAudioFile(String audioUrl) {
        Path file = resolveAudioFile(audioUrl);
        if (file == null) return;
        try {
            Files.deleteIfExists(file);
        } catch (IOException ignored) {
            // The database entry is still removed even if an orphaned file cannot be deleted.
        }
    }

    private long podcastFileSize(PodcastEpisode podcast) {
        if (podcast == null) return 0L;
        Long storedSize = podcast.getFileSizeBytes();
        return storedSize != null && storedSize > 0L
                ? storedSize : existingFileSize(podcast.getAudioUrl());
    }

    private void backfillFileSizes(List<PodcastEpisode> podcasts) {
        List<PodcastEpisode> changed = new ArrayList<>();
        for (PodcastEpisode podcast : podcasts) {
            if (podcast.getFileSizeBytes() == null || podcast.getFileSizeBytes() <= 0L) {
                long actualSize = existingFileSize(podcast.getAudioUrl());
                if (actualSize > 0L) {
                    podcast.setFileSizeBytes(actualSize);
                    changed.add(podcast);
                }
            }
        }
        if (!changed.isEmpty()) {
            podcastRepository.saveAll(changed);
        }
    }

    private void synchronizeStorageUsage(AppUser user, List<PodcastEpisode> podcasts) {
        backfillFileSizes(podcasts);
        long usedBytes = podcasts.stream().mapToLong(this::podcastFileSize).sum();
        long currentUsed = user.getStorageUsedBytes() == null ? 0L : user.getStorageUsedBytes();
        if (currentUsed != usedBytes) {
            user.setStorageUsedBytes(usedBytes);
            userRepository.save(user);
        }
    }

    private void addStorageModel(Model model, AppUser user) {
        long used = user.getStorageUsedBytes() == null ? 0L : user.getStorageUsedBytes();
        long limit = user.getStorageLimitBytes() == null
                ? PodcastStorageService.BASE_STORAGE_BYTES : user.getStorageLimitBytes();
        double percent = limit == 0L ? 0.0 : Math.min(100.0, used * 100.0 / limit);
        model.addAttribute("storageUsedBytes", used);
        model.addAttribute("storageLimitBytes", limit);
        model.addAttribute("storagePercent", percent);
        model.addAttribute("storageExpansionBytes", PodcastStorageService.STORAGE_EXPANSION_BYTES);
        model.addAttribute("storageExpansionCost", (long) PodcastStorageService.STORAGE_EXPANSION_COST);
    }

    private String managementPath(AppUser user) {
        return user != null && "ADMIN".equals(user.getRole()) ? "/podcasts" : "/podcasts/mine";
    }

    private String managementRedirect(AppUser user) {
        return "redirect:" + managementPath(user);
    }

    private String podcastFormError(Long id, String error) {
        return id == null
                ? "redirect:/podcasts/create?error=" + error
                : "redirect:/podcasts/edit/" + id + "?error=" + error;
    }

    @GetMapping("/podcasts/edit/{id}")
    public String editPodcastPage(@PathVariable Long id, Model model, HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        PodcastEpisode podcast = podcastRepository.findById(id).orElse(null);
        if (podcast == null) return "redirect:/podcasts";
        if (!canManagePodcast(currentUser, podcast)) {
            return "redirect:/podcasts?error=access_denied";
        }

        model.addAttribute("podcast", podcast);
        model.addAttribute("manageUrl", managementPath(currentUser));
        return "podcast-form";
    }

    @GetMapping("/podcasts/publish/{id}")
    public String publishPodcast(@PathVariable Long id, HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        PodcastEpisode podcast = podcastRepository.findById(id).orElse(null);
        if (!canManagePodcast(currentUser, podcast)) {
            return "redirect:/podcasts?error=access_denied";
        }
        podcast.setStatus("PUBLISHED");
        podcastRepository.save(podcast);
        return managementRedirect(currentUser);
    }

    @PostMapping("/podcasts/buy/{id}")
    public String buyPodcast(@PathVariable Long id, HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        PodcastEpisode podcast = podcastRepository.findById(id).orElse(null);
        AppUser user = userRepository.findById(currentUser.getId()).orElse(null);

        if (podcast != null && user != null && Boolean.TRUE.equals(podcast.getIsPremium())) {
            if (!podcast.getUnlockedByUsers().contains(user)) {
                if (user.getCreditBalance() >= podcast.getPrice()) {
                    user.setCreditBalance(user.getCreditBalance() - podcast.getPrice());
                    podcast.getUnlockedByUsers().add(user);
                    userRepository.save(user);
                    podcastRepository.save(podcast);
                    session.setAttribute("currentUser", user);
                    return "redirect:/podcasts?success=unlocked";
                } else {
                    return "redirect:/podcasts?error=insufficient_credits";
                }
            }
        }
        return "redirect:/podcasts";
    }

    @GetMapping("/podcasts/delete/{id}")
    public String deletePodcast(@PathVariable Long id, HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        PodcastEpisode podcast = podcastRepository.findById(id).orElse(null);
        if (!canManagePodcast(currentUser, podcast)) {
            return "redirect:/podcasts?error=access_denied";
        }

        long fileSize = podcastFileSize(podcast);
        String audioUrl = podcast.getAudioUrl();
        AppUser creator = podcast.getCreator() == null ? null
                : userRepository.findById(podcast.getCreator().getId()).orElse(null);
        favoriteService.removeForPodcast(id);
        podcastRepository.deleteById(id);
        if (creator != null) {
            long used = creator.getStorageUsedBytes() == null ? 0L : creator.getStorageUsedBytes();
            creator.setStorageUsedBytes(Math.max(0L, used - fileSize));
            userRepository.save(creator);
            if (creator.getId().equals(currentUser.getId())) {
                session.setAttribute("currentUser", creator);
            }
        }
        deleteAudioFile(audioUrl);
        return managementRedirect(currentUser);
    }
}
