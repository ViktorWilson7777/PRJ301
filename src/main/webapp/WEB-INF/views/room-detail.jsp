<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Room: ${room.title}">

<div class="mock-banner">
    <i class="bi bi-info-circle"></i>
    <span><strong>Mock Room:</strong> This simulates a LUCY live audio room. No real-time audio. State changes via form submissions.</span>
</div>

<!-- Room Header -->
<div class="stat-card mb-4">
    <div class="d-flex align-items-start justify-content-between">
        <div>
            <h5 style="font-weight: 600; margin-bottom: 8px;">${room.title}</h5>
            <div class="d-flex gap-2 flex-wrap mb-2">
                <span class="badge-status badge-purple">${room.languageCode}</span>
                <c:choose>
                    <c:when test="${room.status == 'LIVE'}"><span class="badge-status badge-success"><i class="bi bi-broadcast me-1"></i>Live</span></c:when>
                    <c:when test="${room.status == 'SCHEDULED'}"><span class="badge-status badge-warning">Scheduled</span></c:when>
                    <c:when test="${room.status == 'ENDED'}"><span class="badge-status badge-gray">Ended</span></c:when>
                </c:choose>
                <c:choose>
                    <c:when test="${room.roomType == 'PUBLIC'}"><span class="badge-status badge-info">Public</span></c:when>
                    <c:when test="${room.roomType == 'PRO_CLASS'}"><span class="badge-status badge-purple">Pro Class</span></c:when>
                    <c:when test="${room.roomType == 'PREMIUM'}"><span class="badge-status badge-pink">Premium</span></c:when>
                </c:choose>
            </div>
            <p class="text-muted mb-0" style="font-size: 13px;">
                <c:if test="${room.hostUser != null}"><i class="bi bi-person-fill me-1"></i>Host: <strong>${room.hostUser.displayName}</strong> &nbsp;</c:if>
                <c:if test="${room.course != null}"><i class="bi bi-book me-1"></i>Course: ${room.course.title} &nbsp;</c:if>
                <c:if test="${room.chapter != null}"><i class="bi bi-layers me-1"></i>Chapter: ${room.chapter.title}</c:if>
            </p>
        </div>
        <div class="d-flex gap-2">
            <c:if test="${room.status != 'ENDED'}">
                <a href="/rooms/${room.id}/end" class="btn btn-outline-danger btn-sm" style="border-radius: 8px;" onclick="return confirm('End this room?')">
                    <i class="bi bi-stop-fill me-1"></i> End Room
                </a>
            </c:if>
        </div>
    </div>
    <c:if test="${room.description != null}">
        <p class="mt-2 mb-0" style="font-size: 13px; color: #6B7280;">${room.description}</p>
    </c:if>
</div>

