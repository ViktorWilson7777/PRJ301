<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${course.id != null ? 'Edit Course' : 'New Course'}">

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="lucy-form">
            <form method="post" action="/courses/save">
                <c:if test="${course.id != null}">
                    <input type="hidden" name="id" value="${course.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Program <span class="text-danger">*</span></label>
                    <select name="programId" class="form-select" required>
                        <option value="">— Select Program —</option>
                        <c:forEach var="p" items="${programs}">
                            <option value="${p.id}" <c:if test="${course.program != null && course.program.id == p.id}">selected</c:if>>${p.code} — ${p.title}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Code <span class="text-danger">*</span></label>
                    <input type="text" name="code" class="form-control" value="${course.code}" required placeholder="e.g. EN-S1" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Title <span class="text-danger">*</span></label>
                    <input type="text" name="title" class="form-control" value="${course.title}" required placeholder="e.g. English Stage 1" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Level</label>
                    <input type="text" name="level" class="form-control" value="${course.level}" placeholder="e.g. Beginner" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Order Index</label>
                    <input type="number" name="orderIndex" class="form-control" value="${course.orderIndex}" min="0" />
                </div>

                <div class="mb-4">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3">${course.description}</textarea>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/courses" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

</layout:main>
