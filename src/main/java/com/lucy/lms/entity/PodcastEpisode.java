package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "podcast_episode")
@Getter
@Setter
public class PodcastEpisode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "NVARCHAR(255)")
    private String title;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private Room room;

    @ManyToOne
    @JoinColumn(name = "creator_id")
    private AppUser creator;

    @Column(columnDefinition = "NVARCHAR(500)")
    private String audioUrl; // placeholder URL, no real audio

    private Integer durationSeconds = 0;

    @Column(columnDefinition = "NVARCHAR(20)")
    private String status; // DRAFT, PUBLISHED

    private LocalDateTime createdAt;

    @PrePersist
    public void prePersist() {
        if (createdAt == null) createdAt = LocalDateTime.now();
        if (status == null) status = "DRAFT";
    }
}
