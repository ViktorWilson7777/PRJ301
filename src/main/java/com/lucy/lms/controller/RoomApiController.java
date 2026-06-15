package com.lucy.lms.controller;

import com.lucy.lms.entity.JoinRequest;
import com.lucy.lms.entity.Room;
import com.lucy.lms.entity.RoomParticipant;
import com.lucy.lms.repository.JoinRequestRepository;
import com.lucy.lms.repository.RoomParticipantRepository;
import com.lucy.lms.repository.RoomRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;

@RestController
@Tag(name = "Room", description = "Mock Room Management APIs")
@SuppressWarnings("null")
public class RoomApiController {

    private final RoomRepository roomRepository;
    private final RoomParticipantRepository participantRepository;
    private final com.lucy.lms.repository.AppUserRepository userRepository;
    private final com.lucy.lms.repository.PinnedMaterialRepository pinnedMaterialRepository;
    private final com.lucy.lms.repository.LessonRepository lessonRepository;
    private final com.lucy.lms.repository.GiftRepository giftRepository;
    private final com.lucy.lms.repository.GiftTransactionRepository giftTransactionRepository;
    private final com.lucy.lms.repository.PodcastEpisodeRepository podcastEpisodeRepository;
    private final com.lucy.lms.repository.CourseRepository courseRepository;
    private final com.lucy.lms.repository.ChapterRepository chapterRepository;
    private final JoinRequestRepository joinRequestRepository;

    public RoomApiController(RoomRepository roomRepository,
                             RoomParticipantRepository participantRepository,
                             com.lucy.lms.repository.AppUserRepository userRepository,
                             com.lucy.lms.repository.PinnedMaterialRepository pinnedMaterialRepository,
                             com.lucy.lms.repository.LessonRepository lessonRepository,
                             com.lucy.lms.repository.GiftRepository giftRepository,
                             com.lucy.lms.repository.GiftTransactionRepository giftTransactionRepository,
                             com.lucy.lms.repository.PodcastEpisodeRepository podcastEpisodeRepository,
                             com.lucy.lms.repository.CourseRepository courseRepository,
                             com.lucy.lms.repository.ChapterRepository chapterRepository,
                             JoinRequestRepository joinRequestRepository) {
        this.roomRepository = roomRepository;
        this.participantRepository = participantRepository;
        this.userRepository = userRepository;
        this.pinnedMaterialRepository = pinnedMaterialRepository;
        this.lessonRepository = lessonRepository;
        this.giftRepository = giftRepository;
        this.giftTransactionRepository = giftTransactionRepository;
        this.podcastEpisodeRepository = podcastEpisodeRepository;
        this.courseRepository = courseRepository;
        this.chapterRepository = chapterRepository;
        this.joinRequestRepository = joinRequestRepository;
    }

    @GetMapping("/api/rooms")
    @Operation(summary = "List all rooms, optionally filter by status")
    public List<Room> getRooms(@RequestParam(required = false) String status) {
        if (status != null && !status.isBlank()) {
            return roomRepository.findByStatus(status);
        }
        return roomRepository.findAll();
    }

    @GetMapping("/api/rooms/{id}")
    @Operation(summary = "Get room detail with participants")
    public ResponseEntity<Map<String, Object>> getRoomDetail(@PathVariable Long id) {
        Room room = roomRepository.findById(id).orElse(null);
        if (room == null) return ResponseEntity.notFound().build();

        List<RoomParticipant> participants = participantRepository.findByRoomId(id);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("id", room.getId());
        result.put("title", room.getTitle());
        result.put("languageCode", room.getLanguageCode());
        result.put("roomType", room.getRoomType());
        result.put("status", room.getStatus());
        result.put("maxParticipants", room.getMaxParticipants());
        result.put("participantCount", participants.size());
        result.put("participants", participants.stream().map(p -> {
            Map<String, Object> pm = new LinkedHashMap<>();
            pm.put("id", p.getId());
            pm.put("displayName", p.getDisplayName());
            pm.put("roleInRoom", p.getRoleInRoom());
            pm.put("micOn", p.getMicOn());
            pm.put("handRaised", p.getHandRaised());
            return pm;
        }).toList());
        return ResponseEntity.ok(result);
    }

