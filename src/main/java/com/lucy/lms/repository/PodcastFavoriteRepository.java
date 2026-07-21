package com.lucy.lms.repository;

import com.lucy.lms.entity.PodcastFavorite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface PodcastFavoriteRepository extends JpaRepository<PodcastFavorite, Long> {

    Optional<PodcastFavorite> findByUserIdAndPodcastId(Long userId, Long podcastId);

    @Query("""
            select f
            from PodcastFavorite f
            join fetch f.podcast p
            left join fetch p.creator
            where f.user.id = :userId
              and p.status = 'PUBLISHED'
            order by f.createdAt desc
            """)
    List<PodcastFavorite> findLibraryByUserId(@Param("userId") Long userId);

    @Query("select f.podcast.id from PodcastFavorite f where f.user.id = :userId")
    List<Long> findPodcastIdsByUserId(@Param("userId") Long userId);

    @Modifying
    @Query("delete from PodcastFavorite f where f.podcast.id = :podcastId")
    void deleteByPodcastId(@Param("podcastId") Long podcastId);
}
