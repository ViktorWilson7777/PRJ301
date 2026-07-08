package com.lucy.lms.controller;

import com.lucy.lms.dto.DocxPreviewResult;
import com.lucy.lms.entity.Course;
import com.lucy.lms.repository.CourseRepository;
import com.lucy.lms.service.DocxImportService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Controller
public class DocxImportController {

    private final DocxImportService docxImportService;
    private final CourseRepository courseRepository;

    public DocxImportController(DocxImportService docxImportService,
                                CourseRepository courseRepository) {
        this.docxImportService = docxImportService;
        this.courseRepository = courseRepository;
    }

    @PostMapping("/import-files/upload")
    public String uploadDocx(
            @RequestParam Long courseId,
            @RequestParam MultipartFile file,
            Model model
    ) {
        docxImportService.importDocx(courseId, file);
        return "redirect:/import-files";
    }

    @PostMapping("/import-files/preview")
    public String previewImportDocx(
            @RequestParam Long courseId,
            @RequestParam MultipartFile file,
            Model model,
            HttpSession session
    ) {
        DocxPreviewResult preview = docxImportService.previewDocx(courseId, file);
        Course course = courseRepository.findById(courseId).orElse(null);

        clearPreviewSession(session);

        if (preview.isValid()) {
            try {
                session.setAttribute("docxPreviewCourseId", courseId);
                session.setAttribute("docxPreviewFileName", file.getOriginalFilename());
                session.setAttribute("docxPreviewBytes", file.getBytes());
                model.addAttribute("confirmImport", true);
            } catch (IOException e) {
                preview.setValid(false);
                preview.setMessage("Cannot store preview file: " + e.getMessage());
                model.addAttribute("confirmImport", false);
            }
        } else {
            model.addAttribute("confirmImport", false);
        }

        model.addAttribute("preview", preview);
        model.addAttribute("paragraphs", preview.getParagraphs());
        model.addAttribute("fileName", file.getOriginalFilename());
        model.addAttribute("course", course);

        return "docx-preview";
    }

    @PostMapping("/import-files/confirm")
    public String confirmImportDocx(HttpSession session) {
        Long courseId = (Long) session.getAttribute("docxPreviewCourseId");
        String fileName = (String) session.getAttribute("docxPreviewFileName");
        byte[] fileBytes = (byte[]) session.getAttribute("docxPreviewBytes");

        if (courseId == null || fileName == null || fileBytes == null) {
            return "redirect:/import-files/create";
        }

        docxImportService.importDocx(courseId, fileName, fileBytes);
        clearPreviewSession(session);

        return "redirect:/import-files";
    }

    private void clearPreviewSession(HttpSession session) {
        session.removeAttribute("docxPreviewCourseId");
        session.removeAttribute("docxPreviewFileName");
        session.removeAttribute("docxPreviewBytes");
    }
}
