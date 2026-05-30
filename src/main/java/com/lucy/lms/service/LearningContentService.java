package com.lucy.lms.service;

import com.lucy.lms.dto.CourseContentDto;
import com.lucy.lms.dto.LessonContentDto;
import com.lucy.lms.dto.LevelContentDto;
import com.lucy.lms.entity.Chapter;
import com.lucy.lms.entity.Course;
import com.lucy.lms.entity.Lesson;
import com.lucy.lms.repository.ChapterRepository;
import com.lucy.lms.repository.CourseRepository;
import com.lucy.lms.repository.LessonRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class LearningContentService {

    private final CourseRepository courseRepository;
    private final ChapterRepository chapterRepository;
    private final LessonRepository lessonRepository;

    public LearningContentService(CourseRepository courseRepository, ChapterRepository chapterRepository, LessonRepository lessonRepository) {
        this.courseRepository = courseRepository;
        this.chapterRepository = chapterRepository;
        this.lessonRepository = lessonRepository;
    }

    public CourseContentDto getLearningContentByCourseId(Long courseId) {
        if (courseId == null) {
            return null;
        }

        Optional<Course> courseOpt = courseRepository.findById(courseId);
        if (courseOpt.isEmpty()) {
            return null; // Or throw a custom Exception like ResourceNotFoundException
        }

        Course course = courseOpt.get();
        CourseContentDto courseDto = new CourseContentDto();
        courseDto.setCourseId(course.getId());
        courseDto.setCode(course.getCode());
        courseDto.setTitle(course.getTitle());
        courseDto.setDescription(course.getDescription());
        courseDto.setLevel(course.getLevel());

        List<Chapter> chapters = chapterRepository.findByCourseIdOrderByOrderIndexAsc(courseId);
        List<LevelContentDto> levelDtos = chapters.stream().map(chapter -> {
            LevelContentDto levelDto = new LevelContentDto();
            levelDto.setChapterId(chapter.getId());
            levelDto.setLevelNumber(chapter.getOrderIndex());
            levelDto.setTitle(chapter.getTitle());
            levelDto.setDescription(chapter.getDescription());

            List<Lesson> lessons = lessonRepository.findByChapterIdOrderByOrderIndexAsc(chapter.getId());
            List<LessonContentDto> lessonDtos = lessons.stream().map(lesson -> {
                LessonContentDto lessonDto = new LessonContentDto();
                lessonDto.setLessonId(lesson.getId());
                lessonDto.setOrderIndex(lesson.getOrderIndex());
                lessonDto.setType(lesson.getType());
                lessonDto.setTitle(lesson.getTitle());
                lessonDto.setDescription(lesson.getDescription());
                lessonDto.setContentData(lesson.getContentData());
                return lessonDto;
            }).collect(Collectors.toList());

            levelDto.setLessons(lessonDtos);
            return levelDto;
        }).collect(Collectors.toList());

        courseDto.setLevels(levelDtos);
        return courseDto;
    }
}
