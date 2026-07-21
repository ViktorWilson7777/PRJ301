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
                        <option value="SUPER_CREATOR" <c:if test="${user.role == 'SUPER_CREATOR'}">selected</c:if>>Content Creator</option>
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
        <c:if test="${user.id != null}">
            <div class="stat-card mt-4">
                <h5 style="font-weight:700">Program levels and hosting access</h5>
                <p class="text-muted" style="font-size:13px">Every user starts at Level 1. Set a hosting level only for staff or approved Pro Mentors.</p>
                <c:if test="${param.success == 'level_saved'}"><div class="alert alert-success py-2">Program level saved.</div></c:if>
                <div class="mb-3" style="max-height:220px;overflow-y:auto">
                    <c:forEach var="item" items="${programLevels}">
                        <div class="d-flex justify-content-between border-bottom py-2">
                            <span><c:out value="${item.program.title}"/></span>
                            <span>Level ${item.levelNumber} · ${item.experiencePoints} XP · Host through ${item.maxHostingLevel}</span>
                        </div>
                    </c:forEach>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/users/${user.id}/program-level">
                    <div class="row g-3">
                        <div class="col-md-5"><label class="form-label">Program</label><select name="programId" class="form-select" data-live-search required><option value="">Select a program</option><c:forEach var="program" items="${programs}"><option value="${program.id}"><c:out value="${program.title}"/></option></c:forEach></select></div>
                        <div class="col-md-3"><label class="form-label">Program level</label><input type="number" name="levelNumber" class="form-control" value="1" min="1" required></div>
                        <div class="col-md-4"><label class="form-label">Max hosting level</label><input type="number" name="maxHostingLevel" class="form-control" value="0" min="0" required><div class="form-text">Program level is raised automatically when this value is higher.</div></div>
                    </div>
                    <button type="submit" class="btn btn-outline-lucy mt-3"><i class="bi bi-save me-1"></i>Save program level</button>
                </form>
            </div>
            <c:if test="${user.role == 'PRO_MENTOR'}">
                <div class="stat-card mt-4">
                    <h5 style="font-weight:700">Course hosting permissions</h5>
                    <p class="text-muted" style="font-size:13px">The mentor can create rooms only inside selected courses. Unchecking every course revokes administrator-granted hosting access.</p>
                    <c:if test="${param.success == 'hosting_courses_saved'}"><div class="alert alert-success py-2">Hosting courses saved.</div></c:if>
                    <c:if test="${param.error == 'hosting_courses_invalid'}"><div class="alert alert-danger py-2">Could not save hosting courses.</div></c:if>
                    <form method="post" action="${pageContext.request.contextPath}/users/${user.id}/hosting-courses">
                        <div class="border rounded p-2" style="max-height:280px;overflow-y:auto">
                            <c:forEach var="course" items="${courses}">
                                <label class="d-flex gap-2 py-2 border-bottom" style="font-size:13px">
                                    <input class="form-check-input" type="checkbox" name="courseIds" value="${course.id}" <c:if test="${approvedCourseIds.contains(course.id)}">checked</c:if>>
                                    <span><strong><c:out value="${course.program.title}"/></strong> / <c:out value="${course.title}"/></span>
                                </label>
                            </c:forEach>
                        </div>
                        <button type="submit" class="btn btn-outline-lucy mt-3"><i class="bi bi-key me-1"></i>Save hosting permissions</button>
                    </form>
                </div>
            </c:if>
        </c:if>
    </div>
</div>

</layout:main>
