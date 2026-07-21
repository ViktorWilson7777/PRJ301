<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Podcast Episodes">

<style>
    .podcast-management-header{display:flex;align-items:center;justify-content:space-between;gap:16px;margin-bottom:20px}.podcast-management-header h2{font-size:20px;line-height:1.3;margin:0 0 3px;font-weight:750;color:#101828}.podcast-action-group{display:flex;align-items:center;gap:8px;flex-wrap:wrap}
    .storage-panel{display:grid;grid-template-columns:minmax(0,1fr) auto;align-items:center;gap:22px;border:1px solid #DDE3EC;border-radius:8px;background:#fff;padding:18px 20px;margin-bottom:20px}.storage-heading{display:flex;align-items:center;justify-content:space-between;gap:12px;margin-bottom:10px}.storage-heading strong{font-size:15px;color:#101828}.storage-heading span{font-size:13px;color:#475467}.storage-track{height:8px;border-radius:4px;background:#EAECF0;overflow:hidden}.storage-fill{height:100%;border-radius:4px;background:#6558E8;min-width:2px}.storage-terms{font-size:12px;color:#667085;margin:8px 0 0}.storage-buy{min-width:225px}.storage-buy .btn{width:100%}
    @media(max-width:760px){.podcast-management-header,.storage-panel{align-items:stretch;grid-template-columns:1fr;flex-direction:column}.podcast-action-group{display:grid;grid-template-columns:1fr 1fr}.podcast-action-group .btn:last-child{grid-column:1/-1}.storage-buy{min-width:0}.lucy-table{overflow-x:auto}.lucy-table table{min-width:900px}}
</style>

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
<c:if test="${param.error == 'insufficient_credits'}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert" style="border-radius: 8px; font-size: 14px;">
        <i class="bi bi-exclamation-triangle-fill me-2"></i> You need 100,000 credits to add 15MB of podcast storage.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.success == 'storage_added'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert" style="border-radius: 8px; font-size: 14px;">
        <i class="bi bi-check-circle-fill me-2"></i> 15MB has been added to your podcast storage.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="podcast-management-header">
    <div>
        <h2><c:choose><c:when test="${managementMode == 'own'}">My Podcasts</c:when><c:otherwise>Podcast Management</c:otherwise></c:choose></h2>
        <p class="text-muted mb-0" style="font-size: 13px;">
            <c:choose><c:when test="${managementMode == 'own'}">Manage your uploaded episodes</c:when><c:otherwise>Manage all podcast episodes</c:otherwise></c:choose>
        </p>
    </div>
    <div class="podcast-action-group">
        <a href="/podcasts/search" class="btn btn-outline-secondary" title="Search podcasts">
            <i class="bi bi-search me-1"></i> Search
        </a>
        <a href="/podcasts/library" class="btn btn-outline-secondary" title="Open your library">
            <i class="bi bi-collection-play me-1"></i> Library
        </a>
        <a href="/podcasts/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> Upload Podcast</a>
    </div>
</div>

<c:if test="${managementMode == 'own'}">
    <section class="storage-panel" aria-labelledby="podcastStorageTitle">
        <div>
            <div class="storage-heading">
                <strong id="podcastStorageTitle"><i class="bi bi-device-ssd me-1"></i> Podcast storage</strong>
                <span><fmt:formatNumber value="${storageUsedBytes / 1048576.0}" maxFractionDigits="2"/> MB / <fmt:formatNumber value="${storageLimitBytes / 1048576.0}" maxFractionDigits="0"/> MB</span>
            </div>
            <div class="storage-track" role="progressbar" aria-valuenow="${storagePercent}" aria-valuemin="0" aria-valuemax="100">
                <div class="storage-fill" style="width:${storagePercent}%;"></div>
            </div>
            <p class="storage-terms">20MB included. Each storage expansion adds 15MB.</p>
        </div>
        <form class="storage-buy" method="post" action="${pageContext.request.contextPath}/podcasts/storage/buy">
            <button type="submit" class="btn btn-outline-primary" title="Buy 15MB podcast storage">
                <i class="bi bi-database-add me-1"></i> Add 15MB - <fmt:formatNumber value="${storageExpansionCost}" pattern="#,#00"/> cr
            </button>
        </form>
    </section>
</c:if>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty podcasts}">
            <div class="empty-state" style="padding: 60px 20px; text-align: center;">
                <i class="bi bi-headphones" style="font-size: 48px; color: #94A3B8;"></i>
                <p style="color: #64748B; margin-top: 16px; font-size: 14px;"><c:choose><c:when test="${managementMode == 'own'}">You have not uploaded any podcasts yet.</c:when><c:otherwise>No podcast episodes yet.</c:otherwise></c:choose></p>
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
                        <th>File size</th>
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
                            <td>
                                <c:choose>
                                    <c:when test="${p.fileSizeBytes >= 1048576}"><fmt:formatNumber value="${p.fileSizeBytes / 1048576.0}" maxFractionDigits="2"/> MB</c:when>
                                    <c:when test="${p.fileSizeBytes >= 1024}"><fmt:formatNumber value="${p.fileSizeBytes / 1024.0}" maxFractionDigits="1"/> KB</c:when>
                                    <c:when test="${p.fileSizeBytes > 0}">${p.fileSizeBytes} B</c:when>
                                    <c:otherwise><span class="text-muted">Unknown</span></c:otherwise>
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
                                    <a href="/podcasts/publish/${p.id}" class="btn-action edit" title="Publish"><i class="bi bi-check-circle"></i></a>
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
