<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="isAdmin" value="${sessionScope.currentUser.role == 'ADMIN'}" />

<layout:main pageTitle="Live Rooms">

<c:choose>
    <c:when test="${isAdmin}">
        <!-- ADMIN VIEW -->
        <div class="d-flex align-items-center justify-content-between mb-4">
            <p class="text-muted mb-0" style="font-size: 13px;">Manage live audio rooms</p>
            <a href="/rooms/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Room</a>
        </div>

        <div class="lucy-table">
            <c:choose>
                <c:when test="${empty rooms}">
                    <div class="empty-state"><i class="bi bi-mic"></i><p>No rooms yet.</p></div>
                </c:when>
                <c:otherwise>
                    <table class="table mb-0">
                        <thead>
                            <tr><th>ID</th><th>Title</th><th>Level</th><th>Language</th><th>Type</th><th>Status</th><th>Host</th><th>Max</th><th style="width:120px;">Actions</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${rooms}">
                                <tr>
                                    <td><strong>#${r.id}</strong></td>
                                    <td><a href="/rooms/${r.id}" style="color: #6C5CE7; text-decoration: none; font-weight: 500;">${r.title}</a></td>
                                    <td><span class="badge" style="background: #EEF2FF; color: #4F46E5; font-size: 11px;">Lvl ${r.levelNumber != null ? r.levelNumber : '-'}</span></td>
                                    <td><span class="badge-status badge-purple">${r.languageCode}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${r.roomType == 'PUBLIC'}"><span class="badge-status badge-info">Public</span></c:when>
                                            <c:when test="${r.roomType == 'PRO_CLASS'}"><span class="badge-status badge-purple">Pro Class</span></c:when>
                                            <c:when test="${r.roomType == 'PREMIUM'}"><span class="badge-status badge-pink">Premium</span></c:when>
                                            <c:otherwise><span class="badge-status badge-gray">${r.roomType}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${r.status == 'LIVE'}"><span class="badge-status badge-success"><i class="bi bi-broadcast me-1"></i>Live</span></c:when>
                                            <c:when test="${r.status == 'SCHEDULED'}"><span class="badge-status badge-warning">Scheduled</span></c:when>
                                            <c:when test="${r.status == 'ENDED'}"><span class="badge-status badge-gray">Ended</span></c:when>
                                            <c:otherwise><span class="badge-status badge-gray">${r.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><c:if test="${r.hostUser != null}">${r.hostUser.displayName}</c:if></td>
                                    <td>${r.maxParticipants}</td>
                                    <td>
                                        <a href="/rooms/${r.id}" class="btn-action edit" title="View"><i class="bi bi-eye"></i></a>
                                        <button class="btn-action delete" onclick="confirmDelete('/rooms/delete/${r.id}')"><i class="bi bi-trash"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </c:when>

    <c:otherwise>
        <!-- LEARNER VIEW — Level-Based Room Browser -->
        <style>
            .level-browser-header {
                background: linear-gradient(135deg, #1E1B4B 0%, #312E81 50%, #4338CA 100%);
                border-radius: 20px;
                padding: 32px;
                margin-bottom: 28px;
                color: #fff;
                position: relative;
                overflow: hidden;
            }
            .level-browser-header::after {
                content: '';
                position: absolute;
                top: -50%;
                right: -10%;
                width: 300px;
                height: 300px;
                background: radial-gradient(circle, rgba(139,92,246,0.3) 0%, transparent 70%);
                border-radius: 50%;
            }
            .level-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(46px, 1fr));
                gap: 6px;
                max-height: 280px;
                overflow-y: auto;
                padding: 4px;
                scrollbar-width: thin;
                scrollbar-color: rgba(99,102,241,0.4) transparent;
            }
            .level-grid::-webkit-scrollbar { width: 4px; }
            .level-grid::-webkit-scrollbar-thumb { background: rgba(99,102,241,0.4); border-radius: 4px; }
            .level-btn {
                width: 100%;
                aspect-ratio: 1;
                border: 1px solid #E2E8F0;
                border-radius: 10px;
                background: #fff;
                font-weight: 700;
                font-size: 13px;
                color: #475569;
                cursor: pointer;
                transition: all 0.2s;
                display: flex;
                align-items: center;
                justify-content: center;
                text-decoration: none;
            }
            .level-btn:hover {
                background: #EEF2FF;
                border-color: #6366F1;
                color: #4F46E5;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(99,102,241,0.15);
            }
            .level-btn.active {
                background: linear-gradient(135deg, #6366F1, #8B5CF6);
                color: #fff;
                border-color: transparent;
                box-shadow: 0 4px 16px rgba(99,102,241,0.4);
            }
            .level-btn.locked {
                background: #F8FAFC;
                color: #CBD5E1;
                border-color: #F1F5F9;
                cursor: not-allowed;
            }
            .level-btn.locked:hover {
                transform: none;
                box-shadow: none;
            }
            .level-range-nav {
                display: flex;
                gap: 6px;
                flex-wrap: wrap;
                margin-bottom: 12px;
            }
            .range-btn {
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                border: 1px solid rgba(255,255,255,0.2);
                background: rgba(255,255,255,0.1);
                color: rgba(255,255,255,0.8);
                cursor: pointer;
                transition: all 0.2s;
                text-decoration: none;
            }
            .range-btn:hover, .range-btn.active {
                background: rgba(255,255,255,0.25);
                color: #fff;
                border-color: rgba(255,255,255,0.4);
            }
            .level-error-alert {
                background: linear-gradient(135deg, #FEF2F2, #FECACA);
                border: 1px solid #FECACA;
                border-radius: 12px;
                padding: 16px 20px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 12px;
            }
            .room-card-level {
                border-radius: 16px;
                border: 1px solid #E2E8F0;
                background: #fff;
                padding: 0;
                overflow: hidden;
                transition: all 0.3s;
                height: 100%;
                display: flex;
                flex-direction: column;
            }
            .room-card-level:hover {
                box-shadow: 0 8px 32px rgba(99,102,241,0.12);
                transform: translateY(-4px);
                border-color: #C7D2FE;
            }
            .room-card-header {
                background: linear-gradient(135deg, #312E81, #4338CA);
                padding: 16px 20px;
                position: relative;
            }
            .room-card-body {
                padding: 20px;
                flex: 1;
                display: flex;
                flex-direction: column;
            }
            .current-topic-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                background: rgba(16,185,129,0.1);
                border: 1px solid rgba(16,185,129,0.2);
                border-radius: 8px;
                padding: 6px 10px;
                font-size: 11px;
                font-weight: 600;
                color: #059669;
                margin-top: 12px;
            }
            @keyframes pulse-dot {
                0%, 100% { opacity: 1; }
                50% { opacity: 0.3; }
            }
            .live-dot-sm {
                width: 6px;
                height: 6px;
                border-radius: 50%;
                background: #EF4444;
                animation: pulse-dot 1.5s infinite;
                display: inline-block;
            }
        </style>

        <!-- Error Alert -->
        <c:if test="${param.error == 'level_too_low'}">
            <div class="level-error-alert">
                <div style="width: 40px; height: 40px; background: #FEE2E2; border-radius: 10px; display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
                    <i class="bi bi-lock-fill" style="color: #DC2626; font-size: 18px;"></i>
                </div>
                <div>
                    <div style="font-weight: 700; color: #991B1B; font-size: 14px;">Level Too Low!</div>
                    <div style="font-size: 13px; color: #7F1D1D;">
                        Room requires <strong>Level ${param.required}</strong> but your current level is <strong>Level ${param.current}</strong>.
                        Keep practicing to level up!
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Header with Level Browser -->
        <div class="level-browser-header">
            <div style="position: relative; z-index: 1;">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <div>
                        <h3 style="font-weight: 800; margin-bottom: 6px;">🎯 Live Rooms by Level</h3>
                        <p style="color: rgba(255,255,255,0.7); margin-bottom: 0; font-size: 14px;">
                            Select a level to browse rooms. Your current level: 
                            <span class="badge" style="background: rgba(16,185,129,0.3); color: #A7F3D0; font-size: 13px;">
                                Lvl ${userLevel}
                            </span>
                        </p>
                    </div>
                    <c:if test="${sessionScope.currentUser.role != 'LEARNER'}">
                        <a href="/rooms/create" class="btn btn-light px-4" style="border-radius: 12px; font-weight: 600;">
                            <i class="bi bi-plus-lg me-1"></i> Host a Room
                        </a>
                    </c:if>
                </div>

                <!-- Quick Range Navigation -->
                <div class="level-range-nav">
                    <a href="/rooms" class="range-btn ${empty selectedLevel ? 'active' : ''}">All Levels</a>
                    <a href="#" class="range-btn" onclick="showRange(1,10); return false;">1-10 Sơ cấp</a>
                    <a href="#" class="range-btn" onclick="showRange(11,25); return false;">11-25</a>
                    <a href="#" class="range-btn" onclick="showRange(26,50); return false;">26-50 Trung cấp</a>
                    <a href="#" class="range-btn" onclick="showRange(51,75); return false;">51-75</a>
                    <a href="#" class="range-btn" onclick="showRange(76,100); return false;">76-100 Cao cấp</a>
                </div>
            </div>
        </div>

        <!-- 100-Level Grid Selector -->
        <div class="stat-card mb-4" style="border: 1px solid #E2E8F0; background: #fff;">
            <h6 style="font-weight: 700; color: #1E293B; margin-bottom: 16px;">
                <i class="bi bi-grid-3x3 me-2" style="color: #6366F1;"></i>
                Select Level
                <c:if test="${not empty selectedLevel}">
                    <span class="badge" style="background: #6366F1; color: #fff; font-size: 12px; margin-left: 8px;">
                        Showing Level ${selectedLevel}
                    </span>
                    <a href="/rooms" style="font-size: 12px; color: #6366F1; margin-left: 8px; text-decoration: none;">✕ Clear</a>
                </c:if>
            </h6>
            <div class="level-grid" id="levelGrid">
                <c:forEach var="lvl" begin="1" end="100">
                    <a href="/rooms?level=${lvl}" 
                       class="level-btn ${selectedLevel == lvl ? 'active' : ''} ${lvl > userLevel && sessionScope.currentUser.role != 'ADMIN' ? 'locked' : ''}"
                       id="levelBtn_${lvl}"
                       title="Level ${lvl}${lvl > userLevel && sessionScope.currentUser.role != 'ADMIN' ? ' (Locked)' : ''}"
                       ${lvl > userLevel && sessionScope.currentUser.role != 'ADMIN' ? 'onclick="event.preventDefault();"' : ''}>
                        <c:choose>
                            <c:when test="${lvl > userLevel && sessionScope.currentUser.role != 'ADMIN'}">
                                <i class="bi bi-lock-fill" style="font-size: 11px;"></i>
                            </c:when>
                            <c:otherwise>
                                ${lvl}
                            </c:otherwise>
                        </c:choose>
                    </a>
                </c:forEach>
            </div>
        </div>

        <!-- Room Cards -->
        <c:choose>
            <c:when test="${empty rooms}">
                <div class="empty-state" style="background: #fff; border-radius: 16px; border: 1px dashed #CBD5E1; padding: 48px; text-align: center;">
                    <div style="font-size: 48px; margin-bottom: 16px;">🎙️</div>
                    <h5 style="color: #475569; font-weight: 700;">No rooms found</h5>
                    <p style="color: #64748B; max-width: 400px; margin: 0 auto;">
                        <c:choose>
                            <c:when test="${not empty selectedLevel}">
                                No rooms available at <strong>Level ${selectedLevel}</strong>. Try browsing other levels!
                            </c:when>
                            <c:otherwise>
                                No live rooms available right now. Please check back later!
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </c:when>
            <c:otherwise>
                <h5 style="font-weight: 700; color: #1E293B; margin-bottom: 16px;">
                    <c:choose>
                        <c:when test="${not empty selectedLevel}">
                            <i class="bi bi-broadcast me-2" style="color: #EF4444;"></i>Rooms at Level ${selectedLevel}
                        </c:when>
                        <c:otherwise>
                            <i class="bi bi-broadcast me-2" style="color: #EF4444;"></i>All Active Rooms
                        </c:otherwise>
                    </c:choose>
                    <span class="badge" style="background: #F1F5F9; color: #64748B; font-size: 12px; margin-left: 8px;">${rooms.size()} rooms</span>
                </h5>
                <div class="row g-4">
                    <c:forEach var="r" items="${rooms}">
                        <div class="col-xl-4 col-md-6">
                            <div class="room-card-level">
                                <!-- Card Header -->
                                <div class="room-card-header">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="d-flex align-items-center gap-2">
                                            <c:if test="${r.status == 'LIVE'}">
                                                <span class="live-dot-sm"></span>
                                                <span style="font-size: 11px; font-weight: 700; color: #FCA5A5;">LIVE</span>
                                            </c:if>
                                            <c:if test="${r.status == 'SCHEDULED'}">
                                                <i class="bi bi-clock" style="color: #FCD34D; font-size: 12px;"></i>
                                                <span style="font-size: 11px; font-weight: 600; color: #FCD34D;">UPCOMING</span>
                                            </c:if>
                                        </div>
                                        <div class="d-flex gap-2">
                                            <span class="badge" style="background: rgba(255,255,255,0.15); color: #E0E7FF; font-size: 11px;">
                                                ${r.languageCode}
                                            </span>
                                            <span class="badge" style="background: rgba(99,102,241,0.3); color: #E0E7FF; font-size: 11px; font-weight: 700;">
                                                Lvl ${r.levelNumber != null ? r.levelNumber : 1}
                                            </span>
                                        </div>
                                    </div>
                                    <h6 style="font-weight: 700; color: #fff; margin: 12px 0 0; font-size: 15px;">${r.title}</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="room-card-body">
                                    <div class="d-flex align-items-center gap-2 mb-3" style="font-size: 13px; color: #64748B;">
                                        <i class="bi bi-person-fill"></i>
                                        Host: <strong>${r.hostUser != null ? r.hostUser.displayName : 'Unknown'}</strong>
                                    </div>
                                    
                                    <!-- Current Topic Pin -->
                                    <c:if test="${r.currentLesson != null}">
                                        <div class="current-topic-badge">
                                            <i class="bi bi-pin-angle-fill"></i>
                                            <span style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 200px;">
                                                ${r.currentLesson.title}
                                            </span>
                                        </div>
                                    </c:if>
                                    
                                    <div class="mt-auto pt-3 d-flex justify-content-between align-items-center">
                                        <div style="font-size: 12px; color: #94A1B2; font-weight: 500;">
                                            <i class="bi bi-people-fill me-1"></i> Max: ${r.maxParticipants}
                                        </div>
                                        <c:set var="reqLevel" value="${r.levelNumber != null ? r.levelNumber : 1}" />
                                        <c:choose>
                                            <c:when test="${roomAccess[room.id]}">
                                                <a href="/rooms/${r.id}" class="btn btn-lucy px-4" style="border-radius: 20px; font-size: 13px;">
                                                    <c:choose>
                                                        <c:when test="${r.status == 'LIVE'}"><i class="bi bi-broadcast me-1"></i>Join Now</c:when>
                                                        <c:otherwise>View Details</c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-secondary px-4" style="border-radius: 20px; font-size: 13px;" disabled title="Requires Level ${reqLevel}">
                                                    <i class="bi bi-lock-fill me-1"></i> Lvl ${reqLevel}
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <script>
            function showRange(start, end) {
                // Scroll the level grid to show the specified range
                var grid = document.getElementById('levelGrid');
                var targetBtn = document.getElementById('levelBtn_' + start);
                if (targetBtn && grid) {
                    targetBtn.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    // Highlight range
                    document.querySelectorAll('.level-btn').forEach(function(btn) { btn.style.outline = ''; });
                    for (var i = start; i <= end; i++) {
                        var btn = document.getElementById('levelBtn_' + i);
                        if (btn && !btn.classList.contains('active')) {
                            btn.style.outline = '2px solid #6366F1';
                        }
                    }
                }
            }
        </script>
    </c:otherwise>
</c:choose>

</layout:main>
