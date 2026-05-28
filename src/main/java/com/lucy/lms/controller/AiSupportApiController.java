package com.lucy.lms.controller;

import com.lucy.lms.entity.AiGeneratedQuestion;
import com.lucy.lms.entity.AiPromptTemplate;
import com.lucy.lms.entity.Lesson;
import com.lucy.lms.repository.AiGeneratedQuestionRepository;
import com.lucy.lms.repository.AiPromptTemplateRepository;
import com.lucy.lms.repository.LessonRepository;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;

@RestController
public class AiSupportApiController {

    private final LessonRepository lessonRepository;
    private final AiPromptTemplateRepository templateRepository;
    private final AiGeneratedQuestionRepository generatedQuestionRepository;

    public AiSupportApiController(
            LessonRepository lessonRepository,
            AiPromptTemplateRepository templateRepository,
            AiGeneratedQuestionRepository generatedQuestionRepository
    ) {
        this.lessonRepository = lessonRepository;
        this.templateRepository = templateRepository;
        this.generatedQuestionRepository = generatedQuestionRepository;
    }

    @PostMapping("/api/ai/suggest-questions")
    public Map<String, Object> suggestQuestions(
            @RequestParam Long lessonId,
            @RequestParam(defaultValue = "discussion") String promptType
    ) {
        Lesson lesson = lessonRepository.findById(lessonId).orElse(null);

        if (lesson == null) {
            Map<String, Object> error = new HashMap<>();
            error.put("message", "Lesson not found");
            return error;
        }

        List<AiPromptTemplate> templates =
                templateRepository.findByLessonIdAndIsActiveTrue(lessonId);

        String promptInstruction = null;

        for (AiPromptTemplate template : templates) {
            if (template.getPromptType().equalsIgnoreCase(promptType)) {
                promptInstruction = template.getPromptInstruction();
                break;
            }
        }

        List<String> questions = generateMockQuestions(lesson, promptType);

        List<AiGeneratedQuestion> savedQuestions = new ArrayList<>();

        for (String questionText : questions) {
            AiGeneratedQuestion question = new AiGeneratedQuestion();
            question.setLesson(lesson);
            question.setPromptType(promptType);
            question.setGeneratedQuestion(questionText);
            question.setUsedByModerator(false);
            question.setGeneratedAt(LocalDateTime.now());

            savedQuestions.add(generatedQuestionRepository.save(question));
        }

        Map<String, Object> response = new LinkedHashMap<>();
        response.put("lessonId", lesson.getId());
        response.put("lessonTitle", lesson.getTitle());
        response.put("lessonDescription", lesson.getDescription());
        response.put("promptType", promptType);
        response.put("promptInstruction", promptInstruction);
        response.put("questions", savedQuestions);

        return response;
    }

    private List<String> generateMockQuestions(Lesson lesson, String promptType) {
        String title = lesson.getTitle();

        if ("warmup".equalsIgnoreCase(promptType)) {
            return Arrays.asList(
                    "What do you know about " + title + "?",
                    "Can you say one simple sentence about " + title + "?",
                    "How do you feel about this topic?"
            );
        }

        if ("ice_breaker".equalsIgnoreCase(promptType)) {
            return Arrays.asList(
                    "Can you share something fun about this topic?",
                    "Do you have any personal experience with " + title + "?",
                    "What is the first word you think of when you hear " + title + "?"
            );
        }

        if ("practice".equalsIgnoreCase(promptType)) {
            return Arrays.asList(
                    "Please answer using one complete sentence.",
                    "Can you repeat your answer more clearly?",
                    "Can you make one more sentence about " + title + "?"
            );
        }

        if ("wrapup".equalsIgnoreCase(promptType)) {
            return Arrays.asList(
                    "What did you learn from this lesson?",
                    "Which sentence was useful today?",
                    "Can you summarize this topic in one sentence?"
            );
        }

        return Arrays.asList(
                "Can you talk about " + title + "?",
                "Can you give one example?",
                "Can you ask your friend one question about this topic?"
        );
    }
}