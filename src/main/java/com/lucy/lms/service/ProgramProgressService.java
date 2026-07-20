package com.lucy.lms.service;

import com.lucy.lms.entity.*;
import com.lucy.lms.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class ProgramProgressService {
    private final UserProgramLevelRepository levelRepository;
    private final LessonCompletionRepository lessonCompletionRepository;
    private final CourseCompletionRepository courseCompletionRepository;
    private final LessonRepository lessonRepository;
    private final ChapterRepository chapterRepository;
    private final AppUserRepository userRepository;

    public ProgramProgressService(UserProgramLevelRepository levelRepository,
                                  LessonCompletionRepository lessonCompletionRepository,
                                  CourseCompletionRepository courseCompletionRepository,
                                  LessonRepository lessonRepository,
                                  ChapterRepository chapterRepository,
                                  AppUserRepository userRepository) {
        this.levelRepository = levelRepository;
        this.lessonCompletionRepository = lessonCompletionRepository;
        this.courseCompletionRepository = courseCompletionRepository;
        this.lessonRepository = lessonRepository;
        this.chapterRepository = chapterRepository;
        this.userRepository = userRepository;
    }

    @Transactional
    public UserProgramLevel getOrCreate(AppUser user, Program program) {
        if (user == null || user.getId() == null || program == null || program.getId() == null) return null;
        return levelRepository.findByUserIdAndProgramId(user.getId(), program.getId()).orElseGet(() -> {
            UserProgramLevel level = new UserProgramLevel();
            level.setUser(user);
            level.setProgram(program);
            level.setLevelNumber(1);
            level.setExperiencePoints(0);
            level.setMaxHostingLevel(0);
            return levelRepository.save(level);
        });
    }

    @Transactional(readOnly = true)
    public int getLevel(AppUser user, Program program) {
        if (user == null || program == null) return 1;
        return levelRepository.findByUserIdAndProgramId(user.getId(), program.getId())
                .map(UserProgramLevel::getLevelNumber).orElse(1);
    }

    @Transactional
    public void startSpeaking(RoomParticipant participant) {
        if (participant.getSpeakingStartedAt() == null) {
            participant.setSpeakingStartedAt(LocalDateTime.now());
        }
    }

    @Transactional
    public int stopSpeakingAndAward(RoomParticipant participant) {
        if (participant == null || participant.getSpeakingStartedAt() == null) return 0;
        int sessionSeconds = (int) Math.max(0,
                Duration.between(participant.getSpeakingStartedAt(), LocalDateTime.now()).getSeconds());
        int totalSeconds = (participant.getSpeakingSeconds() == null ? 0 : participant.getSpeakingSeconds()) + sessionSeconds;
        participant.setSpeakingSeconds(totalSeconds);
        participant.setSpeakingStartedAt(null);

        int earnedTotal = totalSeconds / 60;
        int alreadyAwarded = participant.getAwardedExperience() == null ? 0 : participant.getAwardedExperience();
        int delta = Math.max(0, earnedTotal - alreadyAwarded);
        if (delta > 0 && participant.getUser() != null && participant.getRoom() != null
                && participant.getRoom().getCourse() != null
                && participant.getRoom().getCourse().getProgram() != null) {
            UserProgramLevel progress = getOrCreate(
                    participant.getUser(), participant.getRoom().getCourse().getProgram());
            int xp = (progress.getExperiencePoints() == null ? 0 : progress.getExperiencePoints()) + delta;
            progress.setExperiencePoints(xp);
            progress.setLevelNumber(1 + xp / 100);
            levelRepository.save(progress);
            participant.setAwardedExperience(earnedTotal);

            AppUser user = participant.getUser();
            user.setReputationScore((user.getReputationScore() == null ? 0 : user.getReputationScore()) + delta);
            userRepository.save(user);
        }
        return delta;
    }

    @Transactional
    public boolean markLessonComplete(AppUser user, Lesson lesson) {
        if (!lessonCompletionRepository.existsByUserIdAndLessonId(user.getId(), lesson.getId())) {
            LessonCompletion completion = new LessonCompletion();
            completion.setUser(user);
            completion.setLesson(lesson);
            lessonCompletionRepository.save(completion);
        }
        Course course = lesson.getChapter().getCourse();
        long total = lessonRepository.countByChapterCourseId(course.getId());
        long completed = lessonCompletionRepository.countByUserIdAndLessonChapterCourseId(user.getId(), course.getId());
        if (total > 0 && completed >= total) {
            grantCourseCompletion(user, course);
            return true;
        }
        return false;
    }

    private void grantCourseCompletion(AppUser user, Course course) {
        if (!courseCompletionRepository.existsByUserIdAndCourseId(user.getId(), course.getId())) {
            CourseCompletion completion = new CourseCompletion();
            completion.setUser(user);
            completion.setCourse(course);
            courseCompletionRepository.save(completion);
        }
        if (!"ADMIN".equals(user.getRole())) {
            user.setRole("PRO_MENTOR");
            user.setRegistrationStatus("APPROVED");
            user.setActive(true);
            userRepository.save(user);
        }
        UserProgramLevel progress = getOrCreate(user, course.getProgram());
        int courseMaxLevel = chapterRepository.findByCourseIdOrderByOrderIndexAsc(course.getId()).stream()
                .map(Chapter::getOrderIndex).filter(java.util.Objects::nonNull).max(Integer::compareTo).orElse(1);
        progress.setMaxHostingLevel(Math.max(
                progress.getMaxHostingLevel() == null ? 0 : progress.getMaxHostingLevel(), courseMaxLevel));
        levelRepository.save(progress);
    }

    @Transactional(readOnly = true)
    public Set<Long> completedLessonIds(AppUser user, Course course) {
        if (user == null) return Set.of();
        return lessonCompletionRepository.findByUserIdAndLessonChapterCourseId(user.getId(), course.getId())
                .stream().map(item -> item.getLesson().getId()).collect(Collectors.toSet());
    }

    @Transactional(readOnly = true)
    public boolean isCourseCompleted(AppUser user, Course course) {
        return user != null && courseCompletionRepository.existsByUserIdAndCourseId(user.getId(), course.getId());
    }

    @Transactional(readOnly = true)
    public boolean canHostCourse(AppUser user, Course course) {
        if (user == null || course == null) return false;
        if ("ADMIN".equals(user.getRole())) return true;
        if (!"PRO_MENTOR".equals(user.getRole())) return false;
        if (courseCompletionRepository.existsByUserIdAndCourseId(user.getId(), course.getId())) return true;
        if (Boolean.TRUE.equals(user.getProGrantedByAdmin())) return true;
        return levelRepository.findByUserIdAndProgramId(user.getId(), course.getProgram().getId())
                .map(level -> level.getMaxHostingLevel() != null && level.getMaxHostingLevel() > 0)
                .orElse(false);
    }

    @Transactional(readOnly = true)
    public boolean canHostRoom(AppUser user, Course course, Integer roomLevel) {
        if (user == null || course == null) return false;
        if ("ADMIN".equals(user.getRole())) return true;
        if (!canHostCourse(user, course)) return false;
        if (Boolean.TRUE.equals(user.getProGrantedByAdmin())) return true;
        int requestedLevel = roomLevel == null ? 1 : Math.max(1, roomLevel);
        return levelRepository.findByUserIdAndProgramId(user.getId(), course.getProgram().getId())
                .map(level -> level.getMaxHostingLevel() != null && level.getMaxHostingLevel() >= requestedLevel)
                .orElse(false);
    }

    @Transactional(readOnly = true)
    public List<UserProgramLevel> levelsForUser(AppUser user) {
        return user == null ? List.of() : levelRepository.findByUserIdOrderByProgramTitleAsc(user.getId());
    }

    @Transactional
    public UserProgramLevel setLevel(AppUser user, Program program, int levelNumber, int maxHostingLevel) {
        UserProgramLevel progress = getOrCreate(user, program);
        progress.setLevelNumber(Math.max(1, levelNumber));
        progress.setExperiencePoints(Math.max(progress.getExperiencePoints() == null ? 0 : progress.getExperiencePoints(),
                (Math.max(1, levelNumber) - 1) * 100));
        progress.setMaxHostingLevel(Math.max(0, maxHostingLevel));
        return levelRepository.save(progress);
    }
}
