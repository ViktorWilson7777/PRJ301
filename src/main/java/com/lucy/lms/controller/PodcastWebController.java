package com.lucy.lms.controller;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.entity.PodcastEpisode;
import com.lucy.lms.repository.AppUserRepository;
import com.lucy.lms.repository.PodcastEpisodeRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Controller
@SuppressWarnings("null")
public class PodcastWebController {

    private final PodcastEpisodeRepository podcastRepository;
    private final AppUserRepository userRepository;

    @Value("${podcast.upload.dir:uploads/podcasts}")
    private String podcastUploadDir;

    public PodcastWebController(PodcastEpisodeRepository podcastRepository,
                                AppUserRepository userRepository) {
        this.podcastRepository = podcastRepository;
        this.userRepository = userRepository;
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

    @GetMapping("/podcasts")
    public String podcasts(Model model, HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        String role = currentUser != null ? currentUser.getRole() : "LEARNER";

        boolean isAdmin = "ADMIN".equals(role) || "SUPER_CREATOR".equals(role)
                || (currentUser != null && "CONTENT_CREATOR".equals(currentUser.getAccountType()));

        if (isAdmin) {
            // Admin/Super Creator sees ALL podcasts in manage view
            model.addAttribute("podcasts", podcastRepository.findAll());
            model.addAttribute("canManage", true);
            return "podcasts";
        } else {
            // LEARNER and PRO_MENTOR: player-only view with published podcasts
            AppUser freshUser = currentUser != null ? userRepository.findById(currentUser.getId()).orElse(currentUser) : null;
            model.addAttribute("currentUser", freshUser);
            model.addAttribute("podcasts", podcastRepository.findByStatus("PUBLISHED"));
            model.addAttribute("canCreatePodcast", false);
            return "podcast-player";
        }
    }

    @GetMapping("/podcasts/create")
    public String createPodcastPage(Model model, HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (!canCreatePodcast(currentUser)) {
            return "redirect:/podcasts?error=access_denied";
        }
        model.addAttribute("podcast", new PodcastEpisode());
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

        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (!canCreatePodcast(currentUser)) {
            return "redirect:/podcasts?error=access_denied";
        }

        PodcastEpisode podcast;
        if (id != null) {
            podcast = podcastRepository.findById(id).orElse(new PodcastEpisode());
        } else {
            podcast = new PodcastEpisode();
        }

        podcast.setTitle(title);
        podcast.setDescription(description);
        podcast.setStatus(status);
        podcast.setIsPremium(isPremium != null);
        podcast.setPrice(0);
        podcast.setRoom(null);

        AppUser freshUser = userRepository.findById(currentUser.getId()).orElse(currentUser);
        if (audioFile != null && !audioFile.isEmpty()) {
            try {
                validateMp3(audioFile, freshUser, podcast);
                String audioUrl = saveAudioFile(audioFile);
                long previousSize = existingFileSize(podcast.getAudioUrl());
                podcast.setAudioUrl(audioUrl);
                freshUser.setStorageUsedBytes(Math.max(0L,
                        (freshUser.getStorageUsedBytes() == null ? 0L : freshUser.getStorageUsedBytes())
                                - previousSize + audioFile.getSize()));
                userRepository.save(freshUser);
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
            podcast.setCreator(freshUser);
        }

        podcastRepository.save(podcast);
        return "redirect:/podcasts";
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
        long previousSize = existingFileSize(podcast.getAudioUrl());
        long used = user.getStorageUsedBytes() == null ? 0L : user.getStorageUsedBytes();
        long limit = user.getStorageLimitBytes() == null ? 104857600L : user.getStorageLimitBytes();
        if (used - previousSize + file.getSize() > limit) {
            throw new IllegalArgumentException("storage_limit");
        }
    }

    private long existingFileSize(String audioUrl) {
        if (audioUrl == null || !audioUrl.startsWith("/uploads/podcasts/")) return 0L;
        try {
            Path file = Paths.get(podcastUploadDir)
                    .resolve(audioUrl.substring(audioUrl.lastIndexOf('/') + 1))
                    .toAbsolutePath().normalize();
            return Files.exists(file) ? Files.size(file) : 0L;
        } catch (IOException e) {
            return 0L;
        }
    }

    private String podcastFormError(Long id, String error) {
        return id == null
                ? "redirect:/podcasts/create?error=" + error
                : "redirect:/podcasts/edit/" + id + "?error=" + error;
    }

    @GetMapping("/podcasts/edit/{id}")
    public String editPodcastPage(@PathVariable Long id, Model model, HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (!canCreatePodcast(currentUser)) {
            return "redirect:/podcasts?error=access_denied";
        }

        PodcastEpisode podcast = podcastRepository.findById(id).orElse(null);
        if (podcast == null) return "redirect:/podcasts";

        model.addAttribute("podcast", podcast);
        return "podcast-form";
    }

    @GetMapping("/podcasts/publish/{id}")
    public String publishPodcast(@PathVariable Long id, HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (!canCreatePodcast(currentUser)) {
            return "redirect:/podcasts?error=access_denied";
        }

        PodcastEpisode podcast = podcastRepository.findById(id).orElse(null);
        if (podcast != null) {
            podcast.setStatus("PUBLISHED");
            podcastRepository.save(podcast);
        }
        return "redirect:/podcasts";
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
        if (!canCreatePodcast(currentUser)) {
            return "redirect:/podcasts?error=access_denied";
        }

        PodcastEpisode podcast = podcastRepository.findById(id).orElse(null);
        if (podcast != null) {
            podcastRepository.deleteById(id);
        }
        return "redirect:/podcasts";
    }
}
