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
                                    <span class="host-name">${room.hostUser != null ? room.hostUser.displayName :
                                        'Unknown Host'}</span>
                                    <span class="room-topic">${room.title}</span>
                                </div>
                                <button id="btnFollow" class="btn btn-sm btn-outline-light ms-2"
                                    style="border-radius: 20px; font-size: 10px; padding: 2px 10px;">+ Follow</button>
                            </div>
                            <div class="live-stats">
                                <c:if test="${room.status == 'LIVE'}">
                                    <div class="stat-pill live">
                                        <div class="live-dot"
                                            style="width:6px;height:6px;background:#fff;border-radius:50%;animation:pulse-red 1s infinite;">
                                        </div> LIVE
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

                            <!-- Mock Chat Messages -->
                            <div class="chat-msg"><span class="user">Alex:</span> Hello everyone! 👋</div>
                            <div class="chat-msg"><span class="user">Sarah:</span> Can't wait to practice speaking.
                            </div>
                            <div class="chat-msg"><span class="user">Mike:</span> Is the audio clear?</div>
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
                                <form method="post" action="/rooms/${room.id}/send-gift">
                                    <input type="hidden" name="senderId" value="${sessionScope.currentUser.id}">
                                    <div class="mb-3">
                                        <label class="form-label" style="font-size: 11px; color: #94A1B2;">To
                                            User</label>
                                        <select name="receiverId" class="form-select form-select-sm form-dark" required>
                                            <c:if test="${room.hostUser != null && sessionScope.currentUser.id != room.hostUser.id}">
                                                <option value="${room.hostUser.id}">👑 ${room.hostUser.displayName} (Host)</option>
                                            </c:if>
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
                                        <select name="giftId" class="form-select form-select-sm form-dark" required>
                                            <c:forEach var="g" items="${gifts}">
                                                <option value="${g.id}">${g.icon} ${g.name} (${g.creditCost} cr)
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

                        <!-- Direct Add User -->
                        <div class="tool-module">
                            <h6>Direct Add User</h6>
                            <form method="post" action="/rooms/${room.id}/add-participant"
                                class="d-flex flex-column gap-2">
                                <select name="userId" class="form-select form-select-sm form-dark" required>
                                    <option value="">— Select User —</option>
                                    <c:forEach var="u" items="${users}">
                                        <option value="${u.id}">${u.displayName}</option>
                                    </c:forEach>
                                </select>
                                <div class="d-flex gap-2">
                                    <select name="roleInRoom" class="form-select form-select-sm form-dark">
                                        <option value="LISTENER">Audience</option>
                                        <option value="SPEAKER">Speaker</option>
                                    </select>
                                    <button type="submit" class="btn btn-sm"
                                        style="background: #6C5CE7; color: white; border-radius: 8px;">Add</button>
                                </div>
                            </form>
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
                            <h6>Pin Material to Stream</h6>
                            <form method="post" action="/rooms/${room.id}/pin-material"
                                class="d-flex flex-column gap-2">
                                <select name="lessonId" class="form-select form-select-sm form-dark" required>
                                    <option value="">— Select Lesson —</option>
                                    <c:forEach var="l" items="${lessons}">
                                        <option value="${l.id}">[${l.type}] ${l.title}</option>
                                    </c:forEach>
                                </select>
                                <button type="submit" class="btn btn-sm"
                                    style="background: rgba(255,255,255,0.1); color: white; border-radius: 8px;">Pin</button>
                            </form>
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
                        });

                        // Báo cho toàn server biết mình đã Join để tăng mắt xem
                        stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'JOIN', senderName: currentUser }));
                    });

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
                    document.getElementById('btnFollow').onclick = function() {
                        stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'FOLLOW', senderName: currentUser }));
                        this.innerHTML = 'Following';
                        this.className = 'btn btn-sm btn-light ms-2';
                        this.disabled = true; // Bấm 1 lần thôi
                    };

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

                    // Host polling pending join requests
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
                            alert('Agora Connection Failed: ' + error.message);
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

            </layout:room>
