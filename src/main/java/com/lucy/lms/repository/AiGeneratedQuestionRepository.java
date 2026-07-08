package com.lucy.lms.repository;

import com.lucy.lms.entity.AiGeneratedQuestion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AiGeneratedQuestionRepository extends JpaRepository<AiGeneratedQuestion, Long> {

    List<AiGeneratedQuestion> findByLessonId(Long lessonId);

    List<AiGeneratedQuestion> findByPromptType(String promptType);

    List<AiGeneratedQuestion> findByLessonIdAndPromptType(Long lessonId, String promptType);
}
