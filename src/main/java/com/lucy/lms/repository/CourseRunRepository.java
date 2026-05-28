package com.lucy.lms.repository;

import com.lucy.lms.entity.CourseRun;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CourseRunRepository extends JpaRepository<CourseRun, Long> {

    List<CourseRun> findByCourseId(Long courseId);

}