package com.lucy.lms.controller;

import io.agora.media.RtcTokenBuilder2;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@Tag(name = "Agora Audio", description = "Agora RTC Token Server Simulation")
public class AgoraApiController {

    private static final String APP_ID = "1adc56609faa4f95b208d10e17d60786";
    private static final String APP_CERTIFICATE = "4fdb68cd884644c4b62c864cfe10545c";

    @GetMapping("/api/agora/token")
    @Operation(summary = "Generate a real Agora RTC Token for a channel")
    public ResponseEntity<Map<String, Object>> generateAgoraToken(
            @RequestParam String channelName,
            @RequestParam String uid,
            @RequestParam(defaultValue = "publisher") String role
    ) {
        int tokenExpirationInSeconds = 86400;
        int privilegeExpirationInSeconds = 86400;

        int uidInt;
        try {
            uidInt = Integer.parseInt(uid);
        } catch (NumberFormatException e) {
            uidInt = 0;
        }

        RtcTokenBuilder2 tokenBuilder = new RtcTokenBuilder2();
        
        RtcTokenBuilder2.Role agoraRole = role.equalsIgnoreCase("publisher") 
            ? RtcTokenBuilder2.Role.ROLE_PUBLISHER 
            : RtcTokenBuilder2.Role.ROLE_SUBSCRIBER;

        String resultToken = tokenBuilder.buildTokenWithUid(
                APP_ID, 
                APP_CERTIFICATE, 
                channelName, 
                uidInt, 
                agoraRole, 
                tokenExpirationInSeconds, 
                privilegeExpirationInSeconds
        );

        Map<String, Object> response = new LinkedHashMap<>();
        response.put("token", resultToken);
        response.put("channelName", channelName);
        response.put("uid", uid);
        response.put("role", role);
        response.put("appId", APP_ID);
        response.put("expiresInSeconds", tokenExpirationInSeconds);

        return ResponseEntity.ok(response);
    }
}
