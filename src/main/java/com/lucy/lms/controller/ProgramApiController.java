package com.lucy.lms.controller;

import com.lucy.lms.entity.Program;
import com.lucy.lms.repository.ProgramRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ProgramApiController {

    private final ProgramRepository programRepository;

    public ProgramApiController(ProgramRepository programRepository) {
        this.programRepository = programRepository;
    }

    @GetMapping("/api/programs")
    public List<Program> getPrograms() {
        return programRepository.findAll();
    }
}