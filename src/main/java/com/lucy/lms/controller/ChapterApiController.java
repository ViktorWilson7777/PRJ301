package com.lucy.lms.controller;

import com.lucy.lms.entity.Chapter;
import com.lucy.lms.repository.ChapterRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ChapterApiController {

    private final ChapterRepository chapterRepository;

    public ChapterApiController(ChapterRepository chapterRepository) {
        this.chapterRepository = chapterRepository;
    }

    @GetMapping("/api/chapters")
    public List<Chapter> getChapters(@RequestParam(required = false) Long courseId) {
        if (courseId != null) {
            return chapterRepository.findByCourseIdOrderByOrderIndexAsc(courseId);
        }

        return chapterRepository.findAll();
    }
}