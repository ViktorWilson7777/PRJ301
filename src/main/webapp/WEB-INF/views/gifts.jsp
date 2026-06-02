<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Gifts">

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
                    <tr><th>ID</th><th>Icon</th><th>Name</th><th>Credit Cost</th><th>Active</th><th style="width:100px;">Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="g" items="${gifts}">
                        <tr>
                            <td><strong>#${g.id}</strong></td>
                            <td style="font-size: 24px;">${g.icon}</td>
                            <td><strong>${g.name}</strong></td>
                            <td>${g.creditCost} credits</td>
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
                <c:forEach var="gt" items="${giftTransactions}">
                    <tr>
                        <td>${gt.gift.icon} ${gt.gift.name}</td>
                        <td><c:if test="${gt.sender != null}">${gt.sender.displayName}</c:if></td>
                        <td><c:if test="${gt.receiver != null}">${gt.receiver.displayName}</c:if></td>
                        <td><c:if test="${gt.room != null}">${gt.room.title}</c:if></td>
                        <td><strong>${gt.creditAmount}</strong></td>
                        <td style="font-size: 12px;">${gt.createdAt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

</layout:main>
