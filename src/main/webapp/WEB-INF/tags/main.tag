<%@ tag description="LUCY Admin Layout" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="pageTitle" required="true" type="java.lang.String" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} — LUCY Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --lucy-primary: #6C5CE7;
            --lucy-primary-light: #A29BFE;
            --lucy-accent: #00CEC9;
            --lucy-accent2: #FD79A8;
            --lucy-dark: #0F0E17;
            --lucy-dark2: #1A1929;
            --lucy-dark3: #232336;
            --lucy-surface: #2D2B47;
            --lucy-text: #FFFFFE;
            --lucy-text-muted: #94A1B2;
            --lucy-success: #00B894;
            --lucy-warning: #FDCB6E;
            --lucy-danger: #E17055;
            --lucy-info: #74B9FF;
            --sidebar-width: 260px;
        }
        * { font-family: 'Inter', sans-serif; }
        body {
            background: #F0F2F5;
            margin: 0;
            min-height: 100vh;
        }
        /* ── Sidebar ── */
        .lucy-sidebar {
            position: fixed;
            top: 0; left: 0;
            width: var(--sidebar-width);
            height: 100vh;
            background: linear-gradient(180deg, var(--lucy-dark) 0%, var(--lucy-dark2) 100%);
            z-index: 1000;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            transition: transform 0.3s;
            scrollbar-width: thin;
            scrollbar-color: var(--lucy-dark3) transparent;
        }
        .lucy-sidebar::-webkit-scrollbar { width: 4px; }
        .lucy-sidebar::-webkit-scrollbar-thumb { background: var(--lucy-dark3); border-radius: 4px; }
        .lucy-brand {
            padding: 24px 20px 20px;
            display: flex; align-items: center; gap: 12px;
            border-bottom: 1px solid rgba(255,255,255,0.06);
        }
        .lucy-brand-icon {
            width: 42px; height: 42px;
            background: linear-gradient(135deg, var(--lucy-primary), var(--lucy-accent));
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px; color: #fff;
            box-shadow: 0 4px 15px rgba(108,92,231,0.4);
        }
        .lucy-brand-text {
            color: var(--lucy-text);
            font-size: 18px; font-weight: 700; letter-spacing: 1px;
        }
        .lucy-brand-sub {
            color: var(--lucy-text-muted);
            font-size: 10px; letter-spacing: 1.5px; text-transform: uppercase;
        }
        .nav-group-label {
            color: var(--lucy-text-muted);
            font-size: 10px; font-weight: 600;
            letter-spacing: 1.5px; text-transform: uppercase;
            padding: 20px 20px 8px;
        }
        .lucy-nav-link {
            display: flex; align-items: center; gap: 10px;
            padding: 10px 20px;
            color: var(--lucy-text-muted);
            text-decoration: none;
            font-size: 13.5px; font-weight: 400;
            transition: all 0.2s;
            border-left: 3px solid transparent;
        }
        .lucy-nav-link:hover {
            color: var(--lucy-text);
            background: rgba(255,255,255,0.04);
            border-left-color: var(--lucy-primary-light);
        }
        .lucy-nav-link.active {
            color: var(--lucy-text);
            background: rgba(108,92,231,0.15);
            border-left-color: var(--lucy-primary);
            font-weight: 500;
        }
        .lucy-nav-link i { font-size: 16px; width: 20px; text-align: center; }

        /* ── Main Content ── */
        .lucy-main {
            margin-left: var(--sidebar-width);
            min-height: 100vh;
        }
        .lucy-topbar {
            background: #fff;
            padding: 16px 32px;
            border-bottom: 1px solid #E8ECF1;
            display: flex; align-items: center; justify-content: space-between;
            position: sticky; top: 0; z-index: 100;
            box-shadow: 0 1px 3px rgba(0,0,0,0.04);
        }
        .lucy-topbar h1 {
            font-size: 20px; font-weight: 600; color: #1A1A2E; margin: 0;
        }
        .lucy-topbar .badge-env {
            background: linear-gradient(135deg, var(--lucy-primary), var(--lucy-accent));
            color: #fff; font-size: 11px; font-weight: 500;
            padding: 4px 12px; border-radius: 20px;
        }
        .lucy-content { padding: 28px 32px; }

        /* ── Cards ── */
        .stat-card {
            background: #fff;
            border-radius: 14px;
            padding: 22px;
            border: 1px solid #E8ECF1;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }
        .stat-icon {
            width: 46px; height: 46px;
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px;
        }
        .stat-value { font-size: 28px; font-weight: 700; color: #1A1A2E; }
        .stat-label { font-size: 12.5px; color: #6B7280; font-weight: 500; }

        /* ── Tables ── */
        .lucy-table {
            background: #fff;
            border-radius: 14px;
            border: 1px solid #E8ECF1;
            overflow: hidden;
        }
        .lucy-table table { margin: 0; }
        .lucy-table thead th {
            background: #F8F9FB;
            font-size: 12px; font-weight: 600;
            color: #6B7280; text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 14px 16px;
            border-bottom: 1px solid #E8ECF1;
        }
        .lucy-table tbody td {
            padding: 14px 16px;
            font-size: 13.5px;
            color: #374151;
            vertical-align: middle;
            border-bottom: 1px solid #F3F4F6;
        }
        .lucy-table tbody tr:hover { background: #F8F9FB; }
        .lucy-table tbody tr:last-child td { border-bottom: none; }

        /* ── Badges ── */
        .badge-status {
            font-size: 11px; font-weight: 600;
            padding: 4px 10px; border-radius: 6px;
        }
        .badge-success { background: #ECFDF5; color: #059669; }
        .badge-warning { background: #FFFBEB; color: #D97706; }
        .badge-danger  { background: #FEF2F2; color: #DC2626; }
        .badge-info    { background: #EFF6FF; color: #2563EB; }
        .badge-purple  { background: #F3E8FF; color: #7C3AED; }
        .badge-pink    { background: #FDF2F8; color: #DB2777; }
        .badge-gray    { background: #F3F4F6; color: #6B7280; }

        /* ── Buttons ── */
        .btn-lucy {
            background: linear-gradient(135deg, var(--lucy-primary), #8B5CF6);
            color: #fff; border: none;
            padding: 8px 20px; border-radius: 8px;
            font-size: 13px; font-weight: 500;
            transition: all 0.2s;
            box-shadow: 0 2px 8px rgba(108,92,231,0.3);
        }
        .btn-lucy:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 15px rgba(108,92,231,0.4);
            color: #fff;
        }
        .btn-outline-lucy {
            border: 1.5px solid var(--lucy-primary);
            color: var(--lucy-primary);
            background: transparent;
            padding: 7px 18px; border-radius: 8px;
            font-size: 13px; font-weight: 500;
            transition: all 0.2s;
        }
        .btn-outline-lucy:hover {
            background: var(--lucy-primary);
            color: #fff;
        }
        .btn-action {
            width: 32px; height: 32px;
            display: inline-flex; align-items: center; justify-content: center;
            border-radius: 8px; border: none;
            font-size: 14px; transition: all 0.15s;
            background: transparent;
        }
        .btn-action.edit { color: #2563EB; }
        .btn-action.edit:hover { background: #EFF6FF; }
        .btn-action.delete { color: #DC2626; }
        .btn-action.delete:hover { background: #FEF2F2; }

        /* ── Forms ── */
        .lucy-form {
            background: #fff;
            border-radius: 14px;
            padding: 28px;
            border: 1px solid #E8ECF1;
        }
        .lucy-form label {
            font-size: 13px; font-weight: 500; color: #374151;
            margin-bottom: 6px;
        }
        .lucy-form .form-control, .lucy-form .form-select {
            border-radius: 8px;
            border: 1.5px solid #D1D5DB;
            padding: 9px 14px;
            font-size: 13.5px;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .lucy-form .form-control:focus, .lucy-form .form-select:focus {
            border-color: var(--lucy-primary);
            box-shadow: 0 0 0 3px rgba(108,92,231,0.12);
        }

        /* ── Empty State ── */
        .empty-state {
            text-align: center; padding: 48px 20px;
            color: #9CA3AF;
        }
        .empty-state i { font-size: 48px; margin-bottom: 12px; display: block; }
        .empty-state p { font-size: 14px; margin: 0; }

        /* ── Mock Banner ── */
        .mock-banner {
            background: linear-gradient(135deg, #FFF3CD, #FFF9E6);
            border: 1px solid #FFECB5;
            border-radius: 10px;
            padding: 10px 16px;
            font-size: 12px;
            color: #856404;
            display: flex; align-items: center; gap: 8px;
            margin-bottom: 20px;
        }
        .mock-banner i { font-size: 16px; }

        /* ── Animations ── */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(12px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .animate-in { animation: fadeInUp 0.35s ease-out; }
    </style>
</head>
<body>

<!-- ── Sidebar ── -->
<nav class="lucy-sidebar">
    <div class="lucy-brand">
        <div class="lucy-brand-icon"><i class="bi bi-translate"></i></div>
        <div>
            <div class="lucy-brand-text">LUCY</div>
            <div class="lucy-brand-sub">Admin Console</div>
        </div>
    </div>

    <div class="nav-group-label">Overview</div>
    <a class="lucy-nav-link" href="/dashboard"><i class="bi bi-grid-1x2-fill"></i> Dashboard</a>

    <div class="nav-group-label">LMS Content</div>
    <a class="lucy-nav-link" href="/programs"><i class="bi bi-collection"></i> Programs</a>
    <a class="lucy-nav-link" href="/courses"><i class="bi bi-book"></i> Courses</a>
    <a class="lucy-nav-link" href="/course-runs"><i class="bi bi-calendar-event"></i> Course Runs</a>
    <a class="lucy-nav-link" href="/chapters"><i class="bi bi-layers"></i> Chapters</a>
    <a class="lucy-nav-link" href="/lessons"><i class="bi bi-file-earmark-text"></i> Lessons</a>

    <div class="nav-group-label">Import</div>
    <a class="lucy-nav-link" href="/import-files"><i class="bi bi-cloud-upload"></i> Import Files</a>
    <a class="lucy-nav-link" href="/docx-preview"><i class="bi bi-file-earmark-word"></i> DOCX Preview</a>

    <div class="nav-group-label">AI Support</div>
    <a class="lucy-nav-link" href="/ai-prompt-templates"><i class="bi bi-cpu"></i> Prompt Templates</a>
    <a class="lucy-nav-link" href="/ai-generated-questions"><i class="bi bi-chat-dots"></i> Generated Questions</a>

    <div class="nav-group-label">Users</div>
    <a class="lucy-nav-link" href="/users"><i class="bi bi-people"></i> User Management</a>

    <div class="nav-group-label">Rooms</div>
    <a class="lucy-nav-link" href="/rooms"><i class="bi bi-mic"></i> Live Rooms</a>

    <div class="nav-group-label">Billing & Gifts</div>
    <a class="lucy-nav-link" href="/billing/plans"><i class="bi bi-credit-card-2-front"></i> Billing Plans</a>
    <a class="lucy-nav-link" href="/billing/users"><i class="bi bi-wallet2"></i> User Wallets</a>
    <a class="lucy-nav-link" href="/billing/transactions"><i class="bi bi-receipt"></i> Transactions</a>
    <a class="lucy-nav-link" href="/gifts"><i class="bi bi-gift"></i> Gifts</a>

    <div class="nav-group-label">Content Creator</div>
    <a class="lucy-nav-link" href="/podcasts"><i class="bi bi-headphones"></i> Podcasts</a>
    <a class="lucy-nav-link" href="/premium-content"><i class="bi bi-star"></i> Premium Content</a>

    <div style="padding: 20px; margin-top: 16px; border-top: 1px solid rgba(255,255,255,0.06);">
        <a href="/swagger-ui/index.html" target="_blank" class="lucy-nav-link" style="padding: 8px 0;">
            <i class="bi bi-braces"></i> Swagger API
        </a>
    </div>

    <!-- User Profile Section at Bottom of Sidebar -->
    <c:if test="${sessionScope.currentUser != null}">
        <div style="padding: 16px 20px; border-top: 1px solid rgba(255,255,255,0.06); background: rgba(255,255,255,0.02); margin-top: auto;">
            <div class="d-flex align-items-center gap-2">
                <div style="width: 38px; height: 38px; border-radius: 50%; background: var(--lucy-primary); display: flex; align-items: center; justify-content: center; font-size: 16px; font-weight: bold; color: white;">
                    <c:choose>
                        <c:when test="${not empty sessionScope.currentUser.avatarPersona}">
                            ${sessionScope.currentUser.avatarPersona}
                        </c:when>
                        <c:otherwise>
                            👤
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="overflow: hidden; flex: 1;">
                    <div style="color: #fff; font-size: 13.5px; font-weight: 600; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
                        ${sessionScope.currentUser.displayName}
                    </div>
                    <div style="font-size: 10px; color: var(--lucy-text-muted);">
                        <c:choose>
                            <c:when test="${sessionScope.currentUser.role == 'ADMIN'}"><span class="badge-status badge-danger" style="padding: 2px 6px; font-size: 9px;">ADMIN</span></c:when>
                            <c:when test="${sessionScope.currentUser.role == 'PRO_MENTOR'}"><span class="badge-status badge-purple" style="padding: 2px 6px; font-size: 9px;">PRO MENTOR</span></c:when>
                            <c:when test="${sessionScope.currentUser.role == 'SUPER_CREATOR'}"><span class="badge-status badge-pink" style="padding: 2px 6px; font-size: 9px;">SUPER CREATOR</span></c:when>
                            <c:otherwise><span class="badge-status badge-success" style="padding: 2px 6px; font-size: 9px;">LEARNER</span></c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <div class="d-flex gap-2 mt-3">
                <a href="/profile" class="btn btn-outline-lucy btn-sm w-50" style="padding: 4px 0; font-size: 11px; border-color: rgba(255,255,255,0.15); color: #fff;"><i class="bi bi-person"></i> Profile</a>
                <a href="/logout" class="btn btn-danger btn-sm w-50" style="padding: 4px 0; font-size: 11px; background: var(--lucy-danger); border: none;"><i class="bi bi-box-arrow-right"></i> Log out</a>
            </div>
        </div>
    </c:if>
</nav>

<!-- ── Main ── -->
<div class="lucy-main">
    <div class="lucy-topbar">
        <h1>${pageTitle}</h1>
        <span class="badge-env">PRJ301 Demo</span>
    </div>
    <div class="lucy-content animate-in">
        <jsp:doBody/>
    </div>
</div>

<!-- ── Delete Confirmation Modal ── -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 14px; border: none;">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title" style="font-weight: 600;">Confirm Delete</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" style="color: #6B7280;">
                Are you sure you want to delete this item? This action cannot be undone.
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal" style="border-radius: 8px;">Cancel</button>
                <a id="deleteConfirmBtn" href="#" class="btn btn-danger" style="border-radius: 8px;">Delete</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Highlight active nav link
    (function() {
        var path = window.location.pathname;
        var links = document.querySelectorAll('.lucy-nav-link');
        links.forEach(function(link) {
            var href = link.getAttribute('href');
            if (href && href !== '/' && path.startsWith(href)) {
                link.classList.add('active');
            } else if (href === '/dashboard' && path === '/') {
                link.classList.add('active');
            }
        });
    })();

    // Delete confirmation
    function confirmDelete(url) {
        document.getElementById('deleteConfirmBtn').href = url;
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
        return false;
    }
</script>
</body>
</html>
