package com.lucy.lms.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CourseContentDto {

    private Long courseId;
    private String code;
    private String title;
    private String description;
    private String level;
    private List<LevelContentDto> levels;
}
