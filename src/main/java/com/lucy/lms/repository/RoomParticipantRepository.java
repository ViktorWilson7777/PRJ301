package com.lucy.lms.repository;

import com.lucy.lms.entity.RoomParticipant;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RoomParticipantRepository extends JpaRepository<RoomParticipant, Long> {

    List<RoomParticipant> findByRoomId(Long roomId);

    List<RoomParticipant> findByUserId(Long userId);

    boolean existsByRoomIdAndUserId(Long roomId, Long userId);

    java.util.Optional<RoomParticipant> findByRoomIdAndUserId(Long roomId, Long userId);
}