<!-- Active Stage & Recording Controls (Agora & Stage Transition Simulation) -->
<c:if test="${room.status == 'LIVE'}">
    <div class="stat-card mb-4" style="border-left: 4px solid var(--lucy-primary); background: #fff;">
        <div class="row align-items-center">
            <div class="col-md-7">
                <h6 style="font-weight: 700; color: var(--lucy-primary); margin-bottom: 8px;">
                    <i class="bi bi-broadcast me-1"></i> Current Lesson (Active Stage)
                </h6>
                <c:choose>
                    <c:when test="${room.currentLesson != null}">
                        <h5 style="font-weight: 600; margin-bottom: 6px; color: #1A1A2E;">
                            <span class="badge-status badge-purple me-1" style="font-size: 11px; text-transform: uppercase;">${room.currentLesson.type}</span> 
                            ${room.currentLesson.title}
                        </h5>
                        <p class="text-muted mb-0" style="font-size: 13px;">${room.currentLesson.description}</p>
                        <c:if test="${room.stageStartedAt != null}">
                            <small class="text-muted d-block mt-2">
                                <i class="bi bi-clock-history me-1"></i> Stage started at: <strong>${room.stageStartedAt}</strong> (Auto-switches every 10 mins)
                            </small>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted mb-0" style="font-size: 13px;">No active topic selected. Add/select a course chapter to initialize topics.</p>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col-md-5 text-md-end mt-3 mt-md-0">
                <div class="d-flex gap-2 justify-content-md-end flex-wrap">
                    <!-- Next Stage / Topic Skip -->
                    <a href="/rooms/${room.id}/next-stage" class="btn btn-outline-lucy btn-sm" style="border-radius: 8px;">
                        <i class="bi bi-chevron-double-right me-1"></i> Next Topic
                    </a>
                    
                    <!-- Recording Control -->
                    <c:choose>
                        <c:when test="${room.isRecording}">
                            <a href="/rooms/${room.id}/toggle-recording" class="btn btn-danger btn-sm" style="border-radius: 8px; background: var(--lucy-danger); border: none;">
                                <span class="spinner-grow spinner-grow-sm me-1" role="status" aria-hidden="true" style="width: 10px; height: 10px;"></span>
                                🔴 Recording (Stop & Save)
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="/rooms/${room.id}/toggle-recording" class="btn btn-outline-danger btn-sm" style="border-radius: 8px; border-color: var(--lucy-danger); color: var(--lucy-danger);">
                                <i class="bi bi-record-circle me-1"></i> Start Recording
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- Agora Audio Integration UI -->
                <div class="mt-3 p-3" style="background: #F8F9FB; border-radius: 8px; border: 1px dashed #CBD5E1;">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span style="font-size: 12px; font-weight: 600; color: #475569;"><i class="bi bi-headset me-1"></i> Real-time Audio (Agora)</span>
                        <span id="audioStatus" class="badge-status badge-gray" style="font-size: 10px;">Disconnected</span>
                    </div>
                    <div class="d-flex gap-2">
                        <button id="btnConnectAudio" class="btn btn-sm btn-outline-success w-100" style="font-size: 12px;">
                            <i class="bi bi-telephone-fill me-1"></i> Connect Audio
                        </button>
                        <button id="btnDisconnectAudio" class="btn btn-sm btn-outline-danger w-100" style="font-size: 12px; display: none;">
                            <i class="bi bi-telephone-x-fill me-1"></i> Disconnect
                        </button>
                    </div>
                    <div id="audioError" class="mt-2 text-danger" style="font-size: 11px; display: none;"></div>
                    <div class="mt-2 text-muted" style="font-size: 10px;">
                        Channel: <code>lucy_room_${room.id}</code> | Token API: <a href="/api/agora/token?channelName=lucy_room_${room.id}&uid=1" target="_blank">Mock</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>

