package com.lucy.lms.controller;

import com.lucy.lms.dto.CourseContentDto;
import com.lucy.lms.service.LearningContentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/learning-content")
public class LearningContentApiController {

    private final LearningContentService learningContentService;

    public LearningContentApiController(LearningContentService learningContentService) {
        this.learningContentService = learningContentService;
    }

    @GetMapping("/courses/{courseId}")
    public ResponseEntity<CourseContentDto> getCourseContent(@PathVariable Long courseId) {
        CourseContentDto courseContent = learningContentService.getLearningContentByCourseId(courseId);
        
        if (courseContent == null) {
            return ResponseEntity.notFound().build();
        }
        
        return ResponseEntity.ok(courseContent);
    }
}
