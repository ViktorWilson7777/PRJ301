package com.lucy.lms.controller;

import com.lucy.lms.dto.DocxPreviewResult;
import com.lucy.lms.service.DocxImportService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class DocxPreviewController {

    private final DocxImportService docxImportService;

    public DocxPreviewController(DocxImportService docxImportService) {
        this.docxImportService = docxImportService;
    }

    @GetMapping("/docx-preview")
    public String previewPage() {
        return "docx-preview";
    }

    @PostMapping("/docx-preview")
    public String previewDocx(
            @RequestParam MultipartFile file,
            Model model
    ) {
        DocxPreviewResult preview = docxImportService.previewDocx(file);

        model.addAttribute("fileName", file.getOriginalFilename());
        model.addAttribute("preview", preview);
        model.addAttribute("paragraphs", preview.getParagraphs());

        return "docx-preview";
    }
}
