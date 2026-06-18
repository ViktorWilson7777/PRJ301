package com.lucy.lms.controller;

import com.lucy.lms.repository.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    private final ProgramRepository programRepository;
    private final CourseRepository courseRepository;
    private final ChapterRepository chapterRepository;
    private final LessonRepository lessonRepository;
    private final ImportFileRepository importFileRepository;
    private final AiGeneratedQuestionRepository aiQuestionRepository;
    private final AppUserRepository appUserRepository;
    private final RoomRepository roomRepository;
    private final GiftTransactionRepository giftTransactionRepository;
    private final PodcastEpisodeRepository podcastEpisodeRepository;

    public DashboardController(ProgramRepository programRepository,
                               CourseRepository courseRepository,
                               ChapterRepository chapterRepository,
                               LessonRepository lessonRepository,
                               ImportFileRepository importFileRepository,
                               AiGeneratedQuestionRepository aiQuestionRepository,
                               AppUserRepository appUserRepository,
                               RoomRepository roomRepository,
                               GiftTransactionRepository giftTransactionRepository,
                               PodcastEpisodeRepository podcastEpisodeRepository) {
        this.programRepository = programRepository;
        this.courseRepository = courseRepository;
        this.chapterRepository = chapterRepository;
        this.lessonRepository = lessonRepository;
        this.importFileRepository = importFileRepository;
        this.aiQuestionRepository = aiQuestionRepository;
        this.appUserRepository = appUserRepository;
        this.roomRepository = roomRepository;
        this.giftTransactionRepository = giftTransactionRepository;
        this.podcastEpisodeRepository = podcastEpisodeRepository;
    }

    @GetMapping("/")
    public String root() {
        return "redirect:/dashboard";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("programCount", programRepository.count());
        model.addAttribute("courseCount", courseRepository.count());
        model.addAttribute("chapterCount", chapterRepository.count());
        model.addAttribute("lessonCount", lessonRepository.count());
        model.addAttribute("importFileCount", importFileRepository.count());
        model.addAttribute("aiQuestionCount", aiQuestionRepository.count());
        model.addAttribute("userCount", appUserRepository.count());
        model.addAttribute("roomCount", roomRepository.count());
        model.addAttribute("giftTxCount", giftTransactionRepository.count());
        model.addAttribute("podcastCount", podcastEpisodeRepository.count());

        return "dashboard";
    }
}
