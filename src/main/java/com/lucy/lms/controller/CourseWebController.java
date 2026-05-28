package com.lucy.lms.controller;

import com.lucy.lms.entity.Course;
import com.lucy.lms.entity.Program;
import com.lucy.lms.repository.CourseRepository;
import com.lucy.lms.repository.ProgramRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class CourseWebController {

    private final CourseRepository courseRepository;
    private final ProgramRepository programRepository;

    public CourseWebController(CourseRepository courseRepository,
                               ProgramRepository programRepository) {
        this.courseRepository = courseRepository;
        this.programRepository = programRepository;
    }

    @GetMapping("/courses")
    public String courses(Model model) {
        model.addAttribute("courses", courseRepository.findAll());
        return "courses";
    }

    @GetMapping("/courses/create")
    public String createCoursePage(Model model) {
        model.addAttribute("course", new Course());
        model.addAttribute("programs", programRepository.findAll());
        return "course-form";
    }

    @PostMapping("/courses/save")
    public String saveCourse(
            @RequestParam(required = false) Long id,
            @RequestParam Long programId,
            @RequestParam String code,
            @RequestParam String title,
            @RequestParam(required = false) String level,
            @RequestParam(required = false) Integer orderIndex,
            @RequestParam(required = false) String description
    ) {
        Course course;

        if (id != null) {
            course = courseRepository.findById(id).orElse(new Course());
        } else {
            course = new Course();
        }

        Program program = programRepository.findById(programId).orElse(null);

        course.setProgram(program);
        course.setCode(code);
        course.setTitle(title);
        course.setLevel(level);
        course.setOrderIndex(orderIndex);
        course.setDescription(description);

        courseRepository.save(course);

        return "redirect:/courses";
    }

    @GetMapping("/courses/edit/{id}")
    public String editCoursePage(@PathVariable Long id, Model model) {
        Course course = courseRepository.findById(id).orElse(null);

        if (course == null) {
            return "redirect:/courses";
        }

        model.addAttribute("course", course);
        model.addAttribute("programs", programRepository.findAll());
        return "course-form";
    }

    @GetMapping("/courses/delete/{id}")
    public String deleteCourse(@PathVariable Long id) {
        courseRepository.deleteById(id);
        return "redirect:/courses";
    }
}