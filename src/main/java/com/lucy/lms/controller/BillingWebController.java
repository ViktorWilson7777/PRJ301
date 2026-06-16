package com.lucy.lms.controller;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.entity.BillingPlan;
import com.lucy.lms.entity.CreditTransaction;
import com.lucy.lms.repository.AppUserRepository;
import com.lucy.lms.repository.BillingPlanRepository;
import com.lucy.lms.repository.CreditTransactionRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@SuppressWarnings("null")
public class BillingWebController {

    private final BillingPlanRepository planRepository;
    private final AppUserRepository userRepository;
    private final CreditTransactionRepository transactionRepository;

    public BillingWebController(BillingPlanRepository planRepository,
                                AppUserRepository userRepository,
                                CreditTransactionRepository transactionRepository) {
        this.planRepository = planRepository;
        this.userRepository = userRepository;
        this.transactionRepository = transactionRepository;
    }

    // ── Plans ──
    @GetMapping("/billing/plans")
    public String plans(Model model) {
        model.addAttribute("plans", planRepository.findAll());
        return "billing-plans";
    }

    @GetMapping("/billing/plans/create")
    public String createPlanPage(Model model) {
        model.addAttribute("plan", new BillingPlan());
        return "billing-plan-form";
    }

    @PostMapping("/billing/plans/save")
    public String savePlan(@RequestParam(required = false) Long id,
                           @RequestParam String name,
                           @RequestParam Double price,
                           @RequestParam Integer monthlyAiLimit,
                           @RequestParam Integer monthlyImportLimit,
                           @RequestParam Integer maxRoomParticipants,
                           @RequestParam(required = false) String allowPodcastRecording,
                           @RequestParam(required = false) String active) {
        BillingPlan plan;
        if (id != null) {
            plan = planRepository.findById(id).orElse(new BillingPlan());
        } else {
            plan = new BillingPlan();
        }
        plan.setName(name);
        plan.setPrice(price);
        plan.setMonthlyAiLimit(monthlyAiLimit);
        plan.setMonthlyImportLimit(monthlyImportLimit);
        plan.setMaxRoomParticipants(maxRoomParticipants);
        plan.setAllowPodcastRecording(allowPodcastRecording != null);
        plan.setActive(active != null);
        planRepository.save(plan);
        return "redirect:/billing/plans";
    }

    @GetMapping("/billing/plans/edit/{id}")
    public String editPlanPage(@PathVariable Long id, Model model) {
        BillingPlan plan = planRepository.findById(id).orElse(null);
        if (plan == null) return "redirect:/billing/plans";
        model.addAttribute("plan", plan);
        return "billing-plan-form";
    }

    @GetMapping("/billing/plans/delete/{id}")
    public String deletePlan(@PathVariable Long id) {
        planRepository.deleteById(id);
        return "redirect:/billing/plans";
    }

    // ── Self-Service Top-Up ──

    @GetMapping("/billing/topup")
    public String topupPage(Model model, jakarta.servlet.http.HttpSession session) {
        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";
        AppUser fresh = userRepository.findById(currentUser.getId()).orElse(currentUser);
        model.addAttribute("user", fresh);
        return "billing-topup";
    }

    @PostMapping("/billing/topup")
    public String processTopup(
            @RequestParam Long userId,
            @RequestParam Double amount,
            @RequestParam(required = false, defaultValue = "TOP_UP") String txType,
            jakarta.servlet.http.HttpSession session) {

        AppUser user = userRepository.findById(userId).orElse(null);
        if (user == null) return "redirect:/billing/topup?error=user_not_found";
        if (amount == null || amount <= 0) return "redirect:/billing/topup?error=invalid_amount";

        user.setCreditBalance((user.getCreditBalance() != null ? user.getCreditBalance() : 0.0) + amount);
        userRepository.save(user);

        CreditTransaction tx = new CreditTransaction();
        tx.setUser(user);
        tx.setAmount(amount);
        tx.setType(txType);
        tx.setDescription("Self-service top-up of " + amount + " credits");
        transactionRepository.save(tx);

        AppUser currentUser = (AppUser) session.getAttribute("currentUser");
        if (currentUser != null && currentUser.getId().equals(userId)) {
            session.setAttribute("currentUser", user);
        }

        return "redirect:/billing/topup?success=credits_added&amount=" + amount.intValue();
    }

    // ── User Wallets ──
    @GetMapping("/billing/users")
    public String billingUsers(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "billing-users";
    }

    @PostMapping("/billing/users/topup")
    public String topUp(@RequestParam Long userId, @RequestParam Double amount) {
        AppUser user = userRepository.findById(userId).orElse(null);
        if (user != null && amount > 0) {
            user.setCreditBalance((user.getCreditBalance() != null ? user.getCreditBalance() : 0.0) + amount);
            userRepository.save(user);

            CreditTransaction tx = new CreditTransaction();
            tx.setUser(user);
            tx.setAmount(amount);
            tx.setType("TOP_UP");
            tx.setDescription("Mock top-up of " + amount + " credits");
            transactionRepository.save(tx);
        }
        return "redirect:/billing/users";
    }

    // ── Transactions ──
    @GetMapping("/billing/transactions")
    public String transactions(Model model) {
        model.addAttribute("transactions", transactionRepository.findAll());
        return "billing-transactions";
    }
}
