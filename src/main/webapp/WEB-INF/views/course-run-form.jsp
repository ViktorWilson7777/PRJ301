<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${courseRun.id != null ? 'Edit Course Run' : 'New Course Run'}">

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="lucy-form">
            <form method="post" action="/course-runs/save">
                <c:if test="${courseRun.id != null}">
                    <input type="hidden" name="id" value="${courseRun.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Course <span class="text-danger">*</span></label>
                    <select name="courseId" class="form-select" required>
                        <option value="">— Select Course —</option>
                        <c:forEach var="c" items="${courses}">
                            <option value="${c.id}" <c:if test="${courseRun.course != null && courseRun.course.id == c.id}">selected</c:if>>${c.code} — ${c.title}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Code <span class="text-danger">*</span></label>
                    <input type="text" name="code" class="form-control" value="${courseRun.code}" required placeholder="e.g. EN-S1-2025Q1" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Status</label>
                    <select name="status" class="form-select">
                        <option value="">— Select —</option>
                        <option value="OPEN" <c:if test="${courseRun.status == 'OPEN'}">selected</c:if>>Open</option>
                        <option value="CLOSED" <c:if test="${courseRun.status == 'CLOSED'}">selected</c:if>>Closed</option>
                        <option value="PLANNED" <c:if test="${courseRun.status == 'PLANNED'}">selected</c:if>>Planned</option>
                    </select>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Starts At</label>
                        <input type="datetime-local" name="startsAt" class="form-control" value="${courseRun.startsAt}" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Ends At</label>
                        <input type="datetime-local" name="endsAt" class="form-control" value="${courseRun.endsAt}" />
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Capacity</label>
                    <input type="number" name="capacity" class="form-control" value="${courseRun.capacity}" min="0" />
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/course-runs" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

</layout:main>
