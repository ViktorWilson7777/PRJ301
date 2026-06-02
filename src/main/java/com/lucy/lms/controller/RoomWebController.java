package com.lucy.lms.controller;

import com.lucy.lms.entity.*;
import com.lucy.lms.repository.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

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

    public RoomWebController(RoomRepository roomRepository,
                             AppUserRepository userRepository,
                             CourseRepository courseRepository,
                             ChapterRepository chapterRepository,
                             LessonRepository lessonRepository,
                             RoomParticipantRepository participantRepository,
                             PinnedMaterialRepository pinnedMaterialRepository,
                             GiftRepository giftRepository,
                             GiftTransactionRepository giftTransactionRepository) {
        this.roomRepository = roomRepository;
        this.userRepository = userRepository;
        this.courseRepository = courseRepository;
        this.chapterRepository = chapterRepository;
        this.lessonRepository = lessonRepository;
        this.participantRepository = participantRepository;
        this.pinnedMaterialRepository = pinnedMaterialRepository;
        this.giftRepository = giftRepository;
        this.giftTransactionRepository = giftTransactionRepository;
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
            @RequestParam(required = false) String description
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

        if (hostUserId != null) room.setHostUser(userRepository.findById(hostUserId).orElse(null));
        if (courseId != null) room.setCourse(courseRepository.findById(courseId).orElse(null));
        if (chapterId != null) room.setChapter(chapterRepository.findById(chapterId).orElse(null));

        if ("LIVE".equals(status) && room.getStartedAt() == null) {
            room.setStartedAt(LocalDateTime.now());
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
                           @RequestParam Long giftId) {
        Room room = roomRepository.findById(id).orElse(null);
        AppUser sender = userRepository.findById(senderId).orElse(null);
        AppUser receiver = userRepository.findById(receiverId).orElse(null);
        Gift gift = giftRepository.findById(giftId).orElse(null);

        if (room == null || sender == null || receiver == null || gift == null) {
            return "redirect:/rooms/" + id;
        }

        int cost = gift.getCreditCost() != null ? gift.getCreditCost() : 0;

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

        return "redirect:/rooms/" + id;
    }

    @GetMapping("/rooms/{id}/end")
    public String endRoom(@PathVariable Long id) {
        Room room = roomRepository.findById(id).orElse(null);
        if (room != null) {
            room.setStatus("ENDED");
            room.setEndedAt(LocalDateTime.now());
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
