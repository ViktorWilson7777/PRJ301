<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="AI Prompt Templates">

<div class="d-flex align-items-center justify-content-between mb-4">
    <p class="text-muted mb-0" style="font-size: 13px;">Manage AI prompt instructions for question generation</p>
    <a href="/ai-prompt-templates/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Template</a>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty templates}">
            <div class="empty-state">
                <i class="bi bi-cpu"></i>
                <p>No AI prompt templates yet.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr><th>ID</th><th>Prompt Type</th><th>Lesson</th><th>Instruction</th><th>Active</th><th style="width:100px;">Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="t" items="${templates}">
                        <tr>
                            <td><strong>#${t.id}</strong></td>
                            <td><span class="badge-status badge-purple">${t.promptType}</span></td>
                            <td><c:if test="${t.lesson != null}">${t.lesson.title}</c:if></td>
                            <td style="max-width: 350px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; font-size: 12px;">${t.promptInstruction}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${t.isActive}"><span class="badge-status badge-success">Active</span></c:when>
                                    <c:otherwise><span class="badge-status badge-gray">Inactive</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="/ai-prompt-templates/edit/${t.id}" class="btn-action edit"><i class="bi bi-pencil"></i></a>
                                <button class="btn-action delete" onclick="confirmDelete('/ai-prompt-templates/delete/${t.id}')"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</layout:main>
