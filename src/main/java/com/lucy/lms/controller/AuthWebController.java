package com.lucy.lms.controller;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.repository.AppUserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.Optional;

@Controller
@SuppressWarnings("null")
public class AuthWebController {

    private final AppUserRepository userRepository;

    public AuthWebController(AppUserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("/login")
    public String loginPage(HttpSession session, Model model) {
        if (session.getAttribute("currentUser") != null) {
            return "redirect:/dashboard";
        }
        return "login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model
    ) {
        Optional<AppUser> userOpt = userRepository.findByEmail(email);
        if (userOpt.isPresent()) {
            AppUser user = userOpt.get();
            if (password.equals(user.getPassword())) {
                session.setAttribute("currentUser", user);
                return "redirect:/dashboard";
            }
        }
        model.addAttribute("error", "Invalid email or password!");
        return "login";
    }

    @GetMapping("/register")
    public String registerPage(HttpSession session) {
        if (session.getAttribute("currentUser") != null) {
            return "redirect:/dashboard";
        }
        return "register";
    }

    @PostMapping("/register")
    public String register(
            @RequestParam String fullName,
            @RequestParam String email,
            @RequestParam String displayName,
            @RequestParam String password,
            HttpSession session,
            Model model
    ) {
        if (userRepository.findByEmail(email).isPresent()) {
            model.addAttribute("error", "Email is already registered!");
            return "register";
        }

        AppUser user = new AppUser();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setDisplayName(displayName);
        user.setPassword(password);
        user.setRole("LEARNER"); // default role
        user.setCreditBalance(100.0); // starter credits
        user.setReputationScore(0);
        user.setAnonymousMode(false);
        user.setCreatedAt(LocalDateTime.now());
        user.setActive(true);

        userRepository.save(user);
        session.setAttribute("currentUser", user);
        return "redirect:/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("currentUser");
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/profile")
    public String profilePage(HttpSession session, Model model) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }
        // Fetch fresh copy from database
        AppUser freshUser = userRepository.findById(currentUser.getId()).orElse(currentUser);
        model.addAttribute("user", freshUser);
        return "profile";
    }

    @PostMapping("/profile/save")
    public String saveProfile(
            @RequestParam String fullName,
            @RequestParam String displayName,
            @RequestParam String avatarPersona,
            @RequestParam(required = false) String anonymousMode,
            HttpSession session,
            Model model
    ) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        AppUser user = userRepository.findById(currentUser.getId()).orElse(null);
        if (user != null) {
            user.setFullName(fullName);
            user.setDisplayName(displayName);
            user.setAvatarPersona(avatarPersona);
            user.setAnonymousMode(anonymousMode != null);
            userRepository.save(user);
            session.setAttribute("currentUser", user);
        }
        return "redirect:/profile?success=profile_updated";
    }

    @PostMapping("/profile/upgrade")
    public String upgradeRole(
            @RequestParam String newRole,
            HttpSession session,
            Model model
    ) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        AppUser user = userRepository.findById(currentUser.getId()).orElse(null);
        if (user == null) {
            return "redirect:/login";
        }

        // Upgrading fees
        double cost = switch (newRole) {
            case "PRO_MENTOR"    -> 150.0;
            case "SUPER_CREATOR" -> 300.0;
            default -> -1.0;
        };
        if (cost < 0) {
            return "redirect:/profile?error=invalid_role";
        }

        if (user.getRole().equals(newRole)) {
            return "redirect:/profile?error=already_role";
        }

        if (user.getCreditBalance() < cost) {
            return "redirect:/profile?error=insufficient_credits";
        }

        user.setCreditBalance(user.getCreditBalance() - cost);
        user.setRole(newRole);
        userRepository.save(user);
        session.setAttribute("currentUser", user);

        return "redirect:/profile?success=role_upgraded";
    }
}
