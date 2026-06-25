<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

            <layout:room pageTitle="${room.title}">

                <style>
                    /* ── TIKTOK LIVE STYLE OVERRIDES ── */
                    .stream-area {
                        position: relative;
                        background: radial-gradient(circle at center, #1E1B4B 0%, #0F0E17 100%);
                        height: 100%;
                        display: flex;
                        flex-direction: column;
                        justify-content: center;
                        align-items: center;
                        overflow: hidden;
                    }

                    .chat-area {
                        background: rgba(15, 14, 23, 0.95);
                        border-left: 1px solid rgba(255, 255, 255, 0.08);
                        height: 100%;
                        display: flex;
                        flex-direction: column;
                        position: relative;
                    }

                    /* ── OVERLAYS TRÊN STREAM ── */
                    .stream-header-overlay {
                        position: absolute;
                        top: 20px;
                        left: 24px;
                        right: 24px;
                        display: flex;
                        justify-content: space-between;
                        align-items: flex-start;
                        z-index: 10;
                    }

                    .host-badge {
                        background: rgba(0, 0, 0, 0.4);
                        backdrop-filter: blur(8px);
                        border-radius: 40px;
                        padding: 6px 16px 6px 6px;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        border: 1px solid rgba(255, 255, 255, 0.1);
                    }

                    .host-avatar-mini {
                        width: 36px;
                        height: 36px;
                        border-radius: 50%;
                        background: linear-gradient(135deg, #00CEC9, #6C5CE7);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-weight: 700;
                        color: #fff;
                        font-size: 16px;
                    }

                    .host-info {
                        display: flex;
                        flex-direction: column;
                    }

                    .host-name {
                        font-size: 14px;
                        font-weight: 700;
                        color: #fff;
                        line-height: 1.2;
                    }

                    .room-topic {
                        font-size: 11px;
                        color: #A29BFE;
                        font-weight: 500;
                    }

                    .live-stats {
                        display: flex;
                        gap: 8px;
                    }

                    .stat-pill {
                        background: rgba(0, 0, 0, 0.4);
                        backdrop-filter: blur(8px);
                        padding: 6px 12px;
                        border-radius: 20px;
                        font-size: 12px;
                        font-weight: 600;
                        color: #fff;
                        display: flex;
                        align-items: center;
                        gap: 6px;
                    }

                    .stat-pill.live {
                        background: rgba(239, 68, 68, 0.8);
                    }

                    /* ── SÂN KHẤU (AVATARS) ── */
                    .stage-container {
                        position: relative;
                        z-index: 5;
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        gap: 40px;
                    }

                    .host-avatar-big {
                        width: 160px;
                        height: 160px;
                        border-radius: 50%;
                        background: linear-gradient(135deg, #00CEC9, #6C5CE7);
                        border: 4px solid #fff;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 64px;
                        font-weight: 700;
                        color: #fff;
                        position: relative;
                        box-shadow: 0 0 40px rgba(108, 92, 231, 0.4);
                        animation: pulse-avatar 2s infinite;
                    }

                    @keyframes pulse-avatar {
                        0% {
                            box-shadow: 0 0 0 0 rgba(108, 92, 231, 0.6);
                        }

                        70% {
                            box-shadow: 0 0 0 25px rgba(108, 92, 231, 0);
                        }

                        100% {
                            box-shadow: 0 0 0 0 rgba(108, 92, 231, 0);
                        }
                    }

                    .speaker-grid {
                        display: flex;
                        gap: 20px;
                        justify-content: center;
                        flex-wrap: wrap;
                    }

                    .speaker-avatar {
                        width: 80px;
                        height: 80px;
                        border-radius: 50%;
                        background: #2D2B47;
                        border: 2px solid rgba(255, 255, 255, 0.2);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 28px;
                        font-weight: 600;
                        color: #fff;
                        position: relative;
                    }

                    .mic-icon-stage {
                        position: absolute;
                        bottom: 0;
                        right: 0;
                        width: 24px;
                        height: 24px;
                        background: #10B981;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 12px;
                        color: #fff;
                        border: 2px solid #0F0E17;
                    }

                    /* ── FLOATING ACTION BAR ── */
                    .floating-action-bar {
                        position: absolute;
                        bottom: 30px;
                        left: 50%;
                        transform: translateX(-50%);
                        background: rgba(0, 0, 0, 0.6);
                        backdrop-filter: blur(12px);
                        padding: 12px 24px;
                        border-radius: 40px;
                        display: flex;
                        gap: 16px;
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        z-index: 10;
                    }

                    .fab-btn {
                        width: 48px;
                        height: 48px;
                        border-radius: 50%;
                        background: rgba(255, 255, 255, 0.1);
                        border: none;
                        color: #fff;
                        font-size: 20px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        transition: 0.2s;
                        position: relative;
                    }

                    .fab-btn:hover {
                        background: rgba(255, 255, 255, 0.2);
                        transform: scale(1.05);
                    }

                    .fab-btn.primary {
                        background: linear-gradient(135deg, #FD79A8, #E84393);
                    }

                    .fab-btn.primary:hover {
                        box-shadow: 0 0 15px rgba(232, 67, 147, 0.6);
                    }

                    /* ── CHAT SIDEBAR ── */
                    .chat-messages {
                        flex: 1;
                        overflow-y: auto;
                        padding: 20px;
                        display: flex;
                        flex-direction: column;
                        gap: 12px;
                        scrollbar-width: none;
                    }

                    .chat-messages::-webkit-scrollbar {
                        display: none;
                    }

                    .chat-msg {
                        font-size: 13px;
                        color: #E2E8F0;
                        line-height: 1.4;
                        background: rgba(255, 255, 255, 0.03);
                        padding: 8px 12px;
                        border-radius: 12px;
                        width: fit-content;
                        max-width: 90%;
                    }

                    .chat-msg span.user {
                        color: #A29BFE;
                        font-weight: 600;
                        margin-right: 6px;
                    }

                    .chat-msg.gift-alert {
                        background: rgba(253, 121, 168, 0.15);
                        border: 1px solid rgba(253, 121, 168, 0.3);
                        color: #FFE4E6;
                    }

                    .chat-msg.system-alert {
                        color: #00CEC9;
                        font-style: italic;
                        background: transparent;
                        padding: 4px 0;
                    }

                    .chat-input-area {
                        padding: 16px;
                        border-top: 1px solid rgba(255, 255, 255, 0.08);
                        display: flex;
                        gap: 10px;
                        background: rgba(15, 14, 23, 0.95);
                    }

                    .chat-input {
                        flex: 1;
                        background: rgba(255, 255, 255, 0.08);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        color: #fff;
                        border-radius: 20px;
                        padding: 8px 16px;
                        font-size: 13px;
                        outline: none;
                    }

                    .chat-input:focus {
                        border-color: #6C5CE7;
                    }

                    .btn-send {
                        background: #6C5CE7;
                        color: #fff;
                        border: none;
                        width: 38px;
                        height: 38px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    /* ── OFFCANVAS HOST TOOLS ── */
                    .host-tools-panel {
                        background: #1A1929;
                        color: #E2E8F0;
                        border-left: 1px solid rgba(255, 255, 255, 0.1);
                    }

                    .host-tools-panel .offcanvas-header {
                        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                    }

                    .tool-module {
                        background: rgba(255, 255, 255, 0.03);
                        border: 1px solid rgba(255, 255, 255, 0.05);
                        border-radius: 12px;
                        padding: 16px;
                        margin-bottom: 16px;
                    }

                    .tool-module h6 {
                        font-size: 12px;
                        color: #94A1B2;
                        text-transform: uppercase;
                        font-weight: 600;
                        margin-bottom: 12px;
                        letter-spacing: 0.5px;
                    }

                    .form-dark {
                        background: rgba(0, 0, 0, 0.2);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        color: #fff;
                        border-radius: 8px;
                    }

                    @media (max-width: 991.98px) {
                        .stream-area {
                            height: 50vh !important;
                        }
                        .chat-area {
                            height: 50vh !important;
                            border-top: 1px solid rgba(255, 255, 255, 0.1);
                        }
                    }
                </style>

                <div class="row g-0 w-100 h-100">

                    <!-- ========================================== -->
                    <!-- LEFT: THE STREAM (Immersive Stage)         -->
                    <!-- ========================================== -->
                    <div class="col-xl-9 col-lg-8 stream-area">

                        <!-- Stream Overlay Header -->
                        <div class="stream-header-overlay">
                            <div class="host-badge">
                                <div class="host-avatar-mini">
                                    ${room.hostUser != null ? room.hostUser.displayName.substring(0,1).toUpperCase() :
                                    'H'}
                                </div>
                                <div class="host-info">
                                    <div class="d-flex align-items-center gap-2">
                                        <span class="host-name">${room.hostUser != null ? room.hostUser.displayName : 'Unknown Host'}</span>
                                        <span style="font-size: 11px; color: #A29BFE; white-space: nowrap;">(<span id="followerCount">0</span> Followers)</span>
                                    </div>
                                    <span class="room-topic" style="opacity: 0.8; font-size: 12px; font-weight: normal;">Topic: ${room.title}</span>
                                </div>
                                <c:if test="${room.hostUser != null && sessionScope.currentUser.id != room.hostUser.id}">
                                    <button id="btnFollow" class="btn btn-sm btn-outline-light ms-2"
                                        style="border-radius: 20px; font-size: 10px; padding: 2px 10px;">+ Follow</button>
                                </c:if>
                            </div>
                            <div class="live-stats">
                                <c:if test="${room.status == 'LIVE'}">
                                    <div class="stat-pill live">
                                        <div class="live-dot"
                                            style="width:6px;height:6px;background:#fff;border-radius:50%;animation:pulse-red 1s infinite;">
                                        </div> LIVE
                                    </div>
                                </c:if>
                                <c:if test="${room.levelNumber != null}">
                                    <div class="stat-pill" style="background: rgba(99,102,241,0.8); font-weight: 700;">
                                        <i class="bi bi-bar-chart-fill" style="font-size: 10px;"></i>
                                        Lvl ${room.levelNumber}
                                    </div>
                                </c:if>
                                <div class="stat-pill"><i class="bi bi-eye-fill"></i> <span id="eyeCount">${participants.size()}</span></div>
                                <div class="stat-pill" style="background: rgba(108,92,231,0.8);"><i
                                        class="bi bi-stars"></i> ${room.languageCode}</div>
                            </div>
                        </div>

                        <!-- The Stage (Avatars) -->
                        <div class="stage-container">
                            <!-- Host -->
                            <div class="d-flex flex-column align-items-center gap-3">
                                <div class="host-avatar-big">
                                    ${room.hostUser != null ? room.hostUser.displayName.substring(0,1).toUpperCase() : 'H'}
                                    <div class="mic-icon-stage bg-danger" id="micIconStage_${room.hostUser.displayName}" style="width: 32px; height: 32px; font-size: 16px;">
                                        <i class="bi bi-mic-mute-fill" id="micIconStageInner_${room.hostUser.displayName}"></i>
                                    </div>
                                </div>
                                <div class="text-center">
                                    <div style="font-size: 18px; font-weight: 700; color: #fff;">${room.hostUser != null
                                        ? room.hostUser.displayName : 'Host'}</div>
                                    <div style="font-size: 13px; color: #A29BFE; font-weight: 500;">Host</div>
                                </div>
                            </div>

                            <!-- Speakers -->
                            <div class="speaker-grid">
                                <c:forEach var="p" items="${participants}">
                                    <c:if test="${p.roleInRoom == 'SPEAKER' || p.roleInRoom == 'MODERATOR'}">
                                        <div class="d-flex flex-column align-items-center gap-2">
                                            <div class="speaker-avatar">
                                                ${p.displayName.substring(0,1).toUpperCase()}
                                                <div class="mic-icon-stage ${p.micOn ? '' : 'bg-danger'}" id="micIconStage_${p.displayName}">
                                                    <i class="bi ${p.micOn ? 'bi-mic-fill' : 'bi-mic-mute-fill'}" id="micIconStageInner_${p.displayName}"></i>
                                                </div>
                                            </div>
                                            <div style="font-size: 12px; color: #E2E8F0;">${p.displayName}</div>
                                            <div class="mt-1 d-flex gap-1">
                                                <a href="/rooms/${room.id}/toggle-mic/${p.id}" class="badge bg-secondary text-decoration-none" title="Mute/Unmute"><i class="bi bi-mic-fill"></i> Toggle Mic</a>
                                                <a href="/rooms/${room.id}/remove-participant/${p.id}" class="badge bg-danger text-decoration-none" title="Remove User" onclick="return confirm('Remove speaker from room?')"><i class="bi bi-x-circle"></i> Remove</a>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Floating Action Bar -->
                        <div class="floating-action-bar">
                            <button id="btnConnectAudio" class="fab-btn" title="Connect Audio">
                                <i class="bi bi-headset"></i>
                            </button>
                            <button id="btnDisconnectAudio" class="fab-btn" title="Disconnect"
                                style="display:none; color: #EF4444;">
                                <i class="bi bi-telephone-x"></i>
                            </button>

                            <!-- Toggle Mic Button -->
                            <button id="btnToggleMic" class="fab-btn" title="Mute/Unmute Mic" style="display:none;">
                                <i id="micIcon" class="bi bi-mic-fill"></i>
                            </button>

                            <!-- Send Gift triggers Modal -->
                            <button class="fab-btn primary" title="Send Gift" data-bs-toggle="modal"
                                data-bs-target="#giftModal">
                                <i class="bi bi-gift-fill"></i>
                            </button>

                            <button id="btnRaiseHand" class="fab-btn" title="Request to Speak">
                                ✋
                            </button>

                            <!-- Host Tools -->
                            <button class="fab-btn" title="Host Tools" data-bs-toggle="offcanvas"
                                data-bs-target="#hostToolsOffcanvas">
                                <i class="bi bi-sliders"></i>
                            </button>
                        </div>

                    </div>

                    <!-- ========================================== -->
                    <!-- RIGHT: LIVE CHAT & ACTIVITY STREAM         -->
                    <!-- ========================================== -->
                    <div class="col-xl-3 col-lg-4 chat-area">

                        <div class="p-3 border-bottom" style="border-color: rgba(255,255,255,0.08)!important;">
                            <h6 class="m-0" style="color: #fff; font-weight: 600;"><i class="bi bi-chat-dots-fill me-1"
                                     style="color: #6C5CE7;"></i> Host Console</h6>
                        </div>

                        <!-- Chat Stream -->
                        <div class="chat-messages" id="chatStream">
                            <div class="chat-msg system-alert">Welcome to ${room.title}! Remember to be polite and
                                respectful.</div>

                            <c:forEach var="txn" items="${giftTransactions}">
                                <div class="chat-msg gift-alert">
                                    <span class="user">${txn.sender.displayName}</span> sent <strong>${txn.gift.name}
                                        ${txn.gift.icon}</strong> to ${txn.receiver.displayName}
                                </div>
                            </c:forEach>

                        </div>

                        <!-- Chat Input -->
                        <div class="chat-input-area">
                            <input type="text" id="chatInput" class="chat-input" placeholder="Say something nice...">
                            <button id="btnSendChat" class="btn-send"><i class="bi bi-send-fill"></i></button>
                        </div>

                    </div>
                </div>

                <!-- ========================================== -->
                <!-- MODALS & OFFCANVAS (HOST TOOLS)            -->
                <!-- ========================================== -->

                <!-- Gift Modal -->
                <div class="modal fade" id="giftModal" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered modal-sm">
                        <div class="modal-content"
                            style="background: #1A1929; border: 1px solid rgba(255,255,255,0.1); border-radius: 20px;">
                            <div class="modal-header border-0 pb-0">
                                <h6 class="modal-title text-white fw-bold">Send Gift 🎁</h6>
                                <button type="button" class="btn-close btn-close-white"
                                    data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <div class="text-center mb-3">
                                    <span class="badge" style="background: rgba(108,92,231,0.2); color: #A29BFE; font-size: 13px;">
                                        Your Balance: <span id="currentBalanceDisplay">${sessionScope.currentUser.creditBalance != null ? sessionScope.currentUser.creditBalance : 0}</span> cr
                                    </span>
                                </div>
                                <form method="post" action="/rooms/${room.id}/send-gift" id="formSendGift">
                                    <input type="hidden" name="senderId" value="${sessionScope.currentUser.id}">
                                    <input type="hidden" id="currentBalance" value="${sessionScope.currentUser.creditBalance != null ? sessionScope.currentUser.creditBalance : 0}">
                                    <div class="mb-3">
                                        <label class="form-label" style="font-size: 11px; color: #94A1B2;">To
                                            User</label>
                                        <select name="receiverId" class="form-select form-select-sm form-dark" required>
                                            <c:forEach var="p" items="${participants}">
                                                <c:if test="${sessionScope.currentUser.id != p.user.id}">
                                                    <option value="${p.user.id}">${p.displayName}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" style="font-size: 11px; color: #94A1B2;">Select
                                            Gift</label>
                                        <select name="giftId" id="giftSelect" class="form-select form-select-sm form-dark" required>
                                            <c:forEach var="g" items="${gifts}">
                                                <option value="${g.id}" data-cost="${g.creditCost}">${g.icon} ${g.name} (${g.creditCost} cr)
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn w-100"
                                        style="background: linear-gradient(135deg, #FD79A8, #E84393); color: white; border-radius: 12px; font-weight: 600;">
                                        Send 💖
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Top Up Iframe Modal -->
                <div class="modal fade" id="topupModal" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered modal-lg">
                        <div class="modal-content" style="background: #1A1929; border: 1px solid rgba(255,255,255,0.1); border-radius: 20px;">
                            <div class="modal-header border-0 pb-0">
                                <h6 class="modal-title text-white fw-bold">Top Up Credits 💳</h6>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body p-0" style="height: 60vh;">
                                <iframe src="/billing/topup" style="width: 100%; height: 100%; border: none; border-radius: 0 0 20px 20px;"></iframe>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Host Tools Offcanvas -->
                <div class="offcanvas offcanvas-end host-tools-panel" tabindex="-1" id="hostToolsOffcanvas">
                    <div class="offcanvas-header">
                        <h5 class="offcanvas-title fw-bold"><i class="bi bi-sliders me-1"
                                style="color: #00CEC9;"></i> Host Tools</h5>
                        <button type="button" class="btn-close btn-close-white"
                            data-bs-dismiss="offcanvas"></button>
                    </div>
                    <div class="offcanvas-body">

                        <!-- Room Control -->
                        <div class="tool-module">
                            <h6>Room Controls</h6>
                            <div class="d-flex flex-column gap-2">
                                <a href="/rooms/${room.id}/end" class="btn w-100 btn-sm"
                                    style="background: rgba(239,68,68,0.2); color: #FCA5A5; border: 1px solid #EF4444; border-radius: 8px;"
                                    onclick="return confirm('End this live session?')">
                                    <i class="bi bi-stop-fill me-1"></i> End Live Stream
                                </a>
                                <a href="/rooms/${room.id}/next-stage" class="btn w-100 btn-sm btn-outline-info" style="border-radius: 8px;">
                                    <i class="bi bi-arrow-right-circle me-1"></i> Next Chapter/Stage
                                </a>
                                <a href="/rooms/${room.id}/toggle-recording" class="btn w-100 btn-sm ${room.isRecording ? 'btn-danger' : 'btn-outline-danger'}" style="border-radius: 8px;">
                                    <i class="bi ${room.isRecording ? 'bi-record-fill' : 'bi-record'} me-1"></i>
                                    ${room.isRecording ? 'Stop Recording' : 'Start Recording'}
                                </a>
                                <a href="/rooms/${room.id}/export-participants" class="btn w-100 btn-sm btn-outline-success" style="border-radius: 8px;">
                                    <i class="bi bi-file-earmark-excel me-1"></i> Export Participants
                                </a>
                            </div>
                        </div>

                        <!-- AI Support -->
                        <div class="tool-module" style="background: rgba(108, 92, 231, 0.1); border: 1px solid rgba(108, 92, 231, 0.2);">
                            <h6 style="color: #A29BFE;"><i class="bi bi-robot me-1"></i> AI Moderator Support</h6>
                            <p class="text-muted" style="font-size: 11px; margin-bottom: 8px;">Generate questions for the current lesson</p>
                            <div class="d-flex flex-column gap-2">
                                <select id="aiPromptType" class="form-select form-select-sm form-dark">
                                    <option value="warmup">Warm-up Questions</option>
                                    <option value="discussion">Discussion Questions</option>
                                    <option value="practice">Practice Exercises</option>
                                    <option value="wrapup">Wrap-up Questions</option>
                                </select>
                                <c:set var="aiLessonId" value="${room.currentLesson != null ? room.currentLesson.id : 0}" />
                                <button type="button" class="btn btn-sm w-100" style="background: #6C5CE7; color: white; border-radius: 8px;" onclick="generateAiQuestions(Number('${aiLessonId}'))">
                                    <i class="bi bi-magic me-1"></i> Suggest Questions
                                </button>
                                <div id="aiLoadingIndicator" style="display: none; text-align: center; margin-top: 8px;">
                                    <div class="spinner-border spinner-border-sm text-primary" role="status"></div>
                                    <span style="font-size: 12px; color: #A29BFE;"> Generating...</span>
                                </div>
                                <div id="aiResultContainer" class="mt-2 d-flex flex-column gap-2"></div>
                            </div>
                        </div>

                        <!-- Pending Join Requests (Real-time update panel) -->
                        <div class="tool-module" style="background: rgba(245, 158, 11, 0.1); border: 1px solid rgba(245, 158, 11, 0.2);">
                            <h6 style="color: #F59E0B;"><i class="bi bi-person-plus-fill me-1"></i> Join Requests</h6>
                            <div id="pendingRequestsList" class="d-flex flex-column gap-2 mt-2">
                                <c:choose>
                                    <c:when test="${empty pendingRequests}">
                                        <div class="text-muted" style="font-size: 11px;">No pending requests</div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="req" items="${pendingRequests}">
                                            <div class="d-flex justify-content-between align-items-center p-2 rounded" style="background: rgba(0,0,0,0.2); font-size: 12px;">
                                                <div>
                                                    <div class="fw-bold">${req.displayName}</div>
                                                    <div class="text-muted" style="font-size: 10px;">wants to be a ${req.roleRequested}</div>
                                                </div>
                                                <div class="d-flex gap-1">
                                                    <button type="button" class="btn btn-xs btn-success py-1 px-2" style="font-size: 10px; border-radius: 4px;" onclick="approveJoinRequest(this)" data-id="${req.id}" data-name="${req.displayName}">Approve</button>
                                                    <button type="button" class="btn btn-xs btn-danger py-1 px-2" style="font-size: 10px; border-radius: 4px;" onclick="denyJoinRequest(this)" data-id="${req.id}" data-name="${req.displayName}">Deny</button>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Current Participants -->
                        <div class="tool-module">
                            <h6>Current Participants</h6>
                            <div class="d-flex flex-column gap-2" style="max-height: 250px; overflow-y: auto;">
                                <c:forEach var="p" items="${participants}">
                                    <div class="d-flex justify-content-between align-items-center p-2 rounded" style="background: rgba(0,0,0,0.2); font-size: 12px;">
                                        <div>
                                            <div class="fw-bold">${p.displayName}</div>
                                            <div class="text-muted" style="font-size: 10px;">
                                                Role: <span class="badge ${p.roleInRoom == 'SPEAKER' ? 'bg-primary' : (p.roleInRoom == 'MODERATOR' ? 'bg-warning' : 'bg-secondary')}">${p.roleInRoom}</span>
                                            </div>
                                        </div>
                                        <div class="d-flex gap-1">
                                            <c:choose>
                                                <c:when test="${room.hostUser != null && p.user.id == room.hostUser.id}">
                                                    <span class="text-warning" style="font-size: 10px; font-weight: bold;">👑 Host</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="/rooms/${room.id}/toggle-role/${p.id}" class="btn btn-xs btn-outline-info py-0 px-2" style="font-size: 9px; border-radius: 4px;" title="Promote or Demote">Role</a>
                                                    <a href="/rooms/${room.id}/remove-participant/${p.id}" class="btn btn-xs btn-danger py-0 px-2" style="font-size: 9px; border-radius: 4px;" onclick="return confirm('Kick ${p.displayName} from this room?')" title="Kick User">Kick</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Pin Material -->
                        <div class="tool-module">
                            <h6>
                                <i class="bi bi-pin-angle me-1"></i> Pin Material to Stream
                                <c:if test="${room.levelNumber != null}">
                                    <span class="badge" style="background: rgba(99,102,241,0.3); color: #A5B4FC; font-size: 9px; margin-left: 4px;">Level ${room.levelNumber} topics</span>
                                </c:if>
                            </h6>
                            <c:if test="${room.currentLesson != null}">
                                <div class="mb-2 p-2 rounded" style="background: rgba(99,102,241,0.1); border: 1px solid rgba(99,102,241,0.2); font-size: 11px;">
                                    <div style="color: #A5B4FC; font-weight: 700;">Current Topic:</div>
                                    <div style="color: #E0E7FF;">${room.currentLesson.title}</div>
                                    <div style="color: #64748B; font-size: 10px; margin-top: 2px;"><i class="bi bi-robot me-1"></i>AI auto-transitions every 10 min</div>
                                </div>
                            </c:if>
                            <form method="post" action="/rooms/${room.id}/pin-material"
                                class="d-flex flex-column gap-2">
                                <select name="lessonId" class="form-select form-select-sm form-dark" required>
                                    <option value="">— Select Lesson —</option>
                                    <c:forEach var="l" items="${lessons}">
                                        <option value="${l.id}" ${room.currentLesson != null && room.currentLesson.id == l.id ? 'selected' : ''}>
                                            <c:if test="${l.levelNumber != null}">[Lvl ${l.levelNumber}]</c:if>
                                            [${l.type}] ${l.title}
                                        </option>
                                    </c:forEach>
                                </select>
                                <button type="submit" class="btn btn-sm"
                                    style="background: rgba(255,255,255,0.1); color: white; border-radius: 8px;">Pin</button>
                            </form>
                            <c:if test="${not empty pinnedMaterials}">
                                <div class="mt-2">
                                    <div style="font-size: 10px; color: #94A1B2; margin-bottom: 4px;">Active Pins:</div>
                                    <c:forEach var="pm" items="${pinnedMaterials}">
                                        <div class="d-flex justify-content-between align-items-center p-1 mb-1 rounded" style="background: rgba(0,0,0,0.2); font-size: 11px;">
                                            <span style="color: #E0E7FF;"><i class="bi bi-pin-fill me-1" style="color: #6366F1;"></i>${pm.title}</span>
                                            <a href="/rooms/${room.id}/unpin/${pm.id}" class="text-danger" style="font-size: 10px;" title="Unpin"><i class="bi bi-x-circle"></i></a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>

                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
                <script>
                    var roomId = '${room.id}';
                    var currentUser = '${room.hostUser != null ? room.hostUser.displayName : "Host"}';
                    
                    var socket = new SockJS('/ws');
                    var stompClient = Stomp.over(socket);
                    stompClient.debug = null; // Tắt log nhảm của STOMP

                    stompClient.connect({}, function (frame) {
                        stompClient.subscribe('/topic/room/' + roomId, function (message) {
                            var msg = JSON.parse(message.body);
                            
                            // Cập nhật mắt xem real-time
                            if (msg.viewCount !== undefined) {
                                document.getElementById('eyeCount').innerText = msg.viewCount;
                            }

                            var chatStream = document.getElementById('chatStream');

                            // Xử lý Chat
                            if (msg.type === 'CHAT') {
                                var div = document.createElement('div');
                                div.className = 'chat-msg';
                                div.innerHTML = '<span class="user">' + msg.senderName + ':</span> ' + msg.content;
                                chatStream.appendChild(div);
                                chatStream.scrollTop = chatStream.scrollHeight;
                            } 
                            // Xử lý Giơ tay
                            else if (msg.type === 'RAISE_HAND') {
                                var div = document.createElement('div');
                                div.className = 'chat-msg system-alert';
                                div.innerHTML = '✋ <b>' + msg.senderName + '</b> wants to speak!';
                                chatStream.appendChild(div);
                                chatStream.scrollTop = chatStream.scrollHeight;
                            }
                            // Xử lý Follow
                            else if (msg.type === 'FOLLOW') {
                                var div = document.createElement('div');
                                div.className = 'chat-msg gift-alert';
                                div.innerHTML = '💖 <b>' + msg.senderName + '</b> followed the host!';
                                chatStream.appendChild(div);
                                chatStream.scrollTop = chatStream.scrollHeight;
                                
                                var fc = document.getElementById('followerCount');
                                if (fc) {
                                    fc.innerText = parseInt(fc.innerText) + 1;
                                }
                            }
                            // Xử lý bật/tắt Mic
                            else if (msg.type === 'MIC_TOGGLE') {
                                var micStage = document.getElementById('micIconStage_' + msg.senderName);
                                var micInner = document.getElementById('micIconStageInner_' + msg.senderName);
                                if (micStage && micInner) {
                                    if (msg.content === 'ON') {
                                        micInner.className = 'bi bi-mic-fill';
                                        micStage.classList.remove('bg-danger');
                                    } else {
                                        micInner.className = 'bi bi-mic-mute-fill';
                                        micStage.classList.add('bg-danger');
                                    }
                                }
                            }
                            // Nhận tín hiệu có yêu cầu tham gia mới
                            else if (msg.type === 'JOIN_REQUEST') {
                                if (typeof pollPendingRequests === 'function') {
                                    pollPendingRequests();
                                }
                            }
                            // Xử lý Quà tặng
                            else if (msg.type === 'GIFT') {
                                var isReceiver = ('${sessionScope.currentUser.id}' === String(msg.receiverId));
                                var isHost = ('${room.hostUser.id}' === String(msg.receiverId));
                                
                                if (isReceiver) {
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'You got a gift! 🎁',
                                        text: msg.senderName + ' sent you a ' + msg.content + '!',
                                        background: '#1E1B4B', color: '#fff',
                                        toast: true, position: 'top-end', showConfirmButton: false, timer: 4000
                                    });
                                }
                                
                                // Nếu host là người nhận thì ai trong phòng cũng thấy trên chat
                                if (isHost) {
                                    var div = document.createElement('div');
                                    div.className = 'chat-msg gift-alert';
                                    div.innerHTML = '<span class="user">' + msg.senderName + '</span> sent <strong>' + msg.content + '</strong> to the host!';
                                    chatStream.appendChild(div);
                                    chatStream.scrollTop = chatStream.scrollHeight;
                                }
                            }
                        });

                        // Báo cho toàn server biết mình đã Join để tăng mắt xem
                        stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'JOIN', senderName: currentUser }));
                        
                        const urlParams = new URLSearchParams(window.location.search);
                        if (urlParams.get('success') === 'gift_sent') {
                            var encName = urlParams.get('giftName');
                            var encIcon = urlParams.get('giftIcon');
                            var rId = urlParams.get('receiverId');
                            var balance = urlParams.get('balance');
                            var giftContent = decodeURIComponent(encIcon) + ' ' + decodeURIComponent(encName);
                            
                            stompClient.send('/app/room/' + roomId, {}, JSON.stringify({
                                type: 'GIFT',
                                senderName: currentUser,
                                content: giftContent,
                                receiverId: parseInt(rId)
                            }));
                            
                            Swal.fire({
                                icon: 'success',
                                title: 'Gift Sent!',
                                text: 'Your remaining balance is: ' + balance + ' cr',
                                background: '#1E1B4B', color: '#fff', confirmButtonColor: '#6C5CE7',
                                toast: true, position: 'top-end', showConfirmButton: false, timer: 4000
                            });
                            
                            window.history.replaceState({}, document.title, window.location.pathname);
                        }
                    });

                    // Gift Form Intercept
                    var formSendGift = document.getElementById('formSendGift');
                    if (formSendGift) {
                        formSendGift.addEventListener('submit', function(e) {
                            var currentBalance = parseFloat(document.getElementById('currentBalance').value);
                            var giftSelect = document.getElementById('giftSelect');
                            var selectedOption = giftSelect.options[giftSelect.selectedIndex];
                            var cost = parseFloat(selectedOption.getAttribute('data-cost'));
                            
                            if (currentBalance < cost) {
                                e.preventDefault();
                                
                                var giftModalEl = document.getElementById('giftModal');
                                var giftModal = bootstrap.Modal.getInstance(giftModalEl);
                                if (giftModal) giftModal.hide();
                                
                                Swal.fire({
                                    icon: 'warning',
                                    title: 'Insufficient Credits',
                                    text: 'You do not have enough credits for this gift. Would you like to top up?',
                                    showCancelButton: true,
                                    confirmButtonText: 'Yes, Top Up',
                                    cancelButtonText: 'Cancel',
                                    background: '#1E1B4B', color: '#fff', confirmButtonColor: '#6C5CE7', cancelButtonColor: '#EF4444'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        var topupModal = new bootstrap.Modal(document.getElementById('topupModal'));
                                        topupModal.show();
                                    }
                                });
                            }
                        });
                    }

                    // Gửi Chat
                    document.getElementById('btnSendChat').onclick = function() {
                        var input = document.getElementById('chatInput');
                        if (input.value.trim() !== '') {
                            stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'CHAT', senderName: currentUser, content: input.value }));
                            input.value = '';
                        }
                    };
                    document.getElementById('chatInput').addEventListener('keypress', function (e) {
                        if (e.key === 'Enter') document.getElementById('btnSendChat').click();
                    });

                    // Giơ tay
                    document.getElementById('btnRaiseHand').onclick = function() {
                        stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'RAISE_HAND', senderName: currentUser }));
                        this.style.background = '#F59E0B'; // Đổi màu thành vàng báo hiệu đang giơ tay
                        this.style.color = '#fff';
                    };

                    // Follow
                    var btnFollow = document.getElementById('btnFollow');
                    if (btnFollow) {
                        fetch('/api/users/${room.hostUser.id}/follow-status')
                            .then(res => res.json())
                            .then(data => {
                                document.getElementById('followerCount').innerText = data.followerCount;
                                if (data.isFollowing) {
                                    btnFollow.innerHTML = 'Following';
                                    btnFollow.className = 'btn btn-sm btn-light ms-2';
                                }
                            });

                        btnFollow.onclick = function() {
                            fetch('/api/users/${room.hostUser.id}/toggle-follow', { method: 'POST' })
                                .then(res => res.json())
                                .then(data => {
                                    document.getElementById('followerCount').innerText = data.followerCount;
                                    if (data.isFollowing) {
                                        this.innerHTML = 'Following';
                                        this.className = 'btn btn-sm btn-light ms-2';
                                        stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'FOLLOW', senderName: currentUser }));
                                    } else {
                                        this.innerHTML = '+ Follow';
                                        this.className = 'btn btn-sm btn-outline-light ms-2';
                                    }
                                });
                        };
                    }

                    // Khi đóng Tab hoặc tải lại trang thì trừ mắt xem đi
                    window.addEventListener('beforeunload', function() {
                        if (stompClient !== null) {
                            stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'LEAVE', senderName: currentUser }));
                            stompClient.disconnect();
                        }
                    });

                    // Phê duyệt yêu cầu tham gia qua REST API + WebSocket để phản hồi tức thì
                    function approveJoinRequest(btn) {
                        var requestId = btn.getAttribute('data-id');
                        var displayName = btn.getAttribute('data-name');
                        fetch('/api/rooms/' + roomId + '/approve-join/' + requestId, { method: 'POST' })
                            .then(res => res.json())
                            .then(data => {
                                stompClient.send('/app/room/' + roomId, {}, JSON.stringify({
                                    type: 'JOIN_APPROVED',
                                    senderName: displayName,
                                    content: 'APPROVED'
                                }));
                                pollPendingRequests();
                                window.location.reload();
                            })
                            .catch(err => console.error("Error approving join request:", err));
                    }

                    function denyJoinRequest(btn) {
                        var requestId = btn.getAttribute('data-id');
                        var displayName = btn.getAttribute('data-name');
                        fetch('/api/rooms/' + roomId + '/deny-join/' + requestId, { method: 'POST' })
                            .then(res => res.json())
                            .then(data => {
                                stompClient.send('/app/room/' + roomId, {}, JSON.stringify({
                                    type: 'JOIN_DENIED',
                                    senderName: displayName,
                                    content: 'DENIED'
                                }));
                                pollPendingRequests();
                            })
                            .catch(err => console.error("Error denying join request:", err));
                    }

                    function pollPendingRequests() {
                        fetch('/api/rooms/' + roomId + '/pending-requests')
                            .then(response => response.json())
                            .then(data => {
                                const listContainer = document.getElementById('pendingRequestsList');
                                if (!listContainer) return;
                                if (data.length === 0) {
                                    listContainer.innerHTML = '<div class="text-muted" style="font-size: 11px;">No pending requests</div>';
                                    return;
                                }
                                let html = '';
                                data.forEach(req => {
                                    html += '<div class="d-flex justify-content-between align-items-center p-2 rounded" style="background: rgba(0,0,0,0.2); font-size: 12px;">' +
                                                '<div>' +
                                                    '<div class="fw-bold">' + req.displayName + '</div>' +
                                                    '<div class="text-muted" style="font-size: 10px;">wants to be a ' + req.roleRequested + '</div>' +
                                                '</div>' +
                                                '<div class="d-flex gap-1">' +
                                                    '<button type="button" class="btn btn-xs btn-success py-1 px-2" style="font-size: 10px; border-radius: 4px;" onclick="approveJoinRequest(this)" data-id="' + req.requestId + '" data-name="' + req.displayName + '">Approve</button>' +
                                                    '<button type="button" class="btn btn-xs btn-danger py-1 px-2" style="font-size: 10px; border-radius: 4px;" onclick="denyJoinRequest(this)" data-id="' + req.requestId + '" data-name="' + req.displayName + '">Deny</button>' +
                                                '</div>' +
                                            '</div>';
                                });
                                listContainer.innerHTML = html;
                            })
                            .catch(err => console.error("Error polling join requests:", err));
                    }
                    setInterval(pollPendingRequests, 10000);

                    // AI Suggest Questions
                    function generateAiQuestions(lessonId) {
                        if (!lessonId || lessonId === 0) {
                            Swal.fire({
                                icon: 'warning',
                                title: 'No Lesson Selected',
                                text: 'No lesson currently selected in the room.',
                                background: '#1E1B4B', color: '#fff', confirmButtonColor: '#6C5CE7'
                            });
                            return;
                        }
                        var promptType = document.getElementById('aiPromptType').value;
                        var btnContainer = document.getElementById('aiResultContainer');
                        var loading = document.getElementById('aiLoadingIndicator');
                        
                        btnContainer.innerHTML = '';
                        loading.style.display = 'block';

                        fetch('/api/ai/suggest-questions?lessonId=' + lessonId + '&promptType=' + promptType, { method: 'POST' })
                            .then(res => res.json())
                            .then(data => {
                                loading.style.display = 'none';
                                if (data.message) {
                                    btnContainer.innerHTML = '<div class="text-danger" style="font-size: 12px;">' + data.message + '</div>';
                                    return;
                                }
                                if (data.questions && data.questions.length > 0) {
                                    let html = '';
                                    data.questions.forEach(q => {
                                        html += '<div class="p-2 rounded mb-1" style="background: rgba(255,255,255,0.05); font-size: 12px;">' + 
                                                '<div class="d-flex justify-content-between align-items-start">' +
                                                '<div class="flex-grow-1">' + q.generatedQuestion + '</div>' +
                                                '<button class="btn btn-xs btn-outline-light ms-2 py-0 px-1" onclick="sendAiQuestionToChat(this)" data-q="' + encodeURIComponent(q.generatedQuestion) + '"><i class="bi bi-send"></i></button>' +
                                                '</div></div>';
                                    });
                                    btnContainer.innerHTML = html;
                                } else {
                                    btnContainer.innerHTML = '<div class="text-muted" style="font-size: 12px;">No questions generated.</div>';
                                }
                            })
                            .catch(err => {
                                loading.style.display = 'none';
                                btnContainer.innerHTML = '<div class="text-danger" style="font-size: 12px;">Error generating questions.</div>';
                                console.error(err);
                            });
                    }

                    function sendAiQuestionToChat(btn) {
                        var question = decodeURIComponent(btn.getAttribute('data-q'));
                        if (question && stompClient) {
                            var formattedMsg = '🤖 [AI Moderator]: ' + question;
                            stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'CHAT', senderName: currentUser, content: formattedMsg }));
                            
                            // Flash button to show success
                            var origHTML = btn.innerHTML;
                            btn.innerHTML = '<i class="bi bi-check2"></i>';
                            btn.classList.add('btn-success');
                            btn.classList.remove('btn-outline-light');
                            setTimeout(() => {
                                btn.innerHTML = origHTML;
                                btn.classList.remove('btn-success');
                                btn.classList.add('btn-outline-light');
                            }, 2000);
                        }
                    }
                </script>

                <script src="https://download.agora.io/sdk/release/AgoraRTC_N-4.20.0.js"></script>
                <script>
                    // Auto-scroll chat to bottom
                    var chatStream = document.getElementById('chatStream');
                    if (chatStream) chatStream.scrollTop = chatStream.scrollHeight;

                    // Agora Mock Logic
                    var rtc = { client: null, localAudioTrack: null };
                    var options = { appId: "1adc56609faa4f95b208d10e17d60786", channel: "lucy_room_${room.id}", uid: Math.floor(Math.random() * 10000), token: null };

                    var isMuted = false;
                    var btnToggleMic = document.getElementById('btnToggleMic');
                    var micIcon = document.getElementById('micIcon');

                    btnToggleMic.onclick = async function () {
                        if (!rtc.localAudioTrack) return;
                        try {
                            if (isMuted) {
                                await rtc.localAudioTrack.setEnabled(true);
                                isMuted = false;
                                micIcon.className = 'bi bi-mic-fill';
                                btnToggleMic.style.background = '';
                                btnToggleMic.style.color = '';
                            } else {
                                await rtc.localAudioTrack.setEnabled(false);
                                isMuted = true;
                                micIcon.className = 'bi bi-mic-mute-fill';
                                btnToggleMic.style.background = 'rgba(239, 68, 68, 0.2)';
                                btnToggleMic.style.color = '#EF4444';
                            }
                            stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'MIC_TOGGLE', senderName: currentUser, content: isMuted ? 'OFF' : 'ON' }));
                        } catch (err) {
                            console.error("Failed to toggle mic:", err);
                        }
                    };

                    document.getElementById('btnConnectAudio').onclick = async function () {
                        var btnConnect = document.getElementById('btnConnectAudio');
                        var btnDisconnect = document.getElementById('btnDisconnectAudio');
                        btnConnect.disabled = true;

                        try {
                            const response = await fetch('/api/agora/token?channelName=' + options.channel + '&uid=' + options.uid + '&role=publisher');
                            const data = await response.json();
                            options.token = (data.token && data.token.startsWith('006MOCK')) ? null : data.token;

                            rtc.client = AgoraRTC.createClient({ mode: "rtc", codec: "vp8" });
                            rtc.client.on("user-published", async function (user, mediaType) {
                                await rtc.client.subscribe(user, mediaType);
                                if (mediaType === "audio") user.audioTrack.play();
                            });

                            await rtc.client.join(options.appId, options.channel, options.token, options.uid);
                            rtc.localAudioTrack = await AgoraRTC.createMicrophoneAudioTrack({
                                AEC: true,
                                ANS: true,
                                AGC: true
                            });
                            await rtc.client.publish([rtc.localAudioTrack]);

                            btnConnect.style.display = 'none'; 
                            btnDisconnect.style.display = 'block';
                            btnToggleMic.style.display = 'flex';
                            stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'MIC_TOGGLE', senderName: currentUser, content: 'ON' }));
                        } catch (error) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Connection Failed',
                                text: 'Agora Connection Failed: ' + error.message,
                                background: '#1E1B4B', color: '#fff', confirmButtonColor: '#6C5CE7'
                            });
                            btnConnect.disabled = false;
                        }
                    };

                    document.getElementById('btnDisconnectAudio').onclick = async function () {
                        if (rtc.localAudioTrack) rtc.localAudioTrack.close();
                        if (rtc.client) await rtc.client.leave();
                        document.getElementById('btnConnectAudio').style.display = 'block';
                        document.getElementById('btnConnectAudio').disabled = false;
                        document.getElementById('btnDisconnectAudio').style.display = 'none';
                        btnToggleMic.style.display = 'none';
                        isMuted = false;
                        micIcon.className = 'bi bi-mic-fill';
                        btnToggleMic.style.background = '';
                        btnToggleMic.style.color = '';
                        stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'MIC_TOGGLE', senderName: currentUser, content: 'OFF' }));
                    };
                </script>

                <script>
                    var leaveBtn = document.getElementById('globalLeaveBtn');
                    if (leaveBtn) {
                        <c:choose>
                            <c:when test="${room.status == 'SCHEDULED'}">
                                leaveBtn.innerHTML = '<i class="bi bi-play-circle-fill"></i> Start Live Room';
                                leaveBtn.href = '/rooms/${room.id}/go-live';
                                leaveBtn.style.background = '#10B981';
                                leaveBtn.style.color = '#FFFFFF';
                            </c:when>
                            <c:otherwise>
                                leaveBtn.innerHTML = '<i class="bi bi-stop-circle-fill"></i> End Live Room';
                                leaveBtn.href = '/rooms/${room.id}/end';
                                leaveBtn.style.background = '#EF4444';
                                leaveBtn.style.color = '#FFFFFF';
                            </c:otherwise>
                        </c:choose>
                    }
                </script>

            </layout:room>
