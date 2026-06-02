package com.lucy.lms.controller;

import com.lucy.lms.dto.CourseContentDto;
import com.lucy.lms.entity.Chapter;
import com.lucy.lms.entity.Lesson;
import com.lucy.lms.repository.ChapterRepository;
import com.lucy.lms.repository.LessonRepository;
import com.lucy.lms.service.LearningContentService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Tag(name = "LMS", description = "Learning Management System APIs")
public class LearningContentApiController {

    private final LearningContentService learningContentService;
    private final ChapterRepository chapterRepository;
    private final LessonRepository lessonRepository;

    public LearningContentApiController(LearningContentService learningContentService,
                                        ChapterRepository chapterRepository,
                                        LessonRepository lessonRepository) {
        this.learningContentService = learningContentService;
        this.chapterRepository = chapterRepository;
        this.lessonRepository = lessonRepository;
    }

    @GetMapping("/api/learning-content/courses/{courseId}")
    @Operation(summary = "Get nested learning content by course ID (path)")
    public ResponseEntity<CourseContentDto> getCourseContent(@PathVariable Long courseId) {
        CourseContentDto courseContent = learningContentService.getLearningContentByCourseId(courseId);
        if (courseContent == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(courseContent);
    }

    @GetMapping("/api/learning-content")
    @Operation(summary = "Get nested learning content by courseId query param")
    public ResponseEntity<CourseContentDto> getLearningContent(@RequestParam Long courseId) {
        CourseContentDto courseContent = learningContentService.getLearningContentByCourseId(courseId);
        if (courseContent == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(courseContent);
    }

    @GetMapping("/api/courses/{courseId}/levels")
    @Operation(summary = "Get chapters (levels) for a course")
    public List<Chapter> getCourseLevels(@PathVariable Long courseId) {
        return chapterRepository.findByCourseIdOrderByOrderIndexAsc(courseId);
    }

    @GetMapping("/api/levels/{chapterId}/lessons")
    @Operation(summary = "Get lessons for a chapter (level)")
    public List<Lesson> getLevelLessons(@PathVariable Long chapterId) {
        return lessonRepository.findByChapterIdOrderByOrderIndexAsc(chapterId);
    }
}
