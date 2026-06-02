<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${chapter.id != null ? 'Edit Chapter' : 'New Chapter'}">

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="lucy-form">
            <form method="post" action="/chapters/save">
                <c:if test="${chapter.id != null}">
                    <input type="hidden" name="id" value="${chapter.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Course <span class="text-danger">*</span></label>
                    <select name="courseId" class="form-select" required>
                        <option value="">— Select Course —</option>
                        <c:forEach var="c" items="${courses}">
                            <option value="${c.id}" <c:if test="${chapter.course != null && chapter.course.id == c.id}">selected</c:if>>${c.code} — ${c.title}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Title <span class="text-danger">*</span></label>
                    <input type="text" name="title" class="form-control" value="${chapter.title}" required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Order Index</label>
                    <input type="number" name="orderIndex" class="form-control" value="${chapter.orderIndex}" min="0" />
                </div>

                <div class="mb-4">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3">${chapter.description}</textarea>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/chapters" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

</layout:main>
