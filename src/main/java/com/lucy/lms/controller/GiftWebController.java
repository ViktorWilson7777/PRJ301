package com.lucy.lms.controller;

import com.lucy.lms.entity.Gift;
import com.lucy.lms.repository.GiftRepository;
import com.lucy.lms.repository.GiftTransactionRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@SuppressWarnings("null")
public class GiftWebController {

    private final GiftRepository giftRepository;
    private final GiftTransactionRepository giftTransactionRepository;

    public GiftWebController(GiftRepository giftRepository,
                             GiftTransactionRepository giftTransactionRepository) {
        this.giftRepository = giftRepository;
        this.giftTransactionRepository = giftTransactionRepository;
    }

    @GetMapping("/gifts")
    public String gifts(Model model) {
        model.addAttribute("gifts", giftRepository.findAll());
        model.addAttribute("giftTransactions", giftTransactionRepository.findAll());
        return "gifts";
    }

    @GetMapping("/gifts/create")
    public String createGiftPage(Model model) {
        model.addAttribute("gift", new Gift());
        return "gift-form";
    }

    @PostMapping("/gifts/save")
    public String saveGift(@RequestParam(required = false) Long id,
                           @RequestParam String name,
                           @RequestParam(required = false) String icon,
                           @RequestParam Integer creditCost,
                           @RequestParam(required = false) String active) {
        Gift gift;
        if (id != null) {
            gift = giftRepository.findById(id).orElse(new Gift());
        } else {
            gift = new Gift();
        }
        gift.setName(name);
        gift.setIcon(icon);
        gift.setCreditCost(creditCost);
        gift.setActive(active != null);
        giftRepository.save(gift);
        return "redirect:/gifts";
    }

    @GetMapping("/gifts/edit/{id}")
    public String editGiftPage(@PathVariable Long id, Model model) {
        Gift gift = giftRepository.findById(id).orElse(null);
        if (gift == null) return "redirect:/gifts";
        model.addAttribute("gift", gift);
        return "gift-form";
    }

    @GetMapping("/gifts/delete/{id}")
    public String deleteGift(@PathVariable Long id) {
        giftRepository.deleteById(id);
        return "redirect:/gifts";
    }
}
