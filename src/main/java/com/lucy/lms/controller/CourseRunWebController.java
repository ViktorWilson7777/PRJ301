package com.lucy.lms.controller;

import com.lucy.lms.entity.Course;
import com.lucy.lms.entity.CourseRun;
import com.lucy.lms.repository.CourseRepository;
import com.lucy.lms.repository.CourseRunRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
@SuppressWarnings("null")
public class CourseRunWebController {

    private final CourseRunRepository courseRunRepository;
    private final CourseRepository courseRepository;

    public CourseRunWebController(CourseRunRepository courseRunRepository,
                                  CourseRepository courseRepository) {
        this.courseRunRepository = courseRunRepository;
        this.courseRepository = courseRepository;
    }

    @GetMapping("/course-runs")
    public String courseRuns(Model model) {
        model.addAttribute("courseRuns", courseRunRepository.findAll());
        return "course-runs";
    }

    @GetMapping("/course-runs/create")
    public String createCourseRunPage(Model model) {
        model.addAttribute("courseRun", new CourseRun());
        model.addAttribute("courses", courseRepository.findAll());
        return "course-run-form";
    }

    @PostMapping("/course-runs/save")
    public String saveCourseRun(
            @RequestParam(required = false) Long id,
            @RequestParam Long courseId,
            @RequestParam String code,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String startsAt,
            @RequestParam(required = false) String endsAt,
            @RequestParam(required = false) Integer capacity
    ) {
        CourseRun courseRun;

        if (id != null) {
            courseRun = courseRunRepository.findById(id).orElse(new CourseRun());
        } else {
            courseRun = new CourseRun();
        }

        Course course = courseRepository.findById(courseId).orElse(null);

        courseRun.setCourse(course);
        courseRun.setCode(code);
        courseRun.setStatus(status);
        courseRun.setCapacity(capacity);

        if (startsAt != null && !startsAt.isBlank()) {
            courseRun.setStartsAt(LocalDateTime.parse(startsAt));
        }

        if (endsAt != null && !endsAt.isBlank()) {
            courseRun.setEndsAt(LocalDateTime.parse(endsAt));
        }

        courseRunRepository.save(courseRun);

        return "redirect:/course-runs";
    }

    @GetMapping("/course-runs/edit/{id}")
    public String editCourseRunPage(@PathVariable Long id, Model model) {
        CourseRun courseRun = courseRunRepository.findById(id).orElse(null);

        if (courseRun == null) {
            return "redirect:/course-runs";
        }

        model.addAttribute("courseRun", courseRun);
        model.addAttribute("courses", courseRepository.findAll());

        return "course-run-form";
    }

    @GetMapping("/course-runs/delete/{id}")
    public String deleteCourseRun(@PathVariable Long id) {
        courseRunRepository.deleteById(id);
        return "redirect:/course-runs";
    }
}