    @PostMapping("/api/rooms")
    @Operation(summary = "Create a new room")
    public ResponseEntity<Map<String, Object>> createRoom(
            @RequestParam String title,
            @RequestParam(required = false) String languageCode,
            @RequestParam(required = false) Integer levelNumber,
            @RequestParam String roomType,
            @RequestParam String status,
            @RequestParam(required = false) Long hostUserId,
            @RequestParam(required = false) Long courseId,
            @RequestParam(required = false) Long chapterId,
            @RequestParam(required = false) Integer maxParticipants,
            @RequestParam(required = false) String description) {

        Room room = new Room();
        room.setTitle(title);
        room.setLanguageCode(languageCode);
        room.setLevelNumber(levelNumber);
        room.setRoomType(roomType);
        room.setStatus(status);
        room.setMaxParticipants(maxParticipants != null ? maxParticipants : 20);
        room.setDescription(description);

        if (hostUserId != null) room.setHostUser(userRepository.findById(hostUserId).orElse(null));
        if (courseId != null) room.setCourse(courseRepository.findById(courseId).orElse(null));
        if (chapterId != null) room.setChapter(chapterRepository.findById(chapterId).orElse(null));

        if ("LIVE".equals(status) && room.getStartedAt() == null) {
            room.setStartedAt(java.time.LocalDateTime.now());
            if (room.getChapter() != null) {
                List<com.lucy.lms.entity.Lesson> lessons = lessonRepository.findByChapterIdOrderByOrderIndexAsc(room.getChapter().getId());
                if (!lessons.isEmpty()) {
                    room.setCurrentLesson(lessons.get(0));
                    room.setStageStartedAt(java.time.LocalDateTime.now());
                }
            }
        }
        
        Room saved = roomRepository.save(room);
        
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("id", saved.getId());
        result.put("title", saved.getTitle());
        result.put("status", saved.getStatus());
        return ResponseEntity.ok(result);
    }
    @PostMapping("/api/rooms/{id}/join")
    @Operation(summary = "Join a room as a participant")
    public ResponseEntity<Map<String, Object>> joinRoom(@PathVariable Long id,
                                                        @RequestParam Long userId,
                                                        @RequestParam String roleInRoom) {
        Room room = roomRepository.findById(id).orElse(null);
        com.lucy.lms.entity.AppUser user = userRepository.findById(userId).orElse(null);
        if (room == null || user == null) return ResponseEntity.notFound().build();

        RoomParticipant p = new RoomParticipant();
        p.setRoom(room);
        p.setUser(user);
        p.setDisplayName(user.getAnonymousMode() != null && user.getAnonymousMode() ? user.getAvatarPersona() : user.getDisplayName());
        p.setRoleInRoom(roleInRoom);
        p.setMicOn(false);
        p.setHandRaised(false);
        RoomParticipant saved = participantRepository.save(p);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("id", saved.getId());
        result.put("displayName", saved.getDisplayName());
        result.put("roleInRoom", saved.getRoleInRoom());
        return ResponseEntity.ok(result);
    }

    @PostMapping("/api/rooms/{roomId}/toggle-mic/{participantId}")
    @Operation(summary = "Toggle microphone for a participant")
    public ResponseEntity<Map<String, Object>> toggleMic(@PathVariable Long roomId, @PathVariable Long participantId) {
        RoomParticipant p = participantRepository.findById(participantId).orElse(null);
        if (p == null || !p.getRoom().getId().equals(roomId)) return ResponseEntity.notFound().build();

        p.setMicOn(!Boolean.TRUE.equals(p.getMicOn()));
        participantRepository.save(p);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("id", p.getId());
        result.put("micOn", p.getMicOn());
        return ResponseEntity.ok(result);
    }

    @PostMapping("/api/rooms/{roomId}/toggle-hand/{participantId}")
    @Operation(summary = "Toggle raise hand for a participant")
    public ResponseEntity<Map<String, Object>> toggleHand(@PathVariable Long roomId, @PathVariable Long participantId) {
        RoomParticipant p = participantRepository.findById(participantId).orElse(null);
        if (p == null || !p.getRoom().getId().equals(roomId)) return ResponseEntity.notFound().build();

        p.setHandRaised(!Boolean.TRUE.equals(p.getHandRaised()));
        participantRepository.save(p);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("id", p.getId());
        result.put("handRaised", p.getHandRaised());
        return ResponseEntity.ok(result);
    }

