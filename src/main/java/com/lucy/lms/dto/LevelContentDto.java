package com.lucy.lms.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class LevelContentDto {

    private Long chapterId;
    private Integer levelNumber;
    private String title;
    private String description;
    private List<LessonContentDto> lessons;
}
