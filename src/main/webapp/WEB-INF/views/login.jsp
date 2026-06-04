<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — LUCY LMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --lucy-primary: #6C5CE7;
            --lucy-primary-light: #A29BFE;
            --lucy-accent: #00CEC9;
            --lucy-dark: #0F0E17;
            --lucy-dark2: #1A1929;
            --lucy-text: #333333;
        }
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, var(--lucy-dark) 0%, var(--lucy-dark2) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 20px;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 440px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .brand-icon {
            width: 54px; height: 54px;
            background: linear-gradient(135deg, var(--lucy-primary), var(--lucy-accent));
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 26px; color: #fff;
            margin: 0 auto 20px;
            box-shadow: 0 4px 15px rgba(108, 92, 231, 0.4);
        }
        .btn-lucy {
            background: linear-gradient(135deg, var(--lucy-primary), #8B5CF6);
            color: #fff; border: none;
            padding: 12px; border-radius: 10px;
            font-size: 15px; font-weight: 600;
            transition: all 0.2s;
            box-shadow: 0 4px 12px rgba(108,92,231,0.3);
        }
        .btn-lucy:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 18px rgba(108,92,231,0.4);
            color: #fff;
        }
        .form-control {
            border-radius: 10px;
            border: 1.5px solid #E5E7EB;
            padding: 11px 16px;
            font-size: 14px;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-control:focus {
            border-color: var(--lucy-primary);
            box-shadow: 0 0 0 3px rgba(108,92,231,0.12);
        }
        .register-link {
            color: var(--lucy-primary);
            font-weight: 500;
            text-decoration: none;
        }
        .register-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-card text-center">
    <div class="brand-icon"><i class="bi bi-translate"></i></div>
    <h4 style="font-weight: 700; color: #1F2937; margin-bottom: 6px;">Welcome to LUCY</h4>
    <p class="text-muted mb-4" style="font-size: 13.5px;">Sign in to your learning account</p>

    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert" style="border-radius: 10px; font-size: 13.5px; padding: 10px 15px;">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
        </div>
    </c:if>

    <form method="post" action="/login" class="text-start">
        <div class="mb-3">
            <label class="form-label" style="font-size: 13px; font-weight: 500; color: #4B5563;">Email Address</label>
            <div class="input-group">
                <span class="input-group-text" style="background: none; border-right: none; border-radius: 10px 0 0 10px; border-color: #E5E7EB; color: #9CA3AF;"><i class="bi bi-envelope"></i></span>
                <input type="email" name="email" class="form-control" style="border-left: none; border-radius: 0 10px 10px 0;" placeholder="name@domain.com" required />
            </div>
        </div>
        <div class="mb-4">
            <label class="form-label" style="font-size: 13px; font-weight: 500; color: #4B5563;">Password</label>
            <div class="input-group">
                <span class="input-group-text" style="background: none; border-right: none; border-radius: 10px 0 0 10px; border-color: #E5E7EB; color: #9CA3AF;"><i class="bi bi-shield-lock"></i></span>
                <input type="password" name="password" class="form-control" style="border-left: none; border-radius: 0 10px 10px 0;" placeholder="••••••••" required />
            </div>
        </div>
        <button type="submit" class="btn btn-lucy w-100 mb-3">Sign In</button>
    </form>

    <div style="font-size: 13.5px; color: #6B7280;">
        New to LUCY? <a href="/register" class="register-link">Create an account</a>
    </div>
</div>

</body>
</html>
