<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Podcast Episodes">

<c:if test="${param.error == 'access_denied'}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert" style="border-radius: 12px; font-size: 14px;">
        <i class="bi bi-exclamation-triangle-fill me-2"></i> <strong>Access Denied:</strong> You do not have permission to perform that action.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.error == 'upload_failed'}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert" style="border-radius: 12px; font-size: 14px;">
        <i class="bi bi-exclamation-triangle-fill me-2"></i> <strong>Upload Failed:</strong> Could not save the audio file. Please try again.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="d-flex align-items-center justify-content-between mb-4">
    <div>
        <p class="text-muted mb-0" style="font-size: 13px;">
            Manage all podcast episodes
        </p>
    </div>
    <a href="/podcasts/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> Upload Podcast</a>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty podcasts}">
            <div class="empty-state" style="padding: 60px 20px; text-align: center;">
                <i class="bi bi-headphones" style="font-size: 48px; color: #94A3B8;"></i>
                <p style="color: #64748B; margin-top: 16px; font-size: 14px;">No podcast episodes yet. Upload your first audio episode!</p>
                <a href="/podcasts/create" class="btn btn-lucy mt-2"><i class="bi bi-cloud-arrow-up me-1"></i> Upload Now</a>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Creator</th>
                        <th>Audio</th>
                        <th>Duration</th>
                        <th>Status</th>
                        <th style="width:160px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${podcasts}">
                        <tr>
                            <td><strong>#${p.id}</strong></td>
                            <td>
                                ${p.title}
                                <c:if test="${p.isPremium}">
                                    <span class="badge bg-warning text-dark ms-1" style="font-size: 10px;">PREMIUM</span>
                                </c:if>
                            </td>
                            <td><c:if test="${p.creator != null}">${p.creator.displayName}</c:if></td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.audioUrl != null && !p.audioUrl.contains('example.com') && !p.audioUrl.contains('mock-podcast')}">
                                        <span class="badge-status badge-success"><i class="bi bi-check-circle-fill me-1"></i>Uploaded</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-status badge-gray"><i class="bi bi-link-45deg me-1"></i>No audio</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
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
                                <a href="/podcasts/edit/${p.id}" class="btn-action edit" title="Edit"><i class="bi bi-pencil"></i></a>
                                <button class="btn-action delete" onclick="confirmDelete('/podcasts/delete/${p.id}')" title="Delete"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
