package com.lucy.lms.controller;

import com.lucy.lms.entity.PremiumContent;
import com.lucy.lms.repository.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@SuppressWarnings("null")
public class PremiumContentWebController {

    private final PremiumContentRepository premiumRepository;
    private final AppUserRepository userRepository;
    private final CourseRepository courseRepository;
    private final ChapterRepository chapterRepository;

    public PremiumContentWebController(PremiumContentRepository premiumRepository,
                                       AppUserRepository userRepository,
                                       CourseRepository courseRepository,
                                       ChapterRepository chapterRepository) {
        this.premiumRepository = premiumRepository;
        this.userRepository = userRepository;
        this.courseRepository = courseRepository;
        this.chapterRepository = chapterRepository;
    }

    @GetMapping("/premium-content")
    public String premiumContent(Model model) {
        model.addAttribute("contents", premiumRepository.findAll());
        return "premium-content";
    }

    @GetMapping("/premium-content/create")
    public String createPage(Model model) {
        model.addAttribute("content", new PremiumContent());
        model.addAttribute("users", userRepository.findAll());
        model.addAttribute("courses", courseRepository.findAll());
        model.addAttribute("chapters", chapterRepository.findAll());
        return "premium-content-form";
    }

    @PostMapping("/premium-content/save")
    public String save(@RequestParam(required = false) Long id,
                       @RequestParam String title,
                       @RequestParam(required = false) String description,
                       @RequestParam(required = false) Long creatorId,
                       @RequestParam(required = false) Integer priceCredits,
                       @RequestParam(required = false) Long courseId,
                       @RequestParam(required = false) Long chapterId,
                       @RequestParam(required = false) String active) {
        PremiumContent content;
        if (id != null) {
            content = premiumRepository.findById(id).orElse(new PremiumContent());
        } else {
            content = new PremiumContent();
        }
        content.setTitle(title);
        content.setDescription(description);
        content.setPriceCredits(priceCredits != null ? priceCredits : 0);
        content.setActive(active != null);

        if (creatorId != null) content.setCreator(userRepository.findById(creatorId).orElse(null));
        if (courseId != null) content.setCourse(courseRepository.findById(courseId).orElse(null));
        if (chapterId != null) content.setChapter(chapterRepository.findById(chapterId).orElse(null));

        premiumRepository.save(content);
        return "redirect:/premium-content";
    }

    @GetMapping("/premium-content/edit/{id}")
    public String editPage(@PathVariable Long id, Model model) {
        PremiumContent content = premiumRepository.findById(id).orElse(null);
        if (content == null) return "redirect:/premium-content";
        model.addAttribute("content", content);
        model.addAttribute("users", userRepository.findAll());
        model.addAttribute("courses", courseRepository.findAll());
        model.addAttribute("chapters", chapterRepository.findAll());
        return "premium-content-form";
    }

    @GetMapping("/premium-content/delete/{id}")
    public String delete(@PathVariable Long id) {
        premiumRepository.deleteById(id);
        return "redirect:/premium-content";
    }
}
