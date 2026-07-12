package com.lucy.lms.controller;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.repository.AppUserRepository;
import com.lucy.lms.service.EmailService;
import com.lucy.lms.service.ProgramProgressService;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Controller
@SuppressWarnings("null")
public class AuthWebController {

    private static final long OTP_EXPIRY_MS = 5 * 60 * 1000L;
    private static final long OTP_RESEND_MS = 60 * 1000L;
    private static final SecureRandom SECURE_RANDOM = new SecureRandom();

    private final AppUserRepository userRepository;
    private final EmailService emailService;
    private final ProgramProgressService progressService;

    public AuthWebController(AppUserRepository userRepository, EmailService emailService,
                             ProgramProgressService progressService) {
        this.userRepository = userRepository;
        this.emailService = emailService;
        this.progressService = progressService;
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
            RedirectAttributes redirectAttributes
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
                if (!Boolean.TRUE.equals(user.getActive()) || "PENDING".equals(user.getRegistrationStatus())) {
                    redirectAttributes.addFlashAttribute("error", "Your account is waiting for approval or is inactive.");
                    return "redirect:/login";
                }
                session.setAttribute("currentUser", user);
                return "redirect:/dashboard";
            }
        }
        redirectAttributes.addFlashAttribute("error", "Invalid email or password!");
        redirectAttributes.addFlashAttribute("email", email);
        return "redirect:/login";
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
        String normalizedEmail = email == null ? "" : email.trim().toLowerCase();
        if (!normalizedEmail.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            response.put("success", false);
            response.put("message", "Please enter a valid email address.");
            return response;
        }
        if (userRepository.findByEmailIgnoreCase(normalizedEmail).isPresent()) {
            response.put("success", false);
            response.put("message", "Email is already registered!");
            return response;
        }

        Long lastSent = (Long) session.getAttribute("registration_otp_sent_" + normalizedEmail);
        if (lastSent != null && System.currentTimeMillis() - lastSent < OTP_RESEND_MS) {
            response.put("success", false);
            response.put("retryAfter", (OTP_RESEND_MS - (System.currentTimeMillis() - lastSent) + 999) / 1000);
            response.put("message", "Please wait before requesting another code.");
            return response;
        }

        String otp = String.format("%06d", SECURE_RANDOM.nextInt(1_000_000));
        if (!emailService.sendOtpEmail(normalizedEmail, otp)) {
            response.put("success", false);
            response.put("message", "Email is not configured or Gmail rejected the message. Check the SMTP settings.");
            return response;
        }
        session.setAttribute("registration_otp_" + normalizedEmail, otp);
        session.setAttribute("registration_otp_time_" + normalizedEmail, System.currentTimeMillis());
        session.setAttribute("registration_otp_sent_" + normalizedEmail, System.currentTimeMillis());

        response.put("success", true);
        response.put("message", "OTP sent successfully to " + normalizedEmail);
        return response;
    }

    @PostMapping("/register")
    public String register(
            @RequestParam String fullName,
            @RequestParam String email,
            @RequestParam String displayName,
            @RequestParam String password,
            @RequestParam String otp,
            @RequestParam(defaultValue = "LEARNER") String accountType,
            @RequestParam(required = false) String evidenceUrl,
            @RequestParam(required = false) String achievements,
            @RequestParam(required = false) String anonymousMode,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        String normalizedEmail = email.trim().toLowerCase();
        if (userRepository.findByEmailIgnoreCase(normalizedEmail).isPresent()) {
            redirectAttributes.addFlashAttribute("error", "Email is already registered!");
            return "redirect:/register";
        }

        // Validate OTP
        String sessionOtp = (String) session.getAttribute("registration_otp_" + normalizedEmail);
        Long otpTime = (Long) session.getAttribute("registration_otp_time_" + normalizedEmail);

        if (sessionOtp == null || otpTime == null || !sessionOtp.equals(otp)) {
            redirectAttributes.addFlashAttribute("error", "Invalid OTP or email!");
            return "redirect:/register";
        }

        if (System.currentTimeMillis() - otpTime > OTP_EXPIRY_MS) {
            redirectAttributes.addFlashAttribute("error", "OTP has expired. Please request a new one.");
            return "redirect:/register";
        }

        if (password.length() < 8) {
            redirectAttributes.addFlashAttribute("error", "Password must contain at least 8 characters.");
            return "redirect:/register";
        }
        if ("PRO_MENTOR".equals(accountType)
                && ((evidenceUrl == null || evidenceUrl.isBlank()) || (achievements == null || achievements.isBlank()))) {
            redirectAttributes.addFlashAttribute("error", "Pro Mentor applications require an evidence link and achievements.");
            return "redirect:/register";
        }
        
        // Remove OTP from session after successful validation
        session.removeAttribute("registration_otp_" + normalizedEmail);
        session.removeAttribute("registration_otp_time_" + normalizedEmail);
        session.removeAttribute("registration_otp_sent_" + normalizedEmail);

        AppUser user = new AppUser();
        user.setFullName(fullName);
        user.setEmail(normalizedEmail);
        user.setDisplayName(displayName);
        // Hash password
        user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt(12)));
        boolean isProApplication = "PRO_MENTOR".equals(accountType);
        boolean isCreator = "CONTENT_CREATOR".equals(accountType);
        user.setAccountType(isProApplication ? "PRO_MENTOR" : (isCreator ? "CONTENT_CREATOR" : "LEARNER"));
        user.setRole(isProApplication ? "PRO_MENTOR" : (isCreator ? "SUPER_CREATOR" : "LEARNER"));
        user.setRegistrationStatus(isProApplication ? "PENDING" : "APPROVED");
        user.setEvidenceUrl(isProApplication ? evidenceUrl.trim() : null);
        user.setAchievements(isProApplication ? achievements.trim() : null);
        user.setCreditBalance(100.0); // starter credits
        user.setReputationScore(0);
        user.setAnonymousMode("LEARNER".equals(user.getAccountType()) && anonymousMode != null);
        user.setCreatedAt(LocalDateTime.now());
        user.setActive(!isProApplication);

        userRepository.save(user);
        if (isProApplication) {
            emailService.notifyAdminAboutProApplication(user.getId(), user.getFullName());
            redirectAttributes.addFlashAttribute("success", "Application submitted. You can sign in after an administrator approves it.");
            return "redirect:/login";
        }
        session.setAttribute("currentUser", user);
        if (isCreator) {
            redirectAttributes.addFlashAttribute("success", "Content Creator registration completed with mock payment of 100,000 VND.");
        }
        return "redirect:/dashboard";
    }

    @GetMapping("/forgot-password")
    public String forgotPasswordPage(HttpSession session) {
        if (session.getAttribute("currentUser") != null) return "redirect:/dashboard";
        return "forgot-password";
    }

    @PostMapping("/forgot-password/send-otp")
    @ResponseBody
    public Map<String, Object> sendResetOtp(@RequestParam String email, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        String normalizedEmail = email == null ? "" : email.trim().toLowerCase();
        if (userRepository.findByEmailIgnoreCase(normalizedEmail).isEmpty()) {
            response.put("success", false);
            response.put("message", "No account was found for this email.");
            return response;
        }
        Long lastSent = (Long) session.getAttribute("reset_otp_sent_" + normalizedEmail);
        if (lastSent != null && System.currentTimeMillis() - lastSent < OTP_RESEND_MS) {
            response.put("success", false);
            response.put("retryAfter", (OTP_RESEND_MS - (System.currentTimeMillis() - lastSent) + 999) / 1000);
            response.put("message", "Please wait before requesting another code.");
            return response;
        }
        String otp = String.format("%06d", SECURE_RANDOM.nextInt(1_000_000));
        if (!emailService.sendOtpEmail(normalizedEmail, otp, "password reset")) {
            response.put("success", false);
            response.put("message", "Could not send email. Check the Gmail SMTP configuration.");
            return response;
        }
        session.setAttribute("reset_otp_" + normalizedEmail, otp);
        session.setAttribute("reset_otp_time_" + normalizedEmail, System.currentTimeMillis());
        session.setAttribute("reset_otp_sent_" + normalizedEmail, System.currentTimeMillis());
        response.put("success", true);
        response.put("message", "A reset code was sent to your email.");
        return response;
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam String email,
                                @RequestParam String otp,
                                @RequestParam String newPassword,
                                @RequestParam String confirmPassword,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        String normalizedEmail = email.trim().toLowerCase();
        String savedOtp = (String) session.getAttribute("reset_otp_" + normalizedEmail);
        Long sentAt = (Long) session.getAttribute("reset_otp_time_" + normalizedEmail);
        if (savedOtp == null || sentAt == null || !savedOtp.equals(otp)
                || System.currentTimeMillis() - sentAt > OTP_EXPIRY_MS) {
            redirectAttributes.addFlashAttribute("error", "The reset code is invalid or expired.");
            return "redirect:/forgot-password";
        }
        if (newPassword.length() < 8 || !newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Passwords must match and contain at least 8 characters.");
            return "redirect:/forgot-password";
        }
        AppUser user = userRepository.findByEmailIgnoreCase(normalizedEmail).orElse(null);
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Account not found.");
            return "redirect:/forgot-password";
        }
        user.setPassword(BCrypt.hashpw(newPassword, BCrypt.gensalt(12)));
        userRepository.save(user);
        session.removeAttribute("reset_otp_" + normalizedEmail);
        session.removeAttribute("reset_otp_time_" + normalizedEmail);
        session.removeAttribute("reset_otp_sent_" + normalizedEmail);
        redirectAttributes.addFlashAttribute("success", "Password changed successfully. Please sign in again.");
        return "redirect:/login";
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
        model.addAttribute("programLevels", progressService.levelsForUser(freshUser));
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

        // Pro Mentor is earned through course completion or granted by an administrator.
        double cost = switch (newRole) {
            case "SUPER_CREATOR" -> 100000.0;
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
        user.setAccountType("CONTENT_CREATOR");
        if (!"PRO_MENTOR".equals(user.getRole())) user.setRole("SUPER_CREATOR");
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
                if (file.getSize() > 2 * 1024 * 1024L
                        || file.getContentType() == null
                        || !file.getContentType().startsWith("image/")) {
                    return "redirect:/profile?error=invalid_avatar";
                }
                java.nio.file.Path uploadPath = java.nio.file.Paths.get("uploads/avatars").toAbsolutePath().normalize();
                if (!java.nio.file.Files.exists(uploadPath)) {
                    java.nio.file.Files.createDirectories(uploadPath);
                }
                String original = file.getOriginalFilename() == null ? "avatar.jpg" : file.getOriginalFilename();
                String safeOriginal = java.nio.file.Paths.get(original).getFileName().toString()
                        .replaceAll("[^a-zA-Z0-9._-]", "_");
                String filename = currentUser.getId() + "_" + System.currentTimeMillis() + "_" + safeOriginal;
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
