<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Premium Content">

<div class="d-flex align-items-center justify-content-between mb-4">
    <p class="text-muted mb-0" style="font-size: 13px;">Premium learning content by Super Creators</p>
    <a href="/premium-content/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Content</a>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty contents}">
            <div class="empty-state">
                <i class="bi bi-star"></i>
                <p>No premium content yet.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr><th>ID</th><th>Title</th><th>Creator</th><th>Course</th><th>Price</th><th>Active</th><th style="width:100px;">Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${contents}">
                        <tr>
                            <td><strong>#${c.id}</strong></td>
                            <td>${c.title}</td>
                            <td><c:if test="${c.creator != null}">${c.creator.displayName}</c:if></td>
                            <td><c:if test="${c.course != null}"><span class="badge-status badge-info">${c.course.code}</span></c:if></td>
                            <td><strong>${c.priceCredits}</strong> credits</td>
                            <td>
                                <c:choose>
                                    <c:when test="${c.active}"><span class="badge-status badge-success">Active</span></c:when>
                                    <c:otherwise><span class="badge-status badge-gray">Inactive</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="/premium-content/edit/${c.id}" class="btn-action edit"><i class="bi bi-pencil"></i></a>
                                <button class="btn-action delete" onclick="confirmDelete('/premium-content/delete/${c.id}')"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
