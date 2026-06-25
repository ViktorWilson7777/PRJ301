package com.lucy.lms.controller;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.repository.AppUserRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Tag(name = "User", description = "User Management APIs")
@SuppressWarnings("null")
public class UserApiController {

    private final AppUserRepository userRepository;
    private final com.lucy.lms.repository.UserFollowRepository userFollowRepository;

    public UserApiController(AppUserRepository userRepository, com.lucy.lms.repository.UserFollowRepository userFollowRepository) {
        this.userRepository = userRepository;
        this.userFollowRepository = userFollowRepository;
    }

    @GetMapping("/api/users")
    @Operation(summary = "List all users")
    public List<AppUser> getUsers(@RequestParam(required = false) String role) {
        if (role != null && !role.isBlank()) {
            return userRepository.findByRole(role);
        }
        return userRepository.findAll();
    }

    @GetMapping("/api/users/{id}")
    @Operation(summary = "Get user by ID")
    public ResponseEntity<AppUser> getUser(@PathVariable Long id) {
        return userRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/api/users/{id}/toggle-follow")
    @Operation(summary = "Toggle follow status for a user")
    public ResponseEntity<java.util.Map<String, Object>> toggleFollow(@PathVariable Long id, jakarta.servlet.http.HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) {
            return ResponseEntity.status(401).build();
        }

        if (currentUser.getId().equals(id)) {
            return ResponseEntity.badRequest().body(java.util.Map.of("error", "Cannot follow yourself"));
        }

        AppUser targetUser = userRepository.findById(id).orElse(null);
        if (targetUser == null) {
            return ResponseEntity.notFound().build();
        }

        boolean isFollowing = userFollowRepository.existsByFollowerIdAndFollowingId(currentUser.getId(), id);
        if (isFollowing) {
            userFollowRepository.findByFollowerIdAndFollowingId(currentUser.getId(), id).ifPresent(userFollowRepository::delete);
            isFollowing = false;
        } else {
            com.lucy.lms.entity.UserFollow newFollow = new com.lucy.lms.entity.UserFollow();
            newFollow.setFollower(currentUser);
            newFollow.setFollowing(targetUser);
            userFollowRepository.save(newFollow);
            isFollowing = true;
        }

        long followerCount = userFollowRepository.countByFollowingId(id);
        return ResponseEntity.ok(java.util.Map.of("isFollowing", isFollowing, "followerCount", followerCount));
    }

    @GetMapping("/api/users/{id}/follow-status")
    @Operation(summary = "Get follow status and count for a user")
    public ResponseEntity<java.util.Map<String, Object>> getFollowStatus(@PathVariable Long id, jakarta.servlet.http.HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        boolean isFollowing = false;
        if (currentUser != null) {
            isFollowing = userFollowRepository.existsByFollowerIdAndFollowingId(currentUser.getId(), id);
        }
        long followerCount = userFollowRepository.countByFollowingId(id);
        return ResponseEntity.ok(java.util.Map.of("isFollowing", isFollowing, "followerCount", followerCount));
    }
}
