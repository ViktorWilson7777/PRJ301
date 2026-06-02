<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Courses">

<div class="d-flex align-items-center justify-content-between mb-4">
    <p class="text-muted mb-0" style="font-size: 13px;">Manage course stages within each program</p>
    <a href="/courses/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Course</a>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty courses}">
            <div class="empty-state">
                <i class="bi bi-book"></i>
                <p>No courses yet. Create a course within a program.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Code</th>
                        <th>Title</th>
                        <th>Program</th>
                        <th>Level</th>
                        <th>Order</th>
                        <th style="width: 100px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${courses}">
                        <tr>
                            <td><strong>#${c.id}</strong></td>
                            <td><span class="badge-status badge-info">${c.code}</span></td>
                            <td>${c.title}</td>
                            <td>
                                <c:if test="${c.program != null}">
                                    <span class="badge-status badge-purple">${c.program.code}</span>
                                </c:if>
                            </td>
                            <td>${c.level}</td>
                            <td>${c.orderIndex}</td>
                            <td>
                                <a href="/courses/edit/${c.id}" class="btn-action edit"><i class="bi bi-pencil"></i></a>
                                <button class="btn-action delete" onclick="confirmDelete('/courses/delete/${c.id}')"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
