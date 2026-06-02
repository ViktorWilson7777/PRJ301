<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Podcast Episodes">

<div class="mock-banner">
    <i class="bi bi-info-circle"></i>
    <span><strong>Mock Feature:</strong> No real audio recording. Audio URLs are placeholders. Real recording uses Node.js in production.</span>
</div>

<div class="d-flex align-items-center justify-content-between mb-4">
    <p class="text-muted mb-0" style="font-size: 13px;">Super Creator podcast episodes from live sessions</p>
    <a href="/podcasts/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Podcast</a>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty podcasts}">
            <div class="empty-state">
                <i class="bi bi-headphones"></i>
                <p>No podcast episodes yet. Create one from an ended room.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr><th>ID</th><th>Title</th><th>Creator</th><th>Room</th><th>Duration</th><th>Status</th><th style="width:140px;">Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${podcasts}">
                        <tr>
                            <td><strong>#${p.id}</strong></td>
                            <td>${p.title}</td>
                            <td><c:if test="${p.creator != null}">${p.creator.displayName}</c:if></td>
                            <td><c:if test="${p.room != null}">${p.room.title}</c:if></td>
                            <td>${p.durationSeconds}s</td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.status == 'PUBLISHED'}"><span class="badge-status badge-success">Published</span></c:when>
                                    <c:otherwise><span class="badge-status badge-warning">Draft</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${p.status != 'PUBLISHED'}">
                                    <a href="/podcasts/publish/${p.id}" class="btn-action edit" title="Publish" onclick="return confirm('Publish this episode?')"><i class="bi bi-check-circle"></i></a>
                                </c:if>
                                <a href="/podcasts/edit/${p.id}" class="btn-action edit"><i class="bi bi-pencil"></i></a>
                                <button class="btn-action delete" onclick="confirmDelete('/podcasts/delete/${p.id}')"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
