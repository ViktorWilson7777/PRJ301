<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Chapters (Levels)">

<div class="d-flex align-items-center justify-content-between mb-4">
    <p class="text-muted mb-0" style="font-size: 13px;">Manage chapter levels within courses</p>
    <a href="/chapters/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Chapter</a>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty chapters}">
            <div class="empty-state">
                <i class="bi bi-layers"></i>
                <p>No chapters yet. Create a chapter or import from DOCX.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr><th>ID</th><th>Title</th><th>Course</th><th>Order</th><th>Description</th><th style="width:100px;">Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="ch" items="${chapters}">
                        <tr>
                            <td><strong>#${ch.id}</strong></td>
                            <td>${ch.title}</td>
                            <td><c:if test="${ch.course != null}"><span class="badge-status badge-info">${ch.course.code}</span></c:if></td>
                            <td>${ch.orderIndex}</td>
                            <td style="max-width: 250px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${ch.description}</td>
                            <td>
                                <a href="/chapters/edit/${ch.id}" class="btn-action edit"><i class="bi bi-pencil"></i></a>
                                <button class="btn-action delete" onclick="confirmDelete('/chapters/delete/${ch.id}')"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
