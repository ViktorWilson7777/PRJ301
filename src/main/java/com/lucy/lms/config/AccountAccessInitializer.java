package com.lucy.lms.config;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.entity.Course;
import com.lucy.lms.repository.AppUserRepository;
import com.lucy.lms.repository.CourseRepository;
import com.lucy.lms.service.CourseHostingPermissionService;
import com.lucy.lms.service.ProgramProgressService;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Component
@Order(20)
public class AccountAccessInitializer implements ApplicationRunner {

    private final AppUserRepository userRepository;
    private final CourseRepository courseRepository;
    private final ProgramProgressService progressService;
    private final CourseHostingPermissionService hostingPermissionService;

    public AccountAccessInitializer(
            AppUserRepository userRepository,
            CourseRepository courseRepository,
            ProgramProgressService progressService,
            CourseHostingPermissionService hostingPermissionService
    ) {
        this.userRepository = userRepository;
        this.courseRepository = courseRepository;
        this.progressService = progressService;
        this.hostingPermissionService = hostingPermissionService;
    }

    @Override
    @Transactional
    public void run(ApplicationArguments args) {
        List<Course> courses = courseRepository.findAllByOrderByProgramTitleAscOrderIndexAscTitleAsc();
        for (AppUser user : userRepository.findAll()) {
            progressService.initializeAllProgramLevels(user);

            boolean legacyGlobalGrant = Boolean.TRUE.equals(user.getProGrantedByAdmin());
            boolean defaultMentor = "miko@lucy.demo".equalsIgnoreCase(user.getEmail())
                    && "PRO_MENTOR".equals(user.getRole());
            if ((legacyGlobalGrant || defaultMentor)
                    && hostingPermissionService.permissionCount(user) == 0) {
                hostingPermissionService.grantCourses(user, courses, null, "LEGACY");
            }
            if (legacyGlobalGrant) {
                user.setProGrantedByAdmin(false);
                userRepository.save(user);
            }
        }
    }
}
