package com.lucy.lms.service;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.entity.Course;
import com.lucy.lms.entity.CourseHostingPermission;
import com.lucy.lms.repository.CourseHostingPermissionRepository;
import com.lucy.lms.repository.CourseRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class CourseHostingPermissionService {

    private static final String PENDING = "PENDING";
    private static final String APPROVED = "APPROVED";
    private static final String REJECTED = "REJECTED";
    private static final String APPLICATION = "APPLICATION";
    private static final String ADMIN = "ADMIN";

    private final CourseHostingPermissionRepository permissionRepository;
    private final CourseRepository courseRepository;
    private final ProgramProgressService progressService;

    public CourseHostingPermissionService(
            CourseHostingPermissionRepository permissionRepository,
            CourseRepository courseRepository,
            ProgramProgressService progressService
    ) {
        this.permissionRepository = permissionRepository;
        this.courseRepository = courseRepository;
        this.progressService = progressService;
    }

    @Transactional(readOnly = true)
    public boolean isValidCourseSelection(Collection<Long> courseIds) {
        Set<Long> ids = normalizeIds(courseIds);
        return !ids.isEmpty() && courseRepository.findAllById(ids).size() == ids.size();
    }

    @Transactional
    public boolean submitApplication(AppUser user, Collection<Long> requestedCourseIds) {
        if (user == null || user.getId() == null || !isValidCourseSelection(requestedCourseIds)) {
            return false;
        }

        Set<Long> selectedIds = normalizeIds(requestedCourseIds);
        List<CourseHostingPermission> existing = permissionsForUser(user);
        Map<Long, CourseHostingPermission> byCourseId = existingByCourseId(existing);
        LocalDateTime now = LocalDateTime.now();

        for (CourseHostingPermission permission : existing) {
            if (PENDING.equals(permission.getStatus())
                    && !selectedIds.contains(permission.getCourse().getId())) {
                permission.setStatus(REJECTED);
                permission.setReviewedAt(now);
                permission.setReviewedBy(null);
            }
        }

        for (Course course : courseRepository.findAllById(selectedIds)) {
            CourseHostingPermission permission = byCourseId.get(course.getId());
            if (permission == null) {
                permission = new CourseHostingPermission();
                permission.setUser(user);
                permission.setCourse(course);
                existing.add(permission);
            }
            if (!APPROVED.equals(permission.getStatus())) {
                permission.setStatus(PENDING);
                permission.setGrantSource(APPLICATION);
                permission.setRequestedAt(now);
                permission.setReviewedAt(null);
                permission.setReviewedBy(null);
            }
        }
        permissionRepository.saveAll(existing);
        return true;
    }

    @Transactional
    public boolean approveApplication(AppUser user, Collection<Long> approvedCourseIds, AppUser admin) {
        if (user == null || user.getId() == null) return false;
        Set<Long> selectedIds = normalizeIds(approvedCourseIds);
        List<CourseHostingPermission> pending =
                permissionRepository.findByUserIdAndStatus(user.getId(), PENDING);
        Set<Long> requestedIds = pending.stream()
                .map(permission -> permission.getCourse().getId())
                .collect(java.util.stream.Collectors.toSet());
        if (selectedIds.isEmpty() || !requestedIds.containsAll(selectedIds)) return false;

        LocalDateTime now = LocalDateTime.now();
        for (CourseHostingPermission permission : pending) {
            boolean approved = selectedIds.contains(permission.getCourse().getId());
            permission.setStatus(approved ? APPROVED : REJECTED);
            permission.setReviewedAt(now);
            permission.setReviewedBy(admin);
            if (approved) {
                permission.setGrantSource(APPLICATION);
                progressService.grantHostingThroughCourse(user, permission.getCourse());
            }
        }
        permissionRepository.saveAll(pending);
        return true;
    }

    @Transactional
    public void rejectApplication(AppUser user, AppUser admin) {
        if (user == null || user.getId() == null) return;
        List<CourseHostingPermission> pending =
                permissionRepository.findByUserIdAndStatus(user.getId(), PENDING);
        LocalDateTime now = LocalDateTime.now();
        for (CourseHostingPermission permission : pending) {
            permission.setStatus(REJECTED);
            permission.setReviewedAt(now);
            permission.setReviewedBy(admin);
        }
        permissionRepository.saveAll(pending);
    }

    @Transactional
    public boolean replaceApprovedPermissions(
            AppUser user, Collection<Long> approvedCourseIds, AppUser admin
    ) {
        if (user == null || user.getId() == null) return false;
        Set<Long> selectedIds = normalizeIds(approvedCourseIds);
        List<Course> selectedCourses = courseRepository.findAllById(selectedIds);
        if (selectedCourses.size() != selectedIds.size()) return false;

        List<CourseHostingPermission> permissions = permissionsForUser(user);
        Map<Long, CourseHostingPermission> byCourseId = existingByCourseId(permissions);
        LocalDateTime now = LocalDateTime.now();
        for (CourseHostingPermission permission : permissions) {
            if (!selectedIds.contains(permission.getCourse().getId())
                    && APPROVED.equals(permission.getStatus())) {
                permission.setStatus(REJECTED);
                permission.setReviewedAt(now);
                permission.setReviewedBy(admin);
            }
        }
        for (Course course : selectedCourses) {
            CourseHostingPermission permission = byCourseId.get(course.getId());
            if (permission == null) {
                permission = new CourseHostingPermission();
                permission.setUser(user);
                permission.setCourse(course);
                permission.setRequestedAt(now);
                permissions.add(permission);
            }
            permission.setStatus(APPROVED);
            permission.setGrantSource(ADMIN);
            permission.setReviewedAt(now);
            permission.setReviewedBy(admin);
            progressService.grantHostingThroughCourse(user, course);
        }
        permissionRepository.saveAll(permissions);
        return true;
    }

    @Transactional
    public void grantCourses(
            AppUser user, Collection<Course> courses, AppUser admin, String source
    ) {
        if (user == null || user.getId() == null || courses == null) return;
        List<CourseHostingPermission> permissions = permissionsForUser(user);
        Map<Long, CourseHostingPermission> byCourseId = existingByCourseId(permissions);
        LocalDateTime now = LocalDateTime.now();
        for (Course course : courses) {
            if (course == null || course.getId() == null) continue;
            CourseHostingPermission permission = byCourseId.get(course.getId());
            if (permission == null) {
                permission = new CourseHostingPermission();
                permission.setUser(user);
                permission.setCourse(course);
                permission.setRequestedAt(now);
                permissions.add(permission);
            }
            permission.setStatus(APPROVED);
            permission.setGrantSource(source == null ? ADMIN : source);
            permission.setReviewedAt(now);
            permission.setReviewedBy(admin);
            progressService.grantHostingThroughCourse(user, course);
        }
        permissionRepository.saveAll(permissions);
    }

    @Transactional(readOnly = true)
    public List<CourseHostingPermission> permissionsForUser(AppUser user) {
        if (user == null || user.getId() == null) return List.of();
        return permissionRepository
                .findByUserIdOrderByCourseProgramTitleAscCourseOrderIndexAscCourseTitleAsc(user.getId());
    }

    @Transactional(readOnly = true)
    public List<CourseHostingPermission> pendingForUser(AppUser user) {
        if (user == null || user.getId() == null) return List.of();
        return permissionRepository.findByUserIdAndStatus(user.getId(), PENDING);
    }

    @Transactional(readOnly = true)
    public List<CourseHostingPermission> approvedForUser(AppUser user) {
        if (user == null || user.getId() == null) return List.of();
        return permissionRepository.findByUserIdAndStatus(user.getId(), APPROVED);
    }

    @Transactional(readOnly = true)
    public Set<Long> approvedCourseIds(AppUser user) {
        return approvedForUser(user).stream()
                .map(permission -> permission.getCourse().getId())
                .collect(java.util.stream.Collectors.toCollection(LinkedHashSet::new));
    }

    @Transactional(readOnly = true)
    public long permissionCount(AppUser user) {
        return user == null || user.getId() == null ? 0 : permissionRepository.countByUserId(user.getId());
    }

    private Set<Long> normalizeIds(Collection<Long> courseIds) {
        if (courseIds == null) return Set.of();
        return courseIds.stream()
                .filter(java.util.Objects::nonNull)
                .collect(java.util.stream.Collectors.toCollection(LinkedHashSet::new));
    }

    private Map<Long, CourseHostingPermission> existingByCourseId(
            List<CourseHostingPermission> permissions
    ) {
        Map<Long, CourseHostingPermission> result = new HashMap<>();
        for (CourseHostingPermission permission : permissions) {
            result.put(permission.getCourse().getId(), permission);
        }
        return result;
    }
}
