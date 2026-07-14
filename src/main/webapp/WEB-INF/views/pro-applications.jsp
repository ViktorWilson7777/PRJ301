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
                        <div class="d-flex gap-2 mt-3">
                            <form method="post" action="${pageContext.request.contextPath}/pro-applications/${application.id}/decision">
                                <input type="hidden" name="decision" value="APPROVE" />
                                <button class="btn btn-success" type="submit"><i class="bi bi-check-lg me-1"></i>Approve Pro</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/pro-applications/${application.id}/decision">
                                <input type="hidden" name="decision" value="REJECT" />
                                <button class="btn btn-outline-danger" type="submit"><i class="bi bi-x-lg me-1"></i>Reject</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <c:if test="${not empty reviewedApplications}">
        <h6 class="mb-3">Previously reviewed</h6>
        <div class="lucy-table"><table class="table mb-0"><thead><tr><th>Applicant</th><th>Email</th><th>Status</th><th>Evidence</th></tr></thead><tbody>
        <c:forEach var="application" items="${reviewedApplications}"><tr>
            <td><c:out value="${application.fullName}" /></td><td><c:out value="${application.email}" /></td>
            <td><span class="badge ${application.registrationStatus == 'APPROVED' ? 'bg-success' : 'bg-secondary'}">${application.registrationStatus}</span></td>
            <td><a href="<c:out value='${application.evidenceUrl}' />" target="_blank" rel="noopener noreferrer">Open link</a></td>
        </tr></c:forEach>
        </tbody></table></div>
    </c:if>
</layout:main>
