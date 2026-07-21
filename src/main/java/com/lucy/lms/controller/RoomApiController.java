package com.lucy.lms.controller;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.entity.JoinRequest;
import com.lucy.lms.entity.Room;
import com.lucy.lms.entity.RoomParticipant;
import com.lucy.lms.repository.JoinRequestRepository;
import com.lucy.lms.repository.RoomParticipantRepository;
import com.lucy.lms.repository.RoomRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;
import com.lucy.lms.service.ProgramProgressService;

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
    private final org.springframework.messaging.simp.SimpMessagingTemplate messagingTemplate;
    private final ProgramProgressService progressService;

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
                             JoinRequestRepository joinRequestRepository,
                             org.springframework.messaging.simp.SimpMessagingTemplate messagingTemplate,
                             ProgramProgressService progressService) {
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
        this.messagingTemplate = messagingTemplate;
        this.progressService = progressService;
    }

    private AppUser currentUser(HttpSession session) {
        return session == null ? null : (AppUser) session.getAttribute("currentUser");
    }

    private boolean isAdmin(AppUser user) {
        return user != null && "ADMIN".equals(user.getRole());
    }

    private boolean isHost(Room room, AppUser user) {
        return room != null && user != null && room.getHostUser() != null
                && room.getHostUser().getId() != null
                && room.getHostUser().getId().equals(user.getId());
    }

    private boolean canManageRoom(Room room, AppUser user) {
        return isAdmin(user) || isHost(room, user);
    }

    private boolean canRecordRoom(Room room, AppUser user) {
        return canManageRoom(room, user) || (user != null && "SUPER_CREATOR".equals(user.getRole()));
    }

    private ResponseEntity<Map<String, Object>> unauthorized() {
        return ResponseEntity.status(401).body(Map.of("error", "login_required"));
    }

    private ResponseEntity<Map<String, Object>> forbidden(String error) {
        return ResponseEntity.status(403).body(Map.of("error", error));
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
            pm.put("micAllowed", Boolean.TRUE.equals(p.getMicAllowed()));
            pm.put("handRaised", p.getHandRaised());
            if (p.getUser() != null) {
                pm.put("userId", p.getUser().getId());
            }
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
            @RequestParam(required = false) String description,
            HttpSession session) {

        AppUser currentUser = currentUser(session);
        if (currentUser == null) return unauthorized();
        if (!("PRO_MENTOR".equals(currentUser.getRole()) || isAdmin(currentUser))) {
            return forbidden("access_denied");
        }

        Room room = new Room();
        room.setTitle(title);
        room.setLanguageCode(languageCode);
        room.setLevelNumber(levelNumber);
        room.setRoomType(roomType);
        room.setStatus(status);
        room.setMaxParticipants(maxParticipants != null ? maxParticipants : 20);
        room.setDescription(description);

        if (isAdmin(currentUser) && hostUserId != null) {
            room.setHostUser(userRepository.findById(hostUserId).orElse(currentUser));
        } else {
            room.setHostUser(currentUser);
        }
        if (chapterId != null) {
            com.lucy.lms.entity.Chapter chapter = chapterRepository.findById(chapterId).orElse(null);
            room.setChapter(chapter);
            if (chapter != null) {
                room.setCourse(chapter.getCourse());
                room.setLevelNumber(chapter.getOrderIndex() != null ? chapter.getOrderIndex() : levelNumber);
            }
        } else if (courseId != null) {
            room.setCourse(courseRepository.findById(courseId).orElse(null));
        }

        if (!progressService.canHostRoom(currentUser, room.getCourse(), room.getLevelNumber())) {
            return forbidden("host_level_not_allowed");
        }

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
    
    @PostMapping("/api/rooms/{id}/leave")
    @Operation(summary = "Leave a room as a participant")
    public ResponseEntity<Map<String, Object>> leaveRoom(@PathVariable Long id, jakarta.servlet.http.HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return ResponseEntity.status(401).build();

        RoomParticipant participant = participantRepository.findFirstByRoomIdAndUserId(id, currentUser.getId()).orElse(null);
        if (participant != null) {
            if (Boolean.TRUE.equals(participant.getMicOn())) {
                progressService.stopSpeakingAndAward(participant);
            }
            participantRepository.delete(participant);
            // Send STOMP message to notify others
            Map<String, Object> msg = new HashMap<>();
            msg.put("type", "LEAVE");
            msg.put("senderName", currentUser.getDisplayName());
            messagingTemplate.convertAndSend("/topic/room/" + id, msg);
        }

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    @PostMapping("/api/rooms/{id}/join")
    @Operation(summary = "Join a room as a participant (level check enforced for LEARNER)")
    public ResponseEntity<Map<String, Object>> joinRoom(@PathVariable Long id,
                                                        @RequestParam Long userId,
                                                        @RequestParam String roleInRoom,
                                                        HttpSession session) {
        AppUser currentUser = currentUser(session);
        if (currentUser == null) return unauthorized();
        Room room = roomRepository.findById(id).orElse(null);
        com.lucy.lms.entity.AppUser user = userRepository.findById(userId).orElse(null);
        if (room == null || user == null) return ResponseEntity.notFound().build();
        if (!canManageRoom(room, currentUser) && !currentUser.getId().equals(userId)) {
            return forbidden("access_denied");
        }
        if (!canManageRoom(room, currentUser) && !"LISTENER".equalsIgnoreCase(roleInRoom)) {
            return forbidden("speaker_request_requires_host_approval");
        }
        if (participantRepository.existsByRoomIdAndUserId(id, userId)) {
            return ResponseEntity.badRequest().body(Map.of("error", "already_joined"));
        }

        // Level gating applies to every participating account and is program-specific.
        if (!"ADMIN".equals(user.getRole()) && room.getLevelNumber() != null && room.getCourse() != null) {
            int userLevel = progressService.getLevel(user, room.getCourse().getProgram());
            if (userLevel < room.getLevelNumber()) {
                Map<String, Object> error = new LinkedHashMap<>();
                error.put("error", "Level too low");
                error.put("userLevel", userLevel);
                error.put("requiredLevel", room.getLevelNumber());
                return ResponseEntity.status(403).body(error);
            }
        }

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
    public ResponseEntity<Map<String, Object>> toggleMic(@PathVariable Long roomId,
                                                          @PathVariable Long participantId,
                                                          jakarta.servlet.http.HttpSession session) {
        RoomParticipant p = participantRepository.findById(participantId).orElse(null);
        if (p == null || !p.getRoom().getId().equals(roomId)) return ResponseEntity.notFound().build();
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null || p.getUser() == null || !currentUser.getId().equals(p.getUser().getId())) {
            return ResponseEntity.status(403).body(Map.of("error", "You can only control your own microphone."));
        }
        if (!Boolean.TRUE.equals(p.getMicAllowed())) {
            return ResponseEntity.status(403).body(Map.of("error", "The host has not enabled your microphone."));
        }
        if (!("SPEAKER".equals(p.getRoleInRoom()) || "MODERATOR".equals(p.getRoleInRoom()))) {
            return ResponseEntity.status(403).body(Map.of("error", "Only speakers can use a microphone."));
        }

        boolean micOn = !Boolean.TRUE.equals(p.getMicOn());
        p.setMicOn(micOn);
        if (micOn) progressService.startSpeaking(p);
        else progressService.stopSpeakingAndAward(p);
        participantRepository.save(p);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("id", p.getId());
        result.put("micOn", p.getMicOn());
        return ResponseEntity.ok(result);
    }

    @PostMapping("/api/rooms/{roomId}/mic-permission/{participantId}")
    @Operation(summary = "Host grants or revokes a participant's microphone permission")
    public ResponseEntity<Map<String, Object>> setMicPermission(@PathVariable Long roomId,
                                                                @PathVariable Long participantId,
                                                                jakarta.servlet.http.HttpSession session) {
        Room room = roomRepository.findById(roomId).orElse(null);
        RoomParticipant participant = participantRepository.findById(participantId).orElse(null);
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (room == null || participant == null || currentUser == null
                || !participant.getRoom().getId().equals(roomId)) return ResponseEntity.notFound().build();
        boolean isHost = room.getHostUser() != null && room.getHostUser().getId().equals(currentUser.getId());
        if (!isHost && !"ADMIN".equals(currentUser.getRole())) {
            return ResponseEntity.status(403).body(Map.of("error", "Only the host can manage microphone access."));
        }
        boolean allowed = !Boolean.TRUE.equals(participant.getMicAllowed());
        participant.setMicAllowed(allowed);
        if (!allowed && Boolean.TRUE.equals(participant.getMicOn())) {
            progressService.stopSpeakingAndAward(participant);
            participant.setMicOn(false);
        }
        participantRepository.save(participant);

        Map<String, Object> event = new LinkedHashMap<>();
        event.put("type", "MIC_PERMISSION");
        event.put("receiverName", participant.getDisplayName());
        event.put("content", allowed ? "ALLOWED" : "REVOKED");
        messagingTemplate.convertAndSend("/topic/room/" + roomId, event);
        return ResponseEntity.ok(Map.of("micAllowed", allowed, "micOn", Boolean.TRUE.equals(participant.getMicOn())));
    }

    @PostMapping("/api/rooms/{roomId}/toggle-hand/{participantId}")
    @Operation(summary = "Toggle raise hand for a participant")
    public ResponseEntity<Map<String, Object>> toggleHand(@PathVariable Long roomId,
                                                          @PathVariable Long participantId,
                                                          HttpSession session) {
        AppUser currentUser = currentUser(session);
        if (currentUser == null) return unauthorized();
        RoomParticipant p = participantRepository.findById(participantId).orElse(null);
        if (p == null || !p.getRoom().getId().equals(roomId)) return ResponseEntity.notFound().build();
        if (p.getUser() == null || !currentUser.getId().equals(p.getUser().getId())) {
            return forbidden("access_denied");
        }

        p.setHandRaised(!Boolean.TRUE.equals(p.getHandRaised()));
        participantRepository.save(p);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("id", p.getId());
        result.put("handRaised", p.getHandRaised());
        return ResponseEntity.ok(result);
    }

    @DeleteMapping("/api/rooms/{roomId}/participants/{participantId}")
    @Operation(summary = "Remove a participant from a room")
    public ResponseEntity<Void> removeParticipant(@PathVariable Long roomId,
                                                  @PathVariable Long participantId,
                                                  HttpSession session) {
        AppUser currentUser = currentUser(session);
        if (currentUser == null) return ResponseEntity.status(401).build();
        RoomParticipant p = participantRepository.findById(participantId).orElse(null);
        if (p == null || !p.getRoom().getId().equals(roomId)) return ResponseEntity.notFound().build();
        if (!canManageRoom(p.getRoom(), currentUser)) return ResponseEntity.status(403).build();
        if (p != null && p.getRoom().getId().equals(roomId)) {
            if (Boolean.TRUE.equals(p.getMicOn())) progressService.stopSpeakingAndAward(p);
            participantRepository.deleteById(participantId);
        }
        return ResponseEntity.ok().build();
    }

    @PostMapping("/api/rooms/{id}/pin-material")
    @Operation(summary = "Pin a lesson material to a room")
    public ResponseEntity<Map<String, Object>> pinMaterial(@PathVariable Long id,
                                                           @RequestParam Long lessonId,
                                                           @RequestParam(required = false) String pinTitle,
                                                           HttpSession session) {
        AppUser currentUser = currentUser(session);
        if (currentUser == null) return unauthorized();
        Room room = roomRepository.findById(id).orElse(null);
        com.lucy.lms.entity.Lesson lesson = lessonRepository.findById(lessonId).orElse(null);
        if (room == null || lesson == null) return ResponseEntity.notFound().build();
        if (!canManageRoom(room, currentUser)) return forbidden("access_denied");

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
    public ResponseEntity<Void> unpinMaterial(@PathVariable Long roomId,
                                              @PathVariable Long pinId,
                                              HttpSession session) {
        AppUser currentUser = currentUser(session);
        if (currentUser == null) return ResponseEntity.status(401).build();
        com.lucy.lms.entity.PinnedMaterial pm = pinnedMaterialRepository.findById(pinId).orElse(null);
        if (pm == null || !pm.getRoom().getId().equals(roomId)) return ResponseEntity.notFound().build();
        if (!canManageRoom(pm.getRoom(), currentUser)) return ResponseEntity.status(403).build();
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
                                                        @RequestParam Long giftId,
                                                        HttpSession session) {
        AppUser currentUser = currentUser(session);
        if (currentUser == null) return unauthorized();
        if (!currentUser.getId().equals(senderId)) return forbidden("access_denied");
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
    public ResponseEntity<Map<String, Object>> nextStage(@PathVariable Long id, HttpSession session) {
        AppUser currentUser = currentUser(session);
        if (currentUser == null) return unauthorized();
        Room room = roomRepository.findById(id).orElse(null);
        if (room == null) return ResponseEntity.notFound().build();
        if (!canManageRoom(room, currentUser)) return forbidden("access_denied");
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
    @Transactional
    public ResponseEntity<Map<String, Object>> endRoom(@PathVariable Long id, HttpSession session) {
        AppUser currentUser = currentUser(session);
        if (currentUser == null) return unauthorized();
        Room room = roomRepository.findById(id).orElse(null);
        if (room == null) return ResponseEntity.notFound().build();
        if (!canManageRoom(room, currentUser)) return forbidden("access_denied");
        if (Boolean.TRUE.equals(room.getIsRecording())) {
            room.setIsRecording(false);
            
            com.lucy.lms.entity.PodcastEpisode episode = new com.lucy.lms.entity.PodcastEpisode();
            episode.setRoom(null);
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
        
        // Clean up related entities
        participantRepository.findByRoomId(id).forEach(p -> {
            if (Boolean.TRUE.equals(p.getMicOn())) progressService.stopSpeakingAndAward(p);
            participantRepository.deleteById(p.getId());
        });
        pinnedMaterialRepository.findByRoomId(id).forEach(pm -> pinnedMaterialRepository.deleteById(pm.getId()));
        joinRequestRepository.findByRoomId(id).forEach(jr -> joinRequestRepository.deleteById(jr.getId()));
        giftTransactionRepository.findByRoomId(id).forEach(gt -> {
            gt.setRoom(null);
            giftTransactionRepository.save(gt);
        });
        podcastEpisodeRepository.findByRoomId(id).forEach(pe -> {
            pe.setRoom(null);
            podcastEpisodeRepository.save(pe);
        });
        
        // Delete the room
        roomRepository.deleteById(id);
        return ResponseEntity.ok(Map.of("status", "ENDED_AND_DELETED"));
    }

    @PostMapping("/api/rooms/{id}/toggle-recording")
    @Operation(summary = "Toggle recording state in a room")
    public ResponseEntity<Map<String, Object>> toggleRecording(@PathVariable Long id, HttpSession session) {
        AppUser currentUser = currentUser(session);
        if (currentUser == null) return unauthorized();
        Room room = roomRepository.findById(id).orElse(null);
        if (room == null) return ResponseEntity.notFound().build();
        if (!canRecordRoom(room, currentUser)) return forbidden("access_denied");
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
            @RequestParam(defaultValue = "LISTENER") String roleRequested,
            HttpSession session) {

        try {
            AppUser currentUser = currentUser(session);
            if (currentUser == null) return unauthorized();
            if (!currentUser.getId().equals(userId)) return forbidden("access_denied");
            Room room = roomRepository.findById(id).orElse(null);
            com.lucy.lms.entity.AppUser user = userRepository.findById(userId).orElse(null);

            if (room == null || user == null) return ResponseEntity.notFound().build();
        if (!"LIVE".equals(room.getStatus())) {
            return ResponseEntity.badRequest().body(Map.of("error", "Room is not live"));
        }
        if (!"ADMIN".equals(user.getRole()) && room.getLevelNumber() != null && room.getCourse() != null) {
            int userLevel = progressService.getLevel(user, room.getCourse().getProgram());
            if (userLevel < room.getLevelNumber()) {
                return ResponseEntity.status(403).body(Map.of(
                        "error", "Your level is too low for this room.",
                        "userLevel", userLevel,
                        "requiredLevel", room.getLevelNumber()));
            }
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
        
        if ("LISTENER".equals(roleRequested)) {
            jr.setStatus("APPROVED");
            jr = joinRequestRepository.save(jr);
            
            // Auto create participant
            RoomParticipant p = new RoomParticipant();
            p.setRoom(room);
            p.setUser(user);
            p.setDisplayName(jr.getDisplayName());
            p.setRoleInRoom("LISTENER");
            p.setMicOn(false);
            p.setHandRaised(false);
            participantRepository.save(p);
        } else {
            jr.setStatus("PENDING");
            jr = joinRequestRepository.save(jr);
            
            // Send WebSocket notification to host about pending request
            Map<String, Object> msg = new HashMap<>();
            msg.put("type", "JOIN_REQUEST");
            msg.put("senderName", jr.getDisplayName());
            messagingTemplate.convertAndSend("/topic/room/" + id, msg);
        }

            Map<String, Object> result = new LinkedHashMap<>();
            result.put("requestId", jr.getId());
            result.put("displayName", jr.getDisplayName());
            result.put("status", jr.getStatus());
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of("error", e.getMessage() != null ? e.getMessage() : e.getClass().getName()));
        }
    }

    @GetMapping("/api/rooms/{id}/pending-requests")
    @Operation(summary = "Get all pending join requests for a room (host polling)")
    public ResponseEntity<List<Map<String, Object>>> getPendingRequests(@PathVariable Long id, HttpSession session) {
        AppUser currentUser = currentUser(session);
        if (currentUser == null) return ResponseEntity.status(401).build();
        Room room = roomRepository.findById(id).orElse(null);
        if (room == null) return ResponseEntity.notFound().build();
        if (!canManageRoom(room, currentUser)) return ResponseEntity.status(403).build();
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
            @PathVariable Long roomId, @PathVariable Long requestId, HttpSession session) {
        AppUser currentUser = currentUser(session);
        if (currentUser == null) return unauthorized();

        JoinRequest jr = joinRequestRepository.findById(requestId).orElse(null);
        if (jr == null || !jr.getRoom().getId().equals(roomId)) return ResponseEntity.notFound().build();
        if (!canManageRoom(jr.getRoom(), currentUser)) return forbidden("access_denied");

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
            @PathVariable Long roomId, @PathVariable Long requestId, HttpSession session) {
        AppUser currentUser = currentUser(session);
        if (currentUser == null) return unauthorized();

        JoinRequest jr = joinRequestRepository.findById(requestId).orElse(null);
        if (jr == null || !jr.getRoom().getId().equals(roomId)) return ResponseEntity.notFound().build();
        if (!canManageRoom(jr.getRoom(), currentUser)) return forbidden("access_denied");

        jr.setStatus("DENIED");
        jr.setRespondedAt(LocalDateTime.now());
        joinRequestRepository.save(jr);

        return ResponseEntity.ok(Map.of("status", "DENIED", "requestId", requestId));
    }

    @GetMapping("/api/rooms/{roomId}/request-status")
    @Operation(summary = "Get current user's join request status")
    public ResponseEntity<Map<String, Object>> getMyRequestStatus(@PathVariable Long roomId, jakarta.servlet.http.HttpSession session) {
        try {
            com.lucy.lms.entity.AppUser currentUser = (com.lucy.lms.entity.AppUser) session.getAttribute("currentUser");
            if (currentUser == null) {
                System.out.println("[request-status] No currentUser in session for room " + roomId);
                return ResponseEntity.status(401).build();
            }

            // Check if user is a participant (most reliable check)
            boolean isParticipant = participantRepository.existsByRoomIdAndUserId(roomId, currentUser.getId());
            if (isParticipant) {
                String role = "LISTENER";
                try {
                    java.util.Optional<RoomParticipant> pOpt = participantRepository.findFirstByRoomIdAndUserId(roomId, currentUser.getId());
                    if (pOpt.isPresent() && pOpt.get().getRoleInRoom() != null) {
                        role = pOpt.get().getRoleInRoom();
                    }
                } catch (Exception e) {
                    System.out.println("[request-status] Error getting role: " + e.getMessage());
                }
                Map<String, Object> result = new LinkedHashMap<>();
                result.put("status", "APPROVED");
                result.put("role", role);
                return ResponseEntity.ok(result);
            }

            // Check join request history
            List<JoinRequest> requests = joinRequestRepository.findByRoomIdAndUserIdOrderByRequestedAtDesc(roomId, currentUser.getId());
            if (requests.isEmpty()) {
                return ResponseEntity.ok(Map.of("status", "NONE"));
            }

            String status = requests.get(0).getStatus();
            if ("APPROVED".equals(status)) {
                // Join request was approved but participant record is gone = was kicked
                status = "NONE";
            }
            return ResponseEntity.ok(Map.of("status", status));
        } catch (Exception e) {
            System.out.println("[request-status] Unexpected error for room " + roomId + ": " + e.getMessage());
            // Return APPROVED on error to avoid false kicks
            return ResponseEntity.ok(Map.of("status", "APPROVED", "role", "LISTENER"));
        }
    }
}

