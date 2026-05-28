package com.lucy.lms.controller;

import com.lucy.lms.entity.Chapter;
import com.lucy.lms.entity.Lesson;
import com.lucy.lms.repository.ChapterRepository;
import com.lucy.lms.repository.LessonRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class LessonWebController {

    private final LessonRepository lessonRepository;
    private final ChapterRepository chapterRepository;

    public LessonWebController(LessonRepository lessonRepository,
                               ChapterRepository chapterRepository) {
        this.lessonRepository = lessonRepository;
        this.chapterRepository = chapterRepository;
    }

    @GetMapping("/lessons")
    public String lessons(Model model) {
        model.addAttribute("lessons", lessonRepository.findAll());
        return "lessons";
    }

    @GetMapping("/lessons/create")
    public String createLessonPage(Model model) {
        model.addAttribute("lesson", new Lesson());
        model.addAttribute("chapters", chapterRepository.findAll());
        return "lesson-form";
    }

    @PostMapping("/lessons/save")
    public String saveLesson(
            @RequestParam(required = false) Long id,
            @RequestParam Long chapterId,
            @RequestParam String type,
            @RequestParam String title,
            @RequestParam(required = false) String description,
            @RequestParam(required = false) Integer orderIndex,
            @RequestParam(required = false) String contentData
    ) {
        Lesson lesson;

        if (id != null) {
            lesson = lessonRepository.findById(id).orElse(new Lesson());
        } else {
            lesson = new Lesson();
        }

        Chapter chapter = chapterRepository.findById(chapterId).orElse(null);

        lesson.setChapter(chapter);
        lesson.setType(type);
        lesson.setTitle(title);
        lesson.setDescription(description);
        lesson.setOrderIndex(orderIndex);
        lesson.setContentData(contentData);

        lessonRepository.save(lesson);

        return "redirect:/lessons";
    }

    @GetMapping("/lessons/edit/{id}")
    public String editLessonPage(@PathVariable Long id, Model model) {
        Lesson lesson = lessonRepository.findById(id).orElse(null);

        if (lesson == null) {
            return "redirect:/lessons";
        }

        model.addAttribute("lesson", lesson);
        model.addAttribute("chapters", chapterRepository.findAll());

        return "lesson-form";
    }

    @GetMapping("/lessons/delete/{id}")
    public String deleteLesson(@PathVariable Long id) {
        lessonRepository.deleteById(id);
        return "redirect:/lessons";
    }
}