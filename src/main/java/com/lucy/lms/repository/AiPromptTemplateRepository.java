package com.lucy.lms.repository;

import com.lucy.lms.entity.AiPromptTemplate;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AiPromptTemplateRepository extends JpaRepository<AiPromptTemplate, Long> {

    List<AiPromptTemplate> findByLessonId(Long lessonId);

    List<AiPromptTemplate> findByLessonIdAndIsActiveTrue(Long lessonId);
}