package com.lucy.lms.controller;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.entity.CourseHostingPermission;
import com.lucy.lms.repository.AppUserRepository;
import com.lucy.lms.repository.CourseRepository;
import com.lucy.lms.repository.ProgramRepository;
import com.lucy.lms.service.CourseHostingPermissionService;
import com.lucy.lms.service.EmailService;
import com.lucy.lms.service.ProgramProgressService;
import jakarta.servlet.http.HttpSession;
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
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
@SuppressWarnings("null")
public class UserWebController {

    private final AppUserRepository userRepository;
    private final ProgramRepository programRepository;
    private final CourseRepository courseRepository;
    private final ProgramProgressService progressService;
    private final CourseHostingPermissionService hostingPermissionService;
    private final EmailService emailService;
    private static final DateTimeFormatter EXPORT_DATE_FORMAT =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public UserWebController(AppUserRepository userRepository,
                             ProgramRepository programRepository,
                             CourseRepository courseRepository,
                             ProgramProgressService progressService,
                             CourseHostingPermissionService hostingPermissionService,
                             EmailService emailService) {
        this.userRepository = userRepository;
        this.programRepository = programRepository;
        this.courseRepository = courseRepository;
        this.progressService = progressService;
        this.hostingPermissionService = hostingPermissionService;
        this.emailService = emailService;
    }

    @GetMapping("/users")
    public String users(Model model) {
        List<AppUser> pendingApplications = pendingProApplications();
        model.addAttribute("users", userRepository.findAll());
        model.addAttribute("pendingApplications", pendingApplications);
        model.addAttribute("pendingCoursePermissions", permissionsByUser(pendingApplications, "PENDING"));
        return "users";
    }

    @GetMapping("/pro-applications")
    public String proApplications(Model model) {
        List<AppUser> pendingApplications = pendingProApplications();
        List<AppUser> reviewedApplications = userRepository.findAll().stream()
                .filter(user -> user.getEvidenceUrl() != null && !user.getEvidenceUrl().isBlank())
                .filter(user -> !"PENDING".equals(user.getRegistrationStatus()))
                .sorted((left, right) -> {
                    if (left.getCreatedAt() == null) return 1;
                    if (right.getCreatedAt() == null) return -1;
                    return right.getCreatedAt().compareTo(left.getCreatedAt());
                }).toList();
        model.addAttribute("pendingApplications", pendingApplications);
        model.addAttribute("pendingCoursePermissions", permissionsByUser(pendingApplications, "PENDING"));
        model.addAttribute("reviewedApplications", reviewedApplications);
        model.addAttribute("approvedCoursePermissions", permissionsByUser(reviewedApplications, "APPROVED"));
        return "pro-applications";
    }

    @PostMapping("/pro-applications/{id}/decision")
    public String reviewProApplicationPage(@PathVariable Long id,
                                           @RequestParam String decision,
                                           @RequestParam(required = false) List<Long> courseIds,
                                           HttpSession session) {
        if (!reviewApplication(id, decision, courseIds, currentAdmin(session))) {
            return "redirect:/pro-applications?error=invalid_application";
        }
        return "redirect:/pro-applications?success=application_"
                + ("APPROVE".equalsIgnoreCase(decision) ? "approved" : "rejected");
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
        model.addAttribute("programs", programRepository.findAll());
        model.addAttribute("courses", courseRepository.findAllByOrderByProgramTitleAscOrderIndexAscTitleAsc());
        model.addAttribute("approvedCourseIds", Set.of());
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
        applyRoleDefaults(user, role);
        if (user.getRegistrationStatus() == null || "PENDING".equals(user.getRegistrationStatus())) {
            user.setRegistrationStatus("APPROVED");
        }
        user.setAnonymousMode(anonymousMode != null);
        user.setCreditBalance(creditBalance != null ? creditBalance : 0.0);
        user.setReputationScore(reputationScore != null ? reputationScore : 0);
        user.setActive(active != null);

        userRepository.save(user);
        progressService.initializeAllProgramLevels(user);
        return "redirect:/users";
    }

    @GetMapping("/users/edit/{id}")
    public String editUserPage(@PathVariable Long id, Model model) {
        AppUser user = userRepository.findById(id).orElse(null);
        if (user == null) return "redirect:/users";
        model.addAttribute("user", user);
        model.addAttribute("programs", programRepository.findAll());
        model.addAttribute("programLevels", progressService.levelsForUser(user));
        model.addAttribute("courses", courseRepository.findAllByOrderByProgramTitleAscOrderIndexAscTitleAsc());
        model.addAttribute("approvedCourseIds", hostingPermissionService.approvedCourseIds(user));
        return "user-form";
    }

