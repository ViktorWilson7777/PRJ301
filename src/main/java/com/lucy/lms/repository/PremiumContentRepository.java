package com.lucy.lms.repository;

import com.lucy.lms.entity.PremiumContent;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PremiumContentRepository extends JpaRepository<PremiumContent, Long> {

    List<PremiumContent> findByCreatorId(Long creatorId);

    List<PremiumContent> findByActiveTrue();
}
