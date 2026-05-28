package com.lucy.lms.controller;

import com.lucy.lms.entity.Program;
import com.lucy.lms.repository.ProgramRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProgramWebController {

    private final ProgramRepository programRepository;

    public ProgramWebController(ProgramRepository programRepository) {
        this.programRepository = programRepository;
    }

    @GetMapping("/programs")
    public String programs(Model model) {
        model.addAttribute("programs", programRepository.findAll());
        return "programs";
    }

    @GetMapping("/programs/create")
    public String createProgramPage(Model model) {
        model.addAttribute("program", new Program());
        return "program-form";
    }

    @PostMapping("/programs/save")
    public String saveProgram(
            @RequestParam(required = false) Long id,
            @RequestParam String code,
            @RequestParam String title,
            @RequestParam(required = false) String description,
            @RequestParam(required = false) String published
    ) {
        Program program;

        if (id != null) {
            program = programRepository.findById(id).orElse(new Program());
        } else {
            program = new Program();
        }

        program.setCode(code);
        program.setTitle(title);
        program.setDescription(description);

        // Nếu checkbox được tick thì published != null
        // Nếu không tick thì published = null
        program.setIsPublished(published != null);

        programRepository.save(program);

        return "redirect:/programs";
    }

    @GetMapping("/programs/edit/{id}")
    public String editProgramPage(@PathVariable Long id, Model model) {
        Program program = programRepository.findById(id).orElse(null);

        if (program == null) {
            return "redirect:/programs";
        }

        model.addAttribute("program", program);
        return "program-form";
    }

    @GetMapping("/programs/delete/{id}")
    public String deleteProgram(@PathVariable Long id) {
        programRepository.deleteById(id);
        return "redirect:/programs";
    }
}