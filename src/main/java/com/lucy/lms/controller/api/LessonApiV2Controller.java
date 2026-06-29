package com.lucy.lms.controller.api;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.lucy.lms.dto.response.ApiResponse;
import com.lucy.lms.entity.Lesson;
import com.lucy.lms.repository.LessonRepository;

@RestController
@RequestMapping("/api/v2")
public class LessonApiV2Controller {

    private final LessonRepository lessonRepository;

    public LessonApiV2Controller(LessonRepository lessonRepository) {
        this.lessonRepository = lessonRepository;
    }

    @GetMapping("/lessons")
    public ResponseEntity<ApiResponse<List<Lesson>>> getLessons(
            @RequestParam(required = false) Long chapterId
    ) {

        List<Lesson> lessons;

        if (chapterId != null) {
            lessons =
                    lessonRepository
                            .findByChapterIdOrderByOrderIndexAsc(chapterId);
        } else {
            lessons = lessonRepository.findAll();
        }

        return ResponseEntity.ok(
                new ApiResponse<>(
                        200,
                        "Success",
                        lessons
                )
        );
    }
}