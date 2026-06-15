package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "join_request")
@Getter
@Setter
public class JoinRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private Room room;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private AppUser user;

    @Column(columnDefinition = "NVARCHAR(100)")
    private String displayName;

    @Column(columnDefinition = "NVARCHAR(20)")
    private String status; // PENDING, APPROVED, DENIED

    @Column(columnDefinition = "NVARCHAR(20)")
    private String roleRequested = "LISTENER"; // Listener by default

    private LocalDateTime requestedAt;

    private LocalDateTime respondedAt;

    @PrePersist
    public void prePersist() {
        if (requestedAt == null) requestedAt = LocalDateTime.now();
        if (status == null) status = "PENDING";
    }
}
