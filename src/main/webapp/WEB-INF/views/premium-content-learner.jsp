<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="LUCY Premium Store">

<style>
    .premium-banner {
        background: linear-gradient(135deg, #1e1b4b 0%, #311042 100%);
        border: 1px solid rgba(253, 224, 71, 0.2);
        border-radius: 20px;
        padding: 40px;
        color: #fff;
        position: relative;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        margin-bottom: 30px;
    }

    .premium-banner::after {
        content: '⭐';
        position: absolute;
        right: -30px;
        bottom: -30px;
        font-size: 200px;
        opacity: 0.05;
        transform: rotate(-15deg);
    }

    .premium-title {
        font-size: 28px;
        font-weight: 800;
        letter-spacing: -0.5px;
        margin-bottom: 10px;
    }

    .premium-subtitle {
        font-size: 14px;
        color: #cbd5e1;
        max-width: 600px;
        line-height: 1.6;
    }

    .grid-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 24px;
        margin-top: 10px;
    }

    .premium-card {
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 16px;
        overflow: hidden;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        display: flex;
        flex-direction: column;
        height: 100%;
        position: relative;
    }

    .premium-card:hover {
        transform: translateY(-6px);
        box-shadow: 0 12px 30px rgba(0,0,0,0.08);
        border-color: #fde047;
    }

    .card-top {
        padding: 24px 24px 16px;
        position: relative;
        flex-grow: 1;
    }

    .card-badge {
        position: absolute;
        top: 24px;
        right: 24px;
        background: #fef9c3;
        color: #854d0e;
        border: 1px solid #fef08a;
        font-weight: 700;
        font-size: 12px;
        padding: 4px 10px;
        border-radius: 20px;
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .card-badge.unlocked {
        background: #d1fae5;
        color: #065f46;
        border-color: #a7f3d0;
    }

    .card-creator {
        font-size: 12px;
        font-weight: 600;
        color: #64748b;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 8px;
    }

    .card-title {
        font-size: 18px;
        font-weight: 700;
        color: #1e293b;
        line-height: 1.4;
        margin-bottom: 12px;
        padding-right: 80px; /* Avoid overlap with badge */
    }

    .card-desc {
        font-size: 13.5px;
        color: #64748b;
        line-height: 1.5;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .card-bottom {
        padding: 16px 24px 24px;
        border-top: 1px solid #f1f5f9;
        background: #f8fafc;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .price-lbl {
        font-size: 11px;
        color: #94a3b8;
        text-transform: uppercase;
        font-weight: 600;
    }

    .price-val {
        font-size: 20px;
        font-weight: 800;
        color: #1e293b;
    }

    .btn-buy {
        background: linear-gradient(135deg, #4f46e5, #6366f1);
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 10px 20px;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.2s;
        box-shadow: 0 4px 10px rgba(79, 70, 229, 0.2);
    }

    .btn-buy:hover {
        background: linear-gradient(135deg, #4338ca, #4f46e5);
        transform: translateY(-1px);
        box-shadow: 0 6px 15px rgba(79, 70, 229, 0.3);
        color: #fff;
    }

    .btn-view {
        background: linear-gradient(135deg, #10b981, #059669);
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 10px 20px;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.2s;
        box-shadow: 0 4px 10px rgba(16, 185, 129, 0.2);
    }

    .btn-view:hover {
        background: linear-gradient(135deg, #059669, #047857);
        transform: translateY(-1px);
        box-shadow: 0 6px 15px rgba(16, 185, 129, 0.3);
        color: #fff;
    }
</style>

<!-- Alert Banners -->
<c:if test="${not empty param.success}">
    <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm rounded-4 mb-4 p-3" role="alert" style="background:#e6fffa; color:#0d9488;">
        <div class="d-flex align-items-center">
            <i class="bi bi-patch-check-fill me-2 fs-5"></i>
            <div>
                <strong>Unlock Successful!</strong> You have unlocked the premium content and received lifetime access.
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<c:if test="${not empty param.error}">
    <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm rounded-4 mb-4 p-3" role="alert" style="background:#fff5f5; color:#e11d48;">
        <div class="d-flex align-items-center">
            <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
            <div>
                <c:choose>
                    <c:when test="${param.error == 'insufficient_credits'}">
                        <strong>Insufficient Credit Balance!</strong> Please top up your wallet to unlock this premium content.
                    </c:when>
                    <c:otherwise>
                        <strong>Purchase Failed!</strong> Something went wrong during transaction processing. Please try again.
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<div class="premium-banner">
    <div class="premium-title">⭐ LUCY Premium Content Store</div>
    <div class="premium-subtitle">
        Invest your credits to unlock premium, high-quality classes, private webinar recordings, and structured study plans built by our top Super Creators.
    </div>
</div>

<div class="grid-container">
    <c:choose>
        <c:when test="${empty contents}">
            <div class="p-5 text-center text-muted bg-white border rounded-4 w-100 col-span-3">
                <i class="bi bi-star-half" style="font-size: 48px; color: #fbbf24;"></i>
                <h5 class="mt-3">Premium Store is Empty</h5>
                <p>Check back later for premium study contents.</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="c" items="${contents}">
                <c:set var="isUnlocked" value="${unlockedIds.contains(c.id)}" />
                <div class="premium-card">
                    <div class="card-top">
                        <c:choose>
                            <c:when test="${isUnlocked}">
                                <div class="card-badge unlocked"><i class="bi bi-unlock-fill"></i> Unlocked</div>
                            </c:when>
                            <c:otherwise>
                                <div class="card-badge"><i class="bi bi-lock-fill"></i> Locked</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="card-creator">Creator: ${c.creator.displayName}</div>
                        <div class="card-title">${c.title}</div>
                        <div class="card-desc">${c.description}</div>
                    </div>

                    <div class="card-bottom">
                        <div>
                            <div class="price-lbl">Cost</div>
                            <div class="price-val">${c.priceCredits} cr</div>
                        </div>
                        <div>
                            <c:choose>
                                <c:when test="${isUnlocked}">
                                    <a href="/premium-content/view/${c.id}" class="btn-view"><i class="bi bi-eye-fill me-1"></i> Access</a>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn-buy" onclick="confirmPurchase(this)" data-id="${c.id}" data-title="${c.title}" data-cost="${c.priceCredits}">
                                        <i class="bi bi-unlock-fill me-1"></i> Unlock
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<!-- Purchase Confirmation Modal -->
<div class="modal fade" id="purchaseModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 16px; border: none; overflow: hidden; box-shadow: 0 15px 40px rgba(0,0,0,0.15);">
            <div class="modal-header border-0 pb-0 pt-4 px-4">
                <h5 class="modal-title" style="font-weight: 700; color: #1e293b;">Confirm Premium Purchase</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="purchaseForm" method="post" action="">
                <div class="modal-body p-4">
                    <p class="text-muted" style="font-size: 14px; line-height: 1.5;">
                        Are you sure you want to purchase and unlock:
                    </p>
                    <div class="p-3 mb-3 rounded-3" style="background:#f8fafc; border:1px solid #e2e8f0;">
                        <div class="fw-bold text-dark" id="modalContentTitle" style="font-size:15px;">Content Title</div>
                        <div class="text-muted mt-1" style="font-size: 12.5px;">Cost: <span class="fw-bold text-warning" id="modalContentCost">0</span> credits</div>
                    </div>
                    <p class="text-muted mb-0" style="font-size: 12.5px;">
                        * Your current wallet balance: <strong>${sessionScope.currentUser.creditBalance} credits</strong>.
                    </p>
                </div>
                <div class="modal-footer border-0 p-4 pt-0">
                    <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal" style="border-radius: 10px;">Cancel</button>
                    <button type="submit" class="btn btn-lucy px-4" style="border-radius: 10px;">Unlock Now</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function confirmPurchase(btn) {
        var id = btn.getAttribute("data-id");
        var title = btn.getAttribute("data-title");
        var cost = btn.getAttribute("data-cost");

        document.getElementById("purchaseForm").action = "/premium-content/buy/" + id;
        document.getElementById("modalContentTitle").textContent = title;
        document.getElementById("modalContentCost").textContent = cost;
        new bootstrap.Modal(document.getElementById("purchaseModal")).show();
    }
</script>

</layout:main>
