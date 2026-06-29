package com.lucy.lms.controller.api;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lucy.lms.dto.CourseContentDto;
import com.lucy.lms.dto.response.ApiResponse;
import com.lucy.lms.service.LearningContentService;

@RestController
@RequestMapping("/api/v2/learning-content")
public class LearningContentApiV2Controller {

    private final LearningContentService learningContentService;

    public LearningContentApiV2Controller(
            LearningContentService learningContentService
    ) {
        this.learningContentService = learningContentService;
    }

    @GetMapping("/courses/{courseId}")
    public ResponseEntity<ApiResponse<CourseContentDto>>
    getCourseContent(@PathVariable Long courseId) {

        CourseContentDto dto =
                learningContentService
                        .getLearningContentByCourseId(courseId);

        if (dto == null) {

            return ResponseEntity.status(404)
                    .body(
                            new ApiResponse<>(
                                    404,
                                    "Course not found",
                                    null
                            )
                    );
        }

        return ResponseEntity.ok(
                new ApiResponse<>(
                        200,
                        "Success",
                        dto
                )
        );
    }
}