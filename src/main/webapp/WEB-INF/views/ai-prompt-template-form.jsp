<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${template.id != null ? 'Edit AI Template' : 'New AI Template'}">

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="lucy-form">
            <form method="post" action="/ai-prompt-templates/save">
                <c:if test="${template.id != null}">
                    <input type="hidden" name="id" value="${template.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Lesson <span class="text-danger">*</span></label>
                    <select name="lessonId" class="form-select" required>
                        <option value="">— Select Lesson —</option>
                        <c:forEach var="l" items="${lessons}">
                            <option value="${l.id}" <c:if test="${template.lesson != null && template.lesson.id == l.id}">selected</c:if>>[${l.type}] ${l.title}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Prompt Type <span class="text-danger">*</span></label>
                    <select name="promptType" class="form-select" required>
                        <option value="">— Select Type —</option>
                        <option value="warmup" <c:if test="${template.promptType == 'warmup'}">selected</c:if>>warmup</option>
                        <option value="ice_breaker" <c:if test="${template.promptType == 'ice_breaker'}">selected</c:if>>ice_breaker</option>
                        <option value="discussion" <c:if test="${template.promptType == 'discussion'}">selected</c:if>>discussion</option>
                        <option value="follow_up" <c:if test="${template.promptType == 'follow_up'}">selected</c:if>>follow_up</option>
                        <option value="practice" <c:if test="${template.promptType == 'practice'}">selected</c:if>>practice</option>
                        <option value="wrapup" <c:if test="${template.promptType == 'wrapup'}">selected</c:if>>wrapup</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Prompt Instruction <span class="text-danger">*</span></label>
                    <textarea name="promptInstruction" class="form-control" rows="5" required placeholder="Enter the AI prompt instruction...">${template.promptInstruction}</textarea>
                </div>

                <div class="mb-4">
                    <div class="form-check">
                        <input type="checkbox" name="active" class="form-check-input" id="active"
                               <c:if test="${template.isActive == null || template.isActive}">checked</c:if> />
                        <label class="form-check-label" for="active">Active</label>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/ai-prompt-templates" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

</layout:main>
