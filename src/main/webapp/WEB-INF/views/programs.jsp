<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="isAdmin" value="${sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.role == 'SUPER_CREATOR'}" />

<layout:main pageTitle="Programs">

<c:choose>
    <c:when test="${isAdmin}">
        <!-- ADMIN VIEW: Data Table -->
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div><p class="text-muted mb-0" style="font-size: 13px;">Manage language programs (EN, ZH, JA)</p></div>
            <a href="/programs/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Program</a>
        </div>

        <div class="lucy-table">
            <c:choose>
                <c:when test="${empty programs}">
                    <div class="empty-state">
                        <i class="bi bi-collection"></i><p>No programs yet. Create your first language program.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="table mb-0">
                        <thead>
                            <tr>
                                <th>ID</th><th>Code</th><th>Title</th><th>Description</th><th>Status</th><th style="width: 100px;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${programs}">
                                <tr>
                                    <td><strong>#${p.id}</strong></td>
                                    <td><span class="badge-status badge-purple">${p.code}</span></td>
                                    <td>${p.title}</td>
                                    <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${p.description}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.isPublished}"><span class="badge-status badge-success">Published</span></c:when>
                                            <c:otherwise><span class="badge-status badge-gray">Draft</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="/programs/edit/${p.id}" class="btn-action edit" title="Edit"><i class="bi bi-pencil"></i></a>
                                        <button class="btn-action delete" title="Delete" onclick="confirmDelete('/programs/delete/${p.id}')"><i class="bi bi-trash"></i></button>
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
        <!-- LEARNER VIEW: Card Grid -->
        <div class="mb-4">
            <h3 style="font-weight: 700; color: #1E293B;">Language Programs</h3>
            <p style="color: #64748B;">Choose a language path to begin your journey.</p>
        </div>

        <c:choose>
            <c:when test="${empty programs}">
                <div class="empty-state" style="background: #fff; border-radius: 16px; border: 1px dashed #CBD5E1;">
                    <i class="bi bi-collection" style="color: #94A1B2;"></i>
                    <p style="color: #64748B;">No programs available right now. Please check back later!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="p" items="${programs}">
                        <c:if test="${p.isPublished}">
                            <div class="col-xl-4 col-md-6">
                                <div class="stat-card" style="height: 100%; display: flex; flex-direction: column; padding: 0; overflow: hidden;">
                                    <div style="height: 120px; background: linear-gradient(135deg, var(--lucy-primary-light), var(--lucy-primary)); display: flex; align-items: center; justify-content: center; font-size: 48px; color: rgba(255,255,255,0.8);">
                                        <c:choose>
                                            <c:when test="${p.code == 'EN'}">🇬🇧</c:when>
                                            <c:when test="${p.code == 'ZH'}">🇨🇳</c:when>
                                            <c:when test="${p.code == 'JA'}">🇯🇵</c:when>
                                            <c:otherwise><i class="bi bi-translate"></i></c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div style="padding: 24px; flex: 1; display: flex; flex-direction: column;">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <h5 style="font-weight: 700; color: #1E293B; margin: 0;">${p.title}</h5>
                                            <span class="badge-status badge-purple">${p.code}</span>
                                        </div>
                                        <p style="font-size: 14px; color: #64748B; flex: 1; margin-bottom: 24px;">${p.description}</p>
                                        <a href="/courses?programId=${p.id}" class="btn btn-outline-lucy w-100">View Courses</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>

</layout:main>
