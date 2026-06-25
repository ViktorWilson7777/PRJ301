package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "pinned_material")
@Getter
@Setter
public class PinnedMaterial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private Room room;

    @ManyToOne
    @JoinColumn(name = "lesson_id")
    private Lesson lesson;

    @Column(columnDefinition = "NVARCHAR(255)")
    private String title;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String content;

    private Boolean active = true;

    private LocalDateTime pinnedAt;

    @PrePersist
    public void prePersist() {
        if (pinnedAt == null) pinnedAt = LocalDateTime.now();
    }
}
