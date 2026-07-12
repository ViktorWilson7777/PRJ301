package com.lucy.lms.repository;

import com.lucy.lms.entity.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AppUserRepository extends JpaRepository<AppUser, Long> {

    List<AppUser> findByRole(String role);

    List<AppUser> findByActiveTrue();

    Optional<AppUser> findByEmail(String email);

    Optional<AppUser> findByEmailIgnoreCase(String email);

    List<AppUser> findByRegistrationStatusOrderByCreatedAtDesc(String registrationStatus);
}
