<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="My Profile">

<c:set var="activeTab" value="profile" />
<c:if test="${param.success == 'password_changed' || param.error == 'wrong_password' || param.error == 'weak_password'}">
    <c:set var="activeTab" value="security" />
</c:if>
<c:if test="${param.tab == 'security'}"><c:set var="activeTab" value="security" /></c:if>
<c:if test="${param.tab == 'account'}"><c:set var="activeTab" value="account" /></c:if>
<c:if test="${param.success == 'role_upgraded' || param.error == 'insufficient_credits' || param.error == 'already_role'}">
    <c:set var="activeTab" value="account" />
</c:if>

<div class="animate-in">
    <!-- Nav tabs -->
    <ul class="nav nav-pills mb-4" id="profileTabs" role="tablist" style="gap: 10px;">
        <li class="nav-item" role="presentation">
            <button class="nav-link ${activeTab == 'profile' ? 'active' : ''}" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="${activeTab == 'profile'}" style="border-radius: 10px; font-weight: 500;">
                <i class="bi bi-person-bounding-box me-1"></i> Edit Profile
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link ${activeTab == 'security' ? 'active' : ''}" id="security-tab" data-bs-toggle="tab" data-bs-target="#security" type="button" role="tab" aria-controls="security" aria-selected="${activeTab == 'security'}" style="border-radius: 10px; font-weight: 500;">
                <i class="bi bi-shield-lock me-1"></i> Account/Password
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link ${activeTab == 'account' ? 'active' : ''}" id="account-tab" data-bs-toggle="tab" data-bs-target="#account" type="button" role="tab" aria-controls="account" aria-selected="${activeTab == 'account'}" style="border-radius: 10px; font-weight: 500;">
                <i class="bi bi-arrow-up-circle me-1"></i> Account Upgrade
            </button>
        </li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content" id="profileTabsContent">
        
        <!-- ==================== TAB 1: EDIT PROFILE ==================== -->
        <div class="tab-pane fade ${activeTab == 'profile' ? 'show active' : ''}" id="profile" role="tabpanel" aria-labelledby="profile-tab">
            <div class="row g-4">
                <div class="col-lg-8">
                    <!-- Avatar Upload -->
                    <div class="stat-card mb-4">
                        <h5 style="font-weight: 600; margin-bottom: 20px;">
                            <i class="bi bi-camera me-1" style="color: var(--lucy-primary);"></i> Profile Picture
                        </h5>
                        <div class="d-flex align-items-center gap-4">
                            <div style="width: 80px; height: 80px; border-radius: 50%; background: #F1F5F9; display: flex; align-items: center; justify-content: center; overflow: hidden; border: 2px solid #E2E8F0;">
                                <c:choose>
                                    <c:when test="${not empty user.avatarUrl}">
                                        <img id="avatarPreview" src="${pageContext.request.contextPath}${user.avatarUrl}" alt="Avatar" style="width: 100%; height: 100%; object-fit: cover;" />
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-person-fill" style="font-size: 40px; color: #94A1B2;"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <form method="post" action="${pageContext.request.contextPath}/profile/upload-avatar" enctype="multipart/form-data" class="flex-grow-1">
                                <div class="input-group">
                                    <input id="avatarFile" type="file" class="form-control" name="avatarFile" accept="image/jpeg,image/png,image/webp,image/gif" required>
                                    <button class="btn btn-lucy" type="submit"><i class="bi bi-cloud-arrow-up me-1"></i>Upload</button>
                                </div>
                                <small class="text-muted mt-1 d-block">Recommended: Square image, max 2MB.</small>
                                <c:if test="${param.error == 'invalid_avatar'}"><div class="alert alert-danger mt-2 py-2">Choose a JPG, PNG, WebP, or GIF image under 2MB.</div></c:if>
                                <c:if test="${param.error == 'upload_failed'}"><div class="alert alert-danger mt-2 py-2">The image could not be saved. Please try another file.</div></c:if>
                                <c:if test="${param.success == 'avatar_uploaded'}"><div class="alert alert-success mt-2 py-2">Profile picture updated.</div></c:if>
                            </form>
                        </div>
                    </div>

                    <!-- Edit Profile -->
                    <div class="stat-card mb-4">
                        <h5 style="font-weight: 600; margin-bottom: 20px;">
                            <i class="bi bi-person-bounding-box me-1" style="color: var(--lucy-primary);"></i> Edit Profile Details
                        </h5>

                        <c:if test="${param.success == 'profile_updated'}">
                            <div class="alert alert-success" style="border-radius: 10px; font-size: 13.5px; padding: 8px 12px;">
                                <i class="bi bi-check-circle-fill me-2"></i> Profile updated successfully!
                            </div>
                        </c:if>

                        <form method="post" action="${pageContext.request.contextPath}/profile/save" class="lucy-form" style="border: none; padding: 0;">
                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" name="fullName" class="form-control" value="${user.fullName}" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email Address (Read-only)</label>
                                <input type="email" class="form-control" value="${user.email}" readonly style="background: #F3F4F6; border-color: #E5E7EB; color: #6B7280;" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Display Name (Nickname)</label>
                                <input type="text" name="displayName" class="form-control" value="${user.displayName}" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Avatar Persona (Anonymous Mode Avatar)</label>
                                <input type="hidden" name="avatarPersona" id="avatarPersona" value="${user.avatarPersona}" />
                                
                                <div class="d-flex flex-wrap gap-2 mt-1" id="persona-picker">
                                    <c:set var="personas" value="🐶,🐱,🐬,🐧,🦊,🐼,🐰,🐻,🦁,🐸" />
                                    <c:forEach items="${personas}" var="p">
                                        <button type="button" class="btn btn-outline-secondary persona-btn ${user.avatarPersona == p ? 'active' : ''}" 
                                                style="font-size: 24px; padding: 5px 12px; border-radius: 8px; border-color: #E2E8F0;"
                                                onclick="selectPersona('${p}', this)">
                                            ${p}
                                        </button>
                                    </c:forEach>
                                </div>
                                <small class="text-muted mt-2 d-block">Select a 2D animal avatar to represent you when Anonymous Mode is active.</small>
                            </div>
                            <div class="mb-4">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" name="anonymousMode" id="anonymousSwitch" ${user.anonymousMode ? 'checked' : ''} />
                                    <label class="form-check-label" for="anonymousSwitch" style="font-size: 13.5px; font-weight: 500; cursor: pointer;">Enable Anonymous Mode</label>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-lucy w-100"><i class="bi bi-save me-1"></i> Save Changes</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

