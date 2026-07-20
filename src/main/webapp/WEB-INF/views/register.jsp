<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create account | LUCY LMS</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo-favicon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary:#3b82f6; --accent:#2563eb; --muted:#94a3b8; }
        * { box-sizing: border-box; }
        body { 
            font-family: 'Inter', sans-serif; 
            margin: 0; 
            min-height: 100vh; 
            padding: 32px 18px; 
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

        .shell { width: min(1040px, 100%); margin: auto; }
        .brand { display: flex; align-items: center; justify-content: center; gap: 10px; color: #fff; font-weight: 700; font-size: 22px; margin-bottom: 28px; }
        .brand-logo { width: 42px; height: 42px; object-fit: contain; }
        
        .register-panel { 
            background: rgba(15, 23, 42, 0.5);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px; 
            overflow: hidden; 
            display: grid; 
            grid-template-columns: 380px minmax(0, 1fr); 
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5); 
        }
        
        .account-picker { padding: 34px; background: rgba(2, 6, 23, 0.3); border-right: 1px solid rgba(255, 255, 255, 0.05); }
        .account-picker h1 { font-size: 24px; font-weight: 700; margin-bottom: 8px; letter-spacing: -0.5px; }
        .account-picker > p { color: var(--muted); font-size: 14px; margin-bottom: 24px; }
        
        .account-option { 
            display: block; 
            background: rgba(15, 23, 42, 0.4); 
            border: 1px solid rgba(255, 255, 255, 0.1); 
            border-radius: 12px; 
            padding: 18px; 
            margin-bottom: 14px; 
            cursor: pointer; 
            transition: all 0.2s; 
        }
        .account-option:hover { border-color: rgba(59, 130, 246, 0.5); background: rgba(30, 58, 138, 0.2); }
        .account-option.selected { border-color: var(--primary); background: rgba(30, 58, 138, 0.3); box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.25); }
        .account-option input { position: absolute; opacity: 0; }
        
        .option-head { display: flex; align-items: center; gap: 12px; font-weight: 700; color: #fff; }
        .option-head i { color: var(--primary); font-size: 20px; }
        .account-option p { margin: 8px 0 0; color: #cbd5e1; font-size: 13px; line-height: 1.55; }
        .price { color: #fbbf24; font-weight: 700; font-size: 12px; margin-left: auto; background: rgba(251, 191, 36, 0.1); padding: 4px 8px; border-radius: 6px;}
        
        .form-side { padding: 34px 40px; }
        .form-label { font-size: 13px; font-weight: 600; color: #cbd5e1; margin-bottom: 6px; }
        
        .form-control, .form-select { 
            background: rgba(15, 23, 42, 0.6); 
            border-radius: 8px; 
            border: 1px solid rgba(255, 255, 255, 0.15); 
            padding: 12px 14px; 
            font-size: 14px; 
            color: #fff;
            transition: all 0.2s;
        }
        .form-control:focus, .form-select:focus { 
            background: rgba(15, 23, 42, 0.8);
            border-color: var(--primary); 
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.25); 
            color: #fff;
        }
        
        .otp-button { border: 0; background: var(--accent); color: #fff; min-width: 118px; font-weight: 700; border-radius: 0 8px 8px 0; transition: background 0.2s; }
        .otp-button:hover { background: #1d4ed8; }
        .otp-button:disabled { opacity: 1; background: rgba(30, 58, 138, 0.4); color: #94a3b8; }
        
        .btn-submit { background: var(--accent); color: #fff; border: 0; border-radius: 8px; padding: 14px; font-weight: 700; transition: all 0.2s; box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3); font-size: 15px;}
        .btn-submit:hover { background: #1d4ed8; color: #fff; transform: translateY(-1px); box-shadow: 0 6px 16px rgba(37, 99, 235, 0.4); }
        
        .role-fields { display: none; }
        .role-fields.active { display: block; }
        
        .notice { border: 1px solid; border-radius: 8px; padding: 12px 14px; font-size: 13px; display: flex; gap: 8px; align-items: center; }
        .notice.error { color: #fca5a5; background: rgba(127, 29, 29, 0.4); border-color: rgba(248, 113, 113, 0.3); }
        .notice.info { color: #93c5fd; background: rgba(30, 58, 138, 0.4); border-color: rgba(59, 130, 246, 0.3); }
        
        #otpFeedback { min-height: 18px; font-size: 12px; margin-top: 6px; }
        
        .footer-link { font-size: 14px; color: var(--muted); text-align: center; margin-top: 24px; }
        .footer-link a { color: #60a5fa; font-weight: 600; text-decoration: none; transition: color 0.2s; }
        .footer-link a:hover { color: #93c5fd; }
        
        @media(max-width:800px) {
            body { padding: 16px 10px; }
            .register-panel { grid-template-columns: 1fr; }
            .account-picker { border-right: 0; border-bottom: 1px solid rgba(255, 255, 255, 0.05); padding: 24px; }
            .form-side { padding: 24px 20px; }
        }
    </style>
</head>
<body>
<main class="shell">
    <div class="brand"><img src="${pageContext.request.contextPath}/images/logo-icon-light-transparent.png" alt="LUCY Logo" class="brand-logo">LUCY LMS</div>
    <div class="register-panel">
        <section class="account-picker">
            <h1>Choose your account</h1>
            <p>Each account starts with 100 credits. You can add credits later.</p>

            <label class="account-option selected" data-account="LEARNER">
                <input type="radio" name="accountChoice" value="LEARNER" checked>
                <span class="option-head"><i class="bi bi-mortarboard"></i>Learner <span class="price">FREE</span></span>
                <p>Join speaking rooms up to your language level, learn courses, earn XP, and unlock Pro by completing a course.</p>
            </label>
            <label class="account-option" data-account="PRO_MENTOR">
                <input type="radio" name="accountChoice" value="PRO_MENTOR">
                <span class="option-head"><i class="bi bi-patch-check"></i>Pro Mentor <span class="price">FREE REVIEW</span></span>
                <p>Submit qualifications for admin review. Approved mentors can host rooms for verified programs and levels.</p>
            </label>
            <label class="account-option" data-account="CONTENT_CREATOR">
                <input type="radio" name="accountChoice" value="CONTENT_CREATOR">
                <span class="option-head"><i class="bi bi-mic"></i>Content Creator <span class="price">100,000 VND</span></span>
                <p>Includes learner access and podcast publishing with a storage allowance. Payment is mocked for now.</p>
            </label>
        </section>

        <section class="form-side">
            <c:if test="${not empty error}">
                <div class="notice error mb-3"><i class="bi bi-exclamation-circle"></i><span>${error}</span></div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/register" id="registerForm">
                <input type="hidden" name="accountType" id="accountType" value="LEARNER">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label" for="fullName">Full name</label>
                        <input id="fullName" type="text" name="fullName" class="form-control" autocomplete="name" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="displayName">Display name</label>
                        <input id="displayName" type="text" name="displayName" class="form-control" autocomplete="nickname" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label" for="email">Email address</label>
                        <div class="input-group">
                            <input id="email" type="email" name="email" class="form-control" autocomplete="email" required>
                            <button type="button" id="btnSendOtp" class="otp-button">Send OTP</button>
                        </div>
                        <div id="otpFeedback" aria-live="polite"></div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="otp">OTP code</label>
                        <input id="otp" type="text" name="otp" class="form-control" inputmode="numeric" maxlength="6" pattern="[0-9]{6}" autocomplete="one-time-code" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="password">Password</label>
                        <input id="password" type="password" name="password" class="form-control" minlength="8" autocomplete="new-password" required>
                        <div id="passwordStrength" class="form-text"></div>
                    </div>
                </div>

                <div class="role-fields active mt-3" data-fields="LEARNER">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" name="anonymousMode" id="anonymousMode">
                        <label class="form-check-label" for="anonymousMode">Enable anonymous mode</label>
                    </div>
                </div>

                <div class="role-fields mt-3" data-fields="PRO_MENTOR">
                    <div class="notice info mb-3"><i class="bi bi-info-circle"></i><span>Your account stays pending until an admin reviews the evidence.</span></div>
                    <div class="mb-3">
                        <label class="form-label" for="evidenceUrl">Google Drive evidence link</label>
                        <input id="evidenceUrl" type="url" name="evidenceUrl" class="form-control" placeholder="https://drive.google.com/..." disabled>
                    </div>
                    <div>
                        <label class="form-label" for="achievements">Qualifications and achievements</label>
                        <textarea id="achievements" name="achievements" class="form-control" rows="4" placeholder="IELTS, JLPT, HSK, degree, teaching experience..." disabled></textarea>
                    </div>
                </div>

                <div class="role-fields mt-3" data-fields="CONTENT_CREATOR">
                    <div class="notice info mb-3"><i class="bi bi-credit-card"></i><span>Mock checkout: no real charge is made in this version.</span></div>
                    <label class="form-label" for="paymentMethod">Payment method</label>
                    <select id="paymentMethod" name="paymentMethod" class="form-select" disabled>
                        <option value="DOMESTIC_CARD">Domestic bank card</option>
                        <option value="VISA">Visa</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-submit w-100 mt-4">Create account</button>
            </form>
            <div class="footer-link">Already registered? <a href="${pageContext.request.contextPath}/login">Sign in</a></div>
        </section>
    </div>
</main>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const accountType = document.getElementById('accountType');
    const options = document.querySelectorAll('.account-option');
    const fields = document.querySelectorAll('.role-fields');
    const email = document.getElementById('email');
    const sendButton = document.getElementById('btnSendOtp');
    const feedback = document.getElementById('otpFeedback');
    let countdownTimer;

    options.forEach(function (option) {
        option.addEventListener('click', function () {
            const selected = option.dataset.account;
            accountType.value = selected;
            options.forEach(function (item) { item.classList.toggle('selected', item === option); });
            fields.forEach(function (group) {
                const active = group.dataset.fields === selected;
                group.classList.toggle('active', active);
                group.querySelectorAll('input, textarea, select').forEach(function (control) {
                    control.disabled = !active;
                    if (control.id === 'evidenceUrl' || control.id === 'achievements') control.required = active;
                });
            });
        });
    });

    function setFeedback(message, success) {
        feedback.textContent = message;
        feedback.style.color = success ? '#027A48' : '#B42318';
    }

    function beginCountdown(seconds) {
        clearInterval(countdownTimer);
        sendButton.disabled = true;
        let left = Number(seconds) || 60;
        sendButton.textContent = 'Resend in ' + left + 's';
        countdownTimer = setInterval(function () {
            left -= 1;
            if (left <= 0) {
                clearInterval(countdownTimer);
                sendButton.disabled = false;
                sendButton.textContent = 'Resend OTP';
            } else {
                sendButton.textContent = 'Resend in ' + left + 's';
            }
        }, 1000);
    }

    sendButton.addEventListener('click', function () {
        const value = email.value.trim();
        if (!email.checkValidity()) {
            email.reportValidity();
            setFeedback('Enter a valid email address first.', false);
            return;
        }
        sendButton.disabled = true;
        sendButton.textContent = 'Sending...';
        fetch('${pageContext.request.contextPath}/send-otp', {
            method:'POST',
            headers:{'Content-Type':'application/x-www-form-urlencoded'},
            body:'email=' + encodeURIComponent(value)
        })
        .then(function (response) { return response.json(); })
        .then(function (data) {
            setFeedback(data.message || 'Unable to send OTP.', Boolean(data.success));
            if (data.success) beginCountdown(60);
            else if (data.retryAfter) beginCountdown(data.retryAfter);
            else { sendButton.disabled = false; sendButton.textContent = 'Send OTP'; }
        })
        .catch(function () {
            setFeedback('Could not contact the server. Please try again.', false);
            sendButton.disabled = false;
            sendButton.textContent = 'Send OTP';
        });
    });

    document.getElementById('password').addEventListener('input', function (event) {
        const value = event.target.value;
        const score = [/[a-z]/, /[A-Z]/, /[0-9]/, /[^A-Za-z0-9]/].filter(function (rule) { return rule.test(value); }).length;
        const label = value.length < 8 ? 'Use at least 8 characters' : (score >= 4 ? 'Strong password' : (score >= 2 ? 'Medium password' : 'Weak password'));
        const color = value.length < 8 || score < 2 ? '#B42318' : (score >= 4 ? '#027A48' : '#B54708');
        const indicator = document.getElementById('passwordStrength');
        indicator.textContent = label;
        indicator.style.color = color;
    });
});
</script>
</body>
</html>
