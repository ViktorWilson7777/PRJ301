package com.lucy.lms.controller;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.repository.AppUserRepository;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@SuppressWarnings("null")
public class UserWebController {

    private final AppUserRepository userRepository;
    private static final DateTimeFormatter EXPORT_DATE_FORMAT =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public UserWebController(AppUserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("/users")
    public String users(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "users";
    }

    @GetMapping("/users/export")
    public void exportUsers(HttpServletResponse response) throws IOException {
        List<AppUser> users = userRepository.findAll();

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=lucy-users.xlsx");

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Users");

            Font headerFont = workbook.createFont();
            headerFont.setBold(true);

            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFont(headerFont);

            String[] headers = {
                    "ID", "Full Name", "Display Name", "Email", "Role",
                    "Credits", "Reputation", "Status", "Anonymous Mode", "Created At"
            };

            Row headerRow = sheet.createRow(0);
            for (int i = 0; i < headers.length; i++) {
                headerRow.createCell(i).setCellValue(headers[i]);
                headerRow.getCell(i).setCellStyle(headerStyle);
            }

            int rowIndex = 1;
            for (AppUser user : users) {
                Row row = sheet.createRow(rowIndex++);
                row.createCell(0).setCellValue(user.getId() != null ? user.getId() : 0);
                row.createCell(1).setCellValue(text(user.getFullName()));
                row.createCell(2).setCellValue(text(user.getDisplayName()));
                row.createCell(3).setCellValue(text(user.getEmail()));
                row.createCell(4).setCellValue(text(user.getRole()));
                row.createCell(5).setCellValue(user.getCreditBalance() != null ? user.getCreditBalance() : 0);
                row.createCell(6).setCellValue(user.getReputationScore() != null ? user.getReputationScore() : 0);
                row.createCell(7).setCellValue(Boolean.TRUE.equals(user.getActive()) ? "Active" : "Inactive");
                row.createCell(8).setCellValue(Boolean.TRUE.equals(user.getAnonymousMode()) ? "Yes" : "No");
                row.createCell(9).setCellValue(user.getCreatedAt() != null ? user.getCreatedAt().format(EXPORT_DATE_FORMAT) : "");
            }

            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            workbook.write(response.getOutputStream());
        }
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

    private String text(String value) {
        return value == null ? "" : value;
    }
}
