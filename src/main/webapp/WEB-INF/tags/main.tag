<%@ tag description="LUCY Main Layout" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ attribute name="pageTitle" required="true" type="java.lang.String" %>

<c:set var="isAdminMode" value="${sessionScope.currentUser.role == 'ADMIN'}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} — LUCY</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo-favicon.png">
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
            --sidebar-width: 260px;
        }
        * { font-family: 'Inter', sans-serif; }
        body { background: #F8FAFC; margin: 0; min-height: 100vh; }
        
        .btn-lucy {
            background: linear-gradient(135deg, var(--lucy-primary), #8B5CF6); color: #fff; border: none;
            padding: 8px 20px; border-radius: 8px; font-size: 13px; font-weight: 500; transition: all 0.2s; box-shadow: 0 2px 8px rgba(108,92,231,0.3);
        }
        .btn-lucy:hover { transform: translateY(-1px); box-shadow: 0 4px 15px rgba(108,92,231,0.4); color: #fff; }
        .btn-outline-lucy {
            border: 1.5px solid var(--lucy-primary); color: var(--lucy-primary); background: transparent;
            padding: 7px 18px; border-radius: 8px; font-size: 13px; font-weight: 500; transition: all 0.2s;
        }
        .btn-outline-lucy:hover { background: var(--lucy-primary); color: #fff; }
        .btn-action { width: 32px; height: 32px; display: inline-flex; align-items: center; justify-content: center; border-radius: 8px; border: none; font-size: 14px; transition: all 0.15s; background: transparent; }
        .btn-action.edit { color: #2563EB; } .btn-action.edit:hover { background: #EFF6FF; }
        .btn-action.delete { color: #DC2626; } .btn-action.delete:hover { background: #FEF2F2; }
        
        .stat-card { background: #fff; border-radius: 14px; padding: 22px; border: 1px solid #E2E8F0; transition: transform 0.2s, box-shadow 0.2s; }
        .stat-card:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(0,0,0,0.05); }
        .stat-icon { width: 46px; height: 46px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; }
        .stat-value { font-size: 28px; font-weight: 700; color: #1E293B; }
        .stat-label { font-size: 12.5px; color: #64748B; font-weight: 500; }

        .lucy-table { background:#fff; border-radius:8px; border:1px solid #E2E8F0; overflow:auto; max-height:min(72vh,720px); }
        .lucy-table thead { position:sticky; top:0; z-index:2; }
        .lucy-table thead th { background: #F8FAFC; font-size: 12px; font-weight: 600; color: #64748B; text-transform: uppercase; padding: 14px 16px; border-bottom: 1px solid #E2E8F0; }
        .lucy-table tbody td { padding: 14px 16px; font-size: 13.5px; color: #334155; vertical-align: middle; border-bottom: 1px solid #F1F5F9; }
        
        .badge-status { font-size: 11px; font-weight: 600; padding: 4px 10px; border-radius: 6px; }
        .badge-success { background: #ECFDF5; color: #059669; } .badge-warning { background: #FFFBEB; color: #D97706; }
        .badge-danger { background: #FEF2F2; color: #DC2626; } .badge-info { background: #EFF6FF; color: #2563EB; }
        .badge-purple { background: #F3E8FF; color: #7C3AED; } .badge-pink { background: #FDF2F8; color: #DB2777; }
        .badge-gray { background: #F1F5F9; color: #64748B; }

        /* ── ADMIN MODE STYLES ── */
        <c:if test="${isAdminMode}">
            .lucy-sidebar { position: fixed; top: 0; left: 0; width: var(--sidebar-width); height: 100vh; background: linear-gradient(180deg, var(--lucy-dark) 0%, var(--lucy-dark2) 100%); z-index: 1000; overflow-y: auto; display: flex; flex-direction: column; scrollbar-width: thin; scrollbar-color: var(--lucy-dark3) transparent; }
            .lucy-brand { padding: 24px 20px 20px; display: flex; align-items: center; gap: 12px; border-bottom: 1px solid rgba(255,255,255,0.06); }
            .lucy-brand-icon { width: 42px; height: 42px; object-fit: contain; }
            .lucy-brand-text { color: var(--lucy-text); font-size: 18px; font-weight: 700; letter-spacing: 1px; }
            .lucy-brand-sub { color: var(--lucy-text-muted); font-size: 10px; letter-spacing: 1.5px; text-transform: uppercase; }
            .nav-group-label { color: var(--lucy-text-muted); font-size: 10px; font-weight: 600; letter-spacing: 1.5px; text-transform: uppercase; padding: 20px 20px 8px; }
            .lucy-nav-link { display: flex; align-items: center; gap: 10px; padding: 10px 20px; color: var(--lucy-text-muted); text-decoration: none; font-size: 13.5px; font-weight: 400; border-left: 3px solid transparent; }
            .lucy-nav-link:hover { color: var(--lucy-text); background: rgba(255,255,255,0.04); border-left-color: var(--lucy-primary-light); }
            .lucy-nav-link.active { color: var(--lucy-text); background: rgba(108,92,231,0.15); border-left-color: var(--lucy-primary); font-weight: 500; }
            
            .lucy-main { margin-left: var(--sidebar-width); min-height: 100vh; }
            .lucy-topbar { background: #fff; padding: 16px 32px; border-bottom: 1px solid #E2E8F0; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; box-shadow: 0 1px 3px rgba(0,0,0,0.04); }
        </c:if>

        /* ── LEARNER MODE STYLES ── */
        <c:if test="${!isAdminMode}">
            body { background: #F8FAFC; }
            .lucy-main { margin-left: 0; min-height: 100vh; }
            .learner-navbar { background: #fff; padding: 12px 32px; border-bottom: 1px solid #E2E8F0; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; box-shadow: 0 2px 10px rgba(0,0,0,0.02); }
            .learner-brand { display: flex; align-items: center; gap: 12px; text-decoration: none; }
            .learner-brand-icon { width: 36px; height: 36px; object-fit: contain; }
            .learner-brand-text { color: #1E293B; font-size: 18px; font-weight: 800; letter-spacing: 0.5px; }
            
            .learner-nav-links { display: flex; gap: 24px; margin-left: 40px; }
            .learner-nav-link { color: #64748B; font-size: 14px; font-weight: 500; text-decoration: none; padding: 8px 0; border-bottom: 2px solid transparent; transition: all 0.2s; }
            .learner-nav-link:hover { color: var(--lucy-primary); }
            .learner-nav-link.active { color: var(--lucy-primary); border-bottom-color: var(--lucy-primary); font-weight: 600; }
            
            .learner-user { display: flex; align-items: center; gap: 12px; }
            .lucy-topbar { display: none; }
            .content-container { max-width: 1200px; margin: 0 auto; width: 100%; }
        </c:if>

        .lucy-content { padding: 28px 32px; }
        .lucy-topbar h1 { font-size: 20px; font-weight: 600; color: #1E293B; margin: 0; }
        .live-search-select { position:relative; }
        .live-search-results { position:absolute;z-index:1050;top:calc(100% + 4px);left:0;right:0;display:none;max-height:240px;overflow-y:auto;background:#fff;border:1px solid #DDE1EA;border-radius:8px;box-shadow:0 12px 28px rgba(16,24,40,.14); }
        .live-search-results.open { display:block; }
        .live-search-option { width:100%;border:0;border-bottom:1px solid #F2F4F7;background:#fff;text-align:left;padding:9px 11px;font-size:13px;color:#344054; }
        .live-search-option:hover,.live-search-option:focus { background:#F4F3FF;color:#5145CD;outline:0; }
    </style>
</head>
<body>

<c:choose>
    <c:when test="${isAdminMode}">
        <!-- ── Admin Sidebar ── -->
        <nav class="lucy-sidebar">
            <div class="lucy-brand">
                <img src="${pageContext.request.contextPath}/images/logo-icon-light-transparent.png" alt="LUCY" class="lucy-brand-icon">
                <div><div class="lucy-brand-text">LUCY</div><div class="lucy-brand-sub">Admin Console</div></div>
            </div>
            
            <div class="nav-group-label">Overview</div>
            <a class="lucy-nav-link" href="/dashboard"><i class="bi bi-grid-1x2-fill"></i> Dashboard</a>
            <a class="lucy-nav-link" href="/profile"><i class="bi bi-person-circle"></i> My Profile</a>

            <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                <div class="nav-group-label">LMS Content</div>
                <a class="lucy-nav-link" href="/programs"><i class="bi bi-collection"></i> Programs</a>
                <a class="lucy-nav-link" href="/courses"><i class="bi bi-book"></i> Courses</a>
                <a class="lucy-nav-link" href="/chapters"><i class="bi bi-layers"></i> Chapters (Levels)</a>
                <a class="lucy-nav-link" href="/lessons"><i class="bi bi-file-earmark-text"></i> Lessons (Questions)</a>
            </c:if>

            <div class="nav-group-label">Content Creator</div>
            <a class="lucy-nav-link" href="/podcasts"><i class="bi bi-headphones"></i> Podcasts</a>
            
            <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                <div class="nav-group-label">Admin</div>
                <a class="lucy-nav-link" href="/pro-applications"><i class="bi bi-person-check"></i> Pro Applications</a>
                <a class="lucy-nav-link" href="/users"><i class="bi bi-people"></i> User Management</a>
                <a class="lucy-nav-link" href="/admin/api-settings"><i class="bi bi-key"></i> API Settings</a>
                <a class="lucy-nav-link" href="/billing/stats"><i class="bi bi-cash-coin"></i> Financial Overview</a>
                <a class="lucy-nav-link" href="/import-files"><i class="bi bi-cloud-upload"></i> Import Files</a>
                <a class="lucy-nav-link" href="/gifts"><i class="bi bi-gift"></i> Gifts</a>
            </c:if>

            <div style="padding: 16px 20px; border-top: 1px solid rgba(255,255,255,0.06); margin-top: auto;">
                <div style="color: #fff; font-size: 13px; font-weight: 600; margin-bottom: 8px;">${sessionScope.currentUser.displayName}</div>
                <a href="/logout" class="btn w-100" style="background: rgba(239,68,68,0.2); color: #FCA5A5; font-size: 12px;"><i class="bi bi-box-arrow-right"></i> Log out</a>
            </div>
        </nav>
    </c:when>
    <c:otherwise>
        <!-- ── Learner Top Navbar ── -->
        <nav class="learner-navbar">
            <div class="d-flex align-items-center">
                <a href="/dashboard" class="learner-brand">
                    <img src="${pageContext.request.contextPath}/images/logo-icon.png" alt="LUCY" class="learner-brand-icon">
                    <div class="learner-brand-text">LUCY<span style="color:var(--lucy-primary);">.LMS</span></div>
                </a>
                <div class="learner-nav-links">
                    <a href="/dashboard" class="learner-nav-link">Home</a>
                    <a href="/courses" class="learner-nav-link">Courses</a>
                    <a href="/programs" class="learner-nav-link">Programs</a>
                    <a href="/podcasts" class="learner-nav-link">Podcasts</a>
                    <c:if test="${sessionScope.currentUser.role != 'LEARNER'}">
                        <a href="/my-rooms" class="learner-nav-link">My Live Rooms</a>
                    </c:if>
                    <c:if test="${sessionScope.currentUser.accountType == 'CONTENT_CREATOR'}">
                        <a href="/premium-content" class="learner-nav-link">Premium Content</a>
                    </c:if>
                </div>
            </div>
            <div class="learner-user">
                <a href="/billing/topup" class="btn btn-sm" style="background: #FFFBEB; color: #D97706; border: 1px solid #FDE68A; border-radius: 20px; padding: 4px 12px; font-weight: 600;">
                    <i class="bi bi-coin"></i> <fmt:formatNumber value="${sessionScope.currentUser.creditBalance}" pattern="#,##0"/> cr
                </a>
                <div class="dropdown ms-3">
                    <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" style="color: #1E293B; font-weight: 500;">
                        <div style="width: 32px; height: 32px; border-radius: 50%; background: var(--lucy-primary); color: white; display: flex; align-items: center; justify-content: center; margin-right: 8px; font-weight: 600;">
                            ${sessionScope.currentUser.displayName.substring(0,1).toUpperCase()}
                        </div>
                        ${sessionScope.currentUser.displayName}
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow-sm" style="border-radius: 12px; border: 1px solid #E2E8F0;">
                        <li><a class="dropdown-item" href="/profile"><i class="bi bi-person me-2"></i>My Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="/logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </c:otherwise>
</c:choose>

<!-- ── Main Content ── -->
<div class="lucy-main">
    <c:if test="${isAdminMode}">
        <div class="lucy-topbar">
            <h1>${pageTitle}</h1>
            <span class="badge-status badge-purple">Admin Mode</span>
        </div>
    </c:if>
    <div class="lucy-content">
        <c:choose>
            <c:when test="${!isAdminMode}">
                <div class="content-container">
                    <jsp:doBody/>
                </div>
            </c:when>
            <c:otherwise>
                <jsp:doBody/>
            </c:otherwise>
        </c:choose>
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
    (function() {
        var path = window.location.pathname;
        var links = document.querySelectorAll('.lucy-nav-link, .learner-nav-link');
        links.forEach(function(link) {
            var href = link.getAttribute('href');
            if (href && href !== '/' && path.startsWith(href)) {
                link.classList.add('active');
            } else if (href === '/dashboard' && path === '/') {
                link.classList.add('active');
            }
        });
    })();
    function confirmDelete(url) {
        document.getElementById('deleteConfirmBtn').href = url;
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
        return false;
    }
    document.querySelectorAll('select[data-live-search]').forEach(function(select) {
        if (select.dataset.enhanced === 'true') return;
        select.dataset.enhanced = 'true';
        const shell = document.createElement('div');
        shell.className = 'live-search-select';
        const input = document.createElement('input');
        input.type = 'search';
        input.className = select.classList.contains('form-select-sm') ? 'form-control form-control-sm' : 'form-control';
        input.placeholder = select.dataset.searchPlaceholder || 'Type to search...';
        input.autocomplete = 'off';
        input.disabled = select.disabled;
        const results = document.createElement('div');
        results.className = 'live-search-results';
        select.parentNode.insertBefore(shell, select);
        shell.appendChild(input);
        shell.appendChild(results);
        select.style.position = 'absolute';
        select.style.opacity = '0';
        select.style.pointerEvents = 'none';
        select.style.width = '1px';
        select.style.height = '1px';
        shell.appendChild(select);

        function options() { return Array.from(select.options).filter(function(option) { return option.value && !option.disabled && option.style.display !== 'none'; }); }
        function selectedLabel() { const option = select.options[select.selectedIndex]; return option && option.value ? option.text.trim() : ''; }
        input.value = selectedLabel();
        function render() {
            if (select.disabled) return;
            const query = input.value.trim().toLowerCase();
            results.innerHTML = '';
            const filteredOptions = options().filter(function(option) { return !query || option.text.toLowerCase().includes(query); });
            if (filteredOptions.length === 0) {
                const emptyMsg = document.createElement('div');
                emptyMsg.className = 'live-search-option text-muted';
                emptyMsg.style.pointerEvents = 'none';
                emptyMsg.textContent = 'No options available';
                results.appendChild(emptyMsg);
            } else {
                filteredOptions.forEach(function(option) {
                    const button = document.createElement('button');
                    button.type = 'button';
                    button.className = 'live-search-option';
                    button.textContent = option.text.trim();
                    button.addEventListener('mousedown', function(event) {
                        event.preventDefault();
                        select.value = option.value;
                        input.value = option.text.trim();
                        results.classList.remove('open');
                        select.dispatchEvent(new Event('change', { bubbles:true }));
                    });
                    results.appendChild(button);
                });
            }
            results.classList.add('open');
        }
        results.addEventListener('mousedown', function(event) { if (event.target === results) event.preventDefault(); });
        input.addEventListener('focus', function() { input.select(); render(); });
        input.addEventListener('click', function() { render(); });
        input.addEventListener('input', function() { input.setCustomValidity(''); render(); });
        input.addEventListener('blur', function() { setTimeout(function() { results.classList.remove('open'); input.value = selectedLabel(); }, 150); });
        select.addEventListener('change', function() { input.value = selectedLabel(); input.setCustomValidity(''); });
        select.addEventListener('invalid', function(e) { e.preventDefault(); input.setCustomValidity(select.validationMessage); input.reportValidity(); });
    });
</script>
</body>
</html>
