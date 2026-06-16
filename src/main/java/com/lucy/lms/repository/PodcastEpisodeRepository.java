package com.lucy.lms.repository;

import com.lucy.lms.entity.PodcastEpisode;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PodcastEpisodeRepository extends JpaRepository<PodcastEpisode, Long> {

    List<PodcastEpisode> findByCreatorId(Long creatorId);

    List<PodcastEpisode> findByStatus(String status);

    List<PodcastEpisode> findByRoomId(Long roomId);
}
