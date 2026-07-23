<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Gifts">

<c:if test="${param.error == 'invalid_image'}"><div class="alert alert-danger">The sticker must be a valid PNG, JPG or GIF under 3 MB and 4096 x 4096 px.</div></c:if>
<c:if test="${param.error == 'image_required'}"><div class="alert alert-danger">Please upload a sticker image for this gift.</div></c:if>
<c:if test="${param.error == 'upload_failed'}"><div class="alert alert-danger">The sticker could not be saved. Please try again.</div></c:if>
<c:if test="${param.error == 'invalid_price'}"><div class="alert alert-danger">Gift price must be at least 1,000 credits.</div></c:if>

<div class="mock-banner">
    <i class="bi bi-info-circle"></i>
    <span><strong>MOCK BILLING:</strong> Virtual gifts — no real purchases.</span>
</div>

<div class="d-flex align-items-center justify-content-between mb-4">
    <p class="text-muted mb-0" style="font-size: 13px;">Manage virtual gift types for live rooms</p>
    <a href="/gifts/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Gift</a>
</div>

<div class="lucy-table mb-4">
    <c:choose>
        <c:when test="${empty gifts}">
            <div class="empty-state">
                <i class="bi bi-gift"></i>
                <p>No gifts yet. Create gifts like Star, Coffee, Firework.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr><th>ID</th><th>Sticker</th><th>Name</th><th>Credit Cost</th><th>Active</th><th style="width:100px;">Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="g" items="${gifts}">
                        <tr>
                            <td><strong>#${g.id}</strong></td>
                            <td><c:choose><c:when test="${not empty g.imageUrl}"><img src="${g.imageUrl}" alt="${g.name}" style="width:64px;height:64px;object-fit:contain;border-radius:14px;background:#f8fafc;padding:5px" /></c:when><c:otherwise><i class="bi bi-gift-fill text-muted" style="font-size:32px"></i></c:otherwise></c:choose></td>
                            <td><strong>${g.name}</strong></td>
                            <td><fmt:formatNumber value="${g.creditCost}" pattern="#,##0"/> credits</td>
                            <td>
                                <c:choose>
                                    <c:when test="${g.active}"><span class="badge-status badge-success">Active</span></c:when>
                                    <c:otherwise><span class="badge-status badge-gray">Inactive</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="/gifts/edit/${g.id}" class="btn-action edit"><i class="bi bi-pencil"></i></a>
                                <button class="btn-action delete" onclick="confirmDelete('/gifts/delete/${g.id}')"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<c:if test="${not empty giftTransactions}">
    <h6 style="font-weight: 600; margin-bottom: 12px;"><i class="bi bi-clock-history me-1"></i> Recent Gift Transactions</h6>
    <div class="lucy-table">
        <table class="table mb-0">
            <thead><tr><th>Gift</th><th>Sender</th><th>Receiver</th><th>Room</th><th>Credits</th><th>Date</th></tr></thead>
            <tbody>
                <c:forEach var="txn" items="${giftTransactions}">
                    <tr>
                        <td><span class="d-inline-flex align-items-center gap-2"><c:choose><c:when test="${not empty txn.gift.imageUrl}"><img src="${txn.gift.imageUrl}" alt="${txn.gift.name}" style="width:38px;height:38px;object-fit:contain" /></c:when><c:otherwise><i class="bi bi-gift-fill text-muted"></i></c:otherwise></c:choose><strong>${txn.gift.name}</strong></span></td>
                        <td><c:if test="${txn.sender != null}">${txn.sender.displayName}</c:if></td>
                        <td><c:if test="${txn.receiver != null}">${txn.receiver.displayName}</c:if></td>
                        <td><c:if test="${txn.room != null}">${txn.room.title}</c:if></td>
                        <td><strong><fmt:formatNumber value="${txn.creditAmount}" pattern="#,##0"/></strong></td>
                        <td style="font-size: 12px;">${txn.createdAt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

</layout:main>
