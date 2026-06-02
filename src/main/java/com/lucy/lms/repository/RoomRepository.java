package com.lucy.lms.repository;

import com.lucy.lms.entity.Room;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RoomRepository extends JpaRepository<Room, Long> {

    List<Room> findByStatus(String status);

    List<Room> findByHostUserId(Long hostUserId);

    List<Room> findByLanguageCode(String languageCode);
}
