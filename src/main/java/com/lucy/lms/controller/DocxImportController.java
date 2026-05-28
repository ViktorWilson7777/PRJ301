package com.lucy.lms.controller;

import com.lucy.lms.entity.ImportFile;
import com.lucy.lms.service.DocxImportService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class DocxImportController {

    private final DocxImportService docxImportService;

    public DocxImportController(DocxImportService docxImportService) {
        this.docxImportService = docxImportService;
    }

    @PostMapping("/import-files/upload")
    public String uploadDocx(
            @RequestParam Long courseId,
            @RequestParam MultipartFile file,
            Model model
    ) {
        ImportFile importFile = docxImportService.importDocx(courseId, file);
        return "redirect:/import-files";
    }
}