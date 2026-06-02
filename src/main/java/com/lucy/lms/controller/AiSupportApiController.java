package com.lucy.lms.controller;

import com.lucy.lms.entity.AiGeneratedQuestion;
import com.lucy.lms.entity.AiPromptTemplate;
import com.lucy.lms.entity.Lesson;
import com.lucy.lms.repository.AiGeneratedQuestionRepository;
import com.lucy.lms.repository.AiPromptTemplateRepository;
import com.lucy.lms.repository.LessonRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;

@RestController
@SuppressWarnings("null")
@Tag(name = "AI", description = "AI Moderator Support APIs")
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

    @org.springframework.beans.factory.annotation.Value("${gemini.api.key:}")
    private String geminiApiKey;

    @PostMapping("/api/ai/suggest-questions")
    @Operation(summary = "Generate AI discussion questions for a lesson")
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

        List<String> questions = generateQuestions(lesson, promptType, promptInstruction);

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
        response.put("isMock", geminiApiKey == null || geminiApiKey.trim().isEmpty());
        response.put("questions", savedQuestions);

        return response;
    }

    @GetMapping("/api/ai/generated-questions")
    @Operation(summary = "Get AI generated questions, optionally filter by lessonId")
    public List<AiGeneratedQuestion> getGeneratedQuestions(
            @RequestParam(required = false) Long lessonId) {
        if (lessonId != null) {
            return generatedQuestionRepository.findByLessonId(lessonId);
        }
        return generatedQuestionRepository.findAll();
    }

    @SuppressWarnings({"unchecked", "rawtypes"})
    private List<String> generateQuestions(Lesson lesson, String promptType, String promptInstruction) {
        if (geminiApiKey == null || geminiApiKey.trim().isEmpty()) {
            return generateMockQuestions(lesson, promptType);
        }

        try {
            org.springframework.web.client.RestTemplate restTemplate = new org.springframework.web.client.RestTemplate();
            String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + geminiApiKey;

            String systemPrompt = "You are an English teacher assistant. Generate exactly 3 questions or conversation starters based on the topic. Return ONLY the questions, each on a new line. Do NOT include numbers, bullet points, or intro text.\n";
            String userPrompt = "Topic: " + lesson.getTitle() + "\n";
            if (lesson.getDescription() != null && !lesson.getDescription().isEmpty()) {
                userPrompt += "Content context: " + lesson.getDescription() + "\n";
            }
            if (promptInstruction != null && !promptInstruction.isEmpty()) {
                userPrompt += "Specific Instruction: " + promptInstruction + "\n";
            } else {
                userPrompt += "Task: Generate 3 '" + promptType + "' questions.";
            }

            Map<String, Object> textPart = new HashMap<>();
            textPart.put("text", systemPrompt + userPrompt);
            Map<String, Object> partMap = new HashMap<>();
            partMap.put("parts", Arrays.asList(textPart));
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("contents", Arrays.asList(partMap));

            org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
            headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);
            org.springframework.http.HttpEntity<Map<String, Object>> entity = new org.springframework.http.HttpEntity<>(requestBody, headers);

            org.springframework.http.ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);
            Map<String, Object> responseBody = response.getBody();

            if (responseBody != null && responseBody.containsKey("candidates")) {
                List<Map<String, Object>> candidates = (List<Map<String, Object>>) responseBody.get("candidates");
                if (!candidates.isEmpty()) {
                    Map<String, Object> content = (Map<String, Object>) candidates.get(0).get("content");
                    List<Map<String, Object>> parts = (List<Map<String, Object>>) content.get("parts");
                    if (!parts.isEmpty()) {
                        String text = (String) parts.get(0).get("text");
                        return Arrays.asList(text.split("\\r?\\n")).stream()
                                .map(String::trim)
                                .filter(s -> !s.isEmpty())
                                .map(s -> s.replaceFirst("^\\d+\\.\\s*", ""))
                                .map(s -> s.replaceFirst("^-\\s*", ""))
                                .map(s -> s.replaceFirst("^\\*\\s*", ""))
                                .toList();
                    }
                }
            }
            return generateMockQuestions(lesson, promptType);
        } catch (org.springframework.web.client.HttpClientErrorException e) {
            System.err.println("Gemini HTTP Error: " + e.getResponseBodyAsString());
            return generateMockQuestions(lesson, promptType);
        } catch (RuntimeException e) {
            System.err.println("Gemini API Error: " + e.getMessage());
            return generateMockQuestions(lesson, promptType);
        }
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