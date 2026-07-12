package com.lucy.lms.repository;

import com.lucy.lms.entity.CourseCompletion;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface CourseCompletionRepository extends JpaRepository<CourseCompletion, Long> {
    boolean existsByUserIdAndCourseId(Long userId, Long courseId);
    List<CourseCompletion> findByUserIdOrderByCompletedAtDesc(Long userId);
}
