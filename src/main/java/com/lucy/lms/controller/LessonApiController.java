package com.lucy.lms.controller;

import com.lucy.lms.entity.Lesson;
import com.lucy.lms.repository.LessonRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.tags.Tag;

import java.util.List;

@RestController
@Tag(name = "LMS", description = "Learning Management System APIs")
public class LessonApiController {

    private final LessonRepository lessonRepository;

    public LessonApiController(LessonRepository lessonRepository) {
        this.lessonRepository = lessonRepository;
    }

    @GetMapping("/api/lessons")
    public List<Lesson> getLessons(@RequestParam(required = false) Long chapterId) {
        if (chapterId != null) {
            return lessonRepository.findByChapterIdOrderByOrderIndexAsc(chapterId);
        }

        return lessonRepository.findAll();
    }
}