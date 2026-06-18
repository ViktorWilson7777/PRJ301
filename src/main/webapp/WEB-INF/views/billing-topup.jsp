<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Top Up Credits">

<style>
    .topup-card {
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 20px;
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
        border-radius: 16px;
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
        border-radius: 12px;
        padding: 16px;
        cursor: pointer;
        text-align: center;
        transition: all 0.2s ease-in-out;
        position: relative;
    }

    .package-option:hover {
        border-color: #4f46e5;
        background: #f5f3ff;
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
        <p class="text-muted" style="font-size: 13px;">Acquire credits to purchase premium lessons and support creators</p>
    </div>

    <!-- Alert Notifications -->
    <c:if test="${param.success == 'credits_added'}">
        <div class="alert alert-success border-0 rounded-3 shadow-sm mb-4 p-3 d-flex align-items-center" role="alert" style="background:#ecfdf5; color:#047857;">
            <i class="bi bi-check-circle-fill me-2 fs-5"></i>
            <div>
                Successfully topped up <strong>${param.amount} credits</strong>!
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
        <div class="balance-value"><i class="bi bi-coin me-1"></i> ${user.creditBalance} credits</div>
        <div style="font-size: 11px; opacity: 0.85; margin-top: 4px;">Logged in as: <strong>${user.displayName}</strong></div>
    </div>

    <form method="post" action="/billing/topup" id="topupForm">
        <input type="hidden" name="userId" value="${user.id}" />
        <input type="hidden" name="amount" id="selectedAmount" value="" />

        <div class="mb-3">
            <label class="form-label" style="font-weight: 600; font-size: 13.5px; color: #1e293b;">Select Top-Up Package</label>
            
            <div class="package-grid">
                <div class="package-option" onclick="selectPackage(this, 100)">
                    <div class="package-title">Demo Pack</div>
                    <div class="package-credits">100 cr</div>
                    <div class="package-desc">Perfect for quick trials</div>
                </div>
                <div class="package-option" onclick="selectPackage(this, 500)">
                    <div class="package-title">Starter Pack</div>
                    <div class="package-credits">500 cr</div>
                    <div class="package-desc">Great to unlock first modules</div>
                </div>
                <div class="package-option" onclick="selectPackage(this, 1000)">
                    <div class="package-title">Pro Pack</div>
                    <div class="package-credits">1,000 cr</div>
                    <div class="package-desc">Best value for core study</div>
                </div>
                <div class="package-option" onclick="selectPackage(this, 5000)">
                    <div class="package-title">Super Pack</div>
                    <div class="package-credits">5,000 cr</div>
                    <div class="package-desc">Unlimited access for creators</div>
                </div>
            </div>
        </div>

        <div class="mock-banner mb-4">
            <i class="bi bi-info-circle-fill"></i>
            <span><strong>Mock Billing:</strong> This is a simulation. No real money will be charged.</span>
        </div>

        <button type="submit" class="btn btn-lucy w-100 py-2.5" id="btnSubmitTopup" disabled>
            <i class="bi bi-check-circle me-1"></i> Confirm Payment & Top-Up
        </button>
    </form>

    <div class="mt-4 text-center">
        <a href="/profile" class="text-decoration-none text-muted" style="font-size: 13px;"><i class="bi bi-arrow-left"></i> Back to Profile</a>
    </div>
</div>

<script>
    function selectPackage(element, amount) {
        // Deselect all
        document.querySelectorAll(".package-option").forEach(el => el.classList.remove("selected"));
        
        // Select current
        element.classList.add("selected");
        
        // Update input
        document.getElementById("selectedAmount").value = amount;
        
        // Enable submit button
        document.getElementById("btnSubmitTopup").disabled = false;
    }
</script>

</layout:main>
