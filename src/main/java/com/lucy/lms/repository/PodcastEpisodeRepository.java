package com.lucy.lms.repository;

import com.lucy.lms.entity.PodcastEpisode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PodcastEpisodeRepository extends JpaRepository<PodcastEpisode, Long> {

    List<PodcastEpisode> findByCreatorId(Long creatorId);

    List<PodcastEpisode> findByCreatorIdOrderByCreatedAtDesc(Long creatorId);

    List<PodcastEpisode> findByStatus(String status);

    List<PodcastEpisode> findByStatusOrderByCreatedAtDesc(String status);

    @Query("""
            select p
            from PodcastEpisode p
            left join p.creator c
            where p.status = 'PUBLISHED'
              and (
                    :keyword = ''
                    or lower(p.title) like lower(concat('%', :keyword, '%'))
                    or lower(coalesce(p.description, '')) like lower(concat('%', :keyword, '%'))
                    or lower(coalesce(c.displayName, '')) like lower(concat('%', :keyword, '%'))
                    or lower(coalesce(c.fullName, '')) like lower(concat('%', :keyword, '%'))
                    or lower(coalesce(c.email, '')) like lower(concat('%', :keyword, '%'))
              )
            order by p.createdAt desc
            """)
    List<PodcastEpisode> searchPublished(@Param("keyword") String keyword);

    List<PodcastEpisode> findByRoomId(Long roomId);
}
