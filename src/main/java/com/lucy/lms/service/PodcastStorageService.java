package com.lucy.lms.service;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.entity.CreditTransaction;
import com.lucy.lms.repository.AppUserRepository;
import com.lucy.lms.repository.CreditTransactionRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PodcastStorageService {

    public static final long BASE_STORAGE_BYTES = 20L * 1024 * 1024;
    public static final long STORAGE_EXPANSION_BYTES = 15L * 1024 * 1024;
    public static final double STORAGE_EXPANSION_COST = 100000.0;

    private static final long LEGACY_DEFAULT_STORAGE_BYTES = 100L * 1024 * 1024;

    private final AppUserRepository userRepository;
    private final CreditTransactionRepository transactionRepository;

    public PodcastStorageService(AppUserRepository userRepository,
                                 CreditTransactionRepository transactionRepository) {
        this.userRepository = userRepository;
        this.transactionRepository = transactionRepository;
    }

    @Transactional
    public AppUser ensureDefaultQuota(Long userId) {
        AppUser user = userRepository.findById(userId).orElse(null);
        if (user == null) return null;
        if (normalizeStorage(user)) {
            userRepository.save(user);
        }
        return user;
    }

    @Transactional
    public PurchaseResult purchaseExpansion(Long userId) {
        AppUser user = userRepository.findByIdForUpdate(userId).orElse(null);
        if (user == null) return PurchaseResult.USER_NOT_FOUND;

        normalizeStorage(user);
        double balance = user.getCreditBalance() == null ? 0.0 : user.getCreditBalance();
        if (balance < STORAGE_EXPANSION_COST) {
            userRepository.save(user);
            return PurchaseResult.INSUFFICIENT_CREDITS;
        }

        user.setCreditBalance(balance - STORAGE_EXPANSION_COST);
        user.setStorageLimitBytes(user.getStorageLimitBytes() + STORAGE_EXPANSION_BYTES);
        userRepository.save(user);

        CreditTransaction transaction = new CreditTransaction();
        transaction.setUser(user);
        transaction.setAmount(-STORAGE_EXPANSION_COST);
        transaction.setType("PODCAST_STORAGE");
        transaction.setDescription("Purchased 15 MB of podcast storage");
        transactionRepository.save(transaction);
        return PurchaseResult.SUCCESS;
    }

    private boolean normalizeStorage(AppUser user) {
        boolean changed = false;
        Long currentLimit = user.getStorageLimitBytes();
        if (currentLimit == null || currentLimit <= 0L || currentLimit == LEGACY_DEFAULT_STORAGE_BYTES) {
            user.setStorageLimitBytes(BASE_STORAGE_BYTES);
            changed = true;
        }
        if (user.getStorageUsedBytes() == null || user.getStorageUsedBytes() < 0L) {
            user.setStorageUsedBytes(0L);
            changed = true;
        }
        return changed;
    }

    public enum PurchaseResult {
        SUCCESS,
        INSUFFICIENT_CREDITS,
        USER_NOT_FOUND
    }
}
