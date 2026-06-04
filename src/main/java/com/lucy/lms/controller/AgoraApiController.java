package com.lucy.lms.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@Tag(name = "Agora Audio", description = "Agora RTC Token Server Simulation")
public class AgoraApiController {

    @GetMapping("/api/agora/token")
    @Operation(summary = "Generate a mock Agora RTC Token for a channel")
    public ResponseEntity<Map<String, Object>> generateAgoraToken(
            @RequestParam String channelName,
            @RequestParam String uid,
            @RequestParam(defaultValue = "publisher") String role
    ) {
        // Agora tokens are Base64 encoded byte streams containing AppId, AppCertificate, ChannelName, Uid, etc.
        // We will generate a structured mock token that developers/clients can parse.
        String rawTokenPayload = "LUCY-AGORA-APPID-123456789|" + channelName + "|" + uid + "|" + role + "|" + (System.currentTimeMillis() + 86400000);
        String mockToken = Base64.getEncoder().encodeToString(rawTokenPayload.getBytes(StandardCharsets.UTF_8));

        Map<String, Object> response = new LinkedHashMap<>();
        response.put("token", "006MOCK" + mockToken);
        response.put("channelName", channelName);
        response.put("uid", uid);
        response.put("role", role);
        response.put("appId", "lucy_mock_agora_app_id_999888");
        response.put("expiresInSeconds", 86400);

        return ResponseEntity.ok(response);
    }
}
