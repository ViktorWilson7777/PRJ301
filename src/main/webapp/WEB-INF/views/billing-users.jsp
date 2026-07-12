<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="User Wallets">

<div class="mock-banner">
    <i class="bi bi-info-circle"></i>
    <span><strong>MOCK BILLING:</strong> Credits are virtual. Top-up is simulated.</span>
</div>

<div class="row mb-4">
    <div class="col-lg-5">
        <div class="stat-card">
            <h6 style="font-weight: 600; margin-bottom: 12px;"><i class="bi bi-wallet2 me-1"></i> Mock Top-Up Credits</h6>
            <form method="post" action="/billing/users/topup" class="d-flex gap-2 align-items-end">
                <div style="flex: 1;">
                    <label class="form-label" style="font-size: 12px;">User</label>
                    <select name="userId" class="form-select form-select-sm" data-live-search required>
                        <option value="">— Select User —</option>
                        <c:forEach var="u" items="${users}">
                            <option value="${u.id}">${u.displayName} (${u.creditBalance} credits)</option>
                        </c:forEach>
                    </select>
                </div>
                <div style="width: 120px;">
                    <label class="form-label" style="font-size: 12px;">Amount</label>
                    <input type="number" name="amount" class="form-control form-control-sm" min="1" value="100" required />
                </div>
                <button type="submit" class="btn btn-lucy btn-sm"><i class="bi bi-plus-lg me-1"></i> Top Up</button>
            </form>
        </div>
    </div>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty users}">
            <div class="empty-state">
                <i class="bi bi-wallet2"></i>
                <p>No users. Create users first.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr><th>ID</th><th>Name</th><th>Display</th><th>Role</th><th>Credit Balance</th><th>Reputation</th><th>Status</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td><strong>#${u.id}</strong></td>
                            <td>${u.fullName}</td>
                            <td>${u.displayName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.role == 'ADMIN'}"><span class="badge-status badge-danger">Admin</span></c:when>
                                    <c:when test="${u.role == 'LEARNER'}"><span class="badge-status badge-info">Learner</span></c:when>
                                    <c:when test="${u.role == 'PRO_MENTOR'}"><span class="badge-status badge-purple">Pro Mentor</span></c:when>
                                    <c:when test="${u.role == 'SUPER_CREATOR'}"><span class="badge-status badge-pink">Super Creator</span></c:when>
                                    <c:otherwise><span class="badge-status badge-gray">${u.role}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td><strong style="font-size: 16px; color: #059669;">${u.creditBalance}</strong> credits</td>
                            <td><i class="bi bi-star-fill me-1" style="color: #D97706;"></i>${u.reputationScore}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.active}"><span class="badge-status badge-success">Active</span></c:when>
                                    <c:otherwise><span class="badge-status badge-gray">Inactive</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
