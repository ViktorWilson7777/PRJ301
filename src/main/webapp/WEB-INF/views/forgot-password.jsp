<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset password | LUCY LMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body{font-family:Arial,sans-serif;background:#11101C;min-height:100vh;display:grid;place-items:center;margin:0;padding:18px;color:#172033}
        .reset-card{background:#fff;width:min(470px,100%);padding:32px;border-radius:8px;box-shadow:0 18px 45px rgba(0,0,0,.3)}
        h1{font-size:23px;font-weight:700}.form-label{font-size:13px;font-weight:600;color:#475467}
        .form-control{border-radius:8px;padding:10px 12px}.otp-button,.submit-button{background:#6558E8;color:#fff;border:0;font-weight:700}
        .otp-button{border-radius:0 8px 8px 0;min-width:115px}.otp-button:disabled{opacity:1;background:#E9E7FF;color:#5145CD}
        .submit-button{border-radius:8px;padding:11px}.notice{border:1px solid #FECDCA;background:#FEF3F2;color:#B42318;border-radius:8px;padding:10px 12px;font-size:13px}
        #feedback{font-size:12px;min-height:18px;margin-top:6px}a{color:#6558E8;text-decoration:none;font-weight:600;font-size:13px}
    </style>
</head>
<body>
<main class="reset-card">
    <a href="${pageContext.request.contextPath}/login"><i class="bi bi-arrow-left"></i> Back to sign in</a>
    <h1 class="mt-3">Reset your password</h1>
    <p class="text-muted" style="font-size:13px">We will send a six-digit code to the email registered with LUCY.</p>
    <c:if test="${not empty error}"><div class="notice mb-3">${error}</div></c:if>
    <form method="post" action="${pageContext.request.contextPath}/reset-password">
        <div class="mb-3">
            <label class="form-label" for="resetEmail">Email address</label>
            <div class="input-group">
                <input id="resetEmail" type="email" name="email" class="form-control" autocomplete="email" required>
                <button id="sendResetOtp" type="button" class="otp-button">Send OTP</button>
            </div>
            <div id="feedback" aria-live="polite"></div>
        </div>
        <div class="mb-3"><label class="form-label" for="otp">OTP code</label><input id="otp" type="text" name="otp" class="form-control" maxlength="6" pattern="[0-9]{6}" inputmode="numeric" required></div>
        <div class="mb-3"><label class="form-label" for="newPassword">New password</label><input id="newPassword" type="password" name="newPassword" class="form-control" minlength="8" autocomplete="new-password" required></div>
        <div class="mb-4"><label class="form-label" for="confirmPassword">Confirm new password</label><input id="confirmPassword" type="password" name="confirmPassword" class="form-control" minlength="8" autocomplete="new-password" required></div>
        <button class="submit-button w-100" type="submit">Change password</button>
    </form>
</main>
<script>
document.addEventListener('DOMContentLoaded',function(){
    const button=document.getElementById('sendResetOtp'),email=document.getElementById('resetEmail'),feedback=document.getElementById('feedback');
    let timer;
    function countdown(seconds){clearInterval(timer);let left=Number(seconds)||60;button.disabled=true;button.textContent='Resend in '+left+'s';timer=setInterval(function(){left--;if(left<=0){clearInterval(timer);button.disabled=false;button.textContent='Resend OTP';}else button.textContent='Resend in '+left+'s';},1000);}
    button.addEventListener('click',function(){
        if(!email.checkValidity()){email.reportValidity();return;}
        button.disabled=true;button.textContent='Sending...';
        fetch('${pageContext.request.contextPath}/forgot-password/send-otp',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:'email='+encodeURIComponent(email.value.trim())})
        .then(function(r){return r.json();}).then(function(data){feedback.textContent=data.message;feedback.style.color=data.success?'#027A48':'#B42318';if(data.success||data.retryAfter)countdown(data.retryAfter||60);else{button.disabled=false;button.textContent='Send OTP';}})
        .catch(function(){feedback.textContent='Could not contact the server.';feedback.style.color='#B42318';button.disabled=false;button.textContent='Send OTP';});
    });
});
</script>
</body>
</html>
