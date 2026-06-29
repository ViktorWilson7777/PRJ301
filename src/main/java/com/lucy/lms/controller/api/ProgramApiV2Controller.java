package com.lucy.lms.controller.api;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lucy.lms.dto.response.ApiResponse;
import com.lucy.lms.entity.Program;
import com.lucy.lms.repository.ProgramRepository;

@RestController
@RequestMapping("/api/v2")
public class ProgramApiV2Controller {

    private final ProgramRepository programRepository;

    public ProgramApiV2Controller(ProgramRepository programRepository) {
        this.programRepository = programRepository;
    }

    @GetMapping("/programs")
    public ResponseEntity<ApiResponse<List<Program>>> getPrograms() {

        return ResponseEntity.ok(
                new ApiResponse<>(
                        200,
                        "Success",
                        programRepository.findAll()
                )
        );
    }
}