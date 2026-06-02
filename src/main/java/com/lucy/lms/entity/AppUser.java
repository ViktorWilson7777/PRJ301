package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "app_user")
@Getter
@Setter
public class AppUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "NVARCHAR(255)")
    private String fullName;

    @Column(columnDefinition = "NVARCHAR(255)")
    private String email;

    @Column(columnDefinition = "NVARCHAR(100)")
    private String displayName;

    @Column(columnDefinition = "NVARCHAR(100)")
    private String avatarPersona;

    @Column(columnDefinition = "NVARCHAR(30)")
    private String role; // ADMIN, LEARNER, MODERATOR, PRO_MENTOR, SUPER_CREATOR

    private Boolean anonymousMode = false;

    private Double creditBalance = 0.0;

    private Integer reputationScore = 0;

    private LocalDateTime createdAt;

    private Boolean active = true;

    @PrePersist
    public void prePersist() {
        if (createdAt == null) createdAt = LocalDateTime.now();
    }
}
