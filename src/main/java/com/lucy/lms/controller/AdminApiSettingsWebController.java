package com.lucy.lms.controller;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.service.OpenRouterSettingsService;
import com.lucy.lms.service.RuntimeMailSettingsService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AdminApiSettingsWebController {

    private final OpenRouterSettingsService openRouterSettings;
    private final RuntimeMailSettingsService mailSettings;

    public AdminApiSettingsWebController(OpenRouterSettingsService openRouterSettings,
                                         RuntimeMailSettingsService mailSettings) {
        this.openRouterSettings = openRouterSettings;
        this.mailSettings = mailSettings;
    }

    @GetMapping("/admin/api-settings")
    public String settingsPage(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard?error=access_denied";
        }

        OpenRouterSettingsService.Settings current = openRouterSettings.current();
        model.addAttribute("apiConfigured", openRouterSettings.isConfigured());
        model.addAttribute("maskedApiKey", openRouterSettings.maskedApiKey());
        model.addAttribute("openRouterModel", current.model());
        model.addAttribute("smtpConfigured", mailSettings.isConfigured());
        model.addAttribute("maskedMailUsername", mailSettings.maskedSenderAddress());
        model.addAttribute("maskedMailPassword", mailSettings.maskedPassword());
        model.addAttribute("smtpEnvironmentConfigured", hasText(System.getenv("LUCY_MAIL_USERNAME"))
                && hasText(System.getenv("LUCY_MAIL_APP_PASSWORD")));
        return "admin-api-settings";
    }

    @PostMapping("/admin/api-settings")
    public String updateSettings(
            @RequestParam(required = false) String apiKey,
            @RequestParam(required = false) String model,
            @RequestParam(defaultValue = "false") boolean clearApiKey,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard?error=access_denied";
        }

        try {
            openRouterSettings.update(apiKey, model, clearApiKey);
            redirectAttributes.addFlashAttribute("settingsSuccess",
                    clearApiKey
                            ? "OpenRouter key removed. AI features are now using preview data."
                            : "OpenRouter settings updated and active immediately.");
        } catch (IllegalArgumentException exception) {
            redirectAttributes.addFlashAttribute("settingsError", exception.getMessage());
        }

        return "redirect:/admin/api-settings";
    }

    @PostMapping("/admin/api-settings/email")
    public String updateEmailSettings(
            @RequestParam(required = false) String mailUsername,
            @RequestParam(required = false) String mailAppPassword,
            @RequestParam(defaultValue = "false") boolean clearMailCredentials,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard?error=access_denied";
        }

        try {
            mailSettings.update(mailUsername, mailAppPassword, clearMailCredentials);
            redirectAttributes.addFlashAttribute("mailSettingsSuccess",
                    clearMailCredentials
                            ? "Email credentials removed. OTP delivery is now disabled."
                            : "Email settings updated and active immediately.");
        } catch (IllegalArgumentException exception) {
            redirectAttributes.addFlashAttribute("mailSettingsError", exception.getMessage());
        }

        return "redirect:/admin/api-settings";
    }

    private boolean isAdmin(HttpSession session) {
        Object currentUser = session.getAttribute("currentUser");
        return currentUser instanceof AppUser user && "ADMIN".equals(user.getRole());
    }

    private boolean hasText(String value) {
        return value != null && !value.isBlank();
    }
}