<div class="row g-4">
    <!-- Left Column: Participants -->
    <div class="col-lg-7">
        <!-- HOST: Pending Join Request Notification Panel -->
        <c:if test="${room.status == 'LIVE'}">
            <div id="joinRequestPanel" class="stat-card mb-4" data-room-id="${room.id}" style="border-left: 4px solid #F59E0B; background: #FFFBEB;" ${empty pendingRequests ? 'hidden' : ''}>
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h6 style="font-weight: 700; color: #D97706; margin: 0;">
                        <i class="bi bi-person-plus-fill me-1"></i>
                        Join Requests
                        <span id="joinRequestBadge" class="ms-2" style="background: #EF4444; color: white; border-radius: 50%; padding: 2px 7px; font-size: 12px;">
                            ${pendingRequests.size()}
                        </span>
                    </h6>
                    <small class="text-muted" style="font-size: 11px;">Auto-refreshes every 5s</small>
                </div>
                <div id="joinRequestList">
                    <c:forEach var="jr" items="${pendingRequests}">
                        <div id="jr-row-${jr.id}" class="d-flex align-items-center justify-content-between p-2 mb-2" style="background: white; border-radius: 8px; border: 1px solid #FDE68A;">
                            <div>
                                <strong style="font-size: 13px;">${jr.displayName}</strong>
                                <span class="ms-2 badge-status badge-gray" style="font-size: 10px;">${jr.roleRequested}</span>
                                <br><small class="text-muted" style="font-size: 11px;"><i class="bi bi-clock me-1"></i>${jr.requestedAt}</small>
                            </div>
                            <div class="d-flex gap-2">
                                <button class="btn btn-sm" style="background: #059669; color: white; border-radius: 6px; font-size: 12px; border: none;"
                                        data-action="approve" data-request-id="${jr.id}" onclick="handleJoinRequest(this)">
                                    <i class="bi bi-check-lg me-1"></i>Accept
                                </button>
                                <button class="btn btn-sm" style="background: #DC2626; color: white; border-radius: 6px; font-size: 12px; border: none;"
                                        data-action="deny" data-request-id="${jr.id}" onclick="handleJoinRequest(this)">
                                    <i class="bi bi-x-lg me-1"></i>Deny
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <div class="stat-card mb-4">
            <h6 style="font-weight: 600; margin-bottom: 16px;"><i class="bi bi-people-fill me-1"></i> Participants (${participants.size()})</h6>

            <c:if test="${not empty participants}">
                <div class="lucy-table mb-3">
                    <table class="table mb-0">
                        <thead><tr><th>User</th><th>Role</th><th>Mic</th><th>Hand</th><th>Actions</th></tr></thead>
                        <tbody>
                            <c:forEach var="p" items="${participants}">
                                <tr>
                                    <td>
                                        <strong>${p.displayName}</strong>
                                        <c:if test="${p.user != null}"><br><small class="text-muted">${p.user.fullName}</small></c:if>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.roleInRoom == 'HOST'}"><span class="badge-status badge-danger">Host</span></c:when>
                                            <c:when test="${p.roleInRoom == 'MODERATOR'}"><span class="badge-status badge-warning">Mod</span></c:when>
                                            <c:when test="${p.roleInRoom == 'SPEAKER'}"><span class="badge-status badge-success">Speaker</span></c:when>
                                            <c:otherwise><span class="badge-status badge-gray">Listener</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="/rooms/${room.id}/toggle-mic/${p.id}" style="text-decoration: none; font-size: 18px;">
                                            <c:choose>
                                                <c:when test="${p.micOn}"><i class="bi bi-mic-fill" style="color: #059669;"></i></c:when>
                                                <c:otherwise><i class="bi bi-mic-mute-fill" style="color: #DC2626;"></i></c:otherwise>
                                            </c:choose>
                                        </a>
                                    </td>
                                    <td>
                                        <a href="/rooms/${room.id}/toggle-hand/${p.id}" style="text-decoration: none; font-size: 18px;">
                                            <c:choose>
                                                <c:when test="${p.handRaised}"><span style="color: #D97706;">✋</span></c:when>
                                                <c:otherwise><span style="color: #D1D5DB;">✋</span></c:otherwise>
                                            </c:choose>
                                        </a>
                                    </td>
                                    <td>
                                        <button class="btn-action delete" onclick="confirmDelete('/rooms/${room.id}/remove-participant/${p.id}')"><i class="bi bi-x-lg"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <!-- Add Participant Form (Admin/Host direct add) -->
            <details class="mt-3" style="border-top: 1px solid #F1F5F9; padding-top: 12px;">
                <summary style="font-size: 12px; color: #6B7280; cursor: pointer; user-select: none;"><i class="bi bi-person-plus me-1"></i> Direct Add (Admin override)</summary>
                <form method="post" action="/rooms/${room.id}/add-participant" class="d-flex gap-2 align-items-end mt-2">
                    <div style="flex: 1;">
                        <label class="form-label" style="font-size: 12px;">User</label>
                        <select name="userId" class="form-select form-select-sm" required>
                            <option value="">— Select —</option>
                            <c:forEach var="u" items="${users}">
                                <option value="${u.id}">${u.displayName} (${u.role})</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div style="width: 130px;">
                        <label class="form-label" style="font-size: 12px;">Role</label>
                        <select name="roleInRoom" class="form-select form-select-sm">
                            <option value="LISTENER">Listener</option>
                            <option value="SPEAKER">Speaker</option>
                            <option value="MODERATOR">Moderator</option>
                            <option value="HOST">Host</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-lucy btn-sm"><i class="bi bi-plus-lg"></i> Add</button>
                </form>
            </details>

            <!-- VISITOR: Request to Join Panel -->
            <c:if test="${room.status == 'LIVE'}">
                <div class="mt-3" style="border-top: 1px solid #F1F5F9; padding-top: 12px;">
                    <h6 style="font-size: 13px; font-weight: 600; color: #6B7280;"><i class="bi bi-hand-index me-1"></i> Request to Join (Visitor Simulation)</h6>
                    <div class="d-flex gap-2 align-items-end">
                        <div style="flex: 1;">
                            <label class="form-label" style="font-size: 12px;">As User</label>
                            <select id="reqUserId" class="form-select form-select-sm">
                                <option value="">— Select User —</option>
                                <c:forEach var="u" items="${users}">
                                    <option value="${u.id}">${u.displayName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div style="width: 120px;">
                            <label class="form-label" style="font-size: 12px;">Role</label>
                            <select id="reqRole" class="form-select form-select-sm">
                                <option value="LISTENER">Listener</option>
                                <option value="SPEAKER">Speaker</option>
                            </select>
                        </div>
                        <button class="btn btn-sm" style="background: var(--lucy-primary); color: white; border-radius: 8px; border: none;" onclick="sendJoinRequest()">
                            <i class="bi bi-person-plus me-1"></i>Request
                        </button>
                    </div>
                    <div id="joinReqStatus" class="mt-2" style="display: none; font-size: 12px;"></div>
                </div>
            </c:if>
        </div>

        <!-- Gift Transactions in Room -->
        <c:if test="${not empty giftTransactions}">
            <div class="stat-card">
                <h6 style="font-weight: 600; margin-bottom: 16px;"><i class="bi bi-gift me-1"></i> Gift History</h6>
                <div class="lucy-table">
                    <table class="table mb-0">
                        <thead><tr><th>Gift</th><th>Sender</th><th>Receiver</th><th>Credits</th></tr></thead>
                        <tbody>
                            <c:forEach var="txn" items="${giftTransactions}">
                                <tr>
                                    <td>${txn.gift.icon} ${txn.gift.name}</td>
                                    <td>${txn.sender.displayName}</td>
                                    <td>${txn.receiver.displayName}</td>
                                    <td><strong>${txn.creditAmount}</strong></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Right Column: Pinned Materials, Send Gift -->
    <div class="col-lg-5">
        <!-- Pinned Materials -->
        <div class="stat-card mb-4">
            <h6 style="font-weight: 600; margin-bottom: 16px;"><i class="bi bi-pin-angle me-1"></i> Pinned Materials</h6>

            <c:if test="${not empty pinnedMaterials}">
                <c:forEach var="pm" items="${pinnedMaterials}">
                    <div style="background: #F8F9FB; border-radius: 8px; padding: 12px; margin-bottom: 8px; position: relative;">
                        <strong style="font-size: 13px;">${pm.title}</strong>
                        <a href="/rooms/${room.id}/unpin/${pm.id}" style="position: absolute; top: 8px; right: 8px; color: #DC2626;" title="Unpin"><i class="bi bi-x-lg"></i></a>
                        <p style="font-size: 12px; color: #6B7280; margin: 4px 0 0; max-height: 60px; overflow: hidden;">${pm.content}</p>
                    </div>
                </c:forEach>
            </c:if>

            <form method="post" action="/rooms/${room.id}/pin-material" class="mt-3">
                <div class="mb-2">
                    <select name="lessonId" class="form-select form-select-sm" required>
                        <option value="">— Select Lesson to Pin —</option>
                        <c:forEach var="l" items="${lessons}">
                            <option value="${l.id}">[${l.type}] ${l.title}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-2">
                    <input type="text" name="pinTitle" class="form-control form-control-sm" placeholder="Custom title (optional)" />
                </div>
                <button type="submit" class="btn btn-outline-lucy btn-sm w-100"><i class="bi bi-pin me-1"></i> Pin Material</button>
            </form>
        </div>

        <!-- Send Gift -->
        <div class="stat-card mb-4">
            <h6 style="font-weight: 600; margin-bottom: 16px;"><i class="bi bi-gift me-1"></i> Send Gift</h6>
            <div class="mock-banner" style="margin-bottom: 12px;">
                <i class="bi bi-info-circle"></i>
                <span>Mock billing — no real charges</span>
            </div>
            <form method="post" action="/rooms/${room.id}/send-gift">
                <div class="mb-2">
                    <select name="senderId" class="form-select form-select-sm" required>
                        <option value="">— Sender —</option>
                        <c:forEach var="u" items="${users}">
                            <option value="${u.id}">${u.displayName} (${u.creditBalance} credits)</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-2">
                    <select name="receiverId" class="form-select form-select-sm" required>
                        <option value="">— Receiver —</option>
                        <c:forEach var="u" items="${users}">
                            <option value="${u.id}">${u.displayName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-2">
                    <select name="giftId" class="form-select form-select-sm" required>
                        <option value="">— Gift —</option>
                        <c:forEach var="g" items="${gifts}">
                            <option value="${g.id}">${g.icon} ${g.name} (${g.creditCost} credits)</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-lucy btn-sm w-100"><i class="bi bi-send me-1"></i> Send Gift</button>
            </form>
        </div>

        <!-- AI Questions -->
        <div class="stat-card">
            <h6 style="font-weight: 600; margin-bottom: 16px;"><i class="bi bi-cpu me-1"></i> AI Question Generator</h6>
            
            <div class="mb-3">
                <label class="form-label" style="font-size: 12px;">Select Lesson</label>
                <select id="aiLessonId" class="form-select form-select-sm">
                    <option value="">— Select a Lesson —</option>
                    <c:forEach var="l" items="${lessons}">
                        <option value="${l.id}" <c:if test="${room.currentLesson != null and room.currentLesson.id == l.id}">selected</c:if>>[${l.type}] ${l.title}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label" style="font-size: 12px;">Prompt Type</label>
                <select id="aiPromptType" class="form-select form-select-sm">
                    <option value="discussion">Discussion</option>
                    <option value="warmup">Warmup</option>
                    <option value="ice_breaker">Ice Breaker</option>
                    <option value="practice">Practice</option>
                    <option value="wrapup">Wrap Up</option>
                </select>
            </div>
            <button id="btnGenerateAi" class="btn btn-lucy btn-sm w-100" onclick="generateAiQuestions()">
                <i class="bi bi-stars me-1"></i> Generate AI Questions
            </button>

            <!-- Loading indicator -->
            <div id="aiLoading" class="text-center mt-3" style="display: none;">
                <div class="spinner-border spinner-border-sm text-primary" role="status"></div>
                <span style="font-size: 13px; margin-left: 8px;">Generating questions with AI...</span>
            </div>

            <!-- Results -->
            <div id="aiResults" class="mt-3" style="display: none;">
                <h6 style="font-size: 13px; font-weight: 600; color: #059669;"><i class="bi bi-check-circle me-1"></i> Generated Questions</h6>
                <div id="aiMockBadge" class="mb-2" style="display: none;">
                    <span class="badge-status badge-warning" style="font-size: 11px;">Mock Mode (no API key)</span>
                </div>
                <ul id="aiQuestionList" style="padding-left: 18px; font-size: 13px;"></ul>
            </div>

            <!-- Error -->
            <div id="aiError" class="mt-3" style="display: none;">
                <div class="text-danger" style="font-size: 13px;"><i class="bi bi-exclamation-triangle me-1"></i> <span id="aiErrorMsg"></span></div>
            </div>
        </div>

<script>
function generateAiQuestions() {
    var lessonId = document.getElementById('aiLessonId').value;
    var promptType = document.getElementById('aiPromptType').value;

    if (!lessonId) {
        alert('Please select a lesson first!');
        return;
    }

    var btn = document.getElementById('btnGenerateAi');
    var loading = document.getElementById('aiLoading');
    var results = document.getElementById('aiResults');
    var errorDiv = document.getElementById('aiError');

    btn.disabled = true;
    loading.style.display = 'block';
    results.style.display = 'none';
    errorDiv.style.display = 'none';

    fetch('/api/ai/suggest-questions?lessonId=' + lessonId + '&promptType=' + promptType, {
        method: 'POST'
    })
    .then(function(response) { return response.json(); })
    .then(function(data) {
        loading.style.display = 'none';
        btn.disabled = false;

        if (data.message) {
            errorDiv.style.display = 'block';
            document.getElementById('aiErrorMsg').textContent = data.message;
            return;
        }

        results.style.display = 'block';
        var mockBadge = document.getElementById('aiMockBadge');
        mockBadge.style.display = data.isMock ? 'block' : 'none';

        var list = document.getElementById('aiQuestionList');
        list.innerHTML = '';
        if (data.questions) {
            data.questions.forEach(function(q) {
                var li = document.createElement('li');
                li.style.marginBottom = '6px';
                li.textContent = q.generatedQuestion || q;
                list.appendChild(li);
            });
        }
    })
    .catch(function(err) {
        loading.style.display = 'none';
        btn.disabled = false;
        errorDiv.style.display = 'block';
        document.getElementById('aiErrorMsg').textContent = 'Failed to connect: ' + err.message;
    });
}
</script>

<script>
// ============================================================
// JOIN REQUEST: Send + Handle Accept/Deny
// ============================================================

function sendJoinRequest() {
    var panel = document.getElementById('joinRequestPanel');
    var roomId = panel ? parseInt(panel.dataset.roomId) : 0;
    var userId = document.getElementById('reqUserId').value;
    var role = document.getElementById('reqRole').value;
    var statusDiv = document.getElementById('joinReqStatus');

    if (!userId) {
        alert('Please select a user to simulate the join request.');
        return;
    }
    if (!roomId) {
        alert('Room ID not found.');
        return;
    }

    statusDiv.style.display = 'block';
    statusDiv.style.color = '#6B7280';
    statusDiv.innerHTML = '<i class="bi bi-hourglass-split me-1"></i>Sending join request...';

    fetch('/api/rooms/' + roomId + '/request-join?userId=' + userId + '&roleRequested=' + role, { method: 'POST' })
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.error) {
                statusDiv.style.color = '#DC2626';
                statusDiv.innerHTML = '<i class="bi bi-exclamation-triangle me-1"></i>' + data.error;
            } else {
                statusDiv.style.color = '#059669';
                statusDiv.innerHTML = '<i class="bi bi-check-circle me-1"></i>Join request sent! Waiting for host approval...';
            }
        })
        .catch(function(e) {
            statusDiv.style.color = '#DC2626';
            statusDiv.innerHTML = '<i class="bi bi-x-circle me-1"></i>Error: ' + e.message;
        });
}

