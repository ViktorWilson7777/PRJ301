package com.lucy.lms.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    private final JavaMailSender mailSender;
    private final RuntimeMailSettingsService mailSettings;

    @Value("${lucy.admin.email:}")
    private String adminEmail;

    public EmailService(ObjectProvider<JavaMailSender> mailSenderProvider,
                        RuntimeMailSettingsService mailSettings) {
        this.mailSender = mailSenderProvider.getIfAvailable();
        this.mailSettings = mailSettings;
    }

    public boolean sendOtpEmail(String to, String otp) {
        return sendOtpEmail(to, otp, "registration");
    }

    public boolean sendOtpEmail(String to, String otp, String purpose) {
        String senderAddress = mailSettings.senderAddress();
        if (mailSender == null || !mailSettings.isConfigured()) return false;
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(senderAddress);
            message.setTo(to);
            boolean reset = "password reset".equalsIgnoreCase(purpose);
            message.setSubject(reset ? "LUCY LMS - Password reset code" : "LUCY LMS - Registration code");
            message.setText("Your LUCY verification code is: " + otp
                    + "\n\nThis code expires in 5 minutes. If you did not request it, ignore this email.");
            
            mailSender.send(message);
            return true;
        } catch (Exception e) {
            System.err.println("Failed to send OTP email: " + e.getMessage());
            return false;
        }
    }

    public void notifyAdminAboutProApplication(Long userId, String applicantName) {
        String senderAddress = mailSettings.senderAddress();
        if (mailSender == null || adminEmail == null || adminEmail.isBlank()
                || !mailSettings.isConfigured()) return;
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(senderAddress);
            message.setTo(adminEmail);
            message.setSubject("LUCY LMS - New Pro Mentor application");
            message.setText(applicantName + " submitted a Pro Mentor application.\n\nReview: http://localhost:8081/pro-applications?review=" + userId);
            mailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to notify admin: " + e.getMessage());
        }
    }

    public void sendApplicationDecision(String recipient, boolean approved) {
        String senderAddress = mailSettings.senderAddress();
        if (mailSender == null || !mailSettings.isConfigured()
                || recipient == null || recipient.isBlank()) return;
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(senderAddress);
            message.setTo(recipient);
            message.setSubject("LUCY LMS - Pro Mentor application update");
            message.setText(approved
                    ? "Your Pro Mentor application was approved. You can now sign in to LUCY."
                    : "Your Pro Mentor application was not approved. Contact the administrator if you need more details.");
            mailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send application decision: " + e.getMessage());
        }
    }
}
