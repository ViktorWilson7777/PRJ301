package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "ai_prompt_template")
@Getter
@Setter
public class AiPromptTemplate {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "NVARCHAR(50)")
    private String promptType;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String promptInstruction;

    private Boolean isActive = true;

    @ManyToOne
    @JoinColumn(name = "lesson_id")
    private Lesson lesson;
}