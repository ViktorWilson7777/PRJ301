package com.lucy.lms.controller;

import com.lucy.lms.entity.*;
import com.lucy.lms.repository.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.IOException;

@Controller
@SuppressWarnings("null")
public class RoomWebController {

    private final RoomRepository roomRepository;
    private final ProgramRepository programRepository;
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
                             ProgramRepository programRepository,
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
        this.programRepository = programRepository;
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

    @GetMapping("/my-rooms")
    public String myRooms(Model model, jakarta.servlet.http.HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";
        model.addAttribute("rooms", roomRepository.findByHostUserId(currentUser.getId()));
        return "my-rooms";
    }

    @GetMapping("/rooms/create")
    public String createRoomPage(Model model) {
        model.addAttribute("room", new Room());
        model.addAttribute("users", userRepository.findAll());
        model.addAttribute("courses", courseRepository.findAll());
        model.addAttribute("programs", programRepository.findAll());
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
        // levelNumber and course will be inferred from chapter if available
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

        if (chapterId != null) {
            com.lucy.lms.entity.Chapter chapter = chapterRepository.findById(chapterId).orElse(null);
            room.setChapter(chapter);
            if (chapter != null) {
                room.setCourse(chapter.getCourse());
                room.setLevelNumber(chapter.getOrderIndex() != null ? chapter.getOrderIndex() : levelNumber);
            }
        } else {
            room.setChapter(null);
            if (courseId != null) room.setCourse(courseRepository.findById(courseId).orElse(null));
        }

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

        if ("LIVE".equals(status)) {
            return "redirect:/rooms/" + room.getId();
        }
        
        if (room.getCourse() != null) {
            return "redirect:/courses/" + room.getCourse().getId();
        }
        
        return "redirect:/rooms";
    }

    @GetMapping("/rooms/{id}")
    public String roomDetail(@PathVariable Long id, Model model, jakarta.servlet.http.HttpSession session) {
        Room room = roomRepository.findById(id).orElse(null);
        if (room == null) return "redirect:/rooms";

        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        boolean isHost = room.getHostUser() != null && room.getHostUser().getId().equals(currentUser.getId());
        boolean isAdmin = "ADMIN".equals(currentUser.getRole());

        if (isHost || isAdmin) {
            model.addAttribute("room", room);
            model.addAttribute("participants", participantRepository.findByRoomId(id));
            model.addAttribute("pinnedMaterials", pinnedMaterialRepository.findByRoomId(id));
            model.addAttribute("giftTransactions", giftTransactionRepository.findByRoomId(id));
            model.addAttribute("users", userRepository.findAll());
            model.addAttribute("lessons", lessonRepository.findAll());
            model.addAttribute("gifts", giftRepository.findByActiveTrue());
            model.addAttribute("pendingRequests", joinRequestRepository.findByRoomIdAndStatus(id, "PENDING"));
            return "room-detail-host";
        }

        boolean isParticipant = participantRepository.existsByRoomIdAndUserId(id, currentUser.getId());
        if (isParticipant) {
            model.addAttribute("room", room);
            model.addAttribute("participants", participantRepository.findByRoomId(id));
            model.addAttribute("pinnedMaterials", pinnedMaterialRepository.findByRoomId(id));
            model.addAttribute("giftTransactions", giftTransactionRepository.findByRoomId(id));
            model.addAttribute("users", userRepository.findAll());
            model.addAttribute("lessons", lessonRepository.findAll());
            model.addAttribute("gifts", giftRepository.findByActiveTrue());
            
            RoomParticipant currentParticipant = participantRepository.findFirstByRoomIdAndUserId(id, currentUser.getId()).orElse(null);
            model.addAttribute("currentParticipant", currentParticipant);
            
            return "room-detail-learner";
        }

        List<JoinRequest> requests = joinRequestRepository.findByRoomIdAndUserIdOrderByRequestedAtDesc(id, currentUser.getId());
        if (!requests.isEmpty()) {
            JoinRequest latestRequest = requests.get(0);
            if ("PENDING".equals(latestRequest.getStatus())) {
                model.addAttribute("room", room);
                model.addAttribute("request", latestRequest);
                return "room-waiting";
            } else if ("DENIED".equals(latestRequest.getStatus())) {
                model.addAttribute("room", room);
                model.addAttribute("request", latestRequest);
                model.addAttribute("denied", true);
                return "room-join-request";
            }
        }

        // Level check
        if (room.getLevelNumber() != null) {
            int score = currentUser.getReputationScore() != null ? currentUser.getReputationScore() : 0;
            int userLevel = 1 + score / 100;
            if (userLevel < room.getLevelNumber()) {
                return "redirect:/courses/" + (room.getCourse() != null ? room.getCourse().getId() : "") + "?error=level_too_low";
            }
        }

        model.addAttribute("room", room);
        return "room-join-request";
    }


