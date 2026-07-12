<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        display: grid;
        grid-template-columns: 1fr 350px;
        gap: 30px;
    }

    @media (max-width: 992px) {
        .spotify-body {
            grid-template-columns: 1fr;
        }
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
        max-width: 450px;
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

    /* Right pane current details */
    .now-playing-panel {
        background: rgba(255, 255, 255, 0.02);
        border: 1px solid rgba(255, 255, 255, 0.05);
        border-radius: 16px;
        padding: 24px;
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
    }

    .vinyl-container {
        position: relative;
        width: 180px;
        height: 180px;
        margin-bottom: 24px;
    }

    .vinyl {
        width: 100%;
        height: 100%;
        border-radius: 50%;
        background: radial-gradient(circle, #2d2b42 20%, #0f0e17 21%, #0f0e17 30%, #111 31%, #111 60%, #000 61%, #000 100%);
        border: 4px solid #232136;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 8px 30px rgba(0,0,0,0.5);
    }

    .vinyl-label {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: #1DB954;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        font-size: 24px;
        border: 2px solid #000;
    }

    /* Rotation Animation */
    @keyframes rotateVinyl {
        from { transform: rotate(0deg); }
        to { transform: rotate(360deg); }
    }

    .vinyl.playing {
        animation: rotateVinyl 6s linear infinite;
    }

    .current-title {
        font-size: 18px;
        font-weight: 700;
        margin-bottom: 6px;
    }

    .current-creator {
        font-size: 13px;
        color: #1DB954;
        font-weight: 600;
        margin-bottom: 12px;
    }

    .current-desc {
        font-size: 12px;
        color: #a7a9be;
        line-height: 1.5;
        max-height: 80px;
        overflow-y: auto;
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
    </div>

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
            <h5 class="mb-3" style="font-weight: 700; color: #fff;">Podcast Episodes</h5>
            <div class="episode-list" id="episodeListContainer">
                <c:choose>
                    <c:when test="${empty podcasts}">
                        <div class="p-5 text-center text-muted">
                            <i class="bi bi-music-note-beamed" style="font-size: 40px; color: #1DB954;"></i>
                            <p class="mt-3">No podcast episodes published yet.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="p" items="${podcasts}" varStatus="status">
                            <c:set var="isUnlocked" value="true" />
                            
                            <c:set var="audioSrc" value="${p.audioUrl}" />
                            
                            <div class="episode-card ${!isUnlocked ? 'locked' : ''} ${status.first && isUnlocked ? 'active' : ''}" 
                                 data-id="${p.id}" 
                                 data-title="${p.title}" 
                                 data-creator="${p.creator.displayName}" 
                                 data-desc="${p.description}" 
                                 data-url="${isUnlocked ? audioSrc : ''}" 
                                 data-duration="${p.durationSeconds}"
                                 data-unlocked="${isUnlocked}">
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
                                        <div class="episode-title">${p.title} <c:if test="${p.isPremium}"><span class="badge bg-warning text-dark ms-1" style="font-size: 10px;">PREMIUM</span></c:if></div>
                                        <div class="episode-desc">${p.description}</div>
                                    </div>
                                </div>
                                <div class="episode-right">
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
                                                <span class="badge-status badge-purple me-2">By ${p.creator.displayName}</span>
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

        <!-- Now Playing Right Sidebar -->
        <div class="now-playing-panel">
            <div class="vinyl-container">
                <div class="vinyl" id="vinylDisc">
                    <div class="vinyl-label">
                        <i class="bi bi-music-note"></i>
                    </div>
                </div>
            </div>
            <div class="current-title" id="currentSidebarTitle">Select an Episode</div>
            <div class="current-creator" id="currentSidebarCreator">-</div>
            <hr style="width: 100%; border-color: rgba(255,255,255,0.08); margin: 16px 0;">
            <div class="current-desc" id="currentSidebarDesc">Click play on any episode to start listening.</div>
        </div>
    </div>
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
        const cards = document.querySelectorAll(".episode-card");
        
        // Element bindings
        const currentSidebarTitle = document.getElementById("currentSidebarTitle");
        const currentSidebarCreator = document.getElementById("currentSidebarCreator");
        const currentSidebarDesc = document.getElementById("currentSidebarDesc");
        const playerTrackTitle = document.getElementById("playerTrackTitle");
        const playerTrackCreator = document.getElementById("playerTrackCreator");
        
        const btnPlayPause = document.getElementById("btnPlayPause");
        const playIcon = document.getElementById("playIcon");
        const btnPrev = document.getElementById("btnPrev");
        const btnNext = document.getElementById("btnNext");
        const vinylDisc = document.getElementById("vinylDisc");
        
        const timeCurrent = document.getElementById("timeCurrent");
        const timeDuration = document.getElementById("timeDuration");
        const progressWrapper = document.getElementById("progressWrapper");
        const progressFill = document.getElementById("progressFill");
        
        const btnMute = document.getElementById("btnMute");
        const muteIcon = document.getElementById("muteIcon");
        const volumeWrapper = document.getElementById("volumeWrapper");
        const volumeFill = document.getElementById("volumeFill");

        let currentActiveIndex = -1;
        let isPlaying = false;
        let isMuted = false;
        let currentVolume = 0.8;

        // Convert duration to MM:SS
        function formatTime(secs) {
            if (isNaN(secs)) return "0:00";
            const m = Math.floor(secs / 60);
            const s = Math.floor(secs % 60);
            return m + ":" + (s < 10 ? "0" : "") + s;
        }

        // Initialize duration text in episode cards
        cards.forEach((card, index) => {
            const rawSecs = parseInt(card.getAttribute("data-duration")) || 180;
            const durationEl = card.querySelector(".duration-text");
            if (durationEl) durationEl.textContent = formatTime(rawSecs);
            
            card.addEventListener("click", function (e) {
                // Ignore clicks on the buy button/form
                if (e.target.closest('form')) return;

                if (card.getAttribute("data-unlocked") === "true") {
                    selectTrack(index);
                    playTrack();
                }
            });
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
            const desc = card.getAttribute("data-desc");
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
            currentSidebarTitle.textContent = title;
            currentSidebarCreator.textContent = "By " + creator;
            currentSidebarDesc.textContent = desc || "No description provided.";
            playerTrackTitle.textContent = title;
            playerTrackCreator.textContent = "By " + creator;
        }

        function playTrack() {
            if (!audio.src) return;
            audio.play().then(() => {
                isPlaying = true;
                playIcon.className = "bi bi-pause-fill";
                vinylDisc.classList.add("playing");
            }).catch(e => {
                console.error("Playback failed:", e);
            });
        }

        function pauseTrack() {
            audio.pause();
            isPlaying = false;
            playIcon.className = "bi bi-play-fill";
            vinylDisc.classList.remove("playing");
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