    @DeleteMapping("/api/rooms/{roomId}/participants/{participantId}")
    @Operation(summary = "Remove a participant from a room")
    public ResponseEntity<Void> removeParticipant(@PathVariable Long roomId, @PathVariable Long participantId) {
        RoomParticipant p = participantRepository.findById(participantId).orElse(null);
        if (p != null && p.getRoom().getId().equals(roomId)) {
            participantRepository.deleteById(participantId);
        }
        return ResponseEntity.ok().build();
    }

    @PostMapping("/api/rooms/{id}/pin-material")
    @Operation(summary = "Pin a lesson material to a room")
    public ResponseEntity<Map<String, Object>> pinMaterial(@PathVariable Long id,
                                                           @RequestParam Long lessonId,
                                                           @RequestParam(required = false) String pinTitle) {
        Room room = roomRepository.findById(id).orElse(null);
        com.lucy.lms.entity.Lesson lesson = lessonRepository.findById(lessonId).orElse(null);
        if (room == null || lesson == null) return ResponseEntity.notFound().build();

        com.lucy.lms.entity.PinnedMaterial pm = new com.lucy.lms.entity.PinnedMaterial();
        pm.setRoom(room);
        pm.setLesson(lesson);
        pm.setTitle(pinTitle != null && !pinTitle.isBlank() ? pinTitle : lesson.getTitle());
        pm.setContent(lesson.getDescription());
        com.lucy.lms.entity.PinnedMaterial saved = pinnedMaterialRepository.save(pm);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("id", saved.getId());
        result.put("title", saved.getTitle());
        result.put("pinnedAt", saved.getPinnedAt());
        return ResponseEntity.ok(result);
    }

    @DeleteMapping("/api/rooms/{roomId}/unpin/{pinId}")
    @Operation(summary = "Unpin a material from a room")
    public ResponseEntity<Void> unpinMaterial(@PathVariable Long roomId, @PathVariable Long pinId) {
        com.lucy.lms.entity.PinnedMaterial pm = pinnedMaterialRepository.findById(pinId).orElse(null);
        if (pm != null && pm.getRoom().getId().equals(roomId)) {
            pinnedMaterialRepository.deleteById(pinId);
        }
        return ResponseEntity.ok().build();
    }

    @PostMapping("/api/rooms/{id}/send-gift")
    @Operation(summary = "Send a gift in a room")
    public ResponseEntity<Map<String, Object>> sendGift(@PathVariable Long id,
                                                        @RequestParam Long senderId,
                                                        @RequestParam Long receiverId,
                                                        @RequestParam Long giftId) {
        Room room = roomRepository.findById(id).orElse(null);
        com.lucy.lms.entity.AppUser sender = userRepository.findById(senderId).orElse(null);
        com.lucy.lms.entity.AppUser receiver = userRepository.findById(receiverId).orElse(null);
        com.lucy.lms.entity.Gift gift = giftRepository.findById(giftId).orElse(null);

        if (room == null || sender == null || receiver == null || gift == null) {
            return ResponseEntity.notFound().build();
        }

        int cost = gift.getCreditCost() != null ? gift.getCreditCost() : 0;
        if (sender.getCreditBalance() == null || sender.getCreditBalance() < cost) {
            return ResponseEntity.badRequest().body(Map.of("error", "Insufficient credits"));
        }

        // Deduct sender
        sender.setCreditBalance(sender.getCreditBalance() - cost);
        userRepository.save(sender);

        // Add receiver
        receiver.setCreditBalance(receiver.getCreditBalance() + cost);
        receiver.setReputationScore((receiver.getReputationScore() != null ? receiver.getReputationScore() : 0) + 1);
        userRepository.save(receiver);

        // Record transaction
        com.lucy.lms.entity.GiftTransaction tx = new com.lucy.lms.entity.GiftTransaction();
        tx.setGift(gift);
        tx.setSender(sender);
        tx.setReceiver(receiver);
        tx.setRoom(room);
        tx.setCreditAmount(cost);
        com.lucy.lms.entity.GiftTransaction saved = giftTransactionRepository.save(tx);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("transactionId", saved.getId());
        result.put("senderCreditBalance", sender.getCreditBalance());
        result.put("receiverCreditBalance", receiver.getCreditBalance());
        return ResponseEntity.ok(result);
    }

