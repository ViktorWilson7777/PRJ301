package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

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

    private Long fileSizeBytes = 0L;

    private Integer durationSeconds = 0;

    @Column(columnDefinition = "NVARCHAR(20)")
    private String status; // DRAFT, PUBLISHED

    private LocalDateTime createdAt;

    private Boolean isPremium = false;

    private Integer price = 0; // Credit cost if premium

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "podcast_unlocks",
        joinColumns = @JoinColumn(name = "podcast_id"),
        inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private Set<AppUser> unlockedByUsers = new HashSet<>();

    @PrePersist
    public void prePersist() {
        if (createdAt == null) createdAt = LocalDateTime.now();
        if (status == null) status = "DRAFT";
        if (isPremium == null) isPremium = false;
        if (price == null) price = 0;
        if (fileSizeBytes == null) fileSizeBytes = 0L;
    }

    @PreUpdate
    public void preUpdate() {
        if (fileSizeBytes == null) fileSizeBytes = 0L;
    }
}
