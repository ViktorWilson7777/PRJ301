package com.lucy.lms.controller;

import com.lucy.lms.entity.Course;
import com.lucy.lms.entity.ImportFile;
import com.lucy.lms.repository.CourseRepository;
import com.lucy.lms.repository.ImportFileRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
public class ImportFileWebController {

    private final ImportFileRepository importFileRepository;
    private final CourseRepository courseRepository;

    public ImportFileWebController(ImportFileRepository importFileRepository,
                                   CourseRepository courseRepository) {
        this.importFileRepository = importFileRepository;
        this.courseRepository = courseRepository;
    }

    @GetMapping("/import-files")
    public String importFiles(Model model) {
        model.addAttribute("importFiles", importFileRepository.findAll());
        return "import-files";
    }

    @GetMapping("/import-files/create")
    public String createImportFilePage(Model model) {
        model.addAttribute("importFile", new ImportFile());
        model.addAttribute("courses", courseRepository.findAll());
        return "import-file-form";
    }

    @PostMapping("/import-files/save")
    public String saveImportFile(
            @RequestParam(required = false) Long id,
            @RequestParam Long courseId,
            @RequestParam String fileName,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String errorMessage
    ) {
        ImportFile importFile;

        if (id != null) {
            importFile = importFileRepository.findById(id).orElse(new ImportFile());
        } else {
            importFile = new ImportFile();
            importFile.setImportedAt(LocalDateTime.now());
        }

        Course course = courseRepository.findById(courseId).orElse(null);

        importFile.setCourse(course);
        importFile.setFileName(fileName);
        importFile.setStatus(status);
        importFile.setErrorMessage(errorMessage);

        if (importFile.getImportedAt() == null) {
            importFile.setImportedAt(LocalDateTime.now());
        }

        importFileRepository.save(importFile);

        return "redirect:/import-files";
    }

    @GetMapping("/import-files/edit/{id}")
    public String editImportFilePage(@PathVariable Long id, Model model) {
        ImportFile importFile = importFileRepository.findById(id).orElse(null);

        if (importFile == null) {
            return "redirect:/import-files";
        }

        model.addAttribute("importFile", importFile);
        model.addAttribute("courses", courseRepository.findAll());

        return "import-file-form";
    }

    @GetMapping("/import-files/delete/{id}")
    public String deleteImportFile(@PathVariable Long id) {
        importFileRepository.deleteById(id);
        return "redirect:/import-files";
    }
}