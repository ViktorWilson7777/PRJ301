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

    @Column(columnDefinition = "NVARCHAR(255)")
    private String password;

    @PrePersist
    public void prePersist() {
        if (createdAt == null) createdAt = LocalDateTime.now();
        if (password == null) password = "123456";
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getAvatarPersona() {
        return avatarPersona;
    }

    public void setAvatarPersona(String avatarPersona) {
        this.avatarPersona = avatarPersona;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Boolean getAnonymousMode() {
        return anonymousMode;
    }

    public void setAnonymousMode(Boolean anonymousMode) {
        this.anonymousMode = anonymousMode;
    }

    public Double getCreditBalance() {
        return creditBalance;
    }

    public void setCreditBalance(Double creditBalance) {
        this.creditBalance = creditBalance;
    }

    public Integer getReputationScore() {
        return reputationScore;
    }

    public void setReputationScore(Integer reputationScore) {
        this.reputationScore = reputationScore;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
