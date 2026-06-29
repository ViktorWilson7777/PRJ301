<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — LUCY LMS</title>
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
        .register-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 480px;
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
            padding: 10px 14px;
            font-size: 14px;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-control:focus {
            border-color: var(--lucy-primary);
            box-shadow: 0 0 0 3px rgba(108,92,231,0.12);
        }
        .login-link {
            color: var(--lucy-primary);
            font-weight: 500;
            text-decoration: none;
        }
        .login-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="register-card text-center">
    <div class="brand-icon"><i class="bi bi-translate"></i></div>
    <h4 style="font-weight: 700; color: #1F2937; margin-bottom: 6px;">Create an Account</h4>
    <p class="text-muted mb-4" style="font-size: 13.5px;">Register for a learner account (+100 free credits!)</p>

    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert" style="border-radius: 10px; font-size: 13.5px; padding: 10px 15px;">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
        </div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/register" class="text-start">
        <div class="mb-3">
            <label class="form-label" style="font-size: 13px; font-weight: 500; color: #4B5563;">Full Name</label>
            <input type="text" name="fullName" class="form-control" placeholder="John Doe" required />
        </div>
        <div class="mb-3">
            <label class="form-label" style="font-size: 13px; font-weight: 500; color: #4B5563;">Email Address</label>
            <div class="input-group">
                <input type="email" id="email" name="email" class="form-control" placeholder="john@example.com" required />
                <button type="button" id="btnSendOtp" class="btn" style="background-color: var(--lucy-primary-light); color: #fff; font-size: 14px; font-weight: 600; border: none; border-radius: 0 10px 10px 0;">Send OTP</button>
            </div>
            <div id="otpFeedback" class="form-text" style="font-size: 12px; display: none; margin-top: 5px;"></div>
        </div>
        <div class="mb-3">
            <label class="form-label" style="font-size: 13px; font-weight: 500; color: #4B5563;">OTP Code</label>
            <input type="text" name="otp" class="form-control" placeholder="Enter 6-digit OTP sent to email" required maxlength="6" pattern="\d{6}" />
        </div>
        <div class="mb-3">
            <label class="form-label" style="font-size: 13px; font-weight: 500; color: #4B5563;">Display Name (Nickname)</label>
            <input type="text" name="displayName" class="form-control" placeholder="Johnny" required />
        </div>
        <div class="mb-4">
            <label class="form-label" style="font-size: 13px; font-weight: 500; color: #4B5563;">Password</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="••••••••" required />
            <div id="passwordStrength" class="mt-2" style="font-size: 12.5px; font-weight: 600;"></div>
        </div>
        <button type="submit" class="btn btn-lucy w-100 mb-3">Sign Up</button>
    </form>

    <div style="font-size: 13.5px; color: #6B7280;">
        Already have an account? <a href="${pageContext.request.contextPath}/login" class="login-link">Sign In</a>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // --- OTP Logic ---
        const btnSendOtp = document.getElementById("btnSendOtp");
        const emailInput = document.getElementById("email");
        const otpFeedback = document.getElementById("otpFeedback");

        btnSendOtp.addEventListener("click", function() {
            const email = emailInput.value.trim();
            if (!email) {
                otpFeedback.style.display = "block";
                otpFeedback.style.color = "#DC2626";
                otpFeedback.textContent = "Please enter an email address first.";
                return;
            }

            // Simple email validation
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                otpFeedback.style.display = "block";
                otpFeedback.style.color = "#DC2626";
                otpFeedback.textContent = "Please enter a valid email address.";
                return;
            }

            btnSendOtp.disabled = true;
            btnSendOtp.textContent = "Sending...";
            otpFeedback.style.display = "none";

            fetch('${pageContext.request.contextPath}/send-otp', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'email=' + encodeURIComponent(email)
            })
            .then(response => response.json())
            .then(data => {
                otpFeedback.style.display = "block";
                if (data.success) {
                    otpFeedback.style.color = "#059669"; // Green
                    otpFeedback.textContent = data.message;
                    
                    // Countdown
                    let countdown = 60;
                    const interval = setInterval(() => {
                        countdown--;
                        if (countdown <= 0) {
                            clearInterval(interval);
                            btnSendOtp.disabled = false;
                            btnSendOtp.textContent = "Resend OTP";
                        } else {
                            btnSendOtp.textContent = "Wait " + countdown + "s";
                        }
                    }, 1000);
                } else {
                    otpFeedback.style.color = "#DC2626"; // Red
                    otpFeedback.textContent = data.message;
                    btnSendOtp.disabled = false;
                    btnSendOtp.textContent = "Send OTP";
                }
            })
            .catch(error => {
                otpFeedback.style.display = "block";
                otpFeedback.style.color = "#DC2626";
                otpFeedback.textContent = "An error occurred. Please try again.";
                btnSendOtp.disabled = false;
                btnSendOtp.textContent = "Send OTP";
            });
        });

        // --- Password Strength Logic ---
        const passwordInput = document.getElementById("password");
        const strengthIndicator = document.getElementById("passwordStrength");

        passwordInput.addEventListener("input", function() {
            const val = passwordInput.value;
            if (!val) {
                strengthIndicator.textContent = "";
                return;
            }

            let hasLower = /[a-z]/.test(val);
            let hasUpper = /[A-Z]/.test(val);
            let hasNumber = /\d/.test(val);
            let hasSpecial = /[^A-Za-z0-9]/.test(val);

            // Weak: only 1 type
            // Medium: letters and numbers
            // Strong: letters, numbers, special characters, uppercase/lowercase

            let strength = "Yếu"; // Weak
            let color = "#DC2626"; // Red

            let typesCount = 0;
            if (hasLower || hasUpper) typesCount++;
            if (hasNumber) typesCount++;
            if (hasSpecial) typesCount++;

            if (typesCount >= 3 && hasLower && hasUpper) {
                strength = "Mạnh (Strong)";
                color = "#059669"; // Green
            } else if (typesCount >= 2 || ((hasLower || hasUpper) && hasNumber)) {
                strength = "Trung bình (Medium)";
                color = "#D97706"; // Orange
            }

            strengthIndicator.textContent = "Độ mạnh mật khẩu: " + strength;
            strengthIndicator.style.color = color;
        });
    });
</script>

</body>
</html>
