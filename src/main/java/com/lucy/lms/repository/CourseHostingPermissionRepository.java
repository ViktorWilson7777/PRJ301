package com.lucy.lms.repository;

import com.lucy.lms.entity.CourseHostingPermission;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CourseHostingPermissionRepository extends JpaRepository<CourseHostingPermission, Long> {

    Optional<CourseHostingPermission> findByUserIdAndCourseId(Long userId, Long courseId);

    boolean existsByUserIdAndCourseIdAndStatus(Long userId, Long courseId, String status);

    List<CourseHostingPermission> findByUserIdAndStatus(Long userId, String status);

    long countByUserId(Long userId);

    List<CourseHostingPermission> findByUserIdOrderByCourseProgramTitleAscCourseOrderIndexAscCourseTitleAsc(
            Long userId);
}
