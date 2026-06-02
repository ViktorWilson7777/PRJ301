<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Import Files">

<div class="d-flex align-items-center justify-content-between mb-4">
    <p class="text-muted mb-0" style="font-size: 13px;">DOCX import history and management</p>
    <a href="/import-files/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Import</a>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty importFiles}">
            <div class="empty-state">
                <i class="bi bi-cloud-upload"></i>
                <p>No imports yet. Upload a DOCX file to import learning content.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr><th>ID</th><th>File Name</th><th>Course</th><th>Status</th><th>Imported At</th><th>Message</th><th style="width:100px;">Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="f" items="${importFiles}">
                        <tr>
                            <td><strong>#${f.id}</strong></td>
                            <td><i class="bi bi-file-earmark-word me-1" style="color: #2563EB;"></i>${f.fileName}</td>
                            <td><c:if test="${f.course != null}"><span class="badge-status badge-info">${f.course.code}</span></c:if></td>
                            <td>
                                <c:choose>
                                    <c:when test="${f.status == 'SUCCESS'}"><span class="badge-status badge-success">Success</span></c:when>
                                    <c:when test="${f.status == 'FAILED'}"><span class="badge-status badge-danger">Failed</span></c:when>
                                    <c:when test="${f.status == 'PENDING'}"><span class="badge-status badge-warning">Pending</span></c:when>
                                    <c:otherwise><span class="badge-status badge-gray">${f.status}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td style="font-size: 12px;">${f.importedAt}</td>
                            <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; font-size: 12px;">${f.errorMessage}</td>
                            <td>
                                <a href="/import-files/edit/${f.id}" class="btn-action edit"><i class="bi bi-pencil"></i></a>
                                <button class="btn-action delete" onclick="confirmDelete('/import-files/delete/${f.id}')"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
