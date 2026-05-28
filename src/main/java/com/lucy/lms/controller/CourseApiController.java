package com.lucy.lms.controller;

import com.lucy.lms.entity.Course;
import com.lucy.lms.repository.CourseRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class CourseApiController {

    private final CourseRepository courseRepository;

    public CourseApiController(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    @GetMapping("/api/courses")
    public List<Course> getCourses(@RequestParam(required = false) Long programId) {
        if (programId != null) {
            return courseRepository.findByProgramIdOrderByOrderIndexAsc(programId);
        }

        return courseRepository.findAll();
    }
}