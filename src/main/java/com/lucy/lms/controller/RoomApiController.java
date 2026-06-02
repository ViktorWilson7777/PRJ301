package com.lucy.lms.controller;

import com.lucy.lms.entity.Room;
import com.lucy.lms.entity.RoomParticipant;
import com.lucy.lms.repository.RoomParticipantRepository;
import com.lucy.lms.repository.RoomRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@Tag(name = "Room", description = "Mock Room Management APIs")
@SuppressWarnings("null")
public class RoomApiController {

    private final RoomRepository roomRepository;
    private final RoomParticipantRepository participantRepository;

    public RoomApiController(RoomRepository roomRepository,
                             RoomParticipantRepository participantRepository) {
        this.roomRepository = roomRepository;
        this.participantRepository = participantRepository;
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
}
