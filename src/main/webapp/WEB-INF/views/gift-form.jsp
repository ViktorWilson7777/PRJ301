<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${gift.id != null ? 'Edit Gift' : 'New Gift'}">

<div class="row justify-content-center">
    <div class="col-lg-6">
        <div class="lucy-form">
            <form method="post" action="/gifts/save" enctype="multipart/form-data">
                <c:if test="${gift.id != null}">
                    <input type="hidden" name="id" value="${gift.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Gift Name <span class="text-danger">*</span></label>
                    <input type="text" name="name" class="form-control" value="${gift.name}" required placeholder="e.g. Star, Coffee, Firework" />
                </div>

                <input type="hidden" name="icon" value="${gift.icon}" />

                <div class="mb-3">
                    <label class="form-label">Sticker image <c:if test="${gift.id == null}"><span class="text-danger">*</span></c:if></label>
                    <input type="file" name="imageFile" class="form-control" accept="image/png,image/jpeg,image/gif" <c:if test="${gift.id == null}">required</c:if> />
                    <div class="form-text">Upload a real PNG, JPG or GIF sticker; maximum 3 MB and 4096 x 4096 px.</div>
                    <c:if test="${not empty gift.imageUrl}"><div class="mt-3"><span class="text-muted d-block mb-1" style="font-size:12px">Current sticker</span><img src="${gift.imageUrl}" alt="${gift.name}" style="width:96px;height:96px;object-fit:contain;border-radius:16px;background:#f8fafc;padding:8px" /></div></c:if>
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
