package com.lucy.lms.repository;

import com.lucy.lms.entity.Course;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CourseRepository extends JpaRepository<Course, Long> {

    List<Course> findByProgramIdOrderByOrderIndexAsc(Long programId);

    List<Course> findAllByOrderByProgramTitleAscOrderIndexAscTitleAsc();

    @org.springframework.data.jpa.repository.Query("SELECT c FROM Course c WHERE " +
            "(:keyword IS NULL OR c.code LIKE %:keyword% OR c.title LIKE %:keyword% OR c.description LIKE %:keyword%) AND " +
            "(:level IS NULL OR c.level = :level)")
    org.springframework.data.domain.Page<Course> findByFilters(
            @org.springframework.data.repository.query.Param("keyword") String keyword,
            @org.springframework.data.repository.query.Param("level") String level,
            org.springframework.data.domain.Pageable pageable);

}
