package com.lucy.lms.repository;

import com.lucy.lms.entity.JoinRequest;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface JoinRequestRepository extends JpaRepository<JoinRequest, Long> {

    List<JoinRequest> findByRoomIdAndStatus(Long roomId, String status);

    List<JoinRequest> findByRoomId(Long roomId);

    boolean existsByRoomIdAndUserIdAndStatus(Long roomId, Long userId, String status);
}
