package com.lucy.lms.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LessonContentDto {

    private Long lessonId;
    private Integer orderIndex;
    private String type;
    private String title;
    private String description;
    private String contentData;
}
