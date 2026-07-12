package com.lucy.lms.repository;

import com.lucy.lms.entity.LessonCompletion;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface LessonCompletionRepository extends JpaRepository<LessonCompletion, Long> {
    boolean existsByUserIdAndLessonId(Long userId, Long lessonId);
    long countByUserIdAndLessonChapterCourseId(Long userId, Long courseId);
    List<LessonCompletion> findByUserIdAndLessonChapterCourseId(Long userId, Long courseId);
}
