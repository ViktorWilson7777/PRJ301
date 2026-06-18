<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${podcast.id != null ? 'Edit Podcast' : 'New Podcast'}">

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="lucy-form">
            <form method="post" action="/podcasts/save">
                <c:if test="${podcast.id != null}">
                    <input type="hidden" name="id" value="${podcast.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Title <span class="text-danger">*</span></label>
                    <input type="text" name="title" class="form-control" value="${podcast.title}" required placeholder="Episode title" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3">${podcast.description}</textarea>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Source Room</label>
                        <select name="roomId" class="form-select">
                            <option value="">— Optional —</option>
                            <c:forEach var="r" items="${rooms}">
                                <option value="${r.id}" <c:if test="${podcast.room != null && podcast.room.id == r.id}">selected</c:if>>${r.title} (${r.status})</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Creator</label>
                        <select name="creatorId" class="form-select">
                            <option value="">— Select —</option>
                            <c:forEach var="u" items="${users}">
                                <option value="${u.id}" <c:if test="${podcast.creator != null && podcast.creator.id == u.id}">selected</c:if>>${u.displayName} (${u.role})</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-8">
                        <label class="form-label">Audio URL (mock)</label>
                        <input type="text" name="audioUrl" class="form-control" value="${podcast.audioUrl}" placeholder="Auto-generated if empty" />
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Duration (seconds)</label>
                        <input type="number" name="durationSeconds" class="form-control" value="${podcast.durationSeconds}" min="0" />
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Status <span class="text-danger">*</span></label>
                        <select name="status" class="form-select" required>
                            <option value="DRAFT" <c:if test="${podcast.status == null || podcast.status == 'DRAFT'}">selected</c:if>>Draft</option>
                            <option value="PUBLISHED" <c:if test="${podcast.status == 'PUBLISHED'}">selected</c:if>>Published</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Premium Access</label>
                        <div class="d-flex align-items-center gap-3">
                            <div class="form-check form-switch mt-1">
                                <input class="form-check-input" type="checkbox" name="isPremium" id="isPremiumSwitch" value="true" ${podcast.isPremium ? 'checked' : ''} onchange="document.getElementById('priceDiv').style.display = this.checked ? 'block' : 'none';" />
                                <label class="form-check-label" for="isPremiumSwitch">Require Unlock</label>
                            </div>
                            <div id="priceDiv" style="display: ${podcast.isPremium ? 'block' : 'none'}; flex-grow: 1;">
                                <input type="number" name="price" class="form-control form-control-sm" value="${podcast.price}" min="0" placeholder="Price in XP/Credits" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/podcasts" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

</layout:main>
