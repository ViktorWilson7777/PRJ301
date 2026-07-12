package com.lucy.lms.controller;

import com.lucy.lms.entity.Chapter;
import com.lucy.lms.entity.Course;
import com.lucy.lms.entity.Lesson;
import com.lucy.lms.entity.Program;
import com.lucy.lms.entity.Room;
import com.lucy.lms.entity.AppUser;
import com.lucy.lms.repository.ChapterRepository;
import com.lucy.lms.repository.CourseRepository;
import com.lucy.lms.repository.LessonRepository;
import com.lucy.lms.repository.ProgramRepository;
import com.lucy.lms.repository.RoomRepository;
import com.lucy.lms.service.ProgramProgressService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@SuppressWarnings("null")
public class CourseWebController {

    private final CourseRepository courseRepository;
    private final ProgramRepository programRepository;
    private final ChapterRepository chapterRepository;
    private final LessonRepository lessonRepository;
    private final RoomRepository roomRepository;
    private final ProgramProgressService progressService;

    public CourseWebController(CourseRepository courseRepository,
            ProgramRepository programRepository,
            ChapterRepository chapterRepository,
            LessonRepository lessonRepository,
            RoomRepository roomRepository,
            ProgramProgressService progressService) {
        this.courseRepository = courseRepository;
        this.programRepository = programRepository;
        this.chapterRepository = chapterRepository;
        this.lessonRepository = lessonRepository;
        this.roomRepository = roomRepository;
        this.progressService = progressService;
    }

    @GetMapping("/courses")
    public String courses(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String level,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "9") int size,
            Model model) {

        Pageable pageable = PageRequest.of(page, size);
        Page<Course> coursePage;

        if ((keyword != null && !keyword.isEmpty()) || (level != null && !level.isEmpty())) {
            String searchKeyword = (keyword != null && !keyword.isEmpty()) ? keyword : null;
            String searchLevel = (level != null && !level.isEmpty()) ? level : null;
            coursePage = courseRepository.findByFilters(searchKeyword, searchLevel, pageable);
        } else {
            coursePage = courseRepository.findAll(pageable);
        }

        model.addAttribute("coursePage", coursePage);
        model.addAttribute("allCourses", courseRepository.findAll());
        model.addAttribute("keyword", keyword);
        model.addAttribute("level", level);
        return "courses";
    }

    @GetMapping("/courses/{id}")
    public String courseDetail(@PathVariable Long id, 
                               @org.springframework.web.bind.annotation.RequestParam(required = false) String hostName,
                               @org.springframework.web.bind.annotation.RequestParam(required = false) Integer level,
                               Model model, jakarta.servlet.http.HttpSession session) {
        Course course = courseRepository.findById(id).orElse(null);
        if (course == null) {
            return "redirect:/courses";
        }

        List<Chapter> chapters = chapterRepository.findByCourseIdOrderByOrderIndexAsc(id);
        Map<Long, List<Lesson>> chapterLessonsMap = new HashMap<>();

        for (Chapter chapter : chapters) {
            List<Lesson> lessons = lessonRepository.findByChapterIdOrderByOrderIndexAsc(chapter.getId());
            chapterLessonsMap.put(chapter.getId(), lessons);
        }

        // Fetch Live and Scheduled Rooms for this course with filters
        List<Room> liveRooms = roomRepository.findRoomsByFilters(id, java.util.Arrays.asList("LIVE", "SCHEDULED"), 
                                                                 (hostName != null && !hostName.isEmpty()) ? hostName : null, level);
        
        model.addAttribute("hostName", hostName);
        model.addAttribute("searchLevel", level);

        // Calculate User Level
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        int userLevel = progressService.getLevel(currentUser, course.getProgram());

        model.addAttribute("course", course);
        model.addAttribute("chapters", chapters);
        model.addAttribute("chapterLessonsMap", chapterLessonsMap);
        model.addAttribute("liveRooms", liveRooms);
        model.addAttribute("userLevel", userLevel);
        model.addAttribute("completedLessonIds", progressService.completedLessonIds(currentUser, course));
        model.addAttribute("courseCompleted", progressService.isCourseCompleted(currentUser, course));
        model.addAttribute("canHostCourse", progressService.canHostCourse(currentUser, course));

        return "course-detail";
    }

    @PostMapping("/courses/{courseId}/lessons/{lessonId}/complete")
    public String completeLesson(@PathVariable Long courseId,
                                 @PathVariable Long lessonId,
                                 jakarta.servlet.http.HttpSession session,
                                 org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";
        Lesson lesson = lessonRepository.findById(lessonId).orElse(null);
        if (lesson == null || lesson.getChapter() == null || lesson.getChapter().getCourse() == null
                || !courseId.equals(lesson.getChapter().getCourse().getId())) {
            redirectAttributes.addFlashAttribute("error", "Lesson not found in this course.");
            return "redirect:/courses/" + courseId;
        }
        boolean courseCompleted = progressService.markLessonComplete(currentUser, lesson);
        AppUser freshUser = currentUser;
        if (courseCompleted) {
            redirectAttributes.addFlashAttribute("success",
                    "Course completed. Pro Mentor hosting access has been unlocked for this course.");
        } else {
            redirectAttributes.addFlashAttribute("success", "Lesson marked as complete.");
        }
        session.setAttribute("currentUser", freshUser);
        return "redirect:/courses/" + courseId;
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
            @RequestParam(required = false) String description) {
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
