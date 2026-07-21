<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="LUCY Podcast Player">

<style>
    /* Dark Spotify-like Theme overrides inside lucy-content container */
    .spotify-player-container {
        background: #0f0e17;
        color: #fffffe;
        border-radius: 20px;
        padding: 30px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.4);
        margin-top: 10px;
        font-family: 'Inter', sans-serif;
    }

    .spotify-header {
        display: flex;
        align-items: center;
        gap: 20px;
        margin-bottom: 30px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        padding-bottom: 20px;
    }

    .spotify-logo-icon {
        width: 60px;
        height: 60px;
        background: linear-gradient(135deg, #1DB954, #1ed760);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 32px;
        color: #fff;
        box-shadow: 0 4px 15px rgba(29, 185, 84, 0.4);
    }

    .spotify-title {
        font-size: 26px;
        font-weight: 800;
        letter-spacing: -0.5px;
        background: linear-gradient(90deg, #ffffff, #a7a9be);
        -webkit-background-clip: text;
        background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .spotify-body {
        display: block;
    }

    /* Episode list design */
    .episode-list {
        display: flex;
        flex-direction: column;
        gap: 12px;
        max-height: 480px;
        overflow-y: auto;
        padding-right: 8px;
    }

    .episode-list::-webkit-scrollbar {
        width: 6px;
    }
    .episode-list::-webkit-scrollbar-track {
        background: rgba(255,255,255,0.03);
        border-radius: 10px;
    }
    .episode-list::-webkit-scrollbar-thumb {
        background: rgba(255,255,255,0.15);
        border-radius: 10px;
    }

    .episode-card {
        background: rgba(255, 255, 255, 0.03);
        border: 1px solid rgba(255, 255, 255, 0.05);
        border-radius: 12px;
        padding: 16px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        cursor: pointer;
        transition: all 0.2s;
    }

    .episode-card:hover {
        background: rgba(255, 255, 255, 0.08);
        border-color: rgba(29, 185, 84, 0.3);
        transform: translateX(4px);
    }

    .episode-card.active {
        background: rgba(29, 185, 84, 0.1);
        border-color: #1DB954;
    }

    .episode-card.locked {
        opacity: 0.7;
        background: rgba(255, 255, 255, 0.02);
    }

    .episode-info {
        display: flex;
        align-items: center;
        gap: 16px;
        flex: 1;
        min-width: 0;
    }

    .episode-avatar {
        width: 48px;
        height: 48px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
        color: #1DB954;
        transition: all 0.2s;
    }

    .episode-card:not(.locked):hover .episode-avatar {
        background: #1DB954;
        color: #fff;
    }
    
    .episode-card.locked .episode-avatar {
        color: #a7a9be;
    }

    .episode-meta {
        min-width: 0;
    }

    .episode-title {
        font-size: 15px;
        font-weight: 600;
        margin-bottom: 4px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .episode-desc {
        font-size: 12px;
        color: #a7a9be;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        line-clamp: 1;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .episode-right {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .episode-duration {
        font-size: 13px;
        color: #a7a9be;
    }

    /* Spotify-like persistent bottom player */
    .spotify-bottom-player {
        background: #181818;
        border-top: 1px solid #282828;
        padding: 16px 30px;
        position: fixed;
        bottom: 0;
        left: 0;
        right: 0;
        z-index: 1100;
        display: flex;
        align-items: center;
        justify-content: space-between;
        color: #fff;
    }

    .player-left {
        display: flex;
        align-items: center;
        gap: 14px;
        width: 30%;
        min-width: 0;
    }

    .player-album-art {
        width: 50px;
        height: 50px;
        background: #282828;
        border-radius: 4px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 22px;
        color: #1DB954;
    }

    .player-track-info {
        max-width: 200px;
        min-width: 0;
    }

    .player-track-title {
        font-size: 14px;
        font-weight: 600;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .player-track-creator {
        font-size: 11px;
        color: #b3b3b3;
    }

    .player-center {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 8px;
        width: 40%;
    }

    .player-controls {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .control-btn {
        background: none;
        border: none;
        color: #b3b3b3;
        font-size: 18px;
        cursor: pointer;
        transition: all 0.2s;
    }

    .control-btn:hover {
        color: #fff;
    }

    .control-btn.btn-play-pause {
        width: 38px;
        height: 38px;
        border-radius: 50%;
        background: #fff;
        color: #000;
        font-size: 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 2px 8px rgba(255,255,255,0.2);
    }

    .control-btn.btn-play-pause:hover {
        transform: scale(1.06);
        background: #f3f3f3;
    }

    .progress-container {
        display: flex;
        align-items: center;
        gap: 10px;
        width: 100%;
    }

    .time-stamp {
        font-size: 11px;
        color: #b3b3b3;
        width: 35px;
    }

    .progress-bar-wrapper {
        flex-grow: 1;
        position: relative;
        height: 4px;
        background: #535353;
        border-radius: 2px;
        cursor: pointer;
    }

    .progress-bar-fill {
        height: 100%;
        width: 0%;
        background: #1DB954;
        border-radius: 2px;
        position: relative;
    }

    .progress-bar-wrapper:hover .progress-bar-fill {
        background: #1ed760;
    }

    .player-right {
        display: flex;
        align-items: center;
        justify-content: flex-end;
        gap: 12px;
        width: 30%;
    }

    .volume-slider-wrapper {
        width: 100px;
        height: 4px;
        background: #535353;
        border-radius: 2px;
        cursor: pointer;
        position: relative;
    }

    .volume-slider-fill {
        height: 100%;
        width: 80%;
        background: #fff;
        border-radius: 2px;
    }

    .volume-slider-wrapper:hover .volume-slider-fill {
        background: #1DB954;
    }

    /* Padding for footer to avoid being hidden by the sticky bar */
    .lucy-content {
        padding-bottom: 110px !important;
    }

    .podcast-toolbar {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        margin-bottom: 22px;
    }

    .podcast-tabs {
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .podcast-tab,
    .upload-shortcut {
        min-height: 38px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 6px;
        padding: 8px 14px;
        color: #c7c7cf;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
        transition: background 0.2s, border-color 0.2s, color 0.2s;
    }

    .podcast-tab:hover {
        background: rgba(255, 255, 255, 0.07);
        border-color: rgba(255, 255, 255, 0.2);
        color: #fff;
    }

    .upload-shortcut {
        background: #1DB954;
        border-color: #1DB954;
        color: #07150c;
    }

    .upload-shortcut:hover {
        background: #1ed760;
        border-color: #1ed760;
        color: #07150c;
    }

    .podcast-tab.active {
        background: #1DB954;
        border-color: #1DB954;
        color: #07150c;
    }

    .podcast-search {
        display: flex;
        align-items: center;
        gap: 8px;
        width: min(100%, 560px);
        margin-bottom: 24px;
    }

    .podcast-search-field {
        position: relative;
        flex: 1;
        min-width: 0;
    }

    .podcast-search-field > i {
        position: absolute;
        left: 14px;
        top: 50%;
        transform: translateY(-50%);
        color: #858591;
        pointer-events: none;
    }

    .podcast-search input {
        width: 100%;
        height: 42px;
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 6px;
        background: rgba(255, 255, 255, 0.06);
        color: #fff;
        padding: 0 42px 0 40px;
        outline: none;
    }

    .podcast-search input:focus {
        border-color: #1DB954;
        box-shadow: 0 0 0 3px rgba(29, 185, 84, 0.16);
    }

    .podcast-search input::placeholder {
        color: #858591;
    }

    .search-clear {
        position: absolute;
        right: 4px;
        top: 3px;
        width: 36px;
        height: 36px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 4px;
        color: #a7a9be;
        text-decoration: none;
    }

    .search-clear:hover {
        color: #fff;
        background: rgba(255, 255, 255, 0.08);
    }

    .search-submit {
        height: 42px;
        border: 0;
        border-radius: 6px;
        background: #1DB954;
        color: #07150c;
        padding: 0 18px;
        font-weight: 700;
    }

    .favorite-btn {
        width: 36px;
        height: 36px;
        flex: 0 0 36px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border: 0;
        border-radius: 50%;
        background: transparent;
        color: #a7a9be;
        font-size: 18px;
        cursor: pointer;
        transition: color 0.2s, background 0.2s, transform 0.2s;
    }

    .favorite-btn:hover {
        color: #fff;
        background: rgba(255, 255, 255, 0.08);
        transform: scale(1.05);
    }

    .favorite-btn.active {
        color: #1ed760;
    }

    .favorite-btn:disabled {
        cursor: default;
        opacity: 0.35;
        transform: none;
    }

    .podcast-toast {
        position: fixed;
        right: 24px;
        bottom: 104px;
        z-index: 1200;
        max-width: min(360px, calc(100vw - 32px));
        padding: 11px 14px;
        border: 1px solid rgba(29, 185, 84, 0.45);
        border-radius: 6px;
        background: #202020;
        color: #fff;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);
        font-size: 13px;
        opacity: 0;
        visibility: hidden;
        transform: translateY(8px);
        transition: opacity 0.2s, visibility 0.2s, transform 0.2s;
    }

    .podcast-toast.show {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    .podcast-toast.error {
        border-color: rgba(239, 68, 68, 0.55);
    }

    @media (max-width: 768px) {
        .spotify-player-container {
            padding: 20px 14px;
            border-radius: 8px;
        }

        .spotify-header {
            align-items: flex-start;
        }

        .spotify-logo-icon {
            width: 48px;
            height: 48px;
            flex: 0 0 48px;
            font-size: 24px;
        }

        .spotify-title {
            font-size: 21px;
        }

        .upload-shortcut {
            width: 42px;
            flex: 0 0 42px;
            padding: 8px;
        }

        .upload-shortcut span {
            display: none;
        }

        .podcast-toolbar,
        .podcast-search {
            align-items: stretch;
            flex-direction: column;
        }

        .podcast-tabs {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(110px, 1fr));
        }

        .episode-card {
            align-items: flex-start;
            gap: 10px;
            padding: 12px;
        }

        .episode-info,
        .episode-meta {
            min-width: 0;
        }

        .episode-right {
            gap: 4px;
        }

        .episode-duration .badge-status,
        .volume-slider-wrapper {
            display: none;
        }

        .spotify-bottom-player {
            display: grid;
            grid-template-columns: minmax(0, 1fr) auto;
            gap: 8px 12px;
            padding: 10px 12px;
        }

        .player-left {
            width: 100%;
        }

        .player-track-info {
            max-width: none;
            flex: 1;
        }

        .player-center {
            grid-column: 1 / -1;
            grid-row: 2;
            width: 100%;
        }

        .player-right {
            grid-column: 2;
            grid-row: 1;
            width: auto;
        }

        .podcast-toast {
            right: 16px;
            bottom: 142px;
        }

        .lucy-content {
            padding-bottom: 155px !important;
        }
    }
</style>

<div class="spotify-player-container">
    <div class="spotify-header">
        <div class="spotify-logo-icon">
            <i class="bi bi-headphones"></i>
        </div>
        <div style="flex: 1;">
            <div class="spotify-title">LUCY Premium Podcasts</div>
            <p class="text-muted mb-0" style="font-size: 12.5px;">Enjoy recorded audio sessions from our Creators</p>
        </div>
        <c:if test="${canCreatePodcast}">
            <a href="/podcasts/create" class="upload-shortcut" title="Upload podcast">
                <i class="bi bi-cloud-arrow-up"></i><span>Upload Podcast</span>
            </a>
        </c:if>
    </div>

    <div class="podcast-toolbar">
        <nav class="podcast-tabs" aria-label="Podcast sections">
            <a href="/podcasts/search" class="podcast-tab ${viewMode == 'search' ? 'active' : ''}">
                <i class="bi bi-search"></i><span>Search</span>
            </a>
            <a href="/podcasts/library" class="podcast-tab ${viewMode == 'library' ? 'active' : ''}">
                <i class="bi bi-collection-play"></i><span>Your Library</span>
            </a>
            <c:if test="${canCreatePodcast}">
                <a href="/podcasts/mine" class="podcast-tab">
                    <i class="bi bi-mic"></i><span>My Podcasts</span>
                </a>
            </c:if>
        </nav>
    </div>

    <c:if test="${viewMode == 'search'}">
        <form class="podcast-search" method="get" action="/podcasts/search" role="search">
            <div class="podcast-search-field">
                <i class="bi bi-search"></i>
                <input type="search" name="keyword" value="${fn:escapeXml(keyword)}"
                       placeholder="Search by podcast, description, or creator" aria-label="Search podcasts">
                <c:if test="${not empty keyword}">
                    <a href="/podcasts/search" class="search-clear" title="Clear search" aria-label="Clear search">
                        <i class="bi bi-x-lg"></i>
                    </a>
                </c:if>
            </div>
            <button type="submit" class="search-submit"><i class="bi bi-search me-1"></i>Search</button>
        </form>
    </c:if>

    <c:if test="${param.success == 'unlocked'}">
        <div class="alert alert-success" style="border-radius: 12px;">
            <i class="bi bi-check-circle-fill me-2"></i> You have successfully unlocked the premium podcast!
        </div>
    </c:if>
    <c:if test="${param.error == 'insufficient_credits'}">
        <div class="alert alert-danger" style="border-radius: 12px;">
            <i class="bi bi-x-circle-fill me-2"></i> Insufficient credits. Please recharge your account.
        </div>
    </c:if>
    <c:if test="${param.error == 'access_denied'}">
        <div class="alert alert-warning" style="border-radius: 12px;">
            <i class="bi bi-shield-exclamation me-2"></i> You do not have permission to upload podcasts. Only Super Creators can post content.
        </div>
    </c:if>

    <div class="spotify-body">
        <!-- Episode List Panel -->
        <div>
            <h5 class="mb-3" style="font-weight: 700; color: #fff;">
                <c:choose>
                    <c:when test="${viewMode == 'library'}">Saved Podcasts</c:when>
                    <c:when test="${not empty keyword}">Search Results</c:when>
                    <c:otherwise>Podcast Episodes</c:otherwise>
                </c:choose>
            </h5>
            <div class="episode-list" id="episodeListContainer">
                <c:choose>
                    <c:when test="${empty podcasts}">
                        <div class="p-5 text-center text-muted" id="podcastEmptyState">
                            <i class="bi ${viewMode == 'library' ? 'bi-heart' : 'bi-music-note-beamed'}" style="font-size: 40px; color: #1DB954;"></i>
                            <p class="mt-3 mb-0">
                                <c:choose>
                                    <c:when test="${viewMode == 'library'}">Your library is empty. Save a podcast with the heart button.</c:when>
                                    <c:when test="${not empty keyword}">No podcasts match your search.</c:when>
                                    <c:otherwise>No podcast episodes published yet.</c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="p" items="${podcasts}" varStatus="status">
                            <c:set var="isUnlocked" value="true" />
                            <c:set var="audioSrc" value="${p.audioUrl}" />
                            <c:set var="creatorName" value="${p.creator != null && not empty p.creator.displayName ? p.creator.displayName : 'LUCY'}" />
                            <c:set var="isFavorite" value="${favoritePodcastIds.contains(p.id)}" />

                            <div class="episode-card ${!isUnlocked ? 'locked' : ''} ${status.first && isUnlocked ? 'active' : ''}" 
                                 data-id="${p.id}" 
                                 data-title="${fn:escapeXml(p.title)}"
                                 data-creator="${fn:escapeXml(creatorName)}"
                                 data-url="${isUnlocked ? audioSrc : ''}" 
                                 data-duration="${p.durationSeconds}"
                                 data-unlocked="${isUnlocked}"
                                 data-favorite="${isFavorite}">
                                <div class="episode-info">
                                    <div class="episode-avatar">
                                        <c:choose>
                                            <c:when test="${isUnlocked}">
                                                <i class="bi bi-play-fill"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-lock-fill"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="episode-meta">
                                        <div class="episode-title"><c:out value="${p.title}" /> <c:if test="${p.isPremium}"><span class="badge bg-warning text-dark ms-1" style="font-size: 10px;">PREMIUM</span></c:if></div>
                                        <div class="episode-desc"><c:out value="${p.description}" /></div>
                                    </div>
                                </div>
                                <div class="episode-right">
                                    <button type="button"
                                            class="favorite-btn episode-favorite-btn ${isFavorite ? 'active' : ''}"
                                            data-favorite-id="${p.id}"
                                            aria-pressed="${isFavorite}"
                                            title="${isFavorite ? 'Remove from library' : 'Save to library'}">
                                        <i class="bi ${isFavorite ? 'bi-heart-fill' : 'bi-heart'}"></i>
                                    </button>
                                    <div class="episode-duration d-flex align-items-center">
                                        <c:choose>
                                            <c:when test="${!isUnlocked}">
                                                <form method="post" action="/podcasts/buy/${p.id}" class="m-0">
                                                    <button class="btn btn-sm" style="background: rgba(255,255,255,0.1); color: #fff; border-radius: 20px; font-size: 12px; font-weight: 600;">
                                                        Unlock for ${p.price} <i class="bi bi-coin ms-1 text-warning"></i>
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-status badge-purple me-2">By <c:out value="${creatorName}" /></span>
                                                <span class="duration-text"></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
</div>

<div class="podcast-toast" id="podcastToast" role="status" aria-live="polite">
    <i class="bi bi-check-circle-fill me-2" id="podcastToastIcon"></i>
    <span id="podcastToastMessage"></span>
</div>

<!-- Sticky Bottom Player Bar -->
<div class="spotify-bottom-player">
    <div class="player-left">
        <div class="player-album-art">
            <i class="bi bi-disc"></i>
        </div>
        <div class="player-track-info">
            <div class="player-track-title" id="playerTrackTitle">No Episode Selected</div>
            <div class="player-track-creator" id="playerTrackCreator">-</div>
        </div>
        <button type="button" class="favorite-btn" id="btnFavorite" title="Save to library"
                aria-label="Save to library" aria-pressed="false" disabled>
            <i class="bi bi-heart"></i>
        </button>
    </div>

    <div class="player-center">
        <div class="player-controls">
            <button class="control-btn" id="btnPrev" title="Previous"><i class="bi bi-skip-start-fill"></i></button>
            <button class="control-btn btn-play-pause" id="btnPlayPause" title="Play"><i class="bi bi-play-fill" id="playIcon"></i></button>
            <button class="control-btn" id="btnNext" title="Next"><i class="bi bi-skip-end-fill"></i></button>
        </div>
        <div class="progress-container">
            <span class="time-stamp" id="timeCurrent">0:00</span>
            <div class="progress-bar-wrapper" id="progressWrapper">
                <div class="progress-bar-fill" id="progressFill"></div>
            </div>
            <span class="time-stamp" id="timeDuration">0:00</span>
        </div>
    </div>

    <div class="player-right">
        <button class="control-btn" id="btnMute" style="font-size: 15px;"><i class="bi bi-volume-up-fill" id="muteIcon"></i></button>
        <div class="volume-slider-wrapper" id="volumeWrapper">
            <div class="volume-slider-fill" id="volumeFill"></div>
        </div>
    </div>
</div>

<!-- Audio Source -->
<audio id="mainAudio" style="display: none;"></audio>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const audio = document.getElementById("mainAudio");
        let cards = Array.from(document.querySelectorAll(".episode-card"));
        const contextPath = "${pageContext.request.contextPath}";
        const viewMode = "${viewMode}";
        
        // Element bindings
        const playerTrackTitle = document.getElementById("playerTrackTitle");
        const playerTrackCreator = document.getElementById("playerTrackCreator");
        
        const btnPlayPause = document.getElementById("btnPlayPause");
        const playIcon = document.getElementById("playIcon");
        const btnPrev = document.getElementById("btnPrev");
        const btnNext = document.getElementById("btnNext");
        const btnFavorite = document.getElementById("btnFavorite");
        const timeCurrent = document.getElementById("timeCurrent");
        const timeDuration = document.getElementById("timeDuration");
        const progressWrapper = document.getElementById("progressWrapper");
        const progressFill = document.getElementById("progressFill");
        
        const btnMute = document.getElementById("btnMute");
        const muteIcon = document.getElementById("muteIcon");
        const volumeWrapper = document.getElementById("volumeWrapper");
        const volumeFill = document.getElementById("volumeFill");
        const podcastToast = document.getElementById("podcastToast");
        const podcastToastIcon = document.getElementById("podcastToastIcon");
        const podcastToastMessage = document.getElementById("podcastToastMessage");

        let currentActiveIndex = -1;
        let isPlaying = false;
        let isMuted = false;
        let currentVolume = 0.8;
        let toastTimer;

        // Convert duration to MM:SS
        function formatTime(secs) {
            if (isNaN(secs)) return "0:00";
            const m = Math.floor(secs / 60);
            const s = Math.floor(secs % 60);
            return m + ":" + (s < 10 ? "0" : "") + s;
        }

        function updateFavoriteButton(button, isFavorite) {
            if (!button) return;
            const icon = button.querySelector("i");
            button.classList.toggle("active", isFavorite);
            button.setAttribute("aria-pressed", String(isFavorite));
            button.setAttribute("aria-label", isFavorite ? "Remove from library" : "Save to library");
            button.title = isFavorite ? "Remove from library" : "Save to library";
            if (icon) icon.className = isFavorite ? "bi bi-heart-fill" : "bi bi-heart";
        }

        function setFavoriteState(id, isFavorite) {
            cards.forEach(card => {
                if (card.getAttribute("data-id") === String(id)) {
                    card.setAttribute("data-favorite", String(isFavorite));
                }
            });
            document.querySelectorAll('[data-favorite-id="' + id + '"]').forEach(button => {
                updateFavoriteButton(button, isFavorite);
            });
        }

        function showToast(message, isError) {
            clearTimeout(toastTimer);
            podcastToastMessage.textContent = message;
            podcastToast.classList.toggle("error", Boolean(isError));
            podcastToastIcon.className = isError
                    ? "bi bi-exclamation-circle-fill me-2"
                    : "bi bi-check-circle-fill me-2";
            podcastToast.classList.add("show");
            toastTimer = setTimeout(() => podcastToast.classList.remove("show"), 2600);
        }

        function resetPlayer() {
            pauseTrack();
            audio.removeAttribute("src");
            audio.load();
            currentActiveIndex = -1;
            playerTrackTitle.textContent = "No Episode Selected";
            playerTrackCreator.textContent = "-";
            timeCurrent.textContent = "0:00";
            timeDuration.textContent = "0:00";
            progressFill.style.width = "0%";
            btnFavorite.removeAttribute("data-favorite-id");
            btnFavorite.disabled = true;
            updateFavoriteButton(btnFavorite, false);
        }

        function removeCardFromLibrary(id) {
            const card = cards.find(item => item.getAttribute("data-id") === String(id));
            if (!card) return;

            const removedIndex = cards.indexOf(card);
            const removedActiveTrack = removedIndex === currentActiveIndex;
            card.remove();
            cards.splice(removedIndex, 1);

            if (removedActiveTrack) {
                resetPlayer();
                if (cards.length > 0) selectTrack(Math.min(removedIndex, cards.length - 1));
            } else if (currentActiveIndex > removedIndex) {
                currentActiveIndex--;
            }

            if (cards.length === 0) {
                document.getElementById("episodeListContainer").innerHTML =
                        '<div class="p-5 text-center text-muted" id="podcastEmptyState">' +
                        '<i class="bi bi-heart" style="font-size:40px;color:#1DB954;"></i>' +
                        '<p class="mt-3 mb-0">Your library is empty. Save a podcast with the heart button.</p>' +
                        '</div>';
            }
        }

        async function toggleFavorite(id, triggerButton) {
            if (!id || !triggerButton) return;
            triggerButton.disabled = true;
            try {
                const response = await fetch(contextPath + "/podcasts/" + id + "/favorite", {
                    method: "POST",
                    headers: {
                        "Accept": "application/json",
                        "X-Requested-With": "XMLHttpRequest"
                    }
                });
                if (response.status === 401
                        || (response.redirected && response.url.includes("/login"))) {
                    window.location.href = contextPath + "/login";
                    return;
                }
                if (!response.ok) throw new Error("favorite_request_failed");

                const result = await response.json();
                setFavoriteState(id, result.favorite);
                showToast(result.favorite ? "Saved to your library." : "Removed from your library.", false);
                if (viewMode === "library" && !result.favorite) {
                    removeCardFromLibrary(id);
                }
            } catch (error) {
                console.error("Could not update favorite:", error);
                showToast("Could not update your library. Please try again.", true);
            } finally {
                if (document.body.contains(triggerButton)) {
                    triggerButton.disabled = triggerButton === btnFavorite
                            && !btnFavorite.hasAttribute("data-favorite-id");
                }
            }
        }

        // Initialize duration text in episode cards
        cards.forEach(card => {
            const rawSecs = parseInt(card.getAttribute("data-duration")) || 180;
            const durationEl = card.querySelector(".duration-text");
            if (durationEl) durationEl.textContent = formatTime(rawSecs);

            const favoriteButton = card.querySelector(".episode-favorite-btn");
            if (favoriteButton) {
                favoriteButton.addEventListener("click", function (e) {
                    e.preventDefault();
                    e.stopPropagation();
                    toggleFavorite(card.getAttribute("data-id"), favoriteButton);
                });
            }
            
            card.addEventListener("click", function (e) {
                if (e.target.closest("form") || e.target.closest(".favorite-btn")) return;

                if (card.getAttribute("data-unlocked") === "true") {
                    selectTrack(cards.indexOf(card));
                    playTrack();
                }
            });
        });

        btnFavorite.addEventListener("click", function () {
            toggleFavorite(btnFavorite.getAttribute("data-favorite-id"), btnFavorite);
        });

        function selectTrack(index) {
            if (index < 0 || index >= cards.length) return;
            const card = cards[index];
            if (card.getAttribute("data-unlocked") !== "true") return; // Cannot play locked track
            
            cards.forEach(c => c.classList.remove("active"));
            card.classList.add("active");
            currentActiveIndex = index;

            const title = card.getAttribute("data-title");
            const creator = card.getAttribute("data-creator");
            let url = card.getAttribute("data-url");
            const id = parseInt(card.getAttribute("data-id"));

            // Real audio fallback for demo purposes
            if (url && (url.includes("example.com") || url.includes("mock-podcast") || url.includes("/audio/recordings/"))) {
                url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-" + ((id % 8) + 1) + ".mp3";
            }

            if (url) {
                audio.src = url;
                audio.load();
            }

            // Update details
            playerTrackTitle.textContent = title;
            playerTrackCreator.textContent = "By " + creator;
            btnFavorite.setAttribute("data-favorite-id", String(id));
            btnFavorite.disabled = false;
            updateFavoriteButton(btnFavorite, card.getAttribute("data-favorite") === "true");
        }

        function playTrack() {
            if (!audio.src) return;
            audio.play().then(() => {
                isPlaying = true;
                playIcon.className = "bi bi-pause-fill";
            }).catch(e => {
                console.error("Playback failed:", e);
            });
        }

        function pauseTrack() {
            audio.pause();
            isPlaying = false;
            playIcon.className = "bi bi-play-fill";
        }

        // Play/Pause toggle
        btnPlayPause.addEventListener("click", function () {
            if (isPlaying) {
                pauseTrack();
            } else {
                if (!audio.src && currentActiveIndex >= 0) {
                    selectTrack(currentActiveIndex);
                } else if (!audio.src) {
                    // Try to find first unlocked track
                    for (let i = 0; i < cards.length; i++) {
                        if (cards[i].getAttribute("data-unlocked") === "true") {
                            selectTrack(i);
                            break;
                        }
                    }
                }
                playTrack();
            }
        });

        // Skip Next/Prev
        btnNext.addEventListener("click", function () {
            if (cards.length === 0) return;
            let nextIndex = currentActiveIndex;
            // Find next unlocked track
            for (let i = 1; i <= cards.length; i++) {
                let checkIdx = (currentActiveIndex + i) % cards.length;
                if (cards[checkIdx].getAttribute("data-unlocked") === "true") {
                    nextIndex = checkIdx;
                    break;
                }
            }
            if (nextIndex !== currentActiveIndex) {
                selectTrack(nextIndex);
                playTrack();
            }
        });

        btnPrev.addEventListener("click", function () {
            if (cards.length === 0) return;
            let prevIndex = currentActiveIndex;
            // Find prev unlocked track
            for (let i = 1; i <= cards.length; i++) {
                let checkIdx = (currentActiveIndex - i + cards.length) % cards.length;
                if (cards[checkIdx].getAttribute("data-unlocked") === "true") {
                    prevIndex = checkIdx;
                    break;
                }
            }
            if (prevIndex !== currentActiveIndex) {
                selectTrack(prevIndex);
                playTrack();
            }
        });

        // Track progress update
        audio.addEventListener("timeupdate", function () {
            if (audio.duration) {
                const percent = (audio.currentTime / audio.duration) * 100;
                progressFill.style.width = percent + "%";
                timeCurrent.textContent = formatTime(audio.currentTime);
                timeDuration.textContent = formatTime(audio.duration);
            }
        });

        audio.addEventListener("ended", function () {
            // Auto play next
            btnNext.click();
        });

        // Click to scrub progress
        progressWrapper.addEventListener("click", function (e) {
            const rect = progressWrapper.getBoundingClientRect();
            const clickX = e.clientX - rect.left;
            const width = rect.width;
            if (audio.duration) {
                audio.currentTime = (clickX / width) * audio.duration;
            }
        });

        // Mute / Unmute
        btnMute.addEventListener("click", function () {
            isMuted = !isMuted;
            audio.muted = isMuted;
            if (isMuted) {
                muteIcon.className = "bi bi-volume-mute-fill";
                volumeFill.style.width = "0%";
            } else {
                muteIcon.className = "bi bi-volume-up-fill";
                volumeFill.style.width = (currentVolume * 100) + "%";
            }
        });

        // Volume slider
        volumeWrapper.addEventListener("click", function (e) {
            const rect = volumeWrapper.getBoundingClientRect();
            const clickX = e.clientX - rect.left;
            const width = rect.width;
            let percent = clickX / width;
            if (percent < 0) percent = 0;
            if (percent > 1) percent = 1;

            currentVolume = percent;
            audio.volume = percent;
            
            isMuted = false;
            audio.muted = false;
            muteIcon.className = percent === 0 ? "bi bi-volume-mute-fill" : "bi bi-volume-up-fill";
            volumeFill.style.width = (percent * 100) + "%";
        });

        // Select the first unlocked track on page load
        if (cards.length > 0) {
            for (let i = 0; i < cards.length; i++) {
                if (cards[i].getAttribute("data-unlocked") === "true") {
                    selectTrack(i);
                    break;
                }
            }
        }
    });
</script>

</layout:main>
