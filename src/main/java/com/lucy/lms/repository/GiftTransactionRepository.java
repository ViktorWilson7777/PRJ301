package com.lucy.lms.repository;

import com.lucy.lms.entity.GiftTransaction;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GiftTransactionRepository extends JpaRepository<GiftTransaction, Long> {

    List<GiftTransaction> findByRoomId(Long roomId);

    List<GiftTransaction> findBySenderId(Long senderId);

    List<GiftTransaction> findByReceiverId(Long receiverId);
}
