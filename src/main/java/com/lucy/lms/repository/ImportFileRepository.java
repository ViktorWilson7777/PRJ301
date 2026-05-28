package com.lucy.lms.repository;

import com.lucy.lms.entity.ImportFile;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ImportFileRepository extends JpaRepository<ImportFile, Long> {

    List<ImportFile> findByCourseId(Long courseId);

}