function handleJoinRequest(btn) {
    var panel = document.getElementById('joinRequestPanel');
    var roomId = panel ? parseInt(panel.dataset.roomId) : 0;
    var requestId = parseInt(btn.dataset.requestId);
    var action = btn.dataset.action;
    var url = '/api/rooms/' + roomId + '/' + (action === 'approve' ? 'approve-join' : 'deny-join') + '/' + requestId;
    fetch(url, { method: 'POST' })
        .then(function(r) { return r.json(); })
        .then(function(data) {
            var row = document.getElementById('jr-row-' + requestId);
            if (row) {
                row.style.transition = 'opacity 0.3s';
                row.style.opacity = '0';
                setTimeout(function() { row.remove(); refreshJoinBadge(); }, 300);
            }
            if (action === 'approve') {
                setTimeout(function() { window.location.reload(); }, 600);
            }
        })
        .catch(function(e) { alert('Error: ' + e.message); });
}

function refreshJoinBadge() {
    var list = document.getElementById('joinRequestList');
    var panel = document.getElementById('joinRequestPanel');
    var badge = document.getElementById('joinRequestBadge');
    if (!list || !panel) return;
    var rows = list.querySelectorAll('[id^="jr-row-"]');
    badge.textContent = rows.length;
    panel.style.display = rows.length > 0 ? 'block' : 'none';
}

