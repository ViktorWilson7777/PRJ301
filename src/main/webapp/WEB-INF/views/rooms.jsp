<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="isAdmin" value="${sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'SUPER_CREATOR'}" />

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
                            <tr><th>ID</th><th>Title</th><th>Language</th><th>Type</th><th>Status</th><th>Host</th><th>Max</th><th style="width:120px;">Actions</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${rooms}">
                                <tr>
                                    <td><strong>#${r.id}</strong></td>
                                    <td><a href="/rooms/${r.id}" style="color: #6C5CE7; text-decoration: none; font-weight: 500;">${r.title}</a></td>
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
        <!-- LEARNER VIEW -->
        <div class="mb-4 d-flex justify-content-between align-items-end">
            <div>
                <h3 style="font-weight: 700; color: #1E293B;">Live Audio Rooms</h3>
                <p style="color: #64748B; margin-bottom: 0;">Join live conversations to practice speaking.</p>
            </div>
            <c:if test="${sessionScope.currentUser.role != 'LEARNER'}">
                <a href="/rooms/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> Host a Room</a>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${empty rooms}">
                <div class="empty-state" style="background: #fff; border-radius: 16px; border: 1px dashed #CBD5E1;">
                    <i class="bi bi-mic" style="color: #94A1B2;"></i>
                    <p style="color: #64748B;">No live rooms available right now. Please check back later!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="r" items="${rooms}">
                        <div class="col-xl-4 col-md-6">
                            <div class="stat-card" style="height: 100%; display: flex; flex-direction: column; position: relative;">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div style="width: 48px; height: 48px; background: linear-gradient(135deg, #1E293B, #0F172A); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-weight: 700;">
                                        ${r.languageCode}
                                    </div>
                                    <div>
                                        <c:choose>
                                            <c:when test="${r.status == 'LIVE'}">
                                                <span class="badge-status badge-danger animate-pulse"><i class="bi bi-broadcast me-1"></i> LIVE</span>
                                            </c:when>
                                            <c:when test="${r.status == 'SCHEDULED'}">
                                                <span class="badge-status badge-warning"><i class="bi bi-clock me-1"></i> UPCOMING</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                                <h5 style="font-weight: 700; color: #1E293B; margin-bottom: 8px;">${r.title}</h5>
                                <div class="d-flex align-items-center mb-4" style="font-size: 13px; color: #64748B;">
                                    <i class="bi bi-person-fill me-1"></i> Host: <strong class="ms-1"><c:if test="${r.hostUser != null}">${r.hostUser.displayName}</c:if></strong>
                                </div>
                                
                                <div class="mt-auto d-flex justify-content-between align-items-center">
                                    <div style="font-size: 12px; color: #94A1B2; font-weight: 500;">
                                        <i class="bi bi-people-fill me-1"></i> Max: ${r.maxParticipants}
                                    </div>
                                    <a href="/rooms/${r.id}" class="btn btn-lucy px-4" style="border-radius: 20px;">
                                        <c:choose>
                                            <c:when test="${r.status == 'LIVE'}">Join Now</c:when>
                                            <c:otherwise>View Details</c:otherwise>
                                        </c:choose>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>

</layout:main>
