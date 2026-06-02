<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Course Runs">

<div class="d-flex align-items-center justify-content-between mb-4">
    <p class="text-muted mb-0" style="font-size: 13px;">Manage course openings and batches</p>
    <a href="/course-runs/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Course Run</a>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty courseRuns}">
            <div class="empty-state">
                <i class="bi bi-calendar-event"></i>
                <p>No course runs yet.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr><th>ID</th><th>Code</th><th>Course</th><th>Status</th><th>Starts</th><th>Ends</th><th>Capacity</th><th style="width:100px;">Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="cr" items="${courseRuns}">
                        <tr>
                            <td><strong>#${cr.id}</strong></td>
                            <td><span class="badge-status badge-info">${cr.code}</span></td>
                            <td><c:if test="${cr.course != null}">${cr.course.title}</c:if></td>
                            <td>
                                <c:choose>
                                    <c:when test="${cr.status == 'OPEN'}"><span class="badge-status badge-success">Open</span></c:when>
                                    <c:when test="${cr.status == 'CLOSED'}"><span class="badge-status badge-danger">Closed</span></c:when>
                                    <c:otherwise><span class="badge-status badge-gray">${cr.status}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>${cr.startsAt}</td>
                            <td>${cr.endsAt}</td>
                            <td>${cr.capacity}</td>
                            <td>
                                <a href="/course-runs/edit/${cr.id}" class="btn-action edit"><i class="bi bi-pencil"></i></a>
                                <button class="btn-action delete" onclick="confirmDelete('/course-runs/delete/${cr.id}')"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
