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

    public UserApiController(AppUserRepository userRepository) {
        this.userRepository = userRepository;
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
}
