package com.lucy.lms.controller.api;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.lucy.lms.dto.response.ApiResponse;
import com.lucy.lms.entity.Course;
import com.lucy.lms.repository.CourseRepository;

@RestController
@RequestMapping("/api/v2")
public class CourseApiV2Controller {

    private final CourseRepository courseRepository;

    public CourseApiV2Controller(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    @GetMapping("/courses")
    public ResponseEntity<ApiResponse<List<Course>>> getCourses(
            @RequestParam(required = false) Long programId
    ) {

        List<Course> courses;

        if (programId != null) {
            courses =
                    courseRepository
                            .findByProgramIdOrderByOrderIndexAsc(programId);
        } else {
            courses = courseRepository.findAll();
        }

        return ResponseEntity.ok(
                new ApiResponse<>(
                        200,
                        "Success",
                        courses
                )
        );
    }
}