package com.lucy.lms.controller;

import com.lucy.lms.entity.Chapter;
import com.lucy.lms.entity.Course;
import com.lucy.lms.repository.ChapterRepository;
import com.lucy.lms.repository.CourseRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@SuppressWarnings("null")
public class ChapterWebController {

    private final ChapterRepository chapterRepository;
    private final CourseRepository courseRepository;

    public ChapterWebController(ChapterRepository chapterRepository,
                                CourseRepository courseRepository) {
        this.chapterRepository = chapterRepository;
        this.courseRepository = courseRepository;
    }

    @GetMapping("/chapters")
    public String chapters(Model model) {
        model.addAttribute("chapters", chapterRepository.findAll());
        return "chapters";
    }

    @GetMapping("/chapters/create")
    public String createChapterPage(Model model) {
        model.addAttribute("chapter", new Chapter());
        model.addAttribute("courses", courseRepository.findAll());
        return "chapter-form";
    }

    @PostMapping("/chapters/save")
    public String saveChapter(
            @RequestParam(required = false) Long id,
            @RequestParam Long courseId,
            @RequestParam String title,
            @RequestParam(required = false) String description,
            @RequestParam(required = false) Integer orderIndex
    ) {
        Chapter chapter;

        if (id != null) {
            chapter = chapterRepository.findById(id).orElse(new Chapter());
        } else {
            chapter = new Chapter();
        }

        Course course = courseRepository.findById(courseId).orElse(null);

        chapter.setCourse(course);
        chapter.setTitle(title);
        chapter.setDescription(description);
        chapter.setOrderIndex(orderIndex);

        chapterRepository.save(chapter);

        return "redirect:/chapters";
    }

    @GetMapping("/chapters/edit/{id}")
    public String editChapterPage(@PathVariable Long id, Model model) {
        Chapter chapter = chapterRepository.findById(id).orElse(null);

        if (chapter == null) {
            return "redirect:/chapters";
        }

        model.addAttribute("chapter", chapter);
        model.addAttribute("courses", courseRepository.findAll());

        return "chapter-form";
    }

    @GetMapping("/chapters/delete/{id}")
    public String deleteChapter(@PathVariable Long id) {
        chapterRepository.deleteById(id);
        return "redirect:/chapters";
    }
}