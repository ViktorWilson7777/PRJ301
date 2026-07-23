package com.lucy.lms.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "gift")
@Getter
@Setter
public class Gift {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "NVARCHAR(100)")
    private String name;

    @Column(columnDefinition = "NVARCHAR(50)")
    private String icon; // legacy fallback label; stickers use imageUrl

    @Column(length = 500)
    private String imageUrl;

    private Integer creditCost = 2000;

    private Boolean active = true;
}
