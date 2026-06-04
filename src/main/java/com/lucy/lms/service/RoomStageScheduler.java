package com.lucy.lms.service;

import com.lucy.lms.entity.Lesson;
import com.lucy.lms.entity.Room;
import com.lucy.lms.repository.LessonRepository;
import com.lucy.lms.repository.RoomRepository;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

@Component
public class RoomStageScheduler {

    private final RoomRepository roomRepository;
    private final LessonRepository lessonRepository;

    // Configurable transition limit: 10 minutes (600 seconds)
    private static final long TRANSITION_SECONDS = 600; 

    public RoomStageScheduler(RoomRepository roomRepository, LessonRepository lessonRepository) {
        this.roomRepository = roomRepository;
        this.lessonRepository = lessonRepository;
    }

    @Scheduled(fixedRate = 10000) // check every 10 seconds
    public void autoTransitionStages() {
        List<Room> liveRooms = roomRepository.findByStatus("LIVE");
        for (Room room : liveRooms) {
            if (room.getChapter() != null && room.getCurrentLesson() != null && room.getStageStartedAt() != null) {
                long secondsElapsed = Duration.between(room.getStageStartedAt(), LocalDateTime.now()).getSeconds();
                
                if (secondsElapsed >= TRANSITION_SECONDS) {
                    List<Lesson> lessons = lessonRepository.findByChapterIdOrderByOrderIndexAsc(room.getChapter().getId());
                    if (!lessons.isEmpty()) {
                        Lesson nextLesson = null;
                        for (int i = 0; i < lessons.size(); i++) {
                            if (lessons.get(i).getId().equals(room.getCurrentLesson().getId())) {
                                if (i + 1 < lessons.size()) {
                                    nextLesson = lessons.get(i + 1);
                                } else {
                                    nextLesson = lessons.get(0); // Wrap around to the first topic
                                }
                                break;
                            }
                        }
                        if (nextLesson != null) {
                            room.setCurrentLesson(nextLesson);
                            room.setStageStartedAt(LocalDateTime.now());
                            roomRepository.save(room);
                            System.out.println("[RoomStageScheduler] Auto-transitioned Room ID " + room.getId() + " to Lesson: " + nextLesson.getTitle());
                        }
                    }
                }
            }
        }
    }
}
