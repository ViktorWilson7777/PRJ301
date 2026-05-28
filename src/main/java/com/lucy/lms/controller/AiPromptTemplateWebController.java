package com.lucy.lms.controller;

import com.lucy.lms.entity.AiPromptTemplate;
import com.lucy.lms.entity.Lesson;
import com.lucy.lms.repository.AiPromptTemplateRepository;
import com.lucy.lms.repository.LessonRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AiPromptTemplateWebController {

    private final AiPromptTemplateRepository templateRepository;
    private final LessonRepository lessonRepository;

    public AiPromptTemplateWebController(AiPromptTemplateRepository templateRepository,
                                         LessonRepository lessonRepository) {
        this.templateRepository = templateRepository;
        this.lessonRepository = lessonRepository;
    }

    @GetMapping("/ai-prompt-templates")
    public String templates(Model model) {
        model.addAttribute("templates", templateRepository.findAll());
        return "ai-prompt-templates";
    }

    @GetMapping("/ai-prompt-templates/create")
    public String createTemplatePage(Model model) {
        model.addAttribute("template", new AiPromptTemplate());
        model.addAttribute("lessons", lessonRepository.findAll());
        return "ai-prompt-template-form";
    }

    @PostMapping("/ai-prompt-templates/save")
    public String saveTemplate(
            @RequestParam(required = false) Long id,
            @RequestParam Long lessonId,
            @RequestParam String promptType,
            @RequestParam String promptInstruction,
            @RequestParam(required = false) String active
    ) {
        AiPromptTemplate template;

        if (id != null) {
            template = templateRepository.findById(id).orElse(new AiPromptTemplate());
        } else {
            template = new AiPromptTemplate();
        }

        Lesson lesson = lessonRepository.findById(lessonId).orElse(null);

        template.setLesson(lesson);
        template.setPromptType(promptType);
        template.setPromptInstruction(promptInstruction);
        template.setIsActive(active != null);

        templateRepository.save(template);

        return "redirect:/ai-prompt-templates";
    }

    @GetMapping("/ai-prompt-templates/edit/{id}")
    public String editTemplatePage(@PathVariable Long id, Model model) {
        AiPromptTemplate template = templateRepository.findById(id).orElse(null);

        if (template == null) {
            return "redirect:/ai-prompt-templates";
        }

        model.addAttribute("template", template);
        model.addAttribute("lessons", lessonRepository.findAll());

        return "ai-prompt-template-form";
    }

    @GetMapping("/ai-prompt-templates/delete/{id}")
    public String deleteTemplate(@PathVariable Long id) {
        templateRepository.deleteById(id);
        return "redirect:/ai-prompt-templates";
    }
}