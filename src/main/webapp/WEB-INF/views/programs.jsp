<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Programs">

<div class="d-flex align-items-center justify-content-between mb-4">
    <div>
        <p class="text-muted mb-0" style="font-size: 13px;">Manage language programs (EN, ZH, JA)</p>
    </div>
    <a href="/programs/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Program</a>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty programs}">
            <div class="empty-state">
                <i class="bi bi-collection"></i>
                <p>No programs yet. Create your first language program.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Code</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th style="width: 100px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${programs}">
                        <tr>
                            <td><strong>#${p.id}</strong></td>
                            <td><span class="badge-status badge-purple">${p.code}</span></td>
                            <td>${p.title}</td>
                            <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${p.description}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.isPublished}">
                                        <span class="badge-status badge-success">Published</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-status badge-gray">Draft</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="/programs/edit/${p.id}" class="btn-action edit" title="Edit"><i class="bi bi-pencil"></i></a>
                                <button class="btn-action delete" title="Delete" onclick="confirmDelete('/programs/delete/${p.id}')"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
