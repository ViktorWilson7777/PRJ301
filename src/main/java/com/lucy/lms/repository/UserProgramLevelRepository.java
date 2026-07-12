package com.lucy.lms.repository;

import com.lucy.lms.entity.UserProgramLevel;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface UserProgramLevelRepository extends JpaRepository<UserProgramLevel, Long> {
    Optional<UserProgramLevel> findByUserIdAndProgramId(Long userId, Long programId);
    List<UserProgramLevel> findByUserIdOrderByProgramTitleAsc(Long userId);
}
