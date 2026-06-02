<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Dashboard">

<!-- Stat Cards Row 1 -->
<div class="row g-3 mb-4">
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-2">
                <div class="stat-icon" style="background: #F3E8FF;">
                    <i class="bi bi-collection" style="color: #7C3AED;"></i>
                </div>
                <a href="/programs" class="text-decoration-none" style="font-size: 12px;">View all →</a>
            </div>
            <div class="stat-value">${programCount}</div>
            <div class="stat-label">Programs (Languages)</div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-2">
                <div class="stat-icon" style="background: #EFF6FF;">
                    <i class="bi bi-book" style="color: #2563EB;"></i>
                </div>
                <a href="/courses" class="text-decoration-none" style="font-size: 12px;">View all →</a>
            </div>
            <div class="stat-value">${courseCount}</div>
            <div class="stat-label">Courses (Stages)</div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-2">
                <div class="stat-icon" style="background: #ECFDF5;">
                    <i class="bi bi-calendar-event" style="color: #059669;"></i>
                </div>
                <a href="/course-runs" class="text-decoration-none" style="font-size: 12px;">View all →</a>
            </div>
            <div class="stat-value">${courseRunCount}</div>
            <div class="stat-label">Course Runs</div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-2">
                <div class="stat-icon" style="background: #FFF7ED;">
                    <i class="bi bi-layers" style="color: #EA580C;"></i>
                </div>
                <a href="/chapters" class="text-decoration-none" style="font-size: 12px;">View all →</a>
            </div>
            <div class="stat-value">${chapterCount}</div>
            <div class="stat-label">Chapters (Levels)</div>
        </div>
    </div>
</div>

<!-- Stat Cards Row 2 -->
<div class="row g-3 mb-4">
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-2">
                <div class="stat-icon" style="background: #FDF2F8;">
                    <i class="bi bi-file-earmark-text" style="color: #DB2777;"></i>
                </div>
                <a href="/lessons" class="text-decoration-none" style="font-size: 12px;">View all →</a>
            </div>
            <div class="stat-value">${lessonCount}</div>
            <div class="stat-label">Lessons (SubLevels)</div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-2">
                <div class="stat-icon" style="background: #F0F9FF;">
                    <i class="bi bi-people" style="color: #0284C7;"></i>
                </div>
                <a href="/users" class="text-decoration-none" style="font-size: 12px;">View all →</a>
            </div>
            <div class="stat-value">${userCount}</div>
            <div class="stat-label">Users</div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-2">
                <div class="stat-icon" style="background: #FFFBEB;">
                    <i class="bi bi-mic" style="color: #D97706;"></i>
                </div>
                <a href="/rooms" class="text-decoration-none" style="font-size: 12px;">View all →</a>
            </div>
            <div class="stat-value">${roomCount}</div>
            <div class="stat-label">Live Rooms</div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-2">
                <div class="stat-icon" style="background: #FEF2F2;">
                    <i class="bi bi-cloud-upload" style="color: #DC2626;"></i>
                </div>
                <a href="/import-files" class="text-decoration-none" style="font-size: 12px;">View all →</a>
            </div>
            <div class="stat-value">${importFileCount}</div>
            <div class="stat-label">Import Files</div>
        </div>
    </div>
</div>

<!-- Stat Cards Row 3 -->
<div class="row g-3 mb-4">
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-2">
                <div class="stat-icon" style="background: #F0FDF4;">
                    <i class="bi bi-chat-dots" style="color: #16A34A;"></i>
                </div>
                <a href="/ai-generated-questions" class="text-decoration-none" style="font-size: 12px;">View all →</a>
            </div>
            <div class="stat-value">${aiQuestionCount}</div>
            <div class="stat-label">AI Generated Questions</div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-2">
                <div class="stat-icon" style="background: #FFF1F2;">
                    <i class="bi bi-gift" style="color: #E11D48;"></i>
                </div>
                <a href="/billing/transactions" class="text-decoration-none" style="font-size: 12px;">View all →</a>
            </div>
            <div class="stat-value">${giftTxCount}</div>
            <div class="stat-label">Gift Transactions</div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-2">
                <div class="stat-icon" style="background: #F5F3FF;">
                    <i class="bi bi-headphones" style="color: #7C3AED;"></i>
                </div>
                <a href="/podcasts" class="text-decoration-none" style="font-size: 12px;">View all →</a>
            </div>
            <div class="stat-value">${podcastCount}</div>
            <div class="stat-label">Podcast Episodes</div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="stat-card" style="background: linear-gradient(135deg, #6C5CE7, #A29BFE); border: none;">
            <div class="d-flex align-items-center justify-content-between mb-3">
                <div class="stat-icon" style="background: rgba(255,255,255,0.2);">
                    <i class="bi bi-lightning-charge-fill" style="color: #fff;"></i>
                </div>
            </div>
            <div style="color: rgba(255,255,255,0.85); font-size: 13px; font-weight: 500;">Quick Actions</div>
            <div class="mt-2 d-flex flex-wrap gap-2">
                <a href="/programs/create" class="btn btn-sm" style="background: rgba(255,255,255,0.2); color: #fff; border-radius: 6px; font-size: 11px;">+ Program</a>
                <a href="/courses/create" class="btn btn-sm" style="background: rgba(255,255,255,0.2); color: #fff; border-radius: 6px; font-size: 11px;">+ Course</a>
                <a href="/rooms/create" class="btn btn-sm" style="background: rgba(255,255,255,0.2); color: #fff; border-radius: 6px; font-size: 11px;">+ Room</a>
                <a href="/users/create" class="btn btn-sm" style="background: rgba(255,255,255,0.2); color: #fff; border-radius: 6px; font-size: 11px;">+ User</a>
            </div>
        </div>
    </div>
</div>

<!-- Quick Action Buttons -->
<div class="row g-3">
    <div class="col-12">
        <div class="stat-card">
            <h6 style="font-weight: 600; color: #1A1A2E; margin-bottom: 16px;">
                <i class="bi bi-lightning-charge"></i> Getting Started
            </h6>
            <div class="d-flex flex-wrap gap-2">
                <a href="/import-files/create" class="btn btn-lucy btn-sm"><i class="bi bi-upload me-1"></i> Import DOCX</a>
                <a href="/docx-preview" class="btn btn-outline-lucy btn-sm"><i class="bi bi-eye me-1"></i> Preview DOCX</a>
                <a href="/ai-prompt-templates/create" class="btn btn-outline-lucy btn-sm"><i class="bi bi-cpu me-1"></i> Create AI Template</a>
                <a href="/billing/plans" class="btn btn-outline-lucy btn-sm"><i class="bi bi-credit-card me-1"></i> Manage Plans</a>
                <a href="/swagger-ui/index.html" target="_blank" class="btn btn-outline-lucy btn-sm"><i class="bi bi-braces me-1"></i> API Docs</a>
            </div>
        </div>
    </div>
</div>

</layout:main>
