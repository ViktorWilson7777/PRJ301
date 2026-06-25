package com.lucy.lms.repository;

import com.lucy.lms.entity.UserFollow;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserFollowRepository extends JpaRepository<UserFollow, Long> {

    long countByFollowingId(Long followingId);

    long countByFollowerId(Long followerId);

    boolean existsByFollowerIdAndFollowingId(Long followerId, Long followingId);

    Optional<UserFollow> findByFollowerIdAndFollowingId(Long followerId, Long followingId);
}
