package com.lucy.lms.controller.api;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.lucy.lms.dto.response.ApiResponse;
import com.lucy.lms.entity.Chapter;
import com.lucy.lms.repository.ChapterRepository;

@RestController
@RequestMapping("/api/v2")
public class ChapterApiV2Controller {

    private final ChapterRepository chapterRepository;

    public ChapterApiV2Controller(ChapterRepository chapterRepository) {
        this.chapterRepository = chapterRepository;
    }

    @GetMapping("/chapters")
    public ResponseEntity<ApiResponse<List<Chapter>>> getChapters(
            @RequestParam(required = false) Long courseId
    ) {

        List<Chapter> chapters;

        if (courseId != null) {
            chapters =
                    chapterRepository
                            .findByCourseIdOrderByOrderIndexAsc(courseId);
        } else {
            chapters = chapterRepository.findAll();
        }

        return ResponseEntity.ok(
                new ApiResponse<>(
                        200,
                        "Success",
                        chapters
                )
        );
    }
}