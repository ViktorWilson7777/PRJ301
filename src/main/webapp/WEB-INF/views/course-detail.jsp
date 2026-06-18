<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

            <layout:main pageTitle="Course Detail">

                <!-- Header Section -->
                <div class="mb-4">
                    <a href="/courses" class="text-decoration-none text-muted mb-3 d-inline-block"><i
                            class="bi bi-arrow-left"></i> Back to Courses</a>
                    <div class="d-flex align-items-center gap-3 mb-2">
                        <h2 style="font-weight: 800; color: #1E293B; margin-bottom: 0;">${course.title}</h2>
                        <span class="badge-status badge-purple" style="font-size: 14px;">${course.level}</span>
                    </div>
                    <p style="color: #64748B; font-size: 15px;">Course Code: <strong>${course.code}</strong>
                        <c:if test="${course.program != null}">| Program: <strong>${course.program.code}</strong></c:if>
                    </p>
                </div>

                <c:if test="${param.error == 'level_too_low'}">
                    <div class="alert alert-danger" style="border-radius: 10px; font-size: 14px; padding: 12px;">
                        <i class="bi bi-lock-fill me-2"></i> Your level is too low to join this live room. Keep
                        practicing to level up!
                    </div>
                </c:if>

                <!-- Description -->
                <c:if test="${not empty course.description}">
                    <div class="stat-card mb-4" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
                        <h6 style="font-weight: 700; color: #334155; margin-bottom: 12px;"><i
                                class="bi bi-info-circle me-2"></i> About this course</h6>
                        <p style="color: #475569; margin-bottom: 0; line-height: 1.6;">${course.description}</p>
                    </div>
                </c:if>

                <!-- Live Audio Rooms (Course Runs) -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 style="font-weight: 700; color: #1E293B; margin-bottom: 0;">Active Live Rooms</h4>
                    <c:if test="${sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'PRO_MENTOR' || sessionScope.currentUser.role == 'SUPER_CREATOR'}">
                        <a href="/rooms/create?courseId=${course.id}" class="btn btn-lucy btn-sm"><i class="bi bi-plus-lg me-1"></i> Host a Room</a>
                    </c:if>
                </div>

                <!-- Filter Form -->
                <form action="/courses/${course.id}" method="get" class="mb-4 p-3" style="background: #F8FAFC; border-radius: 12px; border: 1px solid #E2E8F0;">
                    <div class="row g-2 align-items-center">
                        <div class="col-md-5">
                            <div class="input-group input-group-sm">
                                <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-person"></i></span>
                                <input type="text" name="hostName" class="form-control border-start-0 ps-0" placeholder="Filter by Host Name..." value="${hostName}">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group input-group-sm">
                                <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-bar-chart"></i></span>
                                <input type="number" name="level" class="form-control border-start-0 ps-0" placeholder="Filter by Level..." value="${searchLevel}" min="1">
                            </div>
                        </div>
                        <div class="col-md-3 d-flex">
                            <button type="submit" class="btn btn-lucy btn-sm w-100 me-2"><i class="bi bi-search"></i> Filter</button>
                            <a href="/courses/${course.id}" class="btn btn-secondary btn-sm"><i class="bi bi-arrow-counterclockwise"></i></a>
                        </div>
                    </div>
                </form>
                
                <c:choose>
                    <c:when test="${not empty liveRooms}">
                        <div class="row g-3 mb-5">
                            <c:forEach var="room" items="${liveRooms}">
                                <div class="col-md-6 col-lg-4">
                                    <div class="stat-card"
                                        style="height: 100%; border: 1px solid #E2E8F0; background: #fff; padding: 20px; border-radius: 16px;">
                                        <div class="d-flex justify-content-between align-items-start mb-3">
                                            <c:choose>
                                                <c:when test="${room.status == 'LIVE'}">
                                                    <span class="badge bg-danger animate-pulse" style="font-size: 11px;">LIVE</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning" style="font-size: 11px; color: #78350F;">UPCOMING</span>
                                                </c:otherwise>
                                            </c:choose>
                                            <span class="badge"
                                                style="background: #EEF2FF; color: #4F46E5; font-size: 11px;">Lvl
                                                ${room.levelNumber != null ? room.levelNumber : 1}</span>
                                        </div>
                                        <h6 style="font-weight: 700; margin-bottom: 8px;">${room.title}</h6>
                                        <p
                                            style="font-size: 13px; color: #64748B; margin-bottom: 16px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                            Host: <strong>${room.hostUser != null ? room.hostUser.displayName : 'Unknown'}</strong><br>
                                            ${room.description}
                                        </p>

                                        <c:set var="reqLevel" value="${room.levelNumber != null ? room.levelNumber : 1}" />
                                        <c:choose>
                                            <c:when
                                                test="${userLevel >= reqLevel || sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'PRO_MENTOR' || sessionScope.currentUser.role == 'SUPER_CREATOR'}">
                                                <a href="/rooms/${room.id}" class="btn btn-lucy w-100 btn-sm"
                                                    style="border-radius: 8px;">
                                                    <i class="bi bi-mic-fill me-1"></i> Join Room
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-secondary w-100 btn-sm" style="border-radius: 8px;"
                                                    disabled>
                                                    <i class="bi bi-lock-fill me-1"></i> Requires Lvl ${reqLevel}
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state mb-5" style="background: #fff; border-radius: 16px; border: 1px dashed #CBD5E1; padding: 40px; text-align: center;">
                            <i class="bi bi-mic-mute" style="color: #94A1B2; font-size: 32px; margin-bottom: 12px; display: block;"></i>
                            <p style="color: #64748B; margin-bottom: 0;">No active or scheduled live rooms available for this course yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                    <!-- Levels & Questions -->
                    <h4 style="font-weight: 700; color: #1E293B; margin-bottom: 20px;">Levels & Questions Structure (Admin Only)</h4>

                    <c:choose>
                        <c:when test="${empty chapters}">
                            <div class="empty-state"
                                style="background: #fff; border-radius: 16px; border: 1px dashed #CBD5E1;">
                                <i class="bi bi-journal-x" style="color: #94A1B2;"></i>
                                <p style="color: #64748B;">No chapters added to this course yet.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="accordion" id="syllabusAccordion">
                                <c:forEach var="chapter" items="${chapters}" varStatus="status">
                                    <div class="accordion-item"
                                        style="border: 1px solid #E2E8F0; border-radius: 12px; margin-bottom: 12px; overflow: hidden; background: #fff;">
                                        <h2 class="accordion-header" id="heading${chapter.id}">
                                            <button class="accordion-button ${status.first ? '' : 'collapsed'}"
                                                type="button" data-bs-toggle="collapse" data-bs-toggle="collapse"
                                                data-bs-target="#collapse${chapter.id}"
                                                aria-expanded="${status.first ? 'true' : 'false'}"
                                                aria-controls="collapse${chapter.id}"
                                                style="background: #fff; color: #1E293B; font-weight: 600; box-shadow: none; padding: 20px;">
                                                <div class="d-flex align-items-center gap-3 w-100">
                                                    <div
                                                        style="width: 32px; height: 32px; border-radius: 8px; background: #EEF2FF; color: #4F46E5; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 14px;">
                                                        ${chapter.orderIndex}</div>
                                                    <div>
                                                        <div style="font-size: 16px;">${chapter.title}</div>
                                                        <div
                                                            style="font-size: 13px; color: #94A1B2; font-weight: 400; margin-top: 4px;">
                                                            ${chapterLessonsMap[chapter.id].size()} lessons</div>
                                                    </div>
                                                </div>
                                            </button>
                                        </h2>
                                        <div id="collapse${chapter.id}"
                                            class="accordion-collapse collapse ${status.first ? 'show' : ''}"
                                            aria-labelledby="heading${chapter.id}" data-bs-parent="#syllabusAccordion">
                                            <div class="accordion-body"
                                                style="padding: 0; border-top: 1px solid #F1F5F9;">
                                                <c:if test="${not empty chapter.description}">
                                                    <div
                                                        style="padding: 16px 20px; background: #F8FAFC; color: #64748B; font-size: 14px; border-bottom: 1px solid #F1F5F9;">
                                                        ${chapter.description}
                                                    </div>
                                                </c:if>

                                                <div class="list-group list-group-flush">
                                                    <c:choose>
                                                        <c:when test="${empty chapterLessonsMap[chapter.id]}">
                                                            <div class="list-group-item text-muted"
                                                                style="padding: 16px 20px; font-style: italic;">No
                                                                lessons in this chapter yet.</div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach var="lesson"
                                                                items="${chapterLessonsMap[chapter.id]}">
                                                                <div class="list-group-item list-group-item-action"
                                                                    style="padding: 16px 20px; display: flex; justify-content: space-between; align-items: center; border-color: #F1F5F9;">
                                                                    <div class="d-flex align-items-center gap-3">
                                                                        <c:choose>
                                                                            <c:when test="${lesson.type == 'VIDEO'}">
                                                                                <div
                                                                                    style="width: 36px; height: 36px; border-radius: 50%; background: #FEF2F2; color: #DC2626; display: flex; align-items: center; justify-content: center;">
                                                                                    <i class="bi bi-play-fill"
                                                                                        style="font-size: 20px;"></i>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:when test="${lesson.type == 'DOCUMENT'}">
                                                                                <div
                                                                                    style="width: 36px; height: 36px; border-radius: 50%; background: #F0FDF4; color: #16A34A; display: flex; align-items: center; justify-content: center;">
                                                                                    <i
                                                                                        class="bi bi-file-earmark-text"></i>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:when test="${lesson.type == 'QUIZ'}">
                                                                                <div
                                                                                    style="width: 36px; height: 36px; border-radius: 50%; background: #FFFBEB; color: #D97706; display: flex; align-items: center; justify-content: center;">
                                                                                    <i class="bi bi-ui-checks"></i>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div
                                                                                    style="width: 36px; height: 36px; border-radius: 50%; background: #F1F5F9; color: #64748B; display: flex; align-items: center; justify-content: center;">
                                                                                    <i class="bi bi-journal-text"></i>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>

                                                                        <div>
                                                                            <div
                                                                                style="font-weight: 600; color: #334155;">
                                                                                ${lesson.title}</div>
                                                                            <c:if test="${not empty lesson.type}">
                                                                                <div
                                                                                    style="font-size: 12px; color: #94A1B2; margin-top: 2px;">
                                                                                    ${lesson.type}</div>
                                                                            </c:if>
                                                                        </div>
                                                                    </div>
                                                                    <a href="/lessons/${lesson.id}"
                                                                        class="btn btn-sm btn-light"
                                                                        style="border-radius: 6px; font-weight: 600; color: #4F46E5;">Study</a>
                                                                </div>
                                                            </c:forEach>
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
                </c:if>

            </layout:main>