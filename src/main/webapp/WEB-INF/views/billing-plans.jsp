<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Billing Plans">

<div class="mock-banner">
    <i class="bi bi-info-circle"></i>
    <span><strong>MOCK BILLING / SANDBOX DEMO:</strong> No real payments. All billing features are simulated for demo purposes.</span>
</div>

<div class="d-flex align-items-center justify-content-between mb-4">
    <p class="text-muted mb-0" style="font-size: 13px;">Manage subscription plans (Free, Pro, Super)</p>
    <a href="/billing/plans/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Plan</a>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty plans}">
            <div class="empty-state">
                <i class="bi bi-credit-card-2-front"></i>
                <p>No billing plans yet.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr><th>ID</th><th>Name</th><th>Price</th><th>AI Limit</th><th>Import Limit</th><th>Max Room</th><th>Podcast</th><th>Active</th><th style="width:100px;">Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${plans}">
                        <tr>
                            <td><strong>#${p.id}</strong></td>
                            <td><strong>${p.name}</strong></td>
                            <td>$${p.price}</td>
                            <td>${p.monthlyAiLimit}/mo</td>
                            <td>${p.monthlyImportLimit}/mo</td>
                            <td>${p.maxRoomParticipants}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.allowPodcastRecording}"><span class="badge-status badge-success">Yes</span></c:when>
                                    <c:otherwise><span class="badge-status badge-gray">No</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.active}"><span class="badge-status badge-success">Active</span></c:when>
                                    <c:otherwise><span class="badge-status badge-gray">Inactive</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="/billing/plans/edit/${p.id}" class="btn-action edit"><i class="bi bi-pencil"></i></a>
                                <button class="btn-action delete" onclick="confirmDelete('/billing/plans/delete/${p.id}')"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
