<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Nạp Credits">

<div class="stat-card" style="max-width: 520px; margin: 0 auto;">
    <h5 style="font-weight: 700; margin-bottom: 20px;">
        <i class="bi bi-coin me-2"></i>Nạp Credits
    </h5>

    <!-- Success/Error banners -->
    <c:if test="${param.success == 'credits_added'}">
        <div class="alert alert-success" role="alert">
            <i class="bi bi-check-circle me-2"></i>
            Đã nạp thành công <strong>${param.amount} credits</strong>!
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>
            <c:choose>
                <c:when test="${param.error == 'insufficient_credits'}">Số dư credits không đủ.</c:when>
                <c:when test="${param.error == 'invalid_amount'}">Số tiền không hợp lệ.</c:when>
                <c:otherwise>Có lỗi xảy ra. Vui lòng thử lại.</c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <!-- Current Balance -->
    <div class="mb-4 p-3" style="background: #F0FDF4; border-radius: 10px; border: 1px solid #BBF7D0;">
        <div style="font-size: 13px; color: #6B7280; margin-bottom: 4px;">Số dư hiện tại</div>
        <div style="font-size: 28px; font-weight: 700; color: #059669;">
            <i class="bi bi-coin me-2"></i>${user.creditBalance} credits
        </div>
        <div style="font-size: 12px; color: #6B7280; margin-top: 4px;">
            Tài khoản: <strong>${user.displayName}</strong> (${user.role})
        </div>
    </div>

    <!-- Top-up Form -->
    <form method="post" action="/billing/topup">
        <input type="hidden" name="userId" value="${user.id}" />
        <div class="mb-3">
            <label class="form-label" style="font-weight: 600;">Số credits muốn nạp</label>
            <select name="amount" class="form-select" required>
                <option value="">— Chọn gói nạp —</option>
                <option value="100">💰 100 credits — Demo Pack</option>
                <option value="500">💰 500 credits — Starter Pack</option>
                <option value="1000">💎 1,000 credits — Pro Pack</option>
                <option value="5000">💎 5,000 credits — Super Pack</option>
            </select>
        </div>
        <div class="mock-banner mb-3">
            <i class="bi bi-info-circle"></i>
            <span>Mock billing — không tính phí thực tế. Dùng để demo hệ thống credits.</span>
        </div>
        <button type="submit" class="btn btn-lucy w-100">
            <i class="bi bi-plus-circle me-2"></i>Xác nhận Nạp Credits
        </button>
    </form>

    <div class="mt-3 text-center">
        <a href="/profile" style="font-size: 13px; color: #6B7280;">← Quay lại Profile</a>
    </div>
</div>

</layout:main>
