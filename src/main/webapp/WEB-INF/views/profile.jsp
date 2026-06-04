<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="My Profile">

<div class="row g-4 animate-in">
    <!-- Left Column: Edit Profile -->
    <div class="col-lg-6">
        <div class="stat-card">
            <h5 style="font-weight: 600; margin-bottom: 20px;">
                <i class="bi bi-person-bounding-box me-1" style="color: var(--lucy-primary);"></i> Edit Profile Details
            </h5>

            <c:if test="${param.success == 'profile_updated'}">
                <div class="alert alert-success" style="border-radius: 10px; font-size: 13.5px; padding: 8px 12px;">
                    <i class="bi bi-check-circle-fill me-2"></i> Profile updated successfully!
                </div>
            </c:if>

            <form method="post" action="/profile/save" class="lucy-form" style="border: none; padding: 0;">
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
                    <label class="form-label">Avatar Persona (e.g. Emoji Character)</label>
                    <input type="text" name="avatarPersona" class="form-control" value="${user.avatarPersona}" placeholder="e.g. CuriousPanda🐼" />
                </div>
                <div class="mb-4">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" name="anonymousMode" id="anonymousSwitch" ${user.anonymousMode ? 'checked' : ''} />
                        <label class="form-check-label" for="anonymousSwitch" style="font-size: 13.5px; font-weight: 500; cursor: pointer;">Enable Anonymous Mode (uses Avatar Persona inside rooms)</label>
                    </div>
                </div>
                <button type="submit" class="btn btn-lucy w-100"><i class="bi bi-save me-1"></i> Save Changes</button>
            </form>
        </div>
    </div>

    <!-- Right Column: Account Status & Upgrades -->
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

            <div class="row text-center g-2 mb-2">
                <div class="col-6">
                    <div style="background: #fff; padding: 12px; border-radius: 10px; border: 1px solid #E8ECF1;">
                        <span class="text-muted" style="font-size: 11px;">Reputation Score</span>
                        <div style="font-size: 20px; font-weight: 700; color: #1A1A2E;">⭐ ${user.reputationScore}</div>
                    </div>
                </div>
                <div class="col-6">
                    <div style="background: #fff; padding: 12px; border-radius: 10px; border: 1px solid #E8ECF1;">
                        <span class="text-muted" style="font-size: 11px;">Account Status</span>
                        <div style="font-size: 20px; font-weight: 700; color: var(--lucy-success);">
                            ${user.active ? 'Active' : 'Suspended'}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Role Upgrade Matrix Card -->
        <c:if test="${user.role != 'ADMIN'}">
            <div class="stat-card">
                <h5 style="font-weight: 600; margin-bottom: 20px;">
                    <i class="bi bi-arrow-up-circle me-1" style="color: var(--lucy-success);"></i> Upgrade Account Level
                </h5>

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
                    <!-- Option 1: Pro Mentor -->
                    <div style="background: #F8F9FB; border-radius: 12px; padding: 16px; border: 1px solid #E8ECF1; position: relative;">
                        <span class="badge bg-purple position-absolute" style="top: 16px; right: 16px; font-size: 10px;">150 CREDITS</span>
                        <h6 style="font-weight: 700; margin-bottom: 6px;">Pro Mentor Tier</h6>
                        <p class="text-muted mb-3" style="font-size: 12px;">Host specialized learning rooms, ghim Slide/Tài liệu, and manage student list in dashboard.</p>
                        
                        <c:choose>
                            <c:when test="${user.role == 'PRO_MENTOR' || user.role == 'SUPER_CREATOR'}">
                                <button class="btn btn-secondary btn-sm w-100" disabled style="border-radius: 8px;">Active / Unlocked</button>
                            </c:when>
                            <c:otherwise>
                                <form method="post" action="/profile/upgrade">
                                    <input type="hidden" name="newRole" value="PRO_MENTOR" />
                                    <button type="submit" class="btn btn-purple btn-sm w-100" style="border-radius: 8px; background: var(--lucy-primary); color: #fff; border: none;" onclick="return confirm('Upgrade to Pro Mentor for 150 credits?')">
                                        <i class="bi bi-unlock me-1"></i> Unlock Pro Mentor
                                    </button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Option 2: Super Creator -->
                    <div style="background: #F8F9FB; border-radius: 12px; padding: 16px; border: 1px solid #E8ECF1; position: relative;">
                        <span class="badge bg-danger position-absolute" style="top: 16px; right: 16px; font-size: 10px; background-color: var(--lucy-accent2) !important;">300 CREDITS</span>
                        <h6 style="font-weight: 700; margin-bottom: 6px;">Super Creator Tier</h6>
                        <p class="text-muted mb-3" style="font-size: 12px;">Unlock live classroom Audio Recording, auto-publish Podcasts, and sell premium course content.</p>
                        
                        <c:choose>
                            <c:when test="${user.role == 'SUPER_CREATOR'}">
                                <button class="btn btn-secondary btn-sm w-100" disabled style="border-radius: 8px;">Active / Unlocked</button>
                            </c:when>
                            <c:otherwise>
                                <form method="post" action="/profile/upgrade">
                                    <input type="hidden" name="newRole" value="SUPER_CREATOR" />
                                    <button type="submit" class="btn btn-danger btn-sm w-100" style="border-radius: 8px; background: var(--lucy-accent2); color: #fff; border: none;" onclick="return confirm('Upgrade to Super Creator for 300 credits?')">
                                        <i class="bi bi-unlock me-1"></i> Unlock Super Creator
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

</layout:main>
