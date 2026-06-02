<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${user.id != null ? 'Edit User' : 'New User'}">

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="lucy-form">
            <form method="post" action="/users/save">
                <c:if test="${user.id != null}">
                    <input type="hidden" name="id" value="${user.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Full Name <span class="text-danger">*</span></label>
                    <input type="text" name="fullName" class="form-control" value="${user.fullName}" required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" value="${user.email}" />
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Display Name</label>
                        <input type="text" name="displayName" class="form-control" value="${user.displayName}" placeholder="Public display name" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Avatar Persona</label>
                        <input type="text" name="avatarPersona" class="form-control" value="${user.avatarPersona}" placeholder="e.g. CuriousPanda" />
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Role <span class="text-danger">*</span></label>
                    <select name="role" class="form-select" required>
                        <option value="">— Select Role —</option>
                        <option value="ADMIN" <c:if test="${user.role == 'ADMIN'}">selected</c:if>>Admin</option>
                        <option value="LEARNER" <c:if test="${user.role == 'LEARNER'}">selected</c:if>>Learner</option>
                        <option value="MODERATOR" <c:if test="${user.role == 'MODERATOR'}">selected</c:if>>Moderator</option>
                        <option value="PRO_MENTOR" <c:if test="${user.role == 'PRO_MENTOR'}">selected</c:if>>Pro Mentor</option>
                        <option value="SUPER_CREATOR" <c:if test="${user.role == 'SUPER_CREATOR'}">selected</c:if>>Super Creator</option>
                    </select>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Credit Balance</label>
                        <input type="number" name="creditBalance" class="form-control" value="${user.creditBalance}" step="0.01" min="0" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Reputation Score</label>
                        <input type="number" name="reputationScore" class="form-control" value="${user.reputationScore}" min="0" />
                    </div>
                </div>

                <div class="mb-4 d-flex gap-4">
                    <div class="form-check">
                        <input type="checkbox" name="anonymousMode" class="form-check-input" id="anonymousMode"
                               <c:if test="${user.anonymousMode}">checked</c:if> />
                        <label class="form-check-label" for="anonymousMode">Anonymous Mode</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" name="active" class="form-check-input" id="active"
                               <c:if test="${user.active == null || user.active}">checked</c:if> />
                        <label class="form-check-label" for="active">Active</label>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/users" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

</layout:main>
