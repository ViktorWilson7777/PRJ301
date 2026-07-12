package com.lucy.lms.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
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
    private final ObjectMapper objectMapper = new ObjectMapper();

    public AiSupportApiController(
            LessonRepository lessonRepository,
            AiPromptTemplateRepository templateRepository,
            AiGeneratedQuestionRepository generatedQuestionRepository
    ) {
        this.lessonRepository = lessonRepository;
        this.templateRepository = templateRepository;
        this.generatedQuestionRepository = generatedQuestionRepository;
    }

    @org.springframework.beans.factory.annotation.Value("${openrouter.api.key:${gemini.api.key:}}")
    private String openRouterApiKey;

    @org.springframework.beans.factory.annotation.Value("${openrouter.model:openrouter/auto}")
    private String openRouterModel;

    @PostMapping("/api/ai/suggest-topics")
    @Operation(summary = "Suggest discussion topics for the current lesson")
    public Map<String, Object> suggestTopics(@RequestParam Long lessonId) {
        return suggestQuestions(lessonId, "discussion_topic");
    }

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

        List<String> questions;
        try {
            questions = generateQuestions(lesson, promptType, promptInstruction);
        } catch (Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("message", "AI Error: " + e.getMessage());
            return error;
        }

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
        response.put("isMock", openRouterApiKey == null || openRouterApiKey.trim().isEmpty());
        response.put("questions", savedQuestions);

        return response;
    }

    @PostMapping("/api/ai/generate-quiz")
    @Operation(summary = "Generate AI multiple-choice quiz questions for a lesson")
    public Map<String, Object> generateQuiz(
            @RequestParam Long lessonId,
            @RequestParam(defaultValue = "5") Integer count
    ) {
        Lesson lesson = lessonRepository.findById(lessonId).orElse(null);

        if (lesson == null) {
            Map<String, Object> error = new HashMap<>();
            error.put("message", "Lesson not found");
            return error;
        }

        int quizCount = count == null ? 5 : Math.max(1, Math.min(count, 10));

        List<AiGeneratedQuestion> quizItems;
        try {
            quizItems = generateQuizItems(lesson, quizCount);
        } catch (Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("message", "AI Error: " + e.getMessage());
            return error;
        }

        List<AiGeneratedQuestion> savedQuestions = new ArrayList<>();
        for (AiGeneratedQuestion item : quizItems) {
            item.setLesson(lesson);
            item.setPromptType("quiz");
            item.setUsedByModerator(false);
            item.setGeneratedAt(LocalDateTime.now());
            savedQuestions.add(generatedQuestionRepository.save(item));
        }

        Map<String, Object> response = new LinkedHashMap<>();
        response.put("lessonId", lesson.getId());
        response.put("lessonTitle", lesson.getTitle());
        response.put("lessonDescription", lesson.getDescription());
        response.put("promptType", "quiz");
        response.put("isMock", openRouterApiKey == null || openRouterApiKey.trim().isEmpty());
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
    private List<String> generateQuestions(Lesson lesson, String promptType, String promptInstruction) throws Exception {
        if (openRouterApiKey == null || openRouterApiKey.trim().isEmpty()) {
            return generateMockQuestions(lesson, promptType);
        }

        try {
            org.springframework.web.client.RestTemplate restTemplate = new org.springframework.web.client.RestTemplate();
            String url = "https://openrouter.ai/api/v1/chat/completions";

            String systemPrompt = "You assist a speaking-room host when they need something useful to ask the current speaker. "
                    + "Generate exactly 3 concise, open-ended speaking questions. The questions must invite personal answers, "
                    + "match the lesson difficulty, avoid yes/no wording, and stay on the lesson topic. "
                    + "Return only one question per line with no numbering, bullets, labels, or introduction.\n";
            String userPrompt = "Topic: " + lesson.getTitle() + "\n";
            if (lesson.getDescription() != null && !lesson.getDescription().isEmpty()) {
                userPrompt += "Content context: " + lesson.getDescription() + "\n";
            }
            if (promptInstruction != null && !promptInstruction.isEmpty()) {
                userPrompt += "Specific Instruction: " + promptInstruction + "\n";
            } else if ("discussion_topic".equalsIgnoreCase(promptType)) {
                userPrompt += "Task: Write 3 short questions the host can ask the active speaker.";
            } else {
                userPrompt += "Task: Write 3 speaking questions for the '" + promptType + "' stage.";
            }
            if (lesson.getLevelNumber() != null) {
                userPrompt += "\nDifficulty level: " + lesson.getLevelNumber() + ".";
            }

            Map<String, Object> messageObj = new HashMap<>();
            messageObj.put("role", "user");
            messageObj.put("content", systemPrompt + userPrompt + "\n[Random Seed for variance: " + UUID.randomUUID().toString() + "]");
            
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("messages", Arrays.asList(messageObj));
            requestBody.put("temperature", 1.2);
            requestBody.put("model", openRouterModel);

            org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
            headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);
            headers.set("Authorization", "Bearer " + openRouterApiKey);
            headers.set("HTTP-Referer", "http://localhost:8081"); // Required by OpenRouter
            headers.set("X-Title", "LUCY LMS"); // Required by OpenRouter

            org.springframework.http.HttpEntity<Map<String, Object>> entity = new org.springframework.http.HttpEntity<>(requestBody, headers);

            org.springframework.http.ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);
            Map<String, Object> responseBody = response.getBody();

            if (responseBody != null && responseBody.containsKey("choices")) {
                List<Map<String, Object>> choices = (List<Map<String, Object>>) responseBody.get("choices");
                if (!choices.isEmpty()) {
                    Map<String, Object> msg = (Map<String, Object>) choices.get(0).get("message");
                    if (msg != null && msg.containsKey("content")) {
                        String text = (String) msg.get("content");
                        List<String> parsed = Arrays.asList(text.split("\\r?\\n")).stream()
                                .map(String::trim)
                                .filter(s -> !s.isEmpty())
                                .map(s -> s.replaceFirst("^\\d+\\.\\s*", ""))
                                .map(s -> s.replaceFirst("^-\\s*", ""))
                                .map(s -> s.replaceFirst("^\\*\\s*", ""))
                                .filter(s -> !s.isBlank())
                                .limit(3)
                                .toList();
                        return ensureThreeQuestions(parsed, lesson, promptType);
                    }
                }
            }
            return generateMockQuestions(lesson, promptType);
        } catch (org.springframework.web.client.HttpClientErrorException e) {
            System.err.println("OpenRouter HTTP Error: " + e.getStatusCode());
            throw new Exception("The AI provider rejected the request. Check the API key and model.");
        } catch (RuntimeException e) {
            System.err.println("OpenRouter API Error: " + e.getMessage());
            throw new Exception("Could not connect to the AI provider.");
        }
    }

    @SuppressWarnings({"unchecked", "rawtypes"})
    private List<AiGeneratedQuestion> generateQuizItems(Lesson lesson, int count) throws Exception {
        if (openRouterApiKey == null || openRouterApiKey.trim().isEmpty()) {
            return generateMockQuizItems(lesson, count);
        }

        try {
            org.springframework.web.client.RestTemplate restTemplate = new org.springframework.web.client.RestTemplate();
            String url = "https://openrouter.ai/api/v1/chat/completions";

            StringBuilder prompt = new StringBuilder();
            prompt.append("You are an English teacher assistant. ");
            prompt.append("Generate exactly ").append(count).append(" multiple-choice quiz questions for learners. ");
            prompt.append("Return valid JSON only, with no markdown and no explanation outside JSON. ");
            prompt.append("Schema: [{\"question\":\"...\",\"options\":{\"A\":\"...\",\"B\":\"...\",\"C\":\"...\",\"D\":\"...\"},\"correctOption\":\"A\",\"explanation\":\"...\"}]\n");
            prompt.append("Lesson title: ").append(lesson.getTitle()).append("\n");
            if (lesson.getDescription() != null && !lesson.getDescription().isEmpty()) {
                prompt.append("Lesson context: ").append(lesson.getDescription()).append("\n");
            }
            if (lesson.getContentData() != null && !lesson.getContentData().isEmpty()) {
                prompt.append("Lesson content data: ").append(lesson.getContentData()).append("\n");
            }

            Map<String, Object> messageObj = new HashMap<>();
            messageObj.put("role", "user");
            messageObj.put("content", prompt.toString() + "\n[Random Seed: " + UUID.randomUUID() + "]");

            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("messages", Arrays.asList(messageObj));
            requestBody.put("temperature", 0.8);
            requestBody.put("model", openRouterModel);

            org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
            headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);
            headers.set("Authorization", "Bearer " + openRouterApiKey);
            headers.set("HTTP-Referer", "http://localhost:8081");
            headers.set("X-Title", "LUCY LMS");

            org.springframework.http.HttpEntity<Map<String, Object>> entity = new org.springframework.http.HttpEntity<>(requestBody, headers);

            org.springframework.http.ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);
            Map<String, Object> responseBody = response.getBody();

            if (responseBody != null && responseBody.containsKey("choices")) {
                List<Map<String, Object>> choices = (List<Map<String, Object>>) responseBody.get("choices");
                if (!choices.isEmpty()) {
                    Map<String, Object> msg = (Map<String, Object>) choices.get(0).get("message");
                    if (msg != null && msg.containsKey("content")) {
                        String text = (String) msg.get("content");
                        List<AiGeneratedQuestion> parsed = parseQuizJson(text);
                        if (!parsed.isEmpty()) {
                            return parsed;
                        }
                    }
                }
            }
            return generateMockQuizItems(lesson, count);
        } catch (org.springframework.web.client.HttpClientErrorException e) {
            System.err.println("OpenRouter HTTP Error: " + e.getStatusCode());
            throw new Exception("AI provider error: " + e.getResponseBodyAsString());
        } catch (RuntimeException e) {
            System.err.println("OpenRouter API Error: " + e.getMessage());
            throw new Exception("Connection error: " + e.getMessage());
        }
    }

    private List<AiGeneratedQuestion> parseQuizJson(String text) {
        List<AiGeneratedQuestion> result = new ArrayList<>();
        String json = extractJsonArray(text);

        if (json == null || json.isBlank()) {
            return result;
        }

        try {
            List<Map<String, Object>> rows = objectMapper.readValue(json, new TypeReference<List<Map<String, Object>>>() {});
            for (Map<String, Object> row : rows) {
                AiGeneratedQuestion item = new AiGeneratedQuestion();
                item.setGeneratedQuestion(cleanString(row.get("question")));

                Object options = row.get("options");
                if (options instanceof Map<?, ?> optionMap) {
                    item.setOptionA(cleanString(optionMap.get("A")));
                    item.setOptionB(cleanString(optionMap.get("B")));
                    item.setOptionC(cleanString(optionMap.get("C")));
                    item.setOptionD(cleanString(optionMap.get("D")));
                } else if (options instanceof List<?> optionList && optionList.size() >= 4) {
                    item.setOptionA(cleanString(optionList.get(0)));
                    item.setOptionB(cleanString(optionList.get(1)));
                    item.setOptionC(cleanString(optionList.get(2)));
                    item.setOptionD(cleanString(optionList.get(3)));
                }

                item.setCorrectOption(normalizeOption(row.get("correctOption")));
                if (item.getCorrectOption() == null) {
                    item.setCorrectOption(normalizeOption(row.get("answer")));
                }
                item.setExplanation(cleanString(row.get("explanation")));

                if (isValidQuizItem(item)) {
                    result.add(item);
                }
            }
        } catch (Exception e) {
            return new ArrayList<>();
        }

        return result;
    }

    private String extractJsonArray(String text) {
        if (text == null) {
            return null;
        }

        String cleaned = text.trim();
        if (cleaned.startsWith("```")) {
            cleaned = cleaned.replaceFirst("^```(?:json)?\\s*", "");
            cleaned = cleaned.replaceFirst("\\s*```$", "");
        }

        int start = cleaned.indexOf('[');
        int end = cleaned.lastIndexOf(']');
        if (start >= 0 && end > start) {
            return cleaned.substring(start, end + 1);
        }

        return cleaned;
    }

    private boolean isValidQuizItem(AiGeneratedQuestion item) {
        return !isBlank(item.getGeneratedQuestion())
                && !isBlank(item.getOptionA())
                && !isBlank(item.getOptionB())
                && !isBlank(item.getOptionC())
                && !isBlank(item.getOptionD())
                && !isBlank(item.getCorrectOption());
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String cleanString(Object value) {
        return value == null ? null : String.valueOf(value).trim();
    }

    private String normalizeOption(Object value) {
        String option = cleanString(value);
        if (option == null || option.isEmpty()) {
            return null;
        }

        option = option.substring(0, 1).toUpperCase(Locale.ROOT);
        return Arrays.asList("A", "B", "C", "D").contains(option) ? option : null;
    }

    private List<String> generateMockQuestions(Lesson lesson, String promptType) {
        String title = lesson.getTitle();

        if ("discussion_topic".equalsIgnoreCase(promptType)) {
            return Arrays.asList(
                    "Discuss real-life examples of " + title + ".",
                    "Compare two different opinions about " + title + ".",
                    "Create a short group conversation using this lesson topic."
            );
        }

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

    private List<String> ensureThreeQuestions(List<String> generated, Lesson lesson, String promptType) {
        List<String> result = new ArrayList<>(generated == null ? List.of() : generated);
        for (String fallback : generateMockQuestions(lesson, promptType)) {
            if (result.size() >= 3) break;
            if (!result.contains(fallback)) result.add(fallback);
        }
        return result.stream().limit(3).toList();
    }

    private List<AiGeneratedQuestion> generateMockQuizItems(Lesson lesson, int count) {
        List<AiGeneratedQuestion> result = new ArrayList<>();
        String title = lesson.getTitle() != null ? lesson.getTitle() : "this lesson";

        for (int i = 1; i <= count; i++) {
            AiGeneratedQuestion item = new AiGeneratedQuestion();
            item.setGeneratedQuestion("Which answer best matches " + title + " concept " + i + "?");
            item.setOptionA("A clear and relevant answer about " + title);
            item.setOptionB("An unrelated idea");
            item.setOptionC("A grammar mistake");
            item.setOptionD("No answer");
            item.setCorrectOption("A");
            item.setExplanation("Option A is the only answer connected to the lesson topic.");
            result.add(item);
        }

        return result;
    }
}
