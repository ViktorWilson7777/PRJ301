package com.lucy.lms.controller;

import com.lucy.lms.repository.AiGeneratedQuestionRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
@SuppressWarnings("null")
public class AiGeneratedQuestionWebController {

    private final AiGeneratedQuestionRepository questionRepository;

    public AiGeneratedQuestionWebController(AiGeneratedQuestionRepository questionRepository) {
        this.questionRepository = questionRepository;
    }

    @GetMapping("/ai-generated-questions")
    public String questions(Model model) {
        model.addAttribute("questions", questionRepository.findAll());
        return "ai-generated-questions";
    }

    @GetMapping("/ai-generated-questions/delete/{id}")
    public String deleteQuestion(@PathVariable Long id) {
        questionRepository.deleteById(id);
        return "redirect:/ai-generated-questions";
    }

    @GetMapping("/ai-generated-questions/toggle-used/{id}")
    public String toggleUsed(@PathVariable Long id) {
        questionRepository.findById(id).ifPresent(q -> {
            q.setUsedByModerator(!Boolean.TRUE.equals(q.getUsedByModerator()));
            questionRepository.save(q);
        });
        return "redirect:/ai-generated-questions";
    }
}
