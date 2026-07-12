package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "user_program_level",
        uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "program_id"}))
@Getter
@Setter
public class UserProgramLevel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id")
    private AppUser user;

    @ManyToOne(optional = false)
    @JoinColumn(name = "program_id")
    private Program program;

    private Integer levelNumber = 1;
    private Integer experiencePoints = 0;
    private Integer maxHostingLevel = 0;

    @PrePersist
    @PreUpdate
    public void defaults() {
        if (levelNumber == null || levelNumber < 1) levelNumber = 1;
        if (experiencePoints == null || experiencePoints < 0) experiencePoints = 0;
        if (maxHostingLevel == null || maxHostingLevel < 0) maxHostingLevel = 0;
    }
}
