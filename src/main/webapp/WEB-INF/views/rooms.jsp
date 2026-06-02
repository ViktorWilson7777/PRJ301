<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Live Rooms">

<div class="d-flex align-items-center justify-content-between mb-4">
    <p class="text-muted mb-0" style="font-size: 13px;">Mock language learning rooms (no real-time audio)</p>
    <a href="/rooms/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Room</a>
</div>

<div class="mock-banner">
    <i class="bi bi-info-circle"></i>
    <span><strong>Mock System:</strong> Rooms simulate LUCY live audio sessions. Real-time audio uses Node.js + Agora in production.</span>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty rooms}">
            <div class="empty-state">
                <i class="bi bi-mic"></i>
                <p>No rooms yet. Create a room to simulate a live session.</p>
            </div>
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

</layout:main>
