package com.lucy.lms.service;

import com.lucy.lms.entity.Lesson;
import com.lucy.lms.entity.PinnedMaterial;
import com.lucy.lms.entity.Room;
import com.lucy.lms.repository.LessonRepository;
import com.lucy.lms.repository.PinnedMaterialRepository;
import com.lucy.lms.repository.RoomRepository;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

/**
 * AI-Driven Room Coordination Scheduler.
 * 
 * Runs as a background Use Case triggered automatically by the system.
 * Every 10 minutes, the AI scans all LIVE rooms and:
 *   1. Closes the current topic (deactivates old PinnedMaterial)
 *   2. Advances to the next Lesson/stage
 *   3. Auto-pins the new topic onto the room interface
 *   4. Logs the transition for monitoring
 */
@Component
public class RoomStageScheduler {

    private final RoomRepository roomRepository;
    private final LessonRepository lessonRepository;
    private final PinnedMaterialRepository pinnedMaterialRepository;

    // AI-driven transition interval: 10 minutes (600 seconds)
    private static final long TRANSITION_SECONDS = 600;

    public RoomStageScheduler(RoomRepository roomRepository,
                              LessonRepository lessonRepository,
                              PinnedMaterialRepository pinnedMaterialRepository) {
        this.roomRepository = roomRepository;
        this.lessonRepository = lessonRepository;
        this.pinnedMaterialRepository = pinnedMaterialRepository;
    }

    /**
     * AI-Driven Auto-Transition.
     * Polls every 10 seconds, but only transitions rooms where 10+ minutes have elapsed.
     * On transition:
     *   - Deactivates all current pinned materials
     *   - Finds the next lesson (respecting level constraints)
     *   - Sets it as current lesson and auto-pins it
     */
    @Scheduled(fixedRate = 10000) // Poll every 10 seconds
    @Transactional
    public void autoTransitionStages() {
        List<Room> liveRooms = roomRepository.findByStatus("LIVE");
        for (Room room : liveRooms) {
            try {
                processRoomTransition(room);
            } catch (jakarta.persistence.EntityNotFoundException ex) {
                System.out.println("[AI-Coordinator] Entity not found for Room ID " + room.getId() + ": " + ex.getMessage());
            } catch (RuntimeException ex) {
                System.out.println("[AI-Coordinator] Error processing Room ID " + room.getId() + ": " + ex.getMessage());
            }
        }
    }

    private void processRoomTransition(Room room) {
        if (room.getChapter() == null || room.getCurrentLesson() == null || room.getStageStartedAt() == null) {
            return;
        }

        long secondsElapsed = Duration.between(room.getStageStartedAt(), LocalDateTime.now()).getSeconds();

        if (secondsElapsed < TRANSITION_SECONDS) {
            return; // Not yet time to transition
        }

        // Determine available lessons — filtered by room level if set
        List<Lesson> lessons;
        if (room.getLevelNumber() != null) {
            lessons = lessonRepository.findByChapterIdAndLevelNumberLessThanEqualOrderByOrderIndexAsc(
                    room.getChapter().getId(), room.getLevelNumber());
            // Fallback to all lessons if no level-matched lessons exist
            if (lessons.isEmpty()) {
                lessons = lessonRepository.findByChapterIdOrderByOrderIndexAsc(room.getChapter().getId());
            }
        } else {
            lessons = lessonRepository.findByChapterIdOrderByOrderIndexAsc(room.getChapter().getId());
        }

        if (lessons.isEmpty()) {
            return;
        }

        // Find next lesson
        Lesson nextLesson = findNextLesson(lessons, room.getCurrentLesson());

        if (nextLesson != null) {
            // Step 1: Close old topic — deactivate all current pinned materials
            pinnedMaterialRepository.deactivateAllByRoomId(room.getId());

            // Step 2: Update room to next lesson
            room.setCurrentLesson(nextLesson);
            room.setStageStartedAt(LocalDateTime.now());
            roomRepository.save(room);

            // Step 3: Auto-pin the new topic
            PinnedMaterial pin = new PinnedMaterial();
            pin.setRoom(room);
            pin.setLesson(nextLesson);
            pin.setTitle("📌 " + nextLesson.getTitle());
            pin.setContent(nextLesson.getDescription() != null ? nextLesson.getDescription() : "");
            pin.setActive(true);
            pinnedMaterialRepository.save(pin);

            System.out.println("[AI-Coordinator] Room #" + room.getId()
                    + " | Level " + room.getLevelNumber()
                    + " | Transitioned to: \"" + nextLesson.getTitle() + "\""
                    + " (Lesson #" + nextLesson.getId() + ")"
                    + " | Old pins deactivated, new pin created");
        }
    }

    /**
     * Find the next lesson in sequence, wrapping around to the first if at the end.
     */
    private Lesson findNextLesson(List<Lesson> lessons, Lesson currentLesson) {
        for (int i = 0; i < lessons.size(); i++) {
            if (lessons.get(i).getId().equals(currentLesson.getId())) {
                if (i + 1 < lessons.size()) {
                    return lessons.get(i + 1);
                } else {
                    return lessons.get(0); // Wrap around to first topic
                }
            }
        }
        return lessons.get(0); // Fallback to first
    }
}
