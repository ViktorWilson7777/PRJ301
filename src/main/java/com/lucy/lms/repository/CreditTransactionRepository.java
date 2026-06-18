package com.lucy.lms.repository;

import com.lucy.lms.entity.CreditTransaction;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CreditTransactionRepository extends JpaRepository<CreditTransaction, Long> {

    List<CreditTransaction> findByUserIdOrderByCreatedAtDesc(Long userId);
    boolean existsByUserIdAndTypeAndDescriptionContaining(Long userId, String type, String description);
}
