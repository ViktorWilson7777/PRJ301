package com.lucy.lms.service;

import org.springframework.beans.factory.ObjectProvider;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import java.util.concurrent.atomic.AtomicReference;

/** Keeps Gmail SMTP credentials in memory and applies changes immediately. */
@Service
public class RuntimeMailSettingsService {

    private final JavaMailSender mailSender;
    private final AtomicReference<Settings> settings;

    public RuntimeMailSettingsService(
            ObjectProvider<JavaMailSender> mailSenderProvider,
            @Value("${spring.mail.username:}") String configuredUsername,
            @Value("${spring.mail.password:}") String configuredPassword
    ) {
        this.mailSender = mailSenderProvider.getIfAvailable();
        this.settings = new AtomicReference<>(new Settings(
                normalizeUsername(configuredUsername),
                normalizePassword(configuredPassword)
        ));
        applyToMailSender(this.settings.get());
    }

    public boolean isConfigured() {
        Settings current = settings.get();
        return mailSender != null && !current.username().isBlank() && !current.password().isBlank();
    }

    public String senderAddress() {
        return settings.get().username();
    }

    public String maskedSenderAddress() {
        String username = settings.get().username();
        if (username.isBlank()) {
            return "Not configured";
        }

        int separator = username.indexOf('@');
        if (separator <= 0) {
            return "\u2022\u2022\u2022\u2022\u2022\u2022";
        }

        String localPart = username.substring(0, separator);
        String visibleStart = localPart.substring(0, 1);
        return visibleStart + "\u2022\u2022\u2022\u2022@" + username.substring(separator + 1);
    }

    public String maskedPassword() {
        return settings.get().password().isBlank() ? "Not configured" : "\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022";
    }

    /** Blank fields retain their current values unless clearCredentials is selected. */
    public void update(String newUsername, String newPassword, boolean clearCredentials) {
        String suppliedUsername = normalizeUsername(newUsername);
        String suppliedPassword = normalizePassword(newPassword);

        if (!suppliedUsername.isBlank() && !looksLikeEmail(suppliedUsername)) {
            throw new IllegalArgumentException("Enter a valid Gmail address.");
        }
        if (!suppliedPassword.isBlank() && suppliedPassword.length() != 16) {
            throw new IllegalArgumentException("The Gmail App Password must contain exactly 16 characters.");
        }

        Settings updated = settings.updateAndGet(previous -> {
            if (clearCredentials) {
                return new Settings("", "");
            }

            String username = suppliedUsername.isBlank() ? previous.username() : suppliedUsername;
            String password = suppliedPassword.isBlank() ? previous.password() : suppliedPassword;
            if (username.isBlank() != password.isBlank()) {
                throw new IllegalArgumentException("Configure both the Gmail address and App Password together.");
            }
            return new Settings(username, password);
        });
        applyToMailSender(updated);
    }

    private void applyToMailSender(Settings current) {
        if (mailSender instanceof JavaMailSenderImpl sender) {
            sender.setUsername(current.username());
            sender.setPassword(current.password());
        }
    }

    private static boolean looksLikeEmail(String value) {
        int separator = value.indexOf('@');
        return separator > 0 && separator < value.length() - 3 && value.indexOf('.', separator) > separator + 1;
    }

    private static String normalizeUsername(String value) {
        return value == null ? "" : value.trim();
    }

    private static String normalizePassword(String value) {
        return value == null ? "" : value.replaceAll("\\s+", "");
    }

    private record Settings(String username, String password) {
    }
}
