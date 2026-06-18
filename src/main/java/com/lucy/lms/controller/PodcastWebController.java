package com.lucy.lms.controller;

import com.lucy.lms.entity.PodcastEpisode;
import com.lucy.lms.repository.AppUserRepository;
import com.lucy.lms.repository.PodcastEpisodeRepository;
import com.lucy.lms.repository.RoomRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@SuppressWarnings("null")
public class PodcastWebController {

    private final PodcastEpisodeRepository podcastRepository;
    private final RoomRepository roomRepository;
    private final AppUserRepository userRepository;

    public PodcastWebController(PodcastEpisodeRepository podcastRepository,
                                RoomRepository roomRepository,
                                AppUserRepository userRepository) {
        this.podcastRepository = podcastRepository;
        this.roomRepository = roomRepository;
        this.userRepository = userRepository;
    }

    @GetMapping("/podcasts")
    public String podcasts(Model model, jakarta.servlet.http.HttpSession session) {
        com.lucy.lms.entity.AppUser currentUser = (com.lucy.lms.entity.AppUser) session.getAttribute("currentUser");
        boolean isAdmin = currentUser != null && ("ADMIN".equals(currentUser.getRole()) || "SUPER_CREATOR".equals(currentUser.getRole()));

        if (isAdmin) {
            model.addAttribute("podcasts", podcastRepository.findAll());
            return "podcasts";
        } else {
            model.addAttribute("podcasts", podcastRepository.findByStatus("PUBLISHED"));
            return "podcast-player";
        }
    }

    @GetMapping("/podcasts/create")
    public String createPodcastPage(Model model) {
        model.addAttribute("podcast", new PodcastEpisode());
        model.addAttribute("rooms", roomRepository.findAll());
        model.addAttribute("users", userRepository.findAll());
        return "podcast-form";
    }

    @PostMapping("/podcasts/save")
    public String savePodcast(@RequestParam(required = false) Long id,
                              @RequestParam String title,
                              @RequestParam(required = false) String description,
                              @RequestParam(required = false) Long roomId,
                              @RequestParam(required = false) Long creatorId,
                              @RequestParam(required = false) String audioUrl,
                              @RequestParam(required = false) Integer durationSeconds,
                              @RequestParam String status) {
        PodcastEpisode podcast;
        if (id != null) {
            podcast = podcastRepository.findById(id).orElse(new PodcastEpisode());
        } else {
            podcast = new PodcastEpisode();
        }
        podcast.setTitle(title);
        podcast.setDescription(description);
        podcast.setStatus(status);
        podcast.setAudioUrl(audioUrl != null && !audioUrl.isBlank() ? audioUrl : "https://example.com/mock-podcast-" + System.currentTimeMillis() + ".mp3");
        podcast.setDurationSeconds(durationSeconds != null ? durationSeconds : 0);

        if (roomId != null) podcast.setRoom(roomRepository.findById(roomId).orElse(null));
        if (creatorId != null) podcast.setCreator(userRepository.findById(creatorId).orElse(null));

        podcastRepository.save(podcast);
        return "redirect:/podcasts";
    }

    @GetMapping("/podcasts/edit/{id}")
    public String editPodcastPage(@PathVariable Long id, Model model) {
        PodcastEpisode podcast = podcastRepository.findById(id).orElse(null);
        if (podcast == null) return "redirect:/podcasts";
        model.addAttribute("podcast", podcast);
        model.addAttribute("rooms", roomRepository.findAll());
        model.addAttribute("users", userRepository.findAll());
        return "podcast-form";
    }

    @GetMapping("/podcasts/publish/{id}")
    public String publishPodcast(@PathVariable Long id) {
        PodcastEpisode podcast = podcastRepository.findById(id).orElse(null);
        if (podcast != null) {
            podcast.setStatus("PUBLISHED");
            podcastRepository.save(podcast);
        }
        return "redirect:/podcasts";
    }

    @GetMapping("/podcasts/delete/{id}")
    public String deletePodcast(@PathVariable Long id) {
        podcastRepository.deleteById(id);
        return "redirect:/podcasts";
    }
}
