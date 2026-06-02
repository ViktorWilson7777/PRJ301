package com.lucy.lms.controller;

import com.lucy.lms.entity.BillingPlan;
import com.lucy.lms.entity.CreditTransaction;
import com.lucy.lms.repository.BillingPlanRepository;
import com.lucy.lms.repository.CreditTransactionRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Tag(name = "Billing", description = "Mock Billing APIs")
public class BillingApiController {

    private final BillingPlanRepository planRepository;
    private final CreditTransactionRepository transactionRepository;

    public BillingApiController(BillingPlanRepository planRepository,
                                CreditTransactionRepository transactionRepository) {
        this.planRepository = planRepository;
        this.transactionRepository = transactionRepository;
    }

    @GetMapping("/api/billing/plans")
    @Operation(summary = "List all billing plans")
    public List<BillingPlan> getPlans() {
        return planRepository.findAll();
    }

    @GetMapping("/api/billing/transactions")
    @Operation(summary = "List transactions, optionally filter by userId")
    public List<CreditTransaction> getTransactions(@RequestParam(required = false) Long userId) {
        if (userId != null) {
            return transactionRepository.findByUserIdOrderByCreatedAtDesc(userId);
        }
        return transactionRepository.findAll();
    }
}
