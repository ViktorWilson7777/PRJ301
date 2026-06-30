package com.lucy.lms.controller;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.repository.AppUserRepository;
import com.lucy.lms.service.EmailService;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

@Controller
@SuppressWarnings("null")
public class AuthWebController {

    private final AppUserRepository userRepository;
    private final EmailService emailService;

    public AuthWebController(AppUserRepository userRepository, EmailService emailService) {
        this.userRepository = userRepository;
        this.emailService = emailService;
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
            // Check password using BCrypt. Also fallback to plain text for old users
            boolean passwordMatch = false;
            try {
                if (user.getPassword() != null && user.getPassword().startsWith("$2a$")) {
                    passwordMatch = BCrypt.checkpw(password, user.getPassword());
                } else {
                    passwordMatch = password.equals(user.getPassword());
                }
            } catch (Exception e) {
                passwordMatch = false;
            }
            
            if (passwordMatch) {
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

    @PostMapping("/send-otp")
    @ResponseBody
    public Map<String, Object> sendOtp(@RequestParam String email, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        if (userRepository.findByEmail(email).isPresent()) {
            response.put("success", false);
            response.put("message", "Email is already registered!");
            return response;
        }

        // Generate 6-digit OTP
        String otp = String.format("%06d", new Random().nextInt(999999));
        session.setAttribute("registration_otp_" + email, otp);
        session.setAttribute("registration_otp_time_" + email, System.currentTimeMillis());

        emailService.sendOtpEmail(email, otp);

        response.put("success", true);
        response.put("message", "OTP sent successfully to " + email);
        return response;
    }

    @PostMapping("/register")
    public String register(
            @RequestParam String fullName,
            @RequestParam String email,
            @RequestParam String displayName,
            @RequestParam String password,
            @RequestParam String otp,
            HttpSession session,
            Model model
    ) {
        if (userRepository.findByEmail(email).isPresent()) {
            model.addAttribute("error", "Email is already registered!");
            return "register";
        }

        // Validate OTP
        String sessionOtp = (String) session.getAttribute("registration_otp_" + email);
        Long otpTime = (Long) session.getAttribute("registration_otp_time_" + email);

        if (sessionOtp == null || otpTime == null || !sessionOtp.equals(otp)) {
            model.addAttribute("error", "Invalid OTP or email!");
            return "register";
        }

        if (System.currentTimeMillis() - otpTime > 5 * 60 * 1000) { // 5 minutes expiration
            model.addAttribute("error", "OTP has expired. Please request a new one.");
            return "register";
        }
        
        // Remove OTP from session after successful validation
        session.removeAttribute("registration_otp_" + email);
        session.removeAttribute("registration_otp_time_" + email);

        AppUser user = new AppUser();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setDisplayName(displayName);
        // Hash password
        user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt(12)));
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

    @PostMapping("/profile/change-password")
    public String changePassword(
            @RequestParam String currentPassword,
            @RequestParam String newPassword,
            HttpSession session
    ) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        AppUser user = userRepository.findById(currentUser.getId()).orElse(null);
        if (user != null) {
            boolean passwordMatch = false;
            try {
                if (user.getPassword() != null && user.getPassword().startsWith("$2a$")) {
                    passwordMatch = BCrypt.checkpw(currentPassword, user.getPassword());
                } else {
                    passwordMatch = currentPassword.equals(user.getPassword());
                }
            } catch (Exception e) {
                passwordMatch = false;
            }

            if (!passwordMatch) {
                return "redirect:/profile?error=wrong_password";
            }
            user.setPassword(BCrypt.hashpw(newPassword, BCrypt.gensalt(12)));
            userRepository.save(user);
            session.setAttribute("currentUser", user);
        }
        return "redirect:/profile?success=password_changed";
    }

    @PostMapping("/profile/upload-avatar")
    public String uploadAvatar(
            @RequestParam("avatarFile") org.springframework.web.multipart.MultipartFile file,
            HttpSession session
    ) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        if (!file.isEmpty()) {
            try {
                java.nio.file.Path uploadPath = java.nio.file.Paths.get("uploads/avatars");
                if (!java.nio.file.Files.exists(uploadPath)) {
                    java.nio.file.Files.createDirectories(uploadPath);
                }
                String filename = currentUser.getId() + "_" + file.getOriginalFilename();
                java.nio.file.Path filePath = uploadPath.resolve(filename);
                file.transferTo(filePath.toFile());

                AppUser user = userRepository.findById(currentUser.getId()).orElse(null);
                if (user != null) {
                    user.setAvatarUrl("/uploads/avatars/" + filename);
                    userRepository.save(user);
                    session.setAttribute("currentUser", user);
                }
            } catch (java.io.IOException | java.lang.IllegalStateException e) {
                // Log error properly in a real app
                return "redirect:/profile?error=upload_failed";
            }
        }
        return "redirect:/profile?success=avatar_uploaded";
    }
}
