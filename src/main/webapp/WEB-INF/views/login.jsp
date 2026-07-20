<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign in | LUCY LMS</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo-favicon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 18px;
            min-height: 100vh;
            display: grid;
            place-items: center;
            color: #f8fafc;
            /* Animated dark blue gradient */
            background: linear-gradient(135deg, #020617 0%, #0f172a 50%, #1e3a8a 100%);
            background-size: 200% 200%;
            animation: gradientBG 10s ease infinite;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .card-login {
            background: rgba(15, 23, 42, 0.5); /* translucent dark */
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            width: min(430px, 100%);
            padding: 34px;
            border-radius: 16px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
        }

        .brand-logo {
            width: 54px;
            height: 54px;
            display: block;
            margin: 0 auto 20px;
            object-fit: contain;
        }

        h1 { font-size: 26px; font-weight: 700; text-align: center; margin: 0 0 6px; letter-spacing: -0.5px; }
        .subtitle { text-align: center; color: #94a3b8; font-size: 14px; margin-bottom: 28px; }
        
        .form-label { font-size: 13px; font-weight: 600; color: #cbd5e1; }
        
        .form-control {
            background: rgba(15, 23, 42, 0.6);
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.15);
            padding: 12px 14px;
            color: #fff;
            transition: all 0.2s;
        }
        
        .form-control:focus {
            background: rgba(15, 23, 42, 0.8);
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.25);
            color: #fff;
        }

        .btn-signin {
            background: #2563eb;
            color: #fff;
            border: 0;
            border-radius: 8px;
            padding: 12px;
            font-weight: 700;
            font-size: 15px;
            transition: all 0.2s;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }
        
        .btn-signin:hover {
            background: #1d4ed8;
            color: #fff;
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(37, 99, 235, 0.4);
        }

        .notice {
            border: 1px solid;
            border-radius: 8px;
            padding: 12px;
            font-size: 13px;
            display: flex;
            gap: 8px;
            margin-bottom: 16px;
            align-items: center;
        }
        
        .error { color: #fca5a5; background: rgba(127, 29, 29, 0.4); border-color: rgba(248, 113, 113, 0.3); }
        .success { color: #86efac; background: rgba(20, 83, 45, 0.4); border-color: rgba(74, 222, 128, 0.3); }
        
        a { color: #60a5fa; text-decoration: none; font-weight: 600; transition: color 0.2s; }
        a:hover { color: #93c5fd; }
        
        .form-links { display: flex; justify-content: space-between; font-size: 13px; margin-top: 20px; gap: 12px; }
        .form-links span { color: #94a3b8; }
    </style>
</head>
<body>
<main class="card-login">
    <img src="${pageContext.request.contextPath}/images/logo-icon-light-transparent.png" alt="LUCY Logo" class="brand-logo">
    <h1>Welcome to LUCY</h1>
    <p class="subtitle">Sign in to continue learning</p>
    <c:if test="${not empty error}"><div class="notice error"><i class="bi bi-exclamation-circle"></i><span>${error}</span></div></c:if>
    <c:if test="${not empty success}"><div class="notice success"><i class="bi bi-check-circle"></i><span>${success}</span></div></c:if>
    <form method="post" action="${pageContext.request.contextPath}/login">
        <div class="mb-3">
            <label class="form-label" for="email">Email address</label>
            <input id="email" type="email" name="email" value="${email}" class="form-control" autocomplete="email" required>
        </div>
        <div>
            <div class="d-flex justify-content-between align-items-center">
                <label class="form-label" for="password">Password</label>
                <a href="${pageContext.request.contextPath}/forgot-password" style="font-size:12px">Forgot password?</a>
            </div>
            <input id="password" type="password" name="password" class="form-control" autocomplete="current-password" required>
        </div>
        <button type="submit" class="btn btn-signin w-100 mt-4">Sign in</button>
    </form>
    <div class="form-links"><span>New to LUCY?</span><a href="${pageContext.request.contextPath}/register">Create an account</a></div>
</main>
</body>
</html>
