package com.lucy.lms.repository;

import com.lucy.lms.entity.Room;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RoomRepository extends JpaRepository<Room, Long> {

    List<Room> findByStatus(String status);

    List<Room> findByHostUserId(Long hostUserId);

    List<Room> findByLanguageCode(String languageCode);

    List<Room> findByCourseIdAndStatusInOrderByLevelNumberAsc(Long courseId, java.util.List<String> statuses);

    @org.springframework.data.jpa.repository.Query("SELECT r FROM Room r WHERE r.course.id = :courseId AND r.status IN :statuses " +
           "AND (:hostName IS NULL OR LOWER(r.hostUser.displayName) LIKE LOWER(CONCAT('%', :hostName, '%'))) " +
           "AND (:level IS NULL OR r.levelNumber = :level) " +
           "ORDER BY r.levelNumber ASC")
    List<Room> findRoomsByFilters(@org.springframework.data.repository.query.Param("courseId") Long courseId, 
                                  @org.springframework.data.repository.query.Param("statuses") java.util.List<String> statuses, 
                                  @org.springframework.data.repository.query.Param("hostName") String hostName, 
                                  @org.springframework.data.repository.query.Param("level") Integer level);
}
