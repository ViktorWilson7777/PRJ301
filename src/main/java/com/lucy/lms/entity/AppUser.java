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

    @Column(columnDefinition = "NVARCHAR(500)")
    private String avatarUrl;

    @Column(columnDefinition = "NVARCHAR(30)")
    private String role; // ADMIN, LEARNER, MODERATOR, PRO_MENTOR, SUPER_CREATOR

    @Column(columnDefinition = "NVARCHAR(30)")
    private String accountType; // LEARNER, PRO_MENTOR, CONTENT_CREATOR

    @Column(columnDefinition = "NVARCHAR(20)")
    private String registrationStatus; // APPROVED, PENDING, REJECTED

    @Column(columnDefinition = "NVARCHAR(1000)")
    private String evidenceUrl;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String achievements;

    private Long storageLimitBytes = 104857600L;

    private Long storageUsedBytes = 0L;

    private Boolean proGrantedByAdmin = false;

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
        if (accountType == null) accountType = "LEARNER";
        if (registrationStatus == null) registrationStatus = "APPROVED";
        if (storageLimitBytes == null) storageLimitBytes = 104857600L;
        if (storageUsedBytes == null) storageUsedBytes = 0L;
        if (proGrantedByAdmin == null) proGrantedByAdmin = false;
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

    public String getAccountType() { return accountType; }
    public void setAccountType(String accountType) { this.accountType = accountType; }
    public String getRegistrationStatus() { return registrationStatus; }
    public void setRegistrationStatus(String registrationStatus) { this.registrationStatus = registrationStatus; }
    public String getEvidenceUrl() { return evidenceUrl; }
    public void setEvidenceUrl(String evidenceUrl) { this.evidenceUrl = evidenceUrl; }
    public String getAchievements() { return achievements; }
    public void setAchievements(String achievements) { this.achievements = achievements; }
    public Long getStorageLimitBytes() { return storageLimitBytes; }
    public void setStorageLimitBytes(Long storageLimitBytes) { this.storageLimitBytes = storageLimitBytes; }
    public Long getStorageUsedBytes() { return storageUsedBytes; }
    public void setStorageUsedBytes(Long storageUsedBytes) { this.storageUsedBytes = storageUsedBytes; }
    public Boolean getProGrantedByAdmin() { return proGrantedByAdmin; }
    public void setProGrantedByAdmin(Boolean proGrantedByAdmin) { this.proGrantedByAdmin = proGrantedByAdmin; }
}
