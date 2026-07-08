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

    @Column(name = "option_a", columnDefinition = "NVARCHAR(500)")
    private String optionA;

    @Column(name = "option_b", columnDefinition = "NVARCHAR(500)")
    private String optionB;

    @Column(name = "option_c", columnDefinition = "NVARCHAR(500)")
    private String optionC;

    @Column(name = "option_d", columnDefinition = "NVARCHAR(500)")
    private String optionD;

    @Column(columnDefinition = "NVARCHAR(1)")
    private String correctOption;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String explanation;

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
    public String getOptionA() { return optionA; }
    public String getOptionB() { return optionB; }
    public String getOptionC() { return optionC; }
    public String getOptionD() { return optionD; }
    public String getCorrectOption() { return correctOption; }
    public String getExplanation() { return explanation; }
    public Boolean getUsedByModerator() { return usedByModerator; }
    public LocalDateTime getGeneratedAt() { return generatedAt; }
    public Lesson getLesson() { return lesson; }

    // Setters
    public void setId(Long id) { this.id = id; }
    public void setPromptType(String promptType) { this.promptType = promptType; }
    public void setGeneratedQuestion(String generatedQuestion) { this.generatedQuestion = generatedQuestion; }
    public void setOptionA(String optionA) { this.optionA = optionA; }
    public void setOptionB(String optionB) { this.optionB = optionB; }
    public void setOptionC(String optionC) { this.optionC = optionC; }
    public void setOptionD(String optionD) { this.optionD = optionD; }
    public void setCorrectOption(String correctOption) { this.correctOption = correctOption; }
    public void setExplanation(String explanation) { this.explanation = explanation; }
    public void setUsedByModerator(Boolean usedByModerator) { this.usedByModerator = usedByModerator; }
    public void setGeneratedAt(LocalDateTime generatedAt) { this.generatedAt = generatedAt; }
    public void setLesson(Lesson lesson) { this.lesson = lesson; }
}
