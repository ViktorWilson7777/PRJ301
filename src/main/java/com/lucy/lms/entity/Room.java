package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "room")
@Getter
@Setter
public class Room {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "NVARCHAR(255)")
    private String title;

    @Column(columnDefinition = "NVARCHAR(10)")
    private String languageCode;

    private Integer levelNumber;

    @Column(columnDefinition = "NVARCHAR(20)")
    private String roomType; // PUBLIC, PRO_CLASS, PREMIUM

    @Column(columnDefinition = "NVARCHAR(20)")
    private String status; // SCHEDULED, LIVE, ENDED

    @ManyToOne
    @JoinColumn(name = "host_user_id")
    private AppUser hostUser;

    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;

    @ManyToOne
    @JoinColumn(name = "chapter_id")
    private Chapter chapter;

    @ManyToOne
    @JoinColumn(name = "current_lesson_id")
    private Lesson currentLesson;

    private LocalDateTime stageStartedAt;

    private Boolean isRecording = false;

    private LocalDateTime recordingStartedAt;

    private Integer maxParticipants = 20;

    private LocalDateTime startedAt;

    private LocalDateTime endedAt;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String description;
}
