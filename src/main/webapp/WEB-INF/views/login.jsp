<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign in | LUCY LMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body{font-family:Inter,sans-serif;background:#11101C;min-height:100vh;display:grid;place-items:center;margin:0;padding:18px;color:#172033}
        .card-login{background:#fff;width:min(430px,100%);padding:34px;border-radius:8px;box-shadow:0 18px 45px rgba(0,0,0,.3)}
        .brand-mark{width:50px;height:50px;border-radius:8px;background:#6558E8;color:#fff;display:grid;place-items:center;font-size:23px;margin:0 auto 18px}
        h1{font-size:24px;font-weight:700;text-align:center;margin:0 0 6px}.subtitle{text-align:center;color:#667085;font-size:13px;margin-bottom:24px}
        .form-label{font-size:13px;font-weight:600;color:#475467}.form-control{border-radius:8px;border:1.5px solid #DDE1EA;padding:11px 13px}
        .form-control:focus{border-color:#6558E8;box-shadow:0 0 0 3px rgba(101,88,232,.1)}
        .btn-signin{background:#6558E8;color:#fff;border:0;border-radius:8px;padding:12px;font-weight:700}.btn-signin:hover{background:#5145CD;color:#fff}
        .notice{border:1px solid;border-radius:8px;padding:10px 12px;font-size:13px;display:flex;gap:8px;margin-bottom:16px}
        .error{color:#B42318;background:#FEF3F2;border-color:#FECDCA}.success{color:#027A48;background:#ECFDF3;border-color:#ABEFC6}
        a{color:#6558E8;text-decoration:none;font-weight:600}.form-links{display:flex;justify-content:space-between;font-size:13px;margin-top:16px;gap:12px}
    </style>
</head>
<body>
<main class="card-login">
    <div class="brand-mark"><i class="bi bi-translate"></i></div>
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
