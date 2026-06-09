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
                
                <!-- Mock Agora Connection Info -->
                <div class="mt-3 text-muted" style="font-size: 11px;">
                    <i class="bi bi-cpu me-1"></i> Agora Audio Channel: <code style="background: #F3F4F6; color: #1F2937; padding: 2px 6px; border-radius: 4px;">lucy_room_${room.id}</code>
                    <a href="/api/agora/token?channelName=lucy_room_${room.id}&uid=1" target="_blank" class="ms-2" style="text-decoration: none; color: var(--lucy-primary);" title="Get Agora Mock Token">
                        <i class="bi bi-key-fill"></i> Get Token API
                    </a>
                </div>
            </div>
        </div>
    </div>
</c:if>

<div class="row g-4">
    <!-- Left Column: Participants -->
    <div class="col-lg-7">
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

            <!-- Add Participant Form -->
            <form method="post" action="/rooms/${room.id}/add-participant" class="d-flex gap-2 align-items-end">
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
        </div>

        <!-- Gift Transactions in Room -->
        <c:if test="${not empty giftTransactions}">
            <div class="stat-card">
                <h6 style="font-weight: 600; margin-bottom: 16px;"><i class="bi bi-gift me-1"></i> Gift History</h6>
                <div class="lucy-table">
                    <table class="table mb-0">
                        <thead><tr><th>Gift</th><th>Sender</th><th>Receiver</th><th>Credits</th></tr></thead>
                        <tbody>
                            <c:forEach var="gt" items="${giftTransactions}">
                                <tr>
                                    <td>${gt.gift.icon} ${gt.gift.name}</td>
                                    <td>${gt.sender.displayName}</td>
                                    <td>${gt.receiver.displayName}</td>
                                    <td><strong>${gt.creditAmount}</strong></td>
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
                        <option value="${l.id}" <c:if test="${room.currentLesson != null && room.currentLesson.id == l.id}">selected</c:if>>[${l.type}] ${l.title}</option>
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
    </div>
</div>

</layout:main>
