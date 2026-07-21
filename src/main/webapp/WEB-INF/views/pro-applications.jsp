<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Pro Mentor Applications">
    <div class="d-flex justify-content-between align-items-start mb-4">
        <div>
            <h5 class="mb-1" style="font-weight:700">Pro Mentor applications</h5>
            <p class="text-muted mb-0">Review the applicant's language certificates and experience before granting Pro access.</p>
        </div>
        <span class="badge bg-warning text-dark">${pendingApplications.size()} pending</span>
    </div>

    <c:if test="${param.success == 'application_approved'}"><div class="alert alert-success">Application approved and Pro Mentor access granted.</div></c:if>
    <c:if test="${param.success == 'application_rejected'}"><div class="alert alert-info">Application rejected.</div></c:if>
    <c:if test="${param.error == 'invalid_application'}"><div class="alert alert-danger">This application is invalid or has already been reviewed.</div></c:if>

    <div class="stat-card mb-4">
        <c:choose>
            <c:when test="${empty pendingApplications}">
                <div class="empty-state py-5"><i class="bi bi-inbox"></i><p class="mb-0">There are no pending Pro applications.</p></div>
            </c:when>
            <c:otherwise>
                <c:forEach var="application" items="${pendingApplications}">
                    <div class="border rounded-3 p-3 mb-3">
                        <div class="d-flex justify-content-between align-items-start gap-3 flex-wrap">
                            <div>
                                <h6 class="mb-1"><c:out value="${application.fullName}" /></h6>
                                <div class="text-muted small"><c:out value="${application.email}" /></div>
                                <div class="text-muted small">Submitted: ${application.createdAt}</div>
                            </div>
                            <a class="btn btn-outline-primary" href="<c:out value='${application.evidenceUrl}' />" target="_blank" rel="noopener noreferrer">
                                <i class="bi bi-google me-1"></i>Open certificate folder
                            </a>
                        </div>
                        <div class="mt-3 p-3 bg-light rounded-3" style="white-space:pre-wrap"><c:out value="${application.achievements}" /></div>
                        <form method="post" action="${pageContext.request.contextPath}/pro-applications/${application.id}/decision" class="pro-review-form mt-3">
                            <div class="form-label mb-1">Requested courses</div>
                            <div class="border rounded p-2" style="max-height:190px;overflow-y:auto">
                                <c:forEach var="permission" items="${pendingCoursePermissions[application.id]}">
                                    <label class="d-flex gap-2 py-2 border-bottom" style="font-size:13px">
                                        <input class="form-check-input review-course" type="checkbox" name="courseIds" value="${permission.course.id}" checked>
                                        <span><strong><c:out value="${permission.course.program.title}"/></strong> / <c:out value="${permission.course.title}"/></span>
                                    </label>
                                </c:forEach>
                            </div>
                            <div class="text-danger review-course-error mt-1" style="font-size:12px"></div>
                            <div class="d-flex gap-2 mt-3">
                                <button class="btn btn-success" type="submit" name="decision" value="APPROVE"><i class="bi bi-check-lg me-1"></i>Approve selected</button>
                                <button class="btn btn-outline-danger" type="submit" name="decision" value="REJECT"><i class="bi bi-x-lg me-1"></i>Reject</button>
                            </div>
                        </form>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <c:if test="${not empty reviewedApplications}">
        <h6 class="mb-3">Previously reviewed</h6>
        <div class="lucy-table"><table class="table mb-0"><thead><tr><th>Applicant</th><th>Email</th><th>Status</th><th>Approved courses</th><th>Evidence</th></tr></thead><tbody>
        <c:forEach var="application" items="${reviewedApplications}"><tr>
            <td><c:out value="${application.fullName}" /></td><td><c:out value="${application.email}" /></td>
            <td><span class="badge ${application.registrationStatus == 'APPROVED' ? 'bg-success' : 'bg-secondary'}">${application.registrationStatus}</span></td>
            <td><c:forEach var="permission" items="${approvedCoursePermissions[application.id]}"><div class="small"><c:out value="${permission.course.program.title}"/> / <c:out value="${permission.course.title}"/></div></c:forEach></td>
            <td><a href="<c:out value='${application.evidenceUrl}' />" target="_blank" rel="noopener noreferrer">Open link</a></td>
        </tr></c:forEach>
        </tbody></table></div>
    </c:if>
    <script>
    document.querySelectorAll('.pro-review-form').forEach(function (form) {
        form.addEventListener('submit', function (event) {
            if (event.submitter && event.submitter.value === 'APPROVE' && !form.querySelector('.review-course:checked')) {
                event.preventDefault();
                form.querySelector('.review-course-error').textContent = 'Select at least one course to approve.';
            }
        });
    });
    </script>
</layout:main>
