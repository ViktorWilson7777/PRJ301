<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="User Management">

<div class="d-flex align-items-center justify-content-between mb-4">
    <p class="text-muted mb-0" style="font-size: 13px;">Manage LUCY platform users and roles</p>
    <div class="d-flex gap-2">
        <a href="/users/export" class="btn btn-outline-lucy"><i class="bi bi-file-earmark-excel me-1"></i> Export Excel</a>
        <a href="/users/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New User</a>
    </div>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty users}">
            <div class="empty-state">
                <i class="bi bi-people"></i>
                <p>No users yet. Create demo users to get started.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr><th>ID</th><th>Name</th><th>Display</th><th>Email</th><th>Role</th><th>Credits</th><th>Rep</th><th>Status</th><th style="width:100px;">Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td><strong>#${u.id}</strong></td>
                            <td>
                                ${u.fullName}
                                <c:if test="${u.anonymousMode}">
                                    <i class="bi bi-incognito ms-1" style="color: #7C3AED;" title="Anonymous Mode"></i>
                                </c:if>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.anonymousMode && u.avatarPersona != null}">${u.avatarPersona}</c:when>
                                    <c:otherwise>${u.displayName}</c:otherwise>
                                </c:choose>
                            </td>
                            <td style="font-size: 12px;">${u.email}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.role == 'ADMIN'}"><span class="badge-status badge-danger">Admin</span></c:when>
                                    <c:when test="${u.role == 'LEARNER'}"><span class="badge-status badge-info">Learner</span></c:when>
                                    <c:when test="${u.role == 'MODERATOR'}"><span class="badge-status badge-warning">Moderator</span></c:when>
                                    <c:when test="${u.role == 'PRO_MENTOR'}"><span class="badge-status badge-purple">Pro Mentor</span></c:when>
                                    <c:when test="${u.role == 'SUPER_CREATOR'}"><span class="badge-status badge-pink">Super Creator</span></c:when>
                                    <c:otherwise><span class="badge-status badge-gray">${u.role}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td><strong>${u.creditBalance}</strong></td>
                            <td>${u.reputationScore}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.active}"><span class="badge-status badge-success">Active</span></c:when>
                                    <c:otherwise><span class="badge-status badge-gray">Inactive</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="/users/edit/${u.id}" class="btn-action edit"><i class="bi bi-pencil"></i></a>
                                <button class="btn-action delete" onclick="confirmDelete('/users/delete/${u.id}')"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
