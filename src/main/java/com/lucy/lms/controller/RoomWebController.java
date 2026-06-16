package com.lucy.lms.controller;

import com.lucy.lms.entity.*;
import com.lucy.lms.repository.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@SuppressWarnings("null")
public class RoomWebController {

    private final RoomRepository roomRepository;
    private final AppUserRepository userRepository;
    private final CourseRepository courseRepository;
    private final ChapterRepository chapterRepository;
    private final LessonRepository lessonRepository;
    private final RoomParticipantRepository participantRepository;
    private final PinnedMaterialRepository pinnedMaterialRepository;
    private final GiftRepository giftRepository;
    private final GiftTransactionRepository giftTransactionRepository;
    private final PodcastEpisodeRepository podcastEpisodeRepository;
    private final JoinRequestRepository joinRequestRepository;

    public RoomWebController(RoomRepository roomRepository,
                             AppUserRepository userRepository,
                             CourseRepository courseRepository,
                             ChapterRepository chapterRepository,
                             LessonRepository lessonRepository,
                             RoomParticipantRepository participantRepository,
                             PinnedMaterialRepository pinnedMaterialRepository,
                             GiftRepository giftRepository,
                             GiftTransactionRepository giftTransactionRepository,
                             PodcastEpisodeRepository podcastEpisodeRepository,
                             JoinRequestRepository joinRequestRepository) {
        this.roomRepository = roomRepository;
        this.userRepository = userRepository;
        this.courseRepository = courseRepository;
        this.chapterRepository = chapterRepository;
        this.lessonRepository = lessonRepository;
        this.participantRepository = participantRepository;
        this.pinnedMaterialRepository = pinnedMaterialRepository;
        this.giftRepository = giftRepository;
        this.giftTransactionRepository = giftTransactionRepository;
        this.podcastEpisodeRepository = podcastEpisodeRepository;
        this.joinRequestRepository = joinRequestRepository;
    }

    @GetMapping("/rooms")
    public String rooms(Model model) {
        model.addAttribute("rooms", roomRepository.findAll());
        return "rooms";
    }

    @GetMapping("/rooms/create")
    public String createRoomPage(Model model) {
        model.addAttribute("room", new Room());
        model.addAttribute("users", userRepository.findAll());
        model.addAttribute("courses", courseRepository.findAll());
        model.addAttribute("chapters", chapterRepository.findAll());
        return "room-form";
    }

    @PostMapping("/rooms/save")
    public String saveRoom(
            @RequestParam(required = false) Long id,
            @RequestParam String title,
            @RequestParam(required = false) String languageCode,
            @RequestParam(required = false) Integer levelNumber,
            @RequestParam String roomType,
            @RequestParam String status,
            @RequestParam(required = false) Long hostUserId,
            @RequestParam(required = false) Long courseId,
            @RequestParam(required = false) Long chapterId,
            @RequestParam(required = false) Integer maxParticipants,
            @RequestParam(required = false) String description,
            jakarta.servlet.http.HttpSession session
    ) {
        Room room;
        if (id != null) {
            room = roomRepository.findById(id).orElse(new Room());
        } else {
            room = new Room();
        }

        room.setTitle(title);
        room.setLanguageCode(languageCode);
        room.setLevelNumber(levelNumber);
        room.setRoomType(roomType);
        room.setStatus(status);
        room.setMaxParticipants(maxParticipants != null ? maxParticipants : 20);
        room.setDescription(description);

        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser != null) {
            room.setHostUser(currentUser);
        } else if (hostUserId != null) {
            room.setHostUser(userRepository.findById(hostUserId).orElse(null));
        }

        if (courseId != null) room.setCourse(courseRepository.findById(courseId).orElse(null));
        if (chapterId != null) room.setChapter(chapterRepository.findById(chapterId).orElse(null));

        if ("LIVE".equals(status) && room.getStartedAt() == null) {
            room.setStartedAt(LocalDateTime.now());
            if (room.getChapter() != null) {
                List<Lesson> lessons = lessonRepository.findByChapterIdOrderByOrderIndexAsc(room.getChapter().getId());
                if (!lessons.isEmpty()) {
                    room.setCurrentLesson(lessons.get(0));
                    room.setStageStartedAt(LocalDateTime.now());
                }
            }
        }
        if ("ENDED".equals(status) && room.getEndedAt() == null) {
            room.setEndedAt(LocalDateTime.now());
        }

