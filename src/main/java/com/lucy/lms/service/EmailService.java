package com.lucy.lms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired(required = false)
    private JavaMailSender mailSender;

    public void sendOtpEmail(String to, String otp) {
        if (mailSender == null) {
            System.out.println("==========================================================");
            System.out.println("MOCK EMAIL SENT TO: " + to);
            System.out.println("OTP CODE: " + otp);
            System.out.println("Configure spring.mail properties to send real emails.");
            System.out.println("==========================================================");
            return;
        }

        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("lucy.lms.noreply@gmail.com");
            message.setTo(to);
            message.setSubject("LUCY LMS - Your Registration OTP");
            message.setText("Welcome to LUCY LMS!\n\nYour OTP for registration is: " + otp + "\n\nThis code will expire in 5 minutes.\n\nThank you!");
            
            mailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send OTP email: " + e.getMessage());
            System.out.println("==========================================================");
            System.out.println("FALLBACK OTP CODE FOR " + to + ": " + otp);
            System.out.println("==========================================================");
        }
    }
}