// Poll for new join requests every 5 seconds (simulates real-time for host)
var roomPollPanel = document.getElementById('joinRequestPanel');
var ROOM_ID_FOR_POLL = roomPollPanel ? parseInt(roomPollPanel.dataset.roomId) : 0;

if (ROOM_ID_FOR_POLL > 0) {
    // Initialise display state
    var _initPanel = document.getElementById('joinRequestPanel');
    if (_initPanel) _initPanel.style.display = _initPanel.querySelectorAll('[id^="jr-row-"]').length > 0 ? 'block' : 'none';

    setInterval(function() {
        fetch('/api/rooms/' + ROOM_ID_FOR_POLL + '/pending-requests')
            .then(function(r) { return r.json(); })
            .then(function(requests) {
                var panel = document.getElementById('joinRequestPanel');
                var list = document.getElementById('joinRequestList');
                var badge = document.getElementById('joinRequestBadge');
                if (!panel || !list || !badge) return;

                panel.style.display = requests.length > 0 ? 'block' : 'none';
                badge.textContent = requests.length;

                requests.forEach(function(jr) {
                    if (!document.getElementById('jr-row-' + jr.requestId)) {
                        var html = '<div id="jr-row-' + jr.requestId + '" class="d-flex align-items-center justify-content-between p-2 mb-2" style="background: white; border-radius: 8px; border: 1px solid #FDE68A;">' +
                            '<div>' +
                            '  <strong style="font-size: 13px;">' + jr.displayName + '</strong>' +
                            '  <span class="ms-2 badge-status badge-gray" style="font-size: 10px;">' + jr.roleRequested + '</span>' +
                            '</div>' +
                            '<div class="d-flex gap-2">' +
                            '  <button class="btn btn-sm" style="background:#059669;color:white;border-radius:6px;font-size:12px;border:none;" data-action="approve" data-request-id="' + jr.requestId + '" onclick="handleJoinRequest(this)"><i class="bi bi-check-lg me-1"></i>Accept</button>' +
                            '  <button class="btn btn-sm" style="background:#DC2626;color:white;border-radius:6px;font-size:12px;border:none;" data-action="deny" data-request-id="' + jr.requestId + '" onclick="handleJoinRequest(this)"><i class="bi bi-x-lg me-1"></i>Deny</button>' +
                            '</div></div>';
                        list.insertAdjacentHTML('beforeend', html);
                    }
                });
            })
            .catch(function() { /* silent poll error */ });
    }, 5000);
}
</script>

