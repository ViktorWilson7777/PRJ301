package com.lucy.lms.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "ai_generated_question")
public class AiGeneratedQuestion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "NVARCHAR(50)")
    private String promptType;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String generatedQuestion;

    private Boolean usedByModerator = false;

    private LocalDateTime generatedAt;

    @ManyToOne
    @JoinColumn(name = "lesson_id")
    @JsonIgnore
    private Lesson lesson;

    // Getters
    public Long getId() { return id; }
    public String getPromptType() { return promptType; }
    public String getGeneratedQuestion() { return generatedQuestion; }
    public Boolean getUsedByModerator() { return usedByModerator; }
    public LocalDateTime getGeneratedAt() { return generatedAt; }
    public Lesson getLesson() { return lesson; }

    // Setters
    public void setId(Long id) { this.id = id; }
    public void setPromptType(String promptType) { this.promptType = promptType; }
    public void setGeneratedQuestion(String generatedQuestion) { this.generatedQuestion = generatedQuestion; }
    public void setUsedByModerator(Boolean usedByModerator) { this.usedByModerator = usedByModerator; }
    public void setGeneratedAt(LocalDateTime generatedAt) { this.generatedAt = generatedAt; }
    public void setLesson(Lesson lesson) { this.lesson = lesson; }
}