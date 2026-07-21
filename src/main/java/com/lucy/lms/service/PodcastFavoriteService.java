package com.lucy.lms.service;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.entity.PodcastEpisode;
import com.lucy.lms.entity.PodcastFavorite;
import com.lucy.lms.repository.PodcastFavoriteRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

@Service
public class PodcastFavoriteService {

    private final PodcastFavoriteRepository favoriteRepository;

    public PodcastFavoriteService(PodcastFavoriteRepository favoriteRepository) {
        this.favoriteRepository = favoriteRepository;
    }

    @Transactional(readOnly = true)
    public Set<Long> getFavoritePodcastIds(Long userId) {
        return new LinkedHashSet<>(favoriteRepository.findPodcastIdsByUserId(userId));
    }

    @Transactional(readOnly = true)
    public List<PodcastEpisode> getLibrary(Long userId) {
        return favoriteRepository.findLibraryByUserId(userId).stream()
                .map(PodcastFavorite::getPodcast)
                .toList();
    }

    @Transactional
    public boolean toggle(AppUser user, PodcastEpisode podcast) {
        PodcastFavorite existing = favoriteRepository
                .findByUserIdAndPodcastId(user.getId(), podcast.getId())
                .orElse(null);
        if (existing != null) {
            favoriteRepository.delete(existing);
            return false;
        }

        PodcastFavorite favorite = new PodcastFavorite();
        favorite.setUser(user);
        favorite.setPodcast(podcast);
        favoriteRepository.save(favorite);
        return true;
    }

    @Transactional
    public void removeForPodcast(Long podcastId) {
        favoriteRepository.deleteByPodcastId(podcastId);
    }
}
