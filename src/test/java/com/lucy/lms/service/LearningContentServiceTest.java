package com.lucy.lms.service;

import com.lucy.lms.dto.CourseContentDto;
import com.lucy.lms.entity.Course;
import com.lucy.lms.repository.ChapterRepository;
import com.lucy.lms.repository.CourseRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class LearningContentServiceTest {

    @Mock
    private CourseRepository courseRepository;

    @Mock
    private ChapterRepository chapterRepository;

    @InjectMocks
    private LearningContentService learningContentService;

    private Course course;

    @BeforeEach
    public void setUp() {
        course = new Course();
        course.setId(1L);
        course.setCode("JAVA101");
        course.setTitle("Java Basics");
    }

    @Test
    void getLearningContentByCourseId_WhenCourseExists_ShouldReturnCourseContentDto() {
        // Arrange: Mock the behavior of repositories
        when(courseRepository.findById(1L)).thenReturn(Optional.of(course));
        when(chapterRepository.findByCourseIdOrderByOrderIndexAsc(1L)).thenReturn(new ArrayList<>());

        // Act: Call the service method
        CourseContentDto result = learningContentService.getLearningContentByCourseId(1L);

        // Assert: Verify the result
        assertNotNull(result);
        assertEquals(1L, result.getCourseId());
        assertEquals("JAVA101", result.getCode());
        assertEquals("Java Basics", result.getTitle());
        assertTrue(result.getLevels().isEmpty()); // We mocked empty chapters
        
        // Verify that the repositories were called
        verify(courseRepository, times(1)).findById(1L);
        verify(chapterRepository, times(1)).findByCourseIdOrderByOrderIndexAsc(1L);
    }

    @Test
    void getLearningContentByCourseId_WhenCourseDoesNotExist_ShouldReturnNull() {
        // Arrange
        when(courseRepository.findById(99L)).thenReturn(Optional.empty());

        // Act
        CourseContentDto result = learningContentService.getLearningContentByCourseId(99L);

        // Assert
        assertNull(result);
        verify(courseRepository, times(1)).findById(99L);
        verify(chapterRepository, never()).findByCourseIdOrderByOrderIndexAsc(anyLong());
    }
    
    @Test
    void getLearningContentByCourseId_WhenCourseIdIsNull_ShouldReturnNull() {
        // Act
        CourseContentDto result = learningContentService.getLearningContentByCourseId(null);

        // Assert
        assertNull(result);
        verify(courseRepository, never()).findById(anyLong());
    }
}
