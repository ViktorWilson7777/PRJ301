<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${gift.id != null ? 'Edit Gift' : 'New Gift'}">

<div class="row justify-content-center">
    <div class="col-lg-6">
        <div class="lucy-form">
            <form method="post" action="/gifts/save">
                <c:if test="${gift.id != null}">
                    <input type="hidden" name="id" value="${gift.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Gift Name <span class="text-danger">*</span></label>
                    <input type="text" name="name" class="form-control" value="${gift.name}" required placeholder="e.g. Star, Coffee, Firework" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Icon (emoji)</label>
                    <input type="text" name="icon" class="form-control" value="${gift.icon}" placeholder="e.g. ⭐ ☕ 🎆 🌹 💎" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Credit Cost <span class="text-danger">*</span></label>
                    <input type="number" name="creditCost" class="form-control" value="${gift.creditCost}" min="1" required />
                </div>

                <div class="mb-4">
                    <div class="form-check">
                        <input type="checkbox" name="active" class="form-check-input" id="active"
                               <c:if test="${gift.active == null || gift.active}">checked</c:if> />
                        <label class="form-check-label" for="active">Active</label>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/gifts" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

</layout:main>
