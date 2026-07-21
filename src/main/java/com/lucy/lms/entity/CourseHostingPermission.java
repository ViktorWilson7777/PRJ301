package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "course_hosting_permission",
        uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "course_id"}))
@Getter
@Setter
public class CourseHostingPermission {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id")
    private AppUser user;

    @ManyToOne(optional = false)
    @JoinColumn(name = "course_id")
    private Course course;

    @Column(nullable = false, columnDefinition = "NVARCHAR(20)")
    private String status = "PENDING";

    @Column(name = "grant_source", nullable = false, columnDefinition = "NVARCHAR(30)")
    private String grantSource = "APPLICATION";

    private LocalDateTime requestedAt;

    private LocalDateTime reviewedAt;

    @ManyToOne
    @JoinColumn(name = "reviewed_by_user_id")
    private AppUser reviewedBy;

    @PrePersist
    public void prePersist() {
        if (requestedAt == null) requestedAt = LocalDateTime.now();
        if (status == null || status.isBlank()) status = "PENDING";
        if (grantSource == null || grantSource.isBlank()) grantSource = "APPLICATION";
    }
}