    @PostMapping("/rooms/{id}/add-participant")
    public String addParticipant(@PathVariable Long id,
                                 @RequestParam Long userId,
                                 @RequestParam String roleInRoom) {
        Room room = roomRepository.findById(id).orElse(null);
        AppUser user = userRepository.findById(userId).orElse(null);
        if (room == null || user == null) return "redirect:/rooms";

        boolean exists = participantRepository.existsByRoomIdAndUserId(id, userId);
        if (!exists) {
            RoomParticipant p = new RoomParticipant();
            p.setRoom(room);
            p.setUser(user);
            p.setDisplayName(user.getAnonymousMode() != null && user.getAnonymousMode() ? user.getAvatarPersona() : user.getDisplayName());
            p.setRoleInRoom(roleInRoom);
            p.setMicOn(false);
            p.setHandRaised(false);
            participantRepository.save(p);
        }

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
        RoomParticipant p = participantRepository.findById(participantId).orElse(null);
        if (p != null) {
            if (p.getJoinedAt() != null) {
                long durationSec = java.time.Duration.between(p.getJoinedAt(), LocalDateTime.now()).getSeconds();
                int points = (int) (durationSec / 60);
                if (points > 0 && p.getUser() != null) {
                    AppUser user = p.getUser();
                    user.setReputationScore((user.getReputationScore() != null ? user.getReputationScore() : 0) + points);
                    userRepository.save(user);
                }
            }
            participantRepository.deleteById(participantId);
        }
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
        java.net.URLEncoder.encode(gift.getName(), java.nio.charset.StandardCharsets.UTF_8);
        String encName = "";
        String encIcon = "";
        try {
            encName = java.net.URLEncoder.encode(gift.getName(), "UTF-8");
            encIcon = java.net.URLEncoder.encode(gift.getIcon(), "UTF-8");
        } catch(Exception e) {}

        return "redirect:/rooms/" + id + "?success=gift_sent&receiverId=" + receiverId + "&giftName=" + encName + "&giftIcon=" + encIcon + "&balance=" + sender.getCreditBalance();
    }

    @GetMapping("/rooms/{id}/go-live")
    public String goLiveRoom(@PathVariable Long id, jakarta.servlet.http.HttpSession session) {
        Room room = roomRepository.findById(id).orElse(null);
        if (room == null) return "redirect:/rooms";

        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        boolean isHost = room.getHostUser() != null && room.getHostUser().getId().equals(currentUser.getId());
        if (isHost && "SCHEDULED".equals(room.getStatus())) {
            room.setStatus("LIVE");
            room.setStartedAt(LocalDateTime.now());
            if (room.getChapter() != null) {
                List<Lesson> lessons = lessonRepository.findByChapterIdOrderByOrderIndexAsc(room.getChapter().getId());
                if (!lessons.isEmpty()) {
                    room.setCurrentLesson(lessons.get(0));
                    room.setStageStartedAt(LocalDateTime.now());
                }
            }
            roomRepository.save(room);
        }
        return "redirect:/rooms/" + id;
    }