<script>
function selectPersona(emoji, btnElement) {
    document.getElementById('avatarPersona').value = emoji;
    const buttons = document.querySelectorAll('#persona-picker .persona-btn');
    buttons.forEach(btn => {
        btn.classList.remove('active');
        btn.style.borderColor = '#E2E8F0';
        btn.style.backgroundColor = 'transparent';
    });
    btnElement.classList.add('active');
    btnElement.style.borderColor = 'var(--lucy-primary)';
    btnElement.style.backgroundColor = 'rgba(108, 92, 231, 0.1)';
}

// Highlight the initial selected one
document.addEventListener("DOMContentLoaded", function() {
    const activeBtn = document.querySelector('#persona-picker .persona-btn.active');
    if (activeBtn) {
        activeBtn.style.borderColor = 'var(--lucy-primary)';
        activeBtn.style.backgroundColor = 'rgba(108, 92, 231, 0.1)';
    }
    const avatarFile = document.getElementById('avatarFile');
    if (avatarFile) {
        avatarFile.addEventListener('change', function () {
            const file = avatarFile.files && avatarFile.files[0];
            const preview = document.getElementById('avatarPreview');
            if (file && preview) preview.src = URL.createObjectURL(file);
        });
    }
});
</script>

        <!-- ==================== TAB 2: SECURITY & PASSWORD ==================== -->
        <div class="tab-pane fade ${activeTab == 'security' ? 'show active' : ''}" id="security" role="tabpanel" aria-labelledby="security-tab">
            <div class="row g-4">
                <div class="col-lg-6">
                    <!-- Change Password -->
                    <div class="stat-card">
                        <h5 style="font-weight: 600; margin-bottom: 20px;">
                            <i class="bi bi-shield-lock me-1" style="color: var(--lucy-primary);"></i> Change Password
                        </h5>
                        
                        <c:if test="${param.success == 'password_changed'}">
                            <div class="alert alert-success" style="border-radius: 10px; font-size: 13.5px; padding: 8px 12px;">
                                <i class="bi bi-check-circle-fill me-2"></i> Password updated successfully!
                            </div>
                        </c:if>
                        <c:if test="${param.error == 'wrong_password'}">
                            <div class="alert alert-danger" style="border-radius: 10px; font-size: 13.5px; padding: 8px 12px;">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i> Incorrect current password!
                            </div>
                        </c:if>
                        <c:if test="${param.error == 'weak_password'}"><div class="alert alert-danger py-2">New password must contain at least 8 characters.</div></c:if>

                        <form method="post" action="${pageContext.request.contextPath}/profile/change-password" class="lucy-form" style="border: none; padding: 0;">
                            <div class="mb-3">
                                <label class="form-label">Current Password</label>
                                <input type="password" name="currentPassword" class="form-control" required />
                            </div>
                            <div class="mb-4">
                                <label class="form-label">New Password</label>
                                <input type="password" name="newPassword" class="form-control" minlength="8" required />
                            </div>
                            <button type="submit" class="btn btn-outline-dark w-100"><i class="bi bi-key me-1"></i> Update Password</button>
                        </form>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="stat-card">
                        <h5 style="font-weight:600;margin-bottom:12px"><i class="bi bi-envelope-key me-1" style="color:var(--lucy-primary)"></i> Forgot password / Reset with OTP</h5>
                        <p class="text-muted" style="font-size:13px">We will send a 6-digit OTP to your registered email: <strong><c:out value="${user.email}" /></strong></p>
                        <c:if test="${not empty resetError}"><div class="alert alert-danger py-2"><c:out value="${resetError}" /></div></c:if>
                        <div id="profileOtpFeedback" class="alert d-none py-2" role="alert"></div>
                        <button id="sendProfileOtp" type="button" class="btn btn-outline-primary w-100 mb-3"><i class="bi bi-send me-1"></i> Send OTP to email</button>
                        <form method="post" action="${pageContext.request.contextPath}/profile/reset-password" class="lucy-form" style="border:none;padding:0">
                            <div class="mb-3"><label class="form-label">OTP code</label><input type="text" name="otp" class="form-control" inputmode="numeric" pattern="[0-9]{6}" maxlength="6" required /></div>
                            <div class="mb-3"><label class="form-label">New password</label><input type="password" name="newPassword" class="form-control" minlength="8" required /></div>
                            <div class="mb-3"><label class="form-label">Confirm new password</label><input type="password" name="confirmPassword" class="form-control" minlength="8" required /></div>
                            <button type="submit" class="btn btn-lucy w-100"><i class="bi bi-arrow-repeat me-1"></i> Reset password</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
        document.addEventListener('DOMContentLoaded', function () {
            const button = document.getElementById('sendProfileOtp');
            const feedback = document.getElementById('profileOtpFeedback');
            if (!button) return;
            button.addEventListener('click', async function () {
                button.disabled = true;
                feedback.className = 'alert alert-info py-2';
                feedback.textContent = 'Sending OTP...';
                try {
                    const response = await fetch('${pageContext.request.contextPath}/profile/forgot-password/send-otp', { method: 'POST' });
                    const result = await response.json();
                    feedback.className = 'alert py-2 ' + (result.success ? 'alert-success' : 'alert-danger');
                    feedback.textContent = result.message;
                    if (!result.success) button.disabled = false;
                    if (result.success) setTimeout(function () { button.disabled = false; }, 60000);
                } catch (error) {
                    feedback.className = 'alert alert-danger py-2';
                    feedback.textContent = 'Could not send OTP. Please try again.';
                    button.disabled = false;
                }
            });
        });
        </script>

        <!-- ==================== TAB 3: ACCOUNT & UPGRADE ==================== -->
        <div class="tab-pane fade ${activeTab == 'account' ? 'show active' : ''}" id="account" role="tabpanel" aria-labelledby="account-tab">
            <div class="row g-4">
                <div class="col-lg-6">
                    <!-- Account Status Card -->
                    <div class="stat-card mb-4" style="background: linear-gradient(135deg, #FAF8FF 0%, #FFFFFF 100%);">
                        <h5 style="font-weight: 600; margin-bottom: 20px;">
                            <i class="bi bi-shield-check me-1" style="color: var(--lucy-primary);"></i> Account Status
                        </h5>

                        <div class="d-flex align-items-center justify-content-between mb-3 pb-3" style="border-bottom: 1px solid #E8ECF1;">
                            <div>
                                <span class="text-muted" style="font-size: 13px;">Current Role</span>
                                <h4 style="font-weight: 700; color: #1A1A2E; margin: 4px 0 0;">
                                    <c:choose>
                                        <c:when test="${user.role == 'ADMIN'}"><span class="badge-status badge-danger">ADMINISTRATOR</span></c:when>
                                        <c:when test="${user.role == 'PRO_MENTOR'}"><span class="badge-status badge-purple">PRO MENTOR</span></c:when>
                                        <c:when test="${user.role == 'SUPER_CREATOR'}"><span class="badge-status badge-pink">SUPER CREATOR</span></c:when>
                                        <c:otherwise><span class="badge-status badge-success">LEARNER</span></c:otherwise>
                                    </c:choose>
                                </h4>
                            </div>
                            <div class="text-end">
                                <span class="text-muted" style="font-size: 13px;">Available Credits</span>
                                <h4 style="font-weight: 700; color: var(--lucy-primary); margin: 4px 0 0;">
                                    ${user.creditBalance} <small style="font-size: 12px; font-weight: 500; color: #6B7280;">Credits</small>
                                </h4>
                            </div>
                        </div>

                        <div class="mb-4" style="background:#F8FAFC;border:1px solid #E2E8F0;padding:16px;border-radius:8px">
                            <div class="d-flex justify-content-between mb-3"><strong>Language levels</strong><span class="text-muted" style="font-size:12px">1 XP / speaking minute</span></div>
                            <c:choose>
                                <c:when test="${empty programLevels}">
                                    <div class="text-muted" style="font-size:13px">You start at Level 1 in every language program. A progress bar appears after your first speaking session.</div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="programLevel" items="${programLevels}">
                                        <c:set var="programProgress" value="${programLevel.experiencePoints % 100}" />
                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between mb-1">
                                                <span style="font-weight:700"><c:out value="${programLevel.program.title}"/> · Level ${programLevel.levelNumber}</span>
                                                <span style="font-size:12px;color:#667085">${programLevel.experiencePoints} XP</span>
                                            </div>
                                            <div class="progress" style="height:8px"><div class="progress-bar bg-warning" style="width:${programProgress}%"></div></div>
                                            <c:if test="${programLevel.maxHostingLevel > 0}"><div class="form-text">Can host through Level ${programLevel.maxHostingLevel}</div></c:if>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="row text-center g-2 mb-2">
                            <div class="col-12">
                                <div style="background: #fff; padding: 12px; border-radius: 10px; border: 1px solid #E8ECF1;">
                                    <span class="text-muted" style="font-size: 11px;">Account Status</span>
                                    <div style="font-size: 18px; font-weight: 700; color: var(--lucy-success);">
                                        ${user.active ? 'Active & Verified' : 'Suspended'}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <!-- Role Upgrade Matrix Card -->
                    <c:if test="${user.role != 'ADMIN'}">
                        <div class="stat-card">
                            <h5 style="font-weight: 600; margin-bottom: 20px;">
                                <i class="bi bi-arrow-up-circle me-1" style="color: var(--lucy-success);"></i> Upgrade Account Level
                            </h5>

                            <c:if test="${not empty success}"><div class="alert alert-success"><c:out value="${success}" /></div></c:if>
                            <c:if test="${not empty error}"><div class="alert alert-danger"><c:out value="${error}" /></div></c:if>

                            <c:if test="${param.success == 'role_upgraded'}">
                                <div class="alert alert-success" style="border-radius: 10px; font-size: 13.5px; padding: 8px 12px;">
                                    <i class="bi bi-check-circle-fill me-2"></i> Congratulations! Your account has been upgraded.
                                </div>
                            </c:if>
                            <c:if test="${param.error == 'insufficient_credits'}">
                                <div class="alert alert-danger" style="border-radius: 10px; font-size: 13.5px; padding: 8px 12px;">
                                    <i class="bi bi-exclamation-octagon-fill me-2"></i> Insufficient credit balance. Please recharge.
                                </div>
                            </c:if>
                            <c:if test="${param.error == 'already_role'}">
                                <div class="alert alert-warning" style="border-radius: 10px; font-size: 13.5px; padding: 8px 12px;">
                                    <i class="bi bi-info-circle-fill me-2"></i> You already have this role.
                                </div>
                            </c:if>

                            <div class="d-grid gap-3">
                                <div style="background: #F8F9FB; border-radius: 8px; padding: 16px; border: 1px solid #E8ECF1; position: relative;">
                                    <span class="badge bg-purple position-absolute" style="top: 16px; right: 16px; font-size: 10px;">EARNED</span>
                                    <h6 style="font-weight: 700; margin-bottom: 6px;">Pro Mentor Tier</h6>
                                    <p class="text-muted mb-3" style="font-size: 12px;">Pro Mentor cannot be purchased. Complete every stage of a course or receive approval from an administrator.</p>
                                    
                                    <c:choose>
                                        <c:when test="${user.role == 'PRO_MENTOR'}">
                                            <button class="btn btn-secondary btn-sm w-100" disabled style="border-radius: 8px;">Active / Unlocked</button>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${user.registrationStatus == 'PENDING'}">
                                                    <div class="alert alert-warning py-2 mb-0">Application pending administrator review.</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <form method="post" action="${pageContext.request.contextPath}/profile/apply-pro">
                                                        <label class="form-label">Google Drive certificate link</label>
                                                        <input type="url" name="evidenceUrl" class="form-control mb-2" placeholder="https://drive.google.com/..." required />
                                                        <label class="form-label">Certificate / language experience description</label>
                                                        <textarea name="achievements" class="form-control mb-2" rows="3" required></textarea>
                                                        <button class="btn btn-outline-primary btn-sm w-100" type="submit"><i class="bi bi-send me-1"></i>Send Pro application</button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div style="background: #F8F9FB; border-radius: 8px; padding: 16px; border: 1px solid #E8ECF1; position: relative;">
                                    <span class="badge bg-danger position-absolute" style="top: 16px; right: 16px; font-size: 10px; background-color: var(--lucy-accent2) !important;">100,000 CREDITS</span>
                                    <h6 style="font-weight: 700; margin-bottom: 6px;">Content Creator</h6>
                                    <p class="text-muted mb-3" style="font-size: 12px;">Publish MP3 podcasts while keeping learner access. Storage can be expanded later with credits.</p>
                                    
                                    <c:choose>
                                        <c:when test="${user.accountType == 'CONTENT_CREATOR' || user.role == 'SUPER_CREATOR'}">
                                            <button class="btn btn-secondary btn-sm w-100" disabled style="border-radius: 8px;">Active / Unlocked</button>
                                        </c:when>
                                        <c:otherwise>
                                            <form method="post" action="${pageContext.request.contextPath}/profile/upgrade">
                                                <input type="hidden" name="newRole" value="SUPER_CREATOR" />
                                                <button type="submit" class="btn btn-danger btn-sm w-100" style="border-radius: 8px; background: var(--lucy-accent2); color: #fff; border: none;">
                                                    <i class="bi bi-mic me-1"></i> Upgrade to Content Creator
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

</layout:main>
