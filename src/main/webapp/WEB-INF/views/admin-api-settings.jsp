<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="API & Email Settings">

<div class="mb-4">
    <h4 class="mb-1" style="font-weight:700;color:#1E293B;">Integrations</h4>
    <p class="text-muted mb-0" style="font-size:13px;">
        Configure AI generation and check the email service used for OTP messages.
    </p>
</div>

<c:if test="${not empty settingsSuccess}">
    <div class="alert alert-success d-flex align-items-center" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>
        <c:out value="${settingsSuccess}" />
    </div>
</c:if>
<c:if test="${not empty settingsError}">
    <div class="alert alert-danger d-flex align-items-center" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i>
        <c:out value="${settingsError}" />
    </div>
</c:if>
<c:if test="${not empty mailSettingsSuccess}">
    <div class="alert alert-success d-flex align-items-center" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>
        <c:out value="${mailSettingsSuccess}" />
    </div>
</c:if>
<c:if test="${not empty mailSettingsError}">
    <div class="alert alert-danger d-flex align-items-center" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i>
        <c:out value="${mailSettingsError}" />
    </div>
</c:if>

<div class="row g-4">
    <div class="col-xl-7">
        <div class="stat-card h-100" style="transform:none;">
            <div class="d-flex align-items-start justify-content-between gap-3 mb-4">
                <div class="d-flex align-items-center gap-3">
                    <div class="stat-icon" style="background:#F3E8FF;color:#7C3AED;">
                        <i class="bi bi-stars"></i>
                    </div>
                    <div>
                        <h5 class="mb-1" style="font-weight:700;">OpenRouter AI</h5>
                        <p class="text-muted mb-0" style="font-size:12.5px;">Used by AI questions and quiz generation</p>
                    </div>
                </div>
                <c:choose>
                    <c:when test="${apiConfigured}">
                        <span class="badge-status badge-success"><i class="bi bi-check-circle me-1"></i>Configured</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge-status badge-warning"><i class="bi bi-exclamation-circle me-1"></i>Preview mode</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="p-3 mb-4" style="background:#F8FAFC;border:1px solid #E2E8F0;border-radius:10px;">
                <div class="row g-3">
                    <div class="col-sm-6">
                        <div class="text-muted mb-1" style="font-size:11px;text-transform:uppercase;font-weight:600;">Saved key</div>
                        <code style="color:#475569;"><c:out value="${maskedApiKey}" /></code>
                    </div>
                    <div class="col-sm-6">
                        <div class="text-muted mb-1" style="font-size:11px;text-transform:uppercase;font-weight:600;">Active model</div>
                        <code style="color:#475569;"><c:out value="${openRouterModel}" /></code>
                    </div>
                </div>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/admin/api-settings">
                <div class="mb-3">
                    <label for="apiKey" class="form-label" style="font-weight:600;">New OpenRouter API key</label>
                    <input id="apiKey" name="apiKey" type="password" class="form-control"
                           autocomplete="new-password" placeholder="Leave blank to keep the saved key" />
                    <div class="form-text">
                        Create a key at
                        <a href="https://openrouter.ai/keys" target="_blank" rel="noopener noreferrer">openrouter.ai/keys <i class="bi bi-box-arrow-up-right"></i></a>.
                        The saved key is never displayed in plain text.
                    </div>
                </div>

                <div class="mb-3">
                    <label for="model" class="form-label" style="font-weight:600;">Model ID</label>
                    <input id="model" name="model" type="text" class="form-control"
                           value="<c:out value='${openRouterModel}' />" required
                           placeholder="openrouter/auto" />
                    <div class="form-text">Use <code>openrouter/auto</code> to let OpenRouter choose an available model.</div>
                </div>

                <div class="form-check mb-4">
                    <input id="clearApiKey" name="clearApiKey" value="true" type="checkbox" class="form-check-input" />
                    <label for="clearApiKey" class="form-check-label text-danger">Remove the saved API key and return to preview mode</label>
                </div>

                <button type="submit" class="btn btn-lucy">
                    <i class="bi bi-floppy me-1"></i> Save API Settings
                </button>
            </form>

            <div class="alert alert-light border mt-4 mb-0" style="font-size:12.5px;color:#64748B;">
                <i class="bi bi-info-circle me-1"></i>
                Changes apply immediately to this running server. Runtime changes are cleared when the application restarts;
                set <code>OPENROUTER_API_KEY</code> and <code>OPENROUTER_MODEL</code> environment variables for permanent deployment configuration.
            </div>
        </div>
    </div>

    <div class="col-xl-5">
        <div class="stat-card h-100" style="transform:none;">
            <div class="d-flex align-items-start justify-content-between gap-3 mb-4">
                <div class="d-flex align-items-center gap-3">
                    <div class="stat-icon" style="background:#ECFDF5;color:#059669;">
                        <i class="bi bi-envelope-check"></i>
                    </div>
                    <div>
                        <h5 class="mb-1" style="font-weight:700;">Email / OTP</h5>
                        <p class="text-muted mb-0" style="font-size:12.5px;">Password reset and registration codes</p>
                    </div>
                </div>
                <c:choose>
                    <c:when test="${smtpConfigured}">
                        <span class="badge-status badge-success">Configured</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge-status badge-warning">Not configured</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <p style="font-size:13px;color:#475569;">
                LUCY uses Gmail SMTP to deliver registration and forgotten-password OTP codes. Credentials are read by the server only and are never shown on this page.
            </p>

            <div class="p-3 mb-3" style="background:#F8FAFC;border:1px solid #E2E8F0;border-radius:10px;">
                <div class="row g-2">
                    <div class="col-12">
                        <div class="text-muted mb-1" style="font-size:11px;text-transform:uppercase;font-weight:600;">Gmail account</div>
                        <code><c:out value="${maskedMailUsername}" /></code>
                    </div>
                    <div class="col-12">
                        <div class="text-muted mb-1" style="font-size:11px;text-transform:uppercase;font-weight:600;">App Password</div>
                        <code><c:out value="${maskedMailPassword}" /></code>
                    </div>
                </div>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/admin/api-settings/email" class="mb-4">
                <div class="mb-3">
                    <label for="mailUsername" class="form-label" style="font-weight:600;">Gmail address</label>
                    <input id="mailUsername" name="mailUsername" type="email" class="form-control"
                           autocomplete="username" placeholder="Leave blank to keep the current address" />
                </div>
                <div class="mb-3">
                    <label for="mailAppPassword" class="form-label" style="font-weight:600;">Gmail App Password</label>
                    <input id="mailAppPassword" name="mailAppPassword" type="password" class="form-control"
                           autocomplete="new-password" placeholder="16-character App Password" />
                    <div class="form-text">Spaces are removed automatically. Your normal Gmail password will not work.</div>
                </div>
                <div class="form-check mb-3">
                    <input id="clearMailCredentials" name="clearMailCredentials" value="true" type="checkbox" class="form-check-input" />
                    <label for="clearMailCredentials" class="form-check-label text-danger">Remove email credentials and disable OTP delivery</label>
                </div>
                <button type="submit" class="btn btn-lucy">
                    <i class="bi bi-floppy me-1"></i> Save Email Settings
                </button>
            </form>

            <div class="p-3 mb-3" style="background:#F8FAFC;border:1px solid #E2E8F0;border-radius:10px;">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <span style="font-size:13px;font-weight:600;">Recommended environment variables</span>
                    <c:if test="${smtpEnvironmentConfigured}">
                        <span class="badge-status badge-success">Detected</span>
                    </c:if>
                </div>
                <div class="mb-2"><code>LUCY_MAIL_USERNAME</code><div class="text-muted" style="font-size:12px;">Your Gmail address</div></div>
                <div><code>LUCY_MAIL_APP_PASSWORD</code><div class="text-muted" style="font-size:12px;">A Google App Password, not your normal Gmail password</div></div>
            </div>

            <ol class="ps-3 mb-0" style="font-size:12.5px;color:#475569;line-height:1.8;">
                <li>Enable 2-Step Verification for the Gmail account.</li>
                <li>Create an App Password in the <a href="https://support.google.com/accounts/answer/185833" target="_blank" rel="noopener noreferrer">Google Account security guide <i class="bi bi-box-arrow-up-right"></i></a>.</li>
                <li>Set both environment variables, then restart LUCY.</li>
            </ol>
            <div class="alert alert-light border mt-3 mb-0" style="font-size:12px;color:#64748B;">
                Runtime changes are cleared after restart. Use the environment variables above for permanent deployment configuration.
            </div>
        </div>
    </div>
</div>

</layout:main>
