<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${podcast.id != null ? 'Edit Podcast' : 'New Podcast'}">
<style>
    .podcast-form{max-width:760px;margin:0 auto}.audio-drop{position:relative;border:1.5px dashed #B8C0CC;border-radius:8px;padding:32px 18px;text-align:center;background:#F8FAFC;transition:.18s}
    .audio-drop:hover,.audio-drop.dragover{border-color:#6558E8;background:#F4F3FF}.audio-drop.ready{border-style:solid;border-color:#12B76A;background:#ECFDF3}
    .audio-drop input{position:absolute;inset:0;width:100%;height:100%;opacity:0;cursor:pointer}.audio-icon{font-size:38px;color:#6558E8}.file-name{font-weight:700;color:#344054;margin-top:8px;overflow-wrap:anywhere}.file-meta{font-size:12px;color:#667085;margin-top:4px}
    .form-alert{border:1px solid #FECDCA;background:#FEF3F2;color:#B42318;border-radius:8px;padding:10px 12px;font-size:13px;margin-bottom:16px}
    .existing-audio{display:flex;align-items:center;gap:10px;border:1px solid #DDE1EA;border-radius:8px;padding:12px;margin-bottom:10px;background:#fff}.existing-audio audio{width:100%;height:36px}
</style>
<div class="podcast-form">
    <div class="lucy-form">
        <c:if test="${not empty param.error}">
            <div class="form-alert">
                <c:choose>
                    <c:when test="${param.error == 'invalid_mp3'}">Only MP3 audio files are accepted.</c:when>
                    <c:when test="${param.error == 'audio_too_large'}">The MP3 file must be 20MB or smaller.</c:when>
                    <c:when test="${param.error == 'storage_limit'}">Your podcast storage is full. Expand storage before uploading another file.</c:when>
                    <c:when test="${param.error == 'mp3_required'}">Choose an MP3 file before creating the podcast.</c:when>
                    <c:otherwise>The audio file could not be saved. Please try again.</c:otherwise>
                </c:choose>
            </div>
        </c:if>
        <form method="post" action="${pageContext.request.contextPath}/podcasts/save" enctype="multipart/form-data">
            <c:if test="${podcast.id != null}"><input type="hidden" name="id" value="${podcast.id}"></c:if>
            <div class="mb-3">
                <label class="form-label" for="title">Title</label>
                <input id="title" type="text" name="title" class="form-control" value="<c:out value='${podcast.title}'/>" maxlength="255" required>
            </div>
            <div class="mb-3">
                <label class="form-label" for="description">Description</label>
                <textarea id="description" name="description" class="form-control" rows="4" maxlength="5000"><c:out value="${podcast.description}"/></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">MP3 audio file</label>
                <c:if test="${podcast.id != null && not empty podcast.audioUrl}">
                    <div class="existing-audio"><i class="bi bi-file-earmark-music" style="font-size:24px;color:#6558E8"></i><audio controls preload="metadata" src="${pageContext.request.contextPath}${podcast.audioUrl}"></audio></div>
                    <div class="form-text mb-2">Choose another MP3 below only when replacing the current audio.</div>
                </c:if>
                <div id="audioDrop" class="audio-drop">
                    <input id="audioFile" type="file" name="audioFile" accept=".mp3,audio/mpeg" <c:if test="${podcast.id == null}">required</c:if>>
                    <div class="audio-icon"><i class="bi bi-cloud-arrow-up"></i></div>
                    <div id="fileName" class="file-name">Choose or drop an MP3 file</div>
                    <div id="fileMeta" class="file-meta">Maximum file size: 20MB</div>
                </div>
            </div>
            <div class="row g-3 mb-4">
                <div class="col-md-6">
                    <label class="form-label" for="status">Status</label>
                    <select id="status" name="status" class="form-select" required>
                        <option value="DRAFT" <c:if test="${podcast.status == null || podcast.status == 'DRAFT'}">selected</c:if>>Draft</option>
                        <option value="PUBLISHED" <c:if test="${podcast.status == 'PUBLISHED'}">selected</c:if>>Published</option>
                    </select>
                </div>
                <div class="col-md-6 d-flex align-items-end">
                    <div class="form-check form-switch mb-2">
                        <input id="premiumAccess" class="form-check-input" type="checkbox" name="isPremium" value="true" <c:if test="${podcast.isPremium}">checked</c:if>>
                        <label class="form-check-label" for="premiumAccess">Premium access</label>
                    </div>
                </div>
            </div>
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i>Save podcast</button>
                <a href="${pageContext.request.contextPath}/podcasts" class="btn btn-light">Cancel</a>
            </div>
        </form>
    </div>
</div>
<script>
document.addEventListener('DOMContentLoaded',function(){
    const input=document.getElementById('audioFile'),drop=document.getElementById('audioDrop'),name=document.getElementById('fileName'),meta=document.getElementById('fileMeta');
    function showFile(){const file=input.files&&input.files[0];if(!file){drop.classList.remove('ready');return;}drop.classList.add('ready');name.textContent=file.name;meta.textContent=(file.size/1048576).toFixed(1)+' MB';}
    input.addEventListener('change',showFile);
    ['dragenter','dragover'].forEach(function(eventName){drop.addEventListener(eventName,function(event){event.preventDefault();drop.classList.add('dragover');});});
    ['dragleave','drop'].forEach(function(eventName){drop.addEventListener(eventName,function(event){event.preventDefault();drop.classList.remove('dragover');});});
    drop.addEventListener('drop',function(event){if(event.dataTransfer.files.length){input.files=event.dataTransfer.files;showFile();}});
});
</script>
</layout:main>
