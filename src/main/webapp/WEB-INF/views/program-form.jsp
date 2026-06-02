<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${program.id != null ? 'Edit Program' : 'New Program'}">

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="lucy-form">
            <form method="post" action="/programs/save">
                <c:if test="${program.id != null}">
                    <input type="hidden" name="id" value="${program.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Code <span class="text-danger">*</span></label>
                    <input type="text" name="code" class="form-control" value="${program.code}" required placeholder="e.g. EN, ZH, JA" maxlength="20" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Title <span class="text-danger">*</span></label>
                    <input type="text" name="title" class="form-control" value="${program.title}" required placeholder="e.g. English, Chinese, Japanese" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3" placeholder="Optional description">${program.description}</textarea>
                </div>

                <div class="mb-4">
                    <div class="form-check">
                        <input type="checkbox" name="published" class="form-check-input" id="published"
                               <c:if test="${program.isPublished}">checked</c:if> />
                        <label class="form-check-label" for="published">Published</label>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/programs" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

</layout:main>
