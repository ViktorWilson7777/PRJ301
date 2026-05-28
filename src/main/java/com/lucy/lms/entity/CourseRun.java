package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "course_run")
@Getter
@Setter
public class CourseRun {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String code;

    private String status;

    private LocalDateTime startsAt;

    private LocalDateTime endsAt;

    private Integer capacity;

    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;
}