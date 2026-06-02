package com.lucy.lms.repository;

import com.lucy.lms.entity.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AppUserRepository extends JpaRepository<AppUser, Long> {

    List<AppUser> findByRole(String role);

    List<AppUser> findByActiveTrue();
}
