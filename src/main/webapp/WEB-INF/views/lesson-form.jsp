<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${lesson.id != null ? 'Edit Lesson' : 'New Lesson'}">

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="lucy-form">
            <form method="post" action="/lessons/save">
                <c:if test="${lesson.id != null}">
                    <input type="hidden" name="id" value="${lesson.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Chapter <span class="text-danger">*</span></label>
                    <select name="chapterId" class="form-select" required>
                        <option value="">— Select Chapter —</option>
                        <c:forEach var="ch" items="${chapters}">
                            <option value="${ch.id}" <c:if test="${lesson.chapter != null && lesson.chapter.id == ch.id}">selected</c:if>>${ch.title}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Type <span class="text-danger">*</span></label>
                    <select name="type" class="form-select" required>
                        <option value="">— Select Type —</option>
                        <option value="warmup" <c:if test="${lesson.type == 'warmup'}">selected</c:if>>warmup</option>
                        <option value="ice_breaker" <c:if test="${lesson.type == 'ice_breaker'}">selected</c:if>>ice_breaker</option>
                        <option value="discussion" <c:if test="${lesson.type == 'discussion'}">selected</c:if>>discussion</option>
                        <option value="follow_up" <c:if test="${lesson.type == 'follow_up'}">selected</c:if>>follow_up</option>
                        <option value="practice" <c:if test="${lesson.type == 'practice'}">selected</c:if>>practice</option>
                        <option value="wrapup" <c:if test="${lesson.type == 'wrapup'}">selected</c:if>>wrapup</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Title <span class="text-danger">*</span></label>
                    <input type="text" name="title" class="form-control" value="${lesson.title}" required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Order Index</label>
                    <input type="number" name="orderIndex" class="form-control" value="${lesson.orderIndex}" min="0" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3">${lesson.description}</textarea>
                </div>

                <div class="mb-4">
                    <label class="form-label">Content Data (JSON)</label>
                    <textarea name="contentData" class="form-control" rows="4" style="font-family: monospace; font-size: 12px;">${lesson.contentData}</textarea>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/lessons" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

</layout:main>
