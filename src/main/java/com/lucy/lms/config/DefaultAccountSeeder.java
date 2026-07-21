package com.lucy.lms.config;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.repository.AppUserRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Component
@ConditionalOnProperty(
        name = "lucy.bootstrap.default-accounts.enabled",
        havingValue = "true",
        matchIfMissing = true
)
public class DefaultAccountSeeder implements ApplicationRunner {

    private static final Logger log = LoggerFactory.getLogger(DefaultAccountSeeder.class);
    private static final String FALLBACK_PASSWORD = "123456";

    private static final List<DefaultAccount> DEFAULT_ACCOUNTS = List.of(
            new DefaultAccount(
                    "Admin User", "admin@lucy.demo", "LucyAdmin", null,
                    "ADMIN", "LEARNER", false, 1000.0, 100, false
            ),
            new DefaultAccount(
                    "Anonymous Learner", "learner@lucy.demo", "AnonymousPanda", "CuriousPanda",
                    "LEARNER", "LEARNER", true, 50.0, 5, false
            ),
            new DefaultAccount(
                    "Sensei Miko", "miko@lucy.demo", "SenseiMiko", null,
                    "PRO_MENTOR", "PRO_MENTOR", false, 500.0, 75, true
            ),
            new DefaultAccount(
                    "Studio Max", "max@lucy.demo", "StudioMax", null,
                    "SUPER_CREATOR", "CONTENT_CREATOR", false, 800.0, 90, false
            )
    );

    private final AppUserRepository userRepository;
    private final String defaultPassword;

    public DefaultAccountSeeder(
            AppUserRepository userRepository,
            @Value("${lucy.bootstrap.default-accounts.password:123456}") String defaultPassword
    ) {
        this.userRepository = userRepository;
        this.defaultPassword = defaultPassword == null || defaultPassword.isBlank()
                ? FALLBACK_PASSWORD
                : defaultPassword;
    }

    @Override
    @Transactional
    public void run(ApplicationArguments args) {
        int created = 0;
        for (DefaultAccount account : DEFAULT_ACCOUNTS) {
            if (synchronize(account)) {
                created++;
            }
        }
        log.info("Default login accounts synchronized: {} created, {} already existed.",
                created, DEFAULT_ACCOUNTS.size() - created);
    }

    private boolean synchronize(DefaultAccount account) {
        AppUser user = userRepository.findByEmailIgnoreCase(account.email()).orElse(null);
        boolean isNew = user == null;

        if (isNew) {
            user = new AppUser();
            user.setEmail(account.email());
            user.setFullName(account.fullName());
            user.setDisplayName(account.displayName());
            user.setAvatarPersona(account.avatarPersona());
            user.setAnonymousMode(account.anonymousMode());
            user.setCreditBalance(account.initialCredits());
            user.setReputationScore(account.initialReputation());
            user.setCreatedAt(LocalDateTime.now());
            user.setPassword(defaultPassword);
        } else {
            fillMissingProfileFields(user, account);
        }

        user.setRole(account.role());
        user.setAccountType(account.accountType());
        user.setRegistrationStatus("APPROVED");
        user.setProGrantedByAdmin(account.proGrantedByAdmin());
        user.setActive(true);
        hashPasswordIfNeeded(user);
        userRepository.save(user);
        return isNew;
    }

    private void fillMissingProfileFields(AppUser user, DefaultAccount account) {
        if (user.getFullName() == null || user.getFullName().isBlank()) {
            user.setFullName(account.fullName());
        }
        if (user.getDisplayName() == null || user.getDisplayName().isBlank()) {
            user.setDisplayName(account.displayName());
        }
        if ((user.getAvatarPersona() == null || user.getAvatarPersona().isBlank())
                && account.avatarPersona() != null) {
            user.setAvatarPersona(account.avatarPersona());
        }
        if (user.getAnonymousMode() == null) {
            user.setAnonymousMode(account.anonymousMode());
        }
        if (user.getCreditBalance() == null) {
            user.setCreditBalance(account.initialCredits());
        }
        if (user.getReputationScore() == null) {
            user.setReputationScore(account.initialReputation());
        }
        if (user.getCreatedAt() == null) {
            user.setCreatedAt(LocalDateTime.now());
        }
        if (user.getPassword() == null || user.getPassword().isBlank()) {
            user.setPassword(defaultPassword);
        }
    }

    private void hashPasswordIfNeeded(AppUser user) {
        String password = user.getPassword();
        if (password == null || password.isBlank()) {
            password = defaultPassword;
        }
        if (!isBcryptHash(password)) {
            user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt(12)));
        }
    }

    private boolean isBcryptHash(String password) {
        return password.startsWith("$2a$")
                || password.startsWith("$2b$")
                || password.startsWith("$2y$");
    }

    private record DefaultAccount(
            String fullName,
            String email,
            String displayName,
            String avatarPersona,
            String role,
            String accountType,
            boolean anonymousMode,
            double initialCredits,
            int initialReputation,
            boolean proGrantedByAdmin
    ) {
    }
}
