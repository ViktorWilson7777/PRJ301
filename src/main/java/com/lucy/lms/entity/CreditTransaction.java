package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "credit_transaction")
@Getter
@Setter
public class CreditTransaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private AppUser user;

    private Double amount;

    @Column(columnDefinition = "NVARCHAR(30)")
    private String type; // TOP_UP, GIFT_SENT, GIFT_RECEIVED, AI_USAGE, IMPORT_USAGE, PREMIUM_PURCHASE, PODCAST_STORAGE

    @Column(columnDefinition = "NVARCHAR(500)")
    private String description;

    private LocalDateTime createdAt;

    @PrePersist
    public void prePersist() {
        if (createdAt == null) createdAt = LocalDateTime.now();
    }
}
