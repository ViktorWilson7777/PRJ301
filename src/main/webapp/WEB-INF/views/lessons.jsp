<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Lessons (SubLevels)">

<div class="d-flex align-items-center justify-content-between mb-4">
    <p class="text-muted mb-0" style="font-size: 13px;">Manage lesson activities within chapters</p>
    <a href="/lessons/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Lesson</a>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty lessons}">
            <div class="empty-state">
                <i class="bi bi-file-earmark-text"></i>
                <p>No lessons yet. Create a lesson or import from DOCX.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr><th>ID</th><th>Type</th><th>Title</th><th>Chapter</th><th>Order</th><th style="width:100px;">Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="l" items="${lessons}">
                        <tr>
                            <td><strong>#${l.id}</strong></td>
                            <td>
                                <c:choose>
                                    <c:when test="${l.type == 'warmup'}"><span class="badge-status badge-warning">warmup</span></c:when>
                                    <c:when test="${l.type == 'ice_breaker'}"><span class="badge-status badge-info">ice_breaker</span></c:when>
                                    <c:when test="${l.type == 'discussion'}"><span class="badge-status badge-purple">discussion</span></c:when>
                                    <c:when test="${l.type == 'follow_up'}"><span class="badge-status badge-pink">follow_up</span></c:when>
                                    <c:when test="${l.type == 'practice'}"><span class="badge-status badge-success">practice</span></c:when>
                                    <c:when test="${l.type == 'wrapup'}"><span class="badge-status badge-gray">wrapup</span></c:when>
                                    <c:otherwise><span class="badge-status badge-gray">${l.type}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>${l.title}</td>
                            <td><c:if test="${l.chapter != null}">${l.chapter.title}</c:if></td>
                            <td>${l.orderIndex}</td>
                            <td>
                                <a href="/lessons/edit/${l.id}" class="btn-action edit"><i class="bi bi-pencil"></i></a>
                                <button class="btn-action delete" onclick="confirmDelete('/lessons/delete/${l.id}')"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
