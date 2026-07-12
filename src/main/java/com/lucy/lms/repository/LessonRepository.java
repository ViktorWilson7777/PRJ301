package com.lucy.lms.repository;

import com.lucy.lms.entity.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface LessonRepository extends JpaRepository<Lesson, Long> {
    long countByChapterCourseId(Long courseId);

    List<Lesson> findByChapterIdOrderByOrderIndexAsc(Long chapterId);

    Optional<Lesson> findByChapterIdAndOrderIndex(Long chapterId, Integer orderIndex);

    List<Lesson> findByChapterIdAndLevelNumberOrderByOrderIndexAsc(Long chapterId, Integer levelNumber);

    List<Lesson> findByChapterIdAndLevelNumberLessThanEqualOrderByOrderIndexAsc(Long chapterId, Integer levelNumber);

}
