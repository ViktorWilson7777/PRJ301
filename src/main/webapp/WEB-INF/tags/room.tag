<%@ tag description="LUCY Full-screen Room Layout" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="pageTitle" required="true" type="java.lang.String" %>
<%@ attribute name="roomId" required="false" type="java.lang.Long" %>

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
            --live-bg: #070b16;
            --live-surface: #0f172a;
            --live-surface-2: #151f34;
            --live-border: rgba(148, 163, 184, .16);
            --live-text: #f8fafc;
            --live-muted: #94a3b8;
            --live-primary: #7c5cff;
            --live-cyan: #22d3ee;
            --live-danger: #fb7185;
        }
        * { box-sizing: border-box; }
        :where(a, button, input, select, textarea):focus-visible { outline: 2px solid var(--live-cyan); outline-offset: 2px; }
        body { margin: 0; padding: 0; min-height: 100vh; background: var(--live-bg); color: var(--live-text); font-family: 'Inter', sans-serif; overflow-x: hidden; }
        .room-nav {
            background: rgba(7, 11, 22, .92); backdrop-filter: blur(18px);
            border-bottom: 1px solid var(--live-border); padding: 0 24px;
            display: flex; align-items: center; justify-content: space-between;
            position: fixed; top: 0; left: 0; right: 0; z-index: 1040; height: 62px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, .22);
        }
        .room-brand { color: var(--live-text); font-size: 17px; font-weight: 800; text-decoration: none; display: flex; align-items: center; gap: 9px; letter-spacing: .35px; }
        .room-brand-icon { width: 28px; height: 28px; object-fit: contain; }
        .room-brand span { color: #9f8cff !important; }
        .btn-leave { background: rgba(251,113,133,.1); color: #fecdd3; border: 1px solid rgba(251,113,133,.28); padding: 8px 15px; border-radius: 12px; font-size: 12px; text-decoration: none; transition: .2s ease; font-weight: 700; }
        .btn-leave:hover { background: #e11d48; border-color: #fb7185; color: #fff; transform: translateY(-1px); }
        .room-content { height: 100dvh; padding-top: 62px; width: 100vw; display: flex; overflow: hidden; }
        @media (max-width: 991.98px) {
            .room-content { flex-wrap: wrap; overflow-y: auto; }
        }
        @media (max-width: 575.98px) {
            .room-nav { height: 58px; padding: 0 14px; }
            .room-content { padding-top: 58px; }
            .room-brand { font-size: 15px; }
            .btn-leave { padding: 7px 10px; font-size: 0; }
            .btn-leave i { font-size: 15px; margin: 0 !important; }
        }
    </style>
</head>
<body>

<nav class="room-nav">
    <a href="/dashboard" class="room-brand"><img src="${pageContext.request.contextPath}/images/logo-icon-light-transparent.png" alt="LUCY" class="room-brand-icon"> LUCY<span style="color: #6C5CE7;">.LIVE</span></a>
    <c:choose>
        <c:when test="${roomId != null}">
            <a href="/rooms/${roomId}/leave" class="btn-leave" id="globalLeaveBtn"><i class="bi bi-door-open-fill"></i> Leave Quietly</a>
        </c:when>
        <c:otherwise>
            <a href="/rooms" class="btn-leave" id="globalLeaveBtn"><i class="bi bi-door-open-fill"></i> Leave Quietly</a>
        </c:otherwise>
    </c:choose>
</nav>

<div class="room-content">
    <jsp:doBody/>
</div>

<link href="/css/live-room-polish.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
