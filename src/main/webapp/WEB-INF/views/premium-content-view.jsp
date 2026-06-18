<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Unlocked Premium Content">

<style>
    .back-btn {
        color: #4f46e5;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        margin-bottom: 20px;
        transition: all 0.2s;
    }
    .back-btn:hover {
        color: #4338ca;
        transform: translateX(-2px);
    }

    .detail-card {
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 20px;
        padding: 40px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.02);
    }

    .content-header {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        border-bottom: 1px solid #f1f5f9;
        padding-bottom: 24px;
        margin-bottom: 24px;
    }

    .content-badge {
        background: #ecfdf5;
        color: #047857;
        font-size: 12px;
        font-weight: 700;
        padding: 6px 14px;
        border-radius: 30px;
        border: 1px solid #a7f3d0;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .content-title {
        font-size: 26px;
        font-weight: 800;
        color: #1e293b;
        margin-top: 12px;
    }

    .creator-info {
        font-size: 14px;
        color: #64748b;
        display: flex;
        align-items: center;
        gap: 8px;
        margin-top: 8px;
    }

    .creator-avatar {
        width: 28px;
        height: 28px;
        border-radius: 50%;
        background: #4f46e5;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 12px;
    }

    .content-body {
        font-size: 15px;
        color: #334155;
        line-height: 1.7;
    }

    .linked-item-card {
        background: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 14px;
        padding: 20px;
        margin-top: 30px;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .linked-icon {
        width: 44px;
        height: 44px;
        border-radius: 10px;
        background: #e0e7ff;
        color: #4f46e5;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
    }

    .linked-info {
        flex-grow: 1;
        margin-left: 16px;
    }

    .linked-label {
        font-size: 11px;
        color: #94a3b8;
        text-transform: uppercase;
        font-weight: 700;
    }

    .linked-title {
        font-size: 15px;
        font-weight: 700;
        color: #1e293b;
    }

    .btn-study {
        background: #4f46e5;
        color: white;
        border: none;
        border-radius: 8px;
        padding: 8px 16px;
        font-size: 13px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.2s;
    }
    .btn-study:hover {
        background: #4338ca;
        color: white;
    }
</style>

<a href="/premium-content" class="back-btn"><i class="bi bi-arrow-left"></i> Back to Premium Store</a>

<div class="detail-card">
    <div class="content-header">
        <div>
            <div class="content-badge"><i class="bi bi-patch-check-fill"></i> Unlocked Lifetime Access</div>
            <h1 class="content-title">${content.title}</h1>
            <div class="creator-info">
                <div class="creator-avatar">${content.creator.displayName.substring(0,1).toUpperCase()}</div>
                <span>Curated by <strong>${content.creator.displayName}</strong></span>
            </div>
        </div>
        <div class="text-end text-muted" style="font-size: 12px;">
            Unlocked: ${content.createdAt.toLocalDate()}
        </div>
    </div>

    <div class="content-body">
        <h5 class="fw-bold mb-3">About this Content</h5>
        <p>${content.description}</p>
    </div>

    <!-- Linked Course / Chapter Action -->
    <c:if test="${content.course != null}">
        <div class="linked-item-card">
            <div class="d-flex align-items-center">
                <div class="linked-icon">
                    <i class="bi bi-book"></i>
                </div>
                <div class="linked-info">
                    <div class="linked-label">Associated Course</div>
                    <div class="linked-title">${content.course.name} (${content.course.code})</div>
                </div>
            </div>
            <div>
                <a href="/courses" class="btn-study">Start Course <i class="bi bi-chevron-right ms-1"></i></a>
            </div>
        </div>
    </c:if>

    <c:if test="${content.chapter != null}">
        <div class="linked-item-card animate__animated animate__fadeIn">
            <div class="d-flex align-items-center">
                <div class="linked-icon">
                    <i class="bi bi-layers"></i>
                </div>
                <div class="linked-info">
                    <div class="linked-label">Associated Chapter</div>
                    <div class="linked-title">${content.chapter.name}</div>
                </div>
            </div>
            <div>
                <a href="/chapters" class="btn-study">Study Chapter <i class="bi bi-chevron-right ms-1"></i></a>
            </div>
        </div>
    </c:if>
</div>

</layout:main>
