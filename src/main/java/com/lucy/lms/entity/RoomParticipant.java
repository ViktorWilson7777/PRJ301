package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "room_participant")
@Getter
@Setter
public class RoomParticipant {

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

    private Boolean micOn = false;

    private Boolean micAllowed = false;

    private LocalDateTime speakingStartedAt;

    private Integer speakingSeconds = 0;

    private Integer awardedExperience = 0;

    private Boolean handRaised = false;

    @Column(columnDefinition = "NVARCHAR(20)")
    private String roleInRoom; // HOST, MODERATOR, SPEAKER, LISTENER

    private LocalDateTime joinedAt;

    private LocalDateTime leftAt;

    @PrePersist
    public void prePersist() {
        if (joinedAt == null) joinedAt = LocalDateTime.now();
    }
}