    private void performRoomCleanup(Long id) {
        Room room = roomRepository.findById(id).orElse(null);
        if (room != null) {
            if (Boolean.TRUE.equals(room.getIsRecording())) {
                room.setIsRecording(false);
                
                PodcastEpisode episode = new PodcastEpisode();
                episode.setRoom(null);
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
            
            // Clean up related entities
            participantRepository.findByRoomId(id).forEach(p -> {
                if (p.getJoinedAt() != null) {
                    long pDurationSec = java.time.Duration.between(p.getJoinedAt(), LocalDateTime.now()).getSeconds();
                    int points = (int) (pDurationSec / 60);
                    if (points > 0 && p.getUser() != null) {
                        AppUser user = p.getUser();
                        user.setReputationScore((user.getReputationScore() != null ? user.getReputationScore() : 0) + points);
                        userRepository.save(user);
                    }
                }
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
        }
    }

    @GetMapping("/rooms/{id}/end")
    @Transactional
    public String endRoom(@PathVariable Long id) {
        performRoomCleanup(id);
        return "redirect:/rooms";
    }

    @GetMapping("/rooms/{roomId}/toggle-role/{participantId}")
    public String toggleRole(@PathVariable Long roomId, @PathVariable Long participantId) {
        RoomParticipant p = participantRepository.findById(participantId).orElse(null);
        if (p != null) {
            if ("SPEAKER".equals(p.getRoleInRoom())) {
                p.setRoleInRoom("LISTENER");
            } else {
                p.setRoleInRoom("SPEAKER");
            }
            participantRepository.save(p);
        }
        return "redirect:/rooms/" + roomId;
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

    @PostMapping("/rooms/{roomId}/approve-join/{requestId}")
    public String approveJoin(@PathVariable Long roomId, @PathVariable Long requestId) {
        JoinRequest jr = joinRequestRepository.findById(requestId).orElse(null);
        if (jr != null && jr.getRoom().getId().equals(roomId)) {
            jr.setStatus("APPROVED");
            jr.setRespondedAt(LocalDateTime.now());
            joinRequestRepository.save(jr);

            // Add participant
            RoomParticipant p = new RoomParticipant();
            p.setRoom(jr.getRoom());
            p.setUser(jr.getUser());
            p.setDisplayName(jr.getDisplayName());
            p.setRoleInRoom(jr.getRoleRequested() != null ? jr.getRoleRequested().toUpperCase() : "LISTENER");
            p.setMicOn(false);
            p.setHandRaised(false);
            participantRepository.save(p);
        }
        return "redirect:/rooms/" + roomId;
    }

    @PostMapping("/rooms/{roomId}/deny-join/{requestId}")
    public String denyJoin(@PathVariable Long roomId, @PathVariable Long requestId) {
        JoinRequest jr = joinRequestRepository.findById(requestId).orElse(null);
        if (jr != null && jr.getRoom().getId().equals(roomId)) {
            jr.setStatus("DENIED");
            jr.setRespondedAt(LocalDateTime.now());
            joinRequestRepository.save(jr);
        }
        return "redirect:/rooms/" + roomId;
    }

    @GetMapping("/rooms/delete/{id}")
    @Transactional
    public String deleteRoom(@PathVariable Long id) {
        performRoomCleanup(id);
        return "redirect:/rooms";
    }

    @GetMapping("/rooms/{id}/export-participants")
    public void exportParticipantsToExcel(@PathVariable Long id, HttpServletResponse response) throws IOException {
        Room room = roomRepository.findById(id).orElse(null);
        if (room == null) return;

        List<RoomParticipant> participants = participantRepository.findByRoomId(id);

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=room_" + id + "_participants.xlsx");

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Participants");

            // Header row
            Row headerRow = sheet.createRow(0);
            String[] columns = {"ID", "Display Name", "Role in Room", "Joined At"};
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                CellStyle style = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                style.setFont(font);
                cell.setCellStyle(style);
            }

            // Data rows
            int rowIdx = 1;
            for (RoomParticipant p : participants) {
                Row row = sheet.createRow(rowIdx++);
                row.createCell(0).setCellValue(p.getId());
                row.createCell(1).setCellValue(p.getDisplayName() != null ? p.getDisplayName() : "");
                row.createCell(2).setCellValue(p.getRoleInRoom() != null ? p.getRoleInRoom() : "");
                row.createCell(3).setCellValue(p.getJoinedAt() != null ? p.getJoinedAt().toString() : "");
            }

            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

            workbook.write(response.getOutputStream());
        }
    }
}