        roomRepository.save(room);
        return "redirect:/rooms";
    }

    @GetMapping("/rooms/{id}")
    public String roomDetail(@PathVariable Long id, Model model) {
        Room room = roomRepository.findById(id).orElse(null);
        if (room == null) return "redirect:/rooms";

        model.addAttribute("room", room);
        model.addAttribute("participants", participantRepository.findByRoomId(id));
        model.addAttribute("pinnedMaterials", pinnedMaterialRepository.findByRoomId(id));
        model.addAttribute("giftTransactions", giftTransactionRepository.findByRoomId(id));
        model.addAttribute("users", userRepository.findAll());
        model.addAttribute("lessons", lessonRepository.findAll());
        model.addAttribute("gifts", giftRepository.findByActiveTrue());
        model.addAttribute("pendingRequests", joinRequestRepository.findByRoomIdAndStatus(id, "PENDING"));
        return "room-detail";
    }

    @PostMapping("/rooms/{id}/add-participant")
    public String addParticipant(@PathVariable Long id,
                                 @RequestParam Long userId,
                                 @RequestParam String roleInRoom) {
        Room room = roomRepository.findById(id).orElse(null);
        AppUser user = userRepository.findById(userId).orElse(null);
        if (room == null || user == null) return "redirect:/rooms";

        RoomParticipant p = new RoomParticipant();
        p.setRoom(room);
        p.setUser(user);
        p.setDisplayName(user.getAnonymousMode() != null && user.getAnonymousMode() ? user.getAvatarPersona() : user.getDisplayName());
        p.setRoleInRoom(roleInRoom);
        p.setMicOn(false);
        p.setHandRaised(false);
        participantRepository.save(p);

        return "redirect:/rooms/" + id;
    }

    @GetMapping("/rooms/{roomId}/toggle-mic/{participantId}")
    public String toggleMic(@PathVariable Long roomId, @PathVariable Long participantId) {
        RoomParticipant p = participantRepository.findById(participantId).orElse(null);
        if (p != null) {
            p.setMicOn(!Boolean.TRUE.equals(p.getMicOn()));
            participantRepository.save(p);
        }
        return "redirect:/rooms/" + roomId;
    }

    @GetMapping("/rooms/{roomId}/toggle-hand/{participantId}")
    public String toggleHand(@PathVariable Long roomId, @PathVariable Long participantId) {
        RoomParticipant p = participantRepository.findById(participantId).orElse(null);
        if (p != null) {
            p.setHandRaised(!Boolean.TRUE.equals(p.getHandRaised()));
            participantRepository.save(p);
        }
        return "redirect:/rooms/" + roomId;
    }

    @GetMapping("/rooms/{roomId}/remove-participant/{participantId}")
    public String removeParticipant(@PathVariable Long roomId, @PathVariable Long participantId) {
        participantRepository.deleteById(participantId);
        return "redirect:/rooms/" + roomId;
    }

    @PostMapping("/rooms/{id}/pin-material")
    public String pinMaterial(@PathVariable Long id,
                              @RequestParam Long lessonId,
                              @RequestParam(required = false) String pinTitle) {
        Room room = roomRepository.findById(id).orElse(null);
        Lesson lesson = lessonRepository.findById(lessonId).orElse(null);
        if (room == null || lesson == null) return "redirect:/rooms/" + id;

        PinnedMaterial pm = new PinnedMaterial();
        pm.setRoom(room);
        pm.setLesson(lesson);
        pm.setTitle(pinTitle != null && !pinTitle.isBlank() ? pinTitle : lesson.getTitle());
        pm.setContent(lesson.getDescription());
        pinnedMaterialRepository.save(pm);

        return "redirect:/rooms/" + id;
    }

    @GetMapping("/rooms/{roomId}/unpin/{pinId}")
    public String unpinMaterial(@PathVariable Long roomId, @PathVariable Long pinId) {
        pinnedMaterialRepository.deleteById(pinId);
        return "redirect:/rooms/" + roomId;
    }

    @PostMapping("/rooms/{id}/send-gift")
    public String sendGift(@PathVariable Long id,
                           @RequestParam Long senderId,
                           @RequestParam Long receiverId,
                           @RequestParam Long giftId,
                           jakarta.servlet.http.HttpSession session) {
        Room room = roomRepository.findById(id).orElse(null);
        AppUser sender = userRepository.findById(senderId).orElse(null);
        AppUser receiver = userRepository.findById(receiverId).orElse(null);
        Gift gift = giftRepository.findById(giftId).orElse(null);

        if (room == null || sender == null || receiver == null || gift == null) {
            return "redirect:/rooms/" + id + "?error=not_found";
        }

        int cost = gift.getCreditCost() != null ? gift.getCreditCost() : 0;
        if (sender.getCreditBalance() == null || sender.getCreditBalance() < cost) {
            return "redirect:/rooms/" + id + "?error=insufficient_credits";
        }

        // Deduct sender
        sender.setCreditBalance(sender.getCreditBalance() - cost);
        userRepository.save(sender);

        // Add receiver
        receiver.setCreditBalance(receiver.getCreditBalance() + cost);
        receiver.setReputationScore((receiver.getReputationScore() != null ? receiver.getReputationScore() : 0) + 1);
        userRepository.save(receiver);

        // Record transaction
        GiftTransaction tx = new GiftTransaction();
        tx.setGift(gift);
        tx.setSender(sender);
        tx.setReceiver(receiver);
        tx.setRoom(room);
        tx.setCreditAmount(cost);
        giftTransactionRepository.save(tx);

        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser != null && currentUser.getId().equals(senderId)) {
            session.setAttribute("currentUser", userRepository.findById(senderId).orElse(currentUser));
        }

        return "redirect:/rooms/" + id + "?success=gift_sent";
    }

    @GetMapping("/rooms/{id}/end")
    public String endRoom(@PathVariable Long id) {
        Room room = roomRepository.findById(id).orElse(null);
        if (room != null) {
            room.setStatus("ENDED");
            room.setEndedAt(LocalDateTime.now());
            if (Boolean.TRUE.equals(room.getIsRecording())) {
                room.setIsRecording(false);
                
                // Create a Podcast Episode from this room
                PodcastEpisode episode = new PodcastEpisode();
                episode.setRoom(room);
                episode.setCreator(room.getHostUser());
                episode.setTitle("Podcast: " + room.getTitle());
                episode.setDescription("Recorded session of room: " + room.getTitle() + "\n" + (room.getDescription() != null ? room.getDescription() : ""));
                episode.setAudioUrl("/audio/recordings/room_" + room.getId() + ".mp3");
                
                long durationSec = 0;
                if (room.getRecordingStartedAt() != null) {
                    durationSec = java.time.Duration.between(room.getRecordingStartedAt(), LocalDateTime.now()).getSeconds();
                }
                episode.setDurationSeconds((int) (durationSec > 0 ? durationSec : 600));
                episode.setStatus("PUBLISHED");
                podcastEpisodeRepository.save(episode);
            }
            roomRepository.save(room);
        }
        return "redirect:/rooms/" + id;
    }

    @GetMapping("/rooms/{id}/next-stage")
    public String nextStage(@PathVariable Long id) {
        Room room = roomRepository.findById(id).orElse(null);
        if (room != null && "LIVE".equals(room.getStatus()) && room.getChapter() != null) {
            List<Lesson> lessons = lessonRepository.findByChapterIdOrderByOrderIndexAsc(room.getChapter().getId());
            if (!lessons.isEmpty()) {
                Lesson nextLesson = null;
                if (room.getCurrentLesson() == null) {
                    nextLesson = lessons.get(0);
                } else {
                    for (int i = 0; i < lessons.size(); i++) {
                        if (lessons.get(i).getId().equals(room.getCurrentLesson().getId())) {
                            if (i + 1 < lessons.size()) {
                                nextLesson = lessons.get(i + 1);
                            } else {
                                // Wrap around or stay at the last one
                                nextLesson = lessons.get(0);
                            }
                            break;
                        }
                    }
                }
                if (nextLesson != null) {
                    room.setCurrentLesson(nextLesson);
                    room.setStageStartedAt(LocalDateTime.now());
                    roomRepository.save(room);
                }
            }
        }
        return "redirect:/rooms/" + id;
    }

    @GetMapping("/rooms/{id}/toggle-recording")
    public String toggleRecording(@PathVariable Long id) {
        Room room = roomRepository.findById(id).orElse(null);
        if (room != null && "LIVE".equals(room.getStatus())) {
            if (Boolean.TRUE.equals(room.getIsRecording())) {
                room.setIsRecording(false);
                
                // Create a Podcast Episode from this room
                PodcastEpisode episode = new PodcastEpisode();
                episode.setRoom(room);
                episode.setCreator(room.getHostUser());
                episode.setTitle("Podcast: " + room.getTitle());
                episode.setDescription("Recorded session of room: " + room.getTitle() + "\n" + (room.getDescription() != null ? room.getDescription() : ""));
                episode.setAudioUrl("/audio/recordings/room_" + room.getId() + "_" + System.currentTimeMillis() + ".mp3");
                
                long durationSec = 0;
                if (room.getRecordingStartedAt() != null) {
                    durationSec = java.time.Duration.between(room.getRecordingStartedAt(), LocalDateTime.now()).getSeconds();
                }
                episode.setDurationSeconds((int) (durationSec > 0 ? durationSec : 300));
                episode.setStatus("PUBLISHED");
                podcastEpisodeRepository.save(episode);
            } else {
                room.setIsRecording(true);
                room.setRecordingStartedAt(LocalDateTime.now());
            }
            roomRepository.save(room);
        }
        return "redirect:/rooms/" + id;
    }

    @GetMapping("/rooms/delete/{id}")
    public String deleteRoom(@PathVariable Long id) {
        // Delete participants and pinned materials first
        participantRepository.findByRoomId(id).forEach(p -> participantRepository.deleteById(p.getId()));
        pinnedMaterialRepository.findByRoomId(id).forEach(pm -> pinnedMaterialRepository.deleteById(pm.getId()));
        roomRepository.deleteById(id);
        return "redirect:/rooms";
    }
}
