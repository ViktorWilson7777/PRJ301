package com.lucy.lms.controller;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.repository.AppUserRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
@SuppressWarnings("null")
public class UserWebController {

    private final AppUserRepository userRepository;

    public UserWebController(AppUserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("/users")
    public String users(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "users";
    }

    @GetMapping("/users/create")
    public String createUserPage(Model model) {
        model.addAttribute("user", new AppUser());
        return "user-form";
    }

    @PostMapping("/users/save")
    public String saveUser(
            @RequestParam(required = false) Long id,
            @RequestParam String fullName,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String displayName,
            @RequestParam(required = false) String avatarPersona,
            @RequestParam String role,
            @RequestParam(required = false) String anonymousMode,
            @RequestParam(required = false) Double creditBalance,
            @RequestParam(required = false) Integer reputationScore,
            @RequestParam(required = false) String active
    ) {
        AppUser user;
        if (id != null) {
            user = userRepository.findById(id).orElse(new AppUser());
        } else {
            user = new AppUser();
            user.setCreatedAt(LocalDateTime.now());
        }

        user.setFullName(fullName);
        user.setEmail(email);
        user.setDisplayName(displayName);
        user.setAvatarPersona(avatarPersona);
        user.setRole(role);
        user.setAnonymousMode(anonymousMode != null);
        user.setCreditBalance(creditBalance != null ? creditBalance : 0.0);
        user.setReputationScore(reputationScore != null ? reputationScore : 0);
        user.setActive(active != null);

        userRepository.save(user);
        return "redirect:/users";
    }

    @GetMapping("/users/edit/{id}")
    public String editUserPage(@PathVariable Long id, Model model) {
        AppUser user = userRepository.findById(id).orElse(null);
        if (user == null) return "redirect:/users";
        model.addAttribute("user", user);
        return "user-form";
    }

    @GetMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable Long id) {
        userRepository.deleteById(id);
        return "redirect:/users";
    }
}
