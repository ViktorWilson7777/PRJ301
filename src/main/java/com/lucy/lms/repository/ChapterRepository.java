package com.lucy.lms.repository;

import com.lucy.lms.entity.Chapter;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ChapterRepository extends JpaRepository<Chapter, Long> {

    List<Chapter> findByCourseIdOrderByOrderIndexAsc(Long courseId);

    Optional<Chapter> findByCourseIdAndOrderIndex(Long courseId, Integer orderIndex);

}