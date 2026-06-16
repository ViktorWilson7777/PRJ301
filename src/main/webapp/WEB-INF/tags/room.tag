<%@ tag description="LUCY Full-screen Room Layout" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="pageTitle" required="true" type="java.lang.String" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} — LUCY</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { margin: 0; padding: 0; min-height: 100vh; background: #0F0E17; color: #E2E8F0; font-family: 'Inter', sans-serif; overflow-x: hidden; }
        .room-nav {
            background: rgba(15, 14, 23, 0.85); backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(255,255,255,0.05); padding: 10px 24px;
            display: flex; align-items: center; justify-content: space-between;
            position: absolute; top: 0; left: 0; right: 0; z-index: 1000; height: 56px;
        }
        .room-brand { color: #fff; font-size: 16px; font-weight: 800; text-decoration: none; display: flex; align-items: center; gap: 8px; letter-spacing: 0.5px; }
        .btn-leave { background: rgba(255,255,255,0.1); color: #fff; border: none; padding: 6px 16px; border-radius: 20px; font-size: 13px; text-decoration: none; transition: 0.2s; font-weight: 500; }
        .btn-leave:hover { background: rgba(239, 68, 68, 0.8); }
        .room-content { height: 100vh; padding-top: 56px; width: 100vw; display: flex; overflow: hidden; }
    </style>
</head>
<body>

<nav class="room-nav">
    <a href="/dashboard" class="room-brand"><i class="bi bi-translate" style="color: #00CEC9;"></i> LUCY<span style="color: #6C5CE7;">.LIVE</span></a>
    <a href="/rooms" class="btn-leave"><i class="bi bi-door-open-fill"></i> Leave Quietly</a>
</nav>

<div class="room-content">
    <jsp:doBody/>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
