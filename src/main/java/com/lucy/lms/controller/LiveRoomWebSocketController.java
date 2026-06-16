package com.lucy.lms.controller;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import java.util.concurrent.ConcurrentHashMap;

@Controller
public class LiveRoomWebSocketController {

    private final ConcurrentHashMap<String, Integer> roomViewers = new ConcurrentHashMap<>();

    public static class LiveRoomMessage {
        public String type; // CHAT, JOIN, LEAVE, RAISE_HAND, FOLLOW, SYSTEM
        public String senderName;
        public String content;
        public int viewCount;
    }

    @MessageMapping("/room/{roomId}")
    @SendTo("/topic/room/{roomId}")
    public LiveRoomMessage broadcastMessage(@DestinationVariable String roomId, @Payload LiveRoomMessage message) {
        
        if ("JOIN".equals(message.type)) {
            roomViewers.compute(roomId, (k, v) -> v == null ? 1 : v + 1);
        } else if ("LEAVE".equals(message.type)) {
            roomViewers.compute(roomId, (k, v) -> (v == null || v <= 1) ? 0 : v - 1);
        }
        
        message.viewCount = roomViewers.getOrDefault(roomId, 0);
        return message;
    }
}