    @PostMapping("/api/rooms/{id}/next-stage")
    @Operation(summary = "Move room to the next lesson/stage")
    public ResponseEntity<Map<String, Object>> nextStage(@PathVariable Long id) {
        Room room = roomRepository.findById(id).orElse(null);
        if (room != null && "LIVE".equals(room.getStatus()) && room.getChapter() != null) {
            List<com.lucy.lms.entity.Lesson> lessons = lessonRepository.findByChapterIdOrderByOrderIndexAsc(room.getChapter().getId());
            if (!lessons.isEmpty()) {
                com.lucy.lms.entity.Lesson nextLesson = null;
                if (room.getCurrentLesson() == null) {
                    nextLesson = lessons.get(0);
                } else {
                    for (int i = 0; i < lessons.size(); i++) {
                        if (lessons.get(i).getId().equals(room.getCurrentLesson().getId())) {
                            if (i + 1 < lessons.size()) {
                                nextLesson = lessons.get(i + 1);
                            } else {
                                nextLesson = lessons.get(0);
                            }
                            break;
                        }
                    }
                }
                if (nextLesson != null) {
                    room.setCurrentLesson(nextLesson);
                    room.setStageStartedAt(java.time.LocalDateTime.now());
                    roomRepository.save(room);
                    return ResponseEntity.ok(Map.of("currentLessonId", nextLesson.getId(), "currentLessonTitle", nextLesson.getTitle()));
                }
            }
        }
        return ResponseEntity.badRequest().build();
    }