<!-- Agora Web SDK -->
<script src="https://download.agora.io/sdk/release/AgoraRTC_N-4.20.0.js"></script>
<script>
    // Agora Audio Integration Logic
    var rtc = {
        client: null,
        localAudioTrack: null
    };
    var options = {
        appId: "1adc56609faa4f95b208d10e17d60786", // TODO: Replace with real App ID
        channel: "lucy_room_${room.id}",
        uid: Math.floor(Math.random() * 10000), // Random UID for testing
        token: null // Will be fetched from Node.js / Java API
    };

    document.getElementById('btnConnectAudio').onclick = async function() {
        var btnConnect = document.getElementById('btnConnectAudio');
        var btnDisconnect = document.getElementById('btnDisconnectAudio');
        var statusBadge = document.getElementById('audioStatus');
        var errorDiv = document.getElementById('audioError');
        
        errorDiv.style.display = 'none';
        btnConnect.disabled = true;
        btnConnect.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span> Connecting...';

        try {
            // 1. Fetch Token from API (Using our Mock API for now)
            const response = await fetch('/api/agora/token?channelName=' + options.channel + '&uid=' + options.uid);
            const data = await response.json();
            // If the token is a mock token, we set it to null so Agora can use AppID-only testing mode (if enabled for this App ID)
            options.token = (data.token && data.token.startsWith('006MOCK')) ? null : data.token; 

            // 2. Initialize Agora Client
            rtc.client = AgoraRTC.createClient({ mode: "rtc", codec: "vp8" });

            // 3. Add Event Listeners for remote users
            rtc.client.on("user-published", async function(user, mediaType) {
                await rtc.client.subscribe(user, mediaType);
                console.log("Subscribed to remote user", user.uid);
                if (mediaType === "audio") {
                    user.audioTrack.play();
                }
            });

            // 4. Join Channel
            // WARNING: If using the Mock Token, this line will throw an error. 
            // In a real environment with Node.js token server, it will succeed.
            await rtc.client.join(options.appId, options.channel, options.token, options.uid);

            // 5. Create and publish local audio track (Microphone)
            rtc.localAudioTrack = await AgoraRTC.createMicrophoneAudioTrack();
            await rtc.client.publish([rtc.localAudioTrack]);

            // Update UI
            btnConnect.style.display = 'none';
            btnDisconnect.style.display = 'block';
            statusBadge.textContent = 'Connected';
            statusBadge.className = 'badge-status badge-success';
            console.log("Publish success!");

        } catch (error) {
            console.error("Agora Connection Failed:", error);
            errorDiv.style.display = 'block';
            errorDiv.innerHTML = '<strong>Connection Failed:</strong> ' + error.message + '<br><small>Note: If using Mock Token, Agora will reject it. Use a real Node.js token server.</small>';
            btnConnect.disabled = false;
            btnConnect.innerHTML = '<i class="bi bi-telephone-fill me-1"></i> Connect Audio';
        }
    };

    document.getElementById('btnDisconnectAudio').onclick = async function() {
        if (rtc.localAudioTrack) {
            rtc.localAudioTrack.close();
        }
        if (rtc.client) {
            await rtc.client.leave();
        }
        document.getElementById('btnConnectAudio').style.display = 'block';
        document.getElementById('btnConnectAudio').disabled = false;
        document.getElementById('btnConnectAudio').innerHTML = '<i class="bi bi-telephone-fill me-1"></i> Connect Audio';
        document.getElementById('btnDisconnectAudio').style.display = 'none';
        
        var statusBadge = document.getElementById('audioStatus');
        statusBadge.textContent = 'Disconnected';
        statusBadge.className = 'badge-status badge-gray';
    };
</script>
    </div>
</div>

</layout:main>
