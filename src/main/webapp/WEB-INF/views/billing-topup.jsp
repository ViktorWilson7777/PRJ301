<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Top Up Credits">

<style>
    .topup-card {
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        padding: 35px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
        max-width: 600px;
        margin: 20px auto;
    }

    .topup-header {
        text-align: center;
        margin-bottom: 24px;
    }

    .topup-icon {
        width: 56px;
        height: 56px;
        background: #fef9c3;
        color: #ca8a04;
        border-radius: 50%;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 26px;
        margin-bottom: 12px;
        box-shadow: 0 4px 10px rgba(202, 138, 4, 0.1);
    }

    .balance-box {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        border-radius: 8px;
        padding: 20px;
        color: #fff;
        text-align: center;
        box-shadow: 0 4px 15px rgba(16, 185, 129, 0.2);
        margin-bottom: 24px;
    }

    .balance-label {
        font-size: 12px;
        text-transform: uppercase;
        letter-spacing: 1px;
        opacity: 0.85;
        font-weight: 600;
        margin-bottom: 4px;
    }

    .balance-value {
        font-size: 30px;
        font-weight: 800;
    }

    .package-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 16px;
        margin-bottom: 24px;
    }

    @media (max-width: 480px) {
        .package-grid {
            grid-template-columns: 1fr;
        }
    }

    .package-option {
        background: #f8fafc;
        border: 2px solid #e2e8f0;
        border-radius: 8px;
        padding: 16px;
        cursor: pointer;
        text-align: center;
        transition: all 0.2s ease-in-out;
        position: relative;
        width: 100%;
        font: inherit;
    }

    .package-option:hover {
        border-color: #4f46e5;
        background: #f5f3ff;
        transform: translateY(-1px);
    }

    .package-option:focus-visible {
        outline: 3px solid rgba(79, 70, 229, 0.22);
        outline-offset: 2px;
    }

    .package-option.selected {
        border-color: #4f46e5;
        background: #e0e7ff;
    }

    .package-option.selected::after {
        content: '✓';
        position: absolute;
        top: 8px;
        right: 12px;
        color: #4f46e5;
        font-weight: 700;
        font-size: 14px;
    }

    .package-title {
        font-weight: 700;
        color: #1e293b;
        font-size: 14px;
        margin-bottom: 4px;
    }

    .package-credits {
        font-size: 20px;
        font-weight: 800;
        color: #4f46e5;
    }

    .package-desc {
        font-size: 11px;
        color: #64748b;
        margin-top: 4px;
    }
</style>

<div class="topup-card">
    <div class="topup-header">
        <div class="topup-icon">
            <i class="bi bi-coin"></i>
        </div>
        <h4 style="font-weight: 800; color: #1e293b;">Top Up Credits</h4>
        <p class="text-muted" style="font-size:13px">Demo mode: credits are added instantly with no bank payment.</p>
    </div>

    <!-- Alert Notifications -->
    <c:if test="${param.success == 'credits_added'}">
        <div class="alert alert-success border-0 rounded-3 shadow-sm mb-4 p-3 d-flex align-items-center" role="alert" style="background:#ecfdf5; color:#047857;">
            <i class="bi bi-check-circle-fill me-2 fs-5"></i>
            <div>
                Successfully topped up <strong><fmt:formatNumber value="${param.amount}" pattern="#,##0"/> credits</strong>!
            </div>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger border-0 rounded-3 shadow-sm mb-4 p-3 d-flex align-items-center" role="alert" style="background:#fef2f2; color:#b91c1c;">
            <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
            <div>
                <c:choose>
                    <c:when test="${param.error == 'invalid_amount'}">Invalid top-up credit amount.</c:when>
                    <c:otherwise>An error occurred. Please try again.</c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:if>

    <!-- Balance display -->
    <div class="balance-box">
        <div class="balance-label">Current Balance</div>
        <div class="balance-value"><i class="bi bi-coin me-1"></i> <fmt:formatNumber value="${user.creditBalance}" pattern="#,##0"/> credits</div>
        <div style="font-size: 11px; opacity: 0.85; margin-top: 4px;">Logged in as: <strong>${user.displayName}</strong></div>
    </div>

    <form method="post" action="/billing/topup">
        <div class="mb-3">
            <label class="form-label" style="font-weight: 600; font-size: 13.5px; color: #1e293b;">Select Top-Up Package</label>

            <div class="package-grid">
                <button type="submit" name="amount" value="20000" class="package-option">
                    <span class="package-title d-block">Starter Pack</span>
                    <span class="package-credits d-block">20,000 cr</span>
                    <span class="package-desc d-block">20,000 VND</span>
                </button>
                <button type="submit" name="amount" value="50000" class="package-option">
                    <span class="package-title d-block">Plus Pack</span>
                    <span class="package-credits d-block">50,000 cr</span>
                    <span class="package-desc d-block">50,000 VND</span>
                </button>
                <button type="submit" name="amount" value="100000" class="package-option">
                    <span class="package-title d-block">Pro Pack</span>
                    <span class="package-credits d-block">100,000 cr</span>
                    <span class="package-desc d-block">100,000 VND</span>
                </button>
                <button type="submit" name="amount" value="200000" class="package-option">
                    <span class="package-title d-block">Creator Pack</span>
                    <span class="package-credits d-block">200,000 cr</span>
                    <span class="package-desc d-block">200,000 VND</span>
                </button>
            </div>
        </div>

        <div class="mock-banner mb-4">
            <i class="bi bi-info-circle-fill"></i>
            <span><strong>Mock Billing:</strong> This is a simulation. No real money will be charged.</span>
        </div>

    </form>

    <div class="mt-4 text-center">
        <a href="/profile" class="text-decoration-none text-muted" style="font-size: 13px;"><i class="bi bi-arrow-left"></i> Back to Profile</a>
    </div>
</div>

</layout:main>