    @PostMapping("/api/rooms/{id}/end")
    @Operation(summary = "End a room and optionally publish podcast")
    public ResponseEntity<Map<String, Object>> endRoom(@PathVariable Long id) {
        Room room = roomRepository.findById(id).orElse(null);
        if (room != null) {
            room.setStatus("ENDED");
            room.setEndedAt(java.time.LocalDateTime.now());
            if (Boolean.TRUE.equals(room.getIsRecording())) {
                room.setIsRecording(false);
                
                com.lucy.lms.entity.PodcastEpisode episode = new com.lucy.lms.entity.PodcastEpisode();
                episode.setRoom(room);
                episode.setCreator(room.getHostUser());
                episode.setTitle("Podcast: " + room.getTitle());
                episode.setDescription("Recorded session of room: " + room.getTitle());
                episode.setAudioUrl("/audio/recordings/room_" + room.getId() + ".mp3");
                
                long durationSec = 0;
                if (room.getRecordingStartedAt() != null) {
                    durationSec = java.time.Duration.between(room.getRecordingStartedAt(), java.time.LocalDateTime.now()).getSeconds();
                }
                episode.setDurationSeconds((int) (durationSec > 0 ? durationSec : 600));
                episode.setStatus("PUBLISHED");
                podcastEpisodeRepository.save(episode);
            }
            roomRepository.save(room);
            return ResponseEntity.ok(Map.of("status", "ENDED"));
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/api/rooms/{id}/toggle-recording")
    @Operation(summary = "Toggle recording state in a room")
    public ResponseEntity<Map<String, Object>> toggleRecording(@PathVariable Long id) {
        Room room = roomRepository.findById(id).orElse(null);
        if (room != null && "LIVE".equals(room.getStatus())) {
            if (Boolean.TRUE.equals(room.getIsRecording())) {
                room.setIsRecording(false);
                
                com.lucy.lms.entity.PodcastEpisode episode = new com.lucy.lms.entity.PodcastEpisode();
                episode.setRoom(room);
                episode.setCreator(room.getHostUser());
                episode.setTitle("Podcast: " + room.getTitle());
                episode.setDescription("Recorded session of room: " + room.getTitle());
                episode.setAudioUrl("/audio/recordings/room_" + room.getId() + "_" + System.currentTimeMillis() + ".mp3");
                
                long durationSec = 0;
                if (room.getRecordingStartedAt() != null) {
                    durationSec = java.time.Duration.between(room.getRecordingStartedAt(), java.time.LocalDateTime.now()).getSeconds();
                }
                episode.setDurationSeconds((int) (durationSec > 0 ? durationSec : 300));
                episode.setStatus("PUBLISHED");
                podcastEpisodeRepository.save(episode);
            } else {
                room.setIsRecording(true);
                room.setRecordingStartedAt(java.time.LocalDateTime.now());
            }
            roomRepository.save(room);
            return ResponseEntity.ok(Map.of("isRecording", room.getIsRecording()));
        }
        return ResponseEntity.notFound().build();
    }

    // =============================================
    // JOIN REQUEST WORKFLOW
    // =============================================

    @PostMapping("/api/rooms/{id}/request-join")
    @Operation(summary = "User requests to join a LIVE room - host must approve")
    public ResponseEntity<Map<String, Object>> requestJoin(
            @PathVariable Long id,
            @RequestParam Long userId,
            @RequestParam(defaultValue = "LISTENER") String roleRequested) {

        Room room = roomRepository.findById(id).orElse(null);
        com.lucy.lms.entity.AppUser user = userRepository.findById(userId).orElse(null);

        if (room == null || user == null) return ResponseEntity.notFound().build();
        if (!"LIVE".equals(room.getStatus())) {
            return ResponseEntity.badRequest().body(Map.of("error", "Room is not live"));
        }

        // Prevent duplicate pending requests
        if (joinRequestRepository.existsByRoomIdAndUserIdAndStatus(id, userId, "PENDING")) {
            return ResponseEntity.badRequest().body(Map.of("error", "Join request already pending"));
        }

        JoinRequest jr = new JoinRequest();
        jr.setRoom(room);
        jr.setUser(user);
        jr.setDisplayName(user.getAnonymousMode() != null && user.getAnonymousMode()
                ? user.getAvatarPersona() : user.getDisplayName());
        jr.setRoleRequested(roleRequested);
        jr.setStatus("PENDING");
        JoinRequest saved = joinRequestRepository.save(jr);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("requestId", saved.getId());
        result.put("displayName", saved.getDisplayName());
        result.put("status", "PENDING");
        return ResponseEntity.ok(result);
    }

    @GetMapping("/api/rooms/{id}/pending-requests")
    @Operation(summary = "Get all pending join requests for a room (host polling)")
    public ResponseEntity<List<Map<String, Object>>> getPendingRequests(@PathVariable Long id) {
        List<JoinRequest> requests = joinRequestRepository.findByRoomIdAndStatus(id, "PENDING");
        List<Map<String, Object>> result = requests.stream().map(jr -> {
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("requestId", jr.getId());
            m.put("userId", jr.getUser() != null ? jr.getUser().getId() : null);
            m.put("displayName", jr.getDisplayName());
            m.put("roleRequested", jr.getRoleRequested());
            m.put("requestedAt", jr.getRequestedAt());
            return m;
        }).toList();
        return ResponseEntity.ok(result);
    }

    @PostMapping("/api/rooms/{roomId}/approve-join/{requestId}")
    @Operation(summary = "Host approves a join request — user is added as participant")
    public ResponseEntity<Map<String, Object>> approveJoin(
            @PathVariable Long roomId, @PathVariable Long requestId) {

        JoinRequest jr = joinRequestRepository.findById(requestId).orElse(null);
        if (jr == null || !jr.getRoom().getId().equals(roomId)) return ResponseEntity.notFound().build();

        jr.setStatus("APPROVED");
        jr.setRespondedAt(LocalDateTime.now());
        joinRequestRepository.save(jr);

        // Auto-add as participant
        RoomParticipant p = new RoomParticipant();
        p.setRoom(jr.getRoom());
        p.setUser(jr.getUser());
        p.setDisplayName(jr.getDisplayName());
        p.setRoleInRoom(jr.getRoleRequested() != null ? jr.getRoleRequested().toUpperCase() : "LISTENER");
        p.setMicOn(false);
        p.setHandRaised(false);
        RoomParticipant saved = participantRepository.save(p);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("status", "APPROVED");
        result.put("participantId", saved.getId());
        result.put("displayName", saved.getDisplayName());
        return ResponseEntity.ok(result);
    }

    @PostMapping("/api/rooms/{roomId}/deny-join/{requestId}")
    @Operation(summary = "Host denies a join request")
    public ResponseEntity<Map<String, Object>> denyJoin(
            @PathVariable Long roomId, @PathVariable Long requestId) {

        JoinRequest jr = joinRequestRepository.findById(requestId).orElse(null);
        if (jr == null || !jr.getRoom().getId().equals(roomId)) return ResponseEntity.notFound().build();

        jr.setStatus("DENIED");
        jr.setRespondedAt(LocalDateTime.now());
        joinRequestRepository.save(jr);

        return ResponseEntity.ok(Map.of("status", "DENIED", "requestId", requestId));
    }
}
