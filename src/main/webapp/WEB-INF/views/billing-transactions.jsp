<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Transactions">

<div class="mock-banner">
    <i class="bi bi-info-circle"></i>
    <span><strong>MOCK BILLING:</strong> All transactions are simulated. No real money involved.</span>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty transactions}">
            <div class="empty-state">
                <i class="bi bi-receipt"></i>
                <p>No transactions yet. Top-up credits or send gifts to see records.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr><th>ID</th><th>User</th><th>Type</th><th>Amount</th><th>Description</th><th>Date</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="tx" items="${transactions}">
                        <tr>
                            <td><strong>#${tx.id}</strong></td>
                            <td><c:if test="${tx.user != null}">${tx.user.displayName}</c:if></td>
                            <td>
                                <c:choose>
                                    <c:when test="${tx.type == 'TOP_UP'}"><span class="badge-status badge-success">Top Up</span></c:when>
                                    <c:when test="${tx.type == 'GIFT_SENT'}"><span class="badge-status badge-danger">Gift Sent</span></c:when>
                                    <c:when test="${tx.type == 'GIFT_RECEIVED'}"><span class="badge-status badge-info">Gift Received</span></c:when>
                                    <c:when test="${tx.type == 'AI_USAGE'}"><span class="badge-status badge-purple">AI Usage</span></c:when>
                                    <c:when test="${tx.type == 'PREMIUM_PURCHASE'}"><span class="badge-status badge-pink">Premium</span></c:when>
                                    <c:otherwise><span class="badge-status badge-gray">${tx.type}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${tx.amount >= 0}"><strong style="color: #059669;">+${tx.amount}</strong></c:when>
                                    <c:otherwise><strong style="color: #DC2626;">${tx.amount}</strong></c:otherwise>
                                </c:choose>
                            </td>
                            <td style="font-size: 12px;">${tx.description}</td>
                            <td style="font-size: 12px;">${tx.createdAt}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
