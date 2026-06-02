package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "billing_plan")
@Getter
@Setter
public class BillingPlan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "NVARCHAR(100)")
    private String name;

    private Double price = 0.0;

    private Integer monthlyAiLimit = 10;

    private Integer monthlyImportLimit = 5;

    private Integer maxRoomParticipants = 10;

    private Boolean allowPodcastRecording = false;

    private Boolean active = true;
}
