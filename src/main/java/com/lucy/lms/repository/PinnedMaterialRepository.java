package com.lucy.lms.repository;

import com.lucy.lms.entity.PinnedMaterial;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PinnedMaterialRepository extends JpaRepository<PinnedMaterial, Long> {

    List<PinnedMaterial> findByRoomId(Long roomId);

    List<PinnedMaterial> findByRoomIdAndActiveTrue(Long roomId);

    @org.springframework.data.jpa.repository.Modifying
    @org.springframework.data.jpa.repository.Query("UPDATE PinnedMaterial pm SET pm.active = false WHERE pm.room.id = :roomId AND pm.active = true")
    void deactivateAllByRoomId(@org.springframework.data.repository.query.Param("roomId") Long roomId);
}
