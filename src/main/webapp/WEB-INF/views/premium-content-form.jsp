<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${content.id != null ? 'Edit Premium Content' : 'New Premium Content'}">

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="lucy-form">
            <form method="post" action="/premium-content/save">
                <c:if test="${content.id != null}">
                    <input type="hidden" name="id" value="${content.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Title <span class="text-danger">*</span></label>
                    <input type="text" name="title" class="form-control" value="${content.title}" required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3">${content.description}</textarea>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Creator</label>
                        <select name="creatorId" class="form-select" data-live-search>
                            <option value="">— Select —</option>
                            <c:forEach var="u" items="${users}">
                                <option value="${u.id}" <c:if test="${content.creator != null && content.creator.id == u.id}">selected</c:if>>${u.displayName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Price (Credits)</label>
                        <input type="number" name="priceCredits" class="form-control" value="${content.priceCredits}" min="0" />
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Course</label>
                        <select name="courseId" class="form-select" data-live-search>
                            <option value="">— Optional —</option>
                            <c:forEach var="c" items="${courses}">
                                <option value="${c.id}" <c:if test="${content.course != null && content.course.id == c.id}">selected</c:if>>${c.code} — ${c.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Chapter</label>
                        <select name="chapterId" class="form-select" data-live-search>
                            <option value="">— Optional —</option>
                            <c:forEach var="ch" items="${chapters}">
                                <option value="${ch.id}" <c:if test="${content.chapter != null && content.chapter.id == ch.id}">selected</c:if>>${ch.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="mb-4">
                    <div class="form-check">
                        <input type="checkbox" name="active" class="form-check-input" id="active"
                               <c:if test="${content.active == null || content.active}">checked</c:if> />
                        <label class="form-check-label" for="active">Active</label>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/premium-content" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

</layout:main>