    @PostMapping("/users/{id}/hosting-courses")
    public String saveHostingCourses(@PathVariable Long id,
                                     @RequestParam(required = false) List<Long> courseIds,
                                     HttpSession session) {
        AppUser admin = currentAdmin(session);
        AppUser user = userRepository.findById(id).orElse(null);
        if (admin == null || user == null || !"PRO_MENTOR".equals(user.getRole())) {
            return "redirect:/users/edit/" + id + "?error=hosting_courses_invalid";
        }
        if (!hostingPermissionService.replaceApprovedPermissions(user, courseIds, admin)) {
            return "redirect:/users/edit/" + id + "?error=hosting_courses_invalid";
        }
        return "redirect:/users/edit/" + id + "?success=hosting_courses_saved";
    }

    @PostMapping("/users/{id}/application")
    public String reviewProApplication(@PathVariable Long id,
                                       @RequestParam String decision,
                                       @RequestParam(required = false) List<Long> courseIds,
                                       HttpSession session) {
        if (!reviewApplication(id, decision, courseIds, currentAdmin(session))) {
            return "redirect:/users?error=invalid_application";
        }
        return "redirect:/users?success=application_"
                + ("APPROVE".equalsIgnoreCase(decision) ? "approved" : "rejected");
    }

    private boolean reviewApplication(Long id, String decision,
                                      List<Long> courseIds, AppUser admin) {
        if (!("APPROVE".equalsIgnoreCase(decision) || "REJECT".equalsIgnoreCase(decision))) return false;
        if (admin == null) return false;
        AppUser user = userRepository.findById(id).orElse(null);
        if (user == null || !"PENDING".equals(user.getRegistrationStatus())
                || user.getEvidenceUrl() == null || user.getEvidenceUrl().isBlank()) return false;
        boolean approved = "APPROVE".equalsIgnoreCase(decision);
        if (approved && !hostingPermissionService.approveApplication(user, courseIds, admin)) {
            return false;
        }
        if (!approved) hostingPermissionService.rejectApplication(user, admin);
        user.setRegistrationStatus(approved ? "APPROVED" : "REJECTED");
        user.setActive(approved || Boolean.TRUE.equals(user.getActive()));
        if (approved) {
            user.setRole("PRO_MENTOR");
            user.setAccountType("PRO_MENTOR");
            user.setProGrantedByAdmin(false);
        }
        userRepository.save(user);
        emailService.sendApplicationDecision(user.getEmail(), approved);
        return true;
    }

    @PostMapping("/users/{id}/program-level")
    public String saveProgramLevel(@PathVariable Long id,
                                   @RequestParam Long programId,
                                   @RequestParam Integer levelNumber,
                                   @RequestParam(defaultValue = "0") Integer maxHostingLevel) {
        AppUser user = userRepository.findById(id).orElse(null);
        com.lucy.lms.entity.Program program = programRepository.findById(programId).orElse(null);
        if (user == null || program == null) return "redirect:/users";
        progressService.setLevel(user, program,
                levelNumber == null ? 1 : levelNumber,
                maxHostingLevel == null ? 0 : maxHostingLevel);
        return "redirect:/users/edit/" + id + "?success=level_saved";
    }

    @GetMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable Long id) {
        userRepository.deleteById(id);
        return "redirect:/users";
    }

    private String text(String value) {
        return value == null ? "" : value;
    }

    private List<AppUser> pendingProApplications() {
        return userRepository.findByRegistrationStatusOrderByCreatedAtDesc("PENDING").stream()
                .filter(user -> user.getEvidenceUrl() != null && !user.getEvidenceUrl().isBlank())
                .toList();
    }

    private Map<Long, List<CourseHostingPermission>> permissionsByUser(
            List<AppUser> users, String status
    ) {
        Map<Long, List<CourseHostingPermission>> result = new LinkedHashMap<>();
        for (AppUser user : users) {
            List<CourseHostingPermission> permissions = hostingPermissionService.permissionsForUser(user).stream()
                    .filter(permission -> status.equals(permission.getStatus()))
                    .toList();
            result.put(user.getId(), permissions);
        }
        return result;
    }

    private AppUser currentAdmin(HttpSession session) {
        AppUser currentUser = session == null ? null : (AppUser) session.getAttribute("currentUser");
        if (currentUser == null || currentUser.getId() == null) return null;
        AppUser freshUser = userRepository.findById(currentUser.getId()).orElse(null);
        return freshUser != null && "ADMIN".equals(freshUser.getRole()) ? freshUser : null;
    }

    private void applyRoleDefaults(AppUser user, String role) {
        if ("SUPER_CREATOR".equals(role)) {
            user.setAccountType("CONTENT_CREATOR");
            user.setProGrantedByAdmin(false);
        } else if ("PRO_MENTOR".equals(role)) {
            user.setAccountType("PRO_MENTOR");
            user.setProGrantedByAdmin(false);
        } else {
            user.setAccountType("LEARNER");
            user.setProGrantedByAdmin(false);
        }
    }
}
