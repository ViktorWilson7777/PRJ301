<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${plan.id != null ? 'Edit Billing Plan' : 'New Billing Plan'}">

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="lucy-form">
            <form method="post" action="/billing/plans/save">
                <c:if test="${plan.id != null}">
                    <input type="hidden" name="id" value="${plan.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Plan Name <span class="text-danger">*</span></label>
                    <input type="text" name="name" class="form-control" value="${plan.name}" required placeholder="e.g. Free, Pro, Super" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Price (USD) <span class="text-danger">*</span></label>
                    <input type="number" name="price" class="form-control" value="${plan.price}" step="0.01" min="0" required />
                </div>

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label class="form-label">Monthly AI Limit</label>
                        <input type="number" name="monthlyAiLimit" class="form-control" value="${plan.monthlyAiLimit}" min="0" required />
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Monthly Import Limit</label>
                        <input type="number" name="monthlyImportLimit" class="form-control" value="${plan.monthlyImportLimit}" min="0" required />
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Max Room Participants</label>
                        <input type="number" name="maxRoomParticipants" class="form-control" value="${plan.maxRoomParticipants}" min="1" required />
                    </div>
                </div>

                <div class="mb-4 d-flex gap-4">
                    <div class="form-check">
                        <input type="checkbox" name="allowPodcastRecording" class="form-check-input" id="allowPodcast"
                               <c:if test="${plan.allowPodcastRecording}">checked</c:if> />
                        <label class="form-check-label" for="allowPodcast">Allow Podcast Recording</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" name="active" class="form-check-input" id="active"
                               <c:if test="${plan.active == null || plan.active}">checked</c:if> />
                        <label class="form-check-label" for="active">Active</label>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/billing/plans" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

</layout:main>
