package com.lucy.lms.repository;

import com.lucy.lms.entity.Gift;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GiftRepository extends JpaRepository<Gift, Long> {

    List<Gift> findByActiveTrue();
}
