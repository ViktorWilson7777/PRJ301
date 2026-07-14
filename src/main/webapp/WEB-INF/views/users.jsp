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

<c:if test="${not empty pendingApplications}">
    <div class="stat-card mb-4" id="proApplications">
        <div class="d-flex align-items-center justify-content-between mb-3">
            <h5 class="mb-0" style="font-weight:700"><i class="bi bi-patch-check me-1"></i>Pro Mentor applications</h5>
            <span class="badge bg-warning text-dark">${pendingApplications.size()} pending</span>
        </div>
        <div style="max-height:380px;overflow-y:auto">
            <c:forEach var="application" items="${pendingApplications}">
                <div class="border rounded p-3 mb-2" style="border-radius:8px!important">
                    <div class="d-flex justify-content-between gap-3 flex-wrap">
                        <div>
                            <strong><c:out value="${application.fullName}"/></strong>
                            <div class="text-muted" style="font-size:12px"><c:out value="${application.email}"/></div>
                        </div>
                        <a href="<c:out value='${application.evidenceUrl}' />" target="_blank" rel="noopener noreferrer" class="btn btn-sm btn-outline-primary"><i class="bi bi-box-arrow-up-right me-1"></i>Open evidence</a>
                    </div>
                    <div class="mt-2" style="font-size:13px;white-space:pre-wrap"><c:out value="${application.achievements}"/></div>
                    <div class="d-flex gap-2 mt-3">
                        <form method="post" action="${pageContext.request.contextPath}/users/${application.id}/application">
                            <input type="hidden" name="decision" value="APPROVE"><button class="btn btn-sm btn-success" type="submit"><i class="bi bi-check-lg me-1"></i>Approve</button>
                        </form>
                        <form method="post" action="${pageContext.request.contextPath}/users/${application.id}/application">
                            <input type="hidden" name="decision" value="REJECT"><button class="btn btn-sm btn-outline-danger" type="submit"><i class="bi bi-x-lg me-1"></i>Reject</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</c:if>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty users}">
            <div class="empty-state">
                <i class="bi bi-people"></i>
                <p>No users yet. Create demo users to get started.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div style="max-height:620px;overflow-y:auto"><table class="table mb-0">
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
                                    <c:when test="${u.role == 'SUPER_CREATOR'}"><span class="badge-status badge-pink">Content Creator</span></c:when>
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
            </table></div>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
