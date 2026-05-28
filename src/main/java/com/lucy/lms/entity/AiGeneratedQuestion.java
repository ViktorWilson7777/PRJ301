package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "ai_generated_question")
@Getter
@Setter
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
    private Lesson lesson;
}