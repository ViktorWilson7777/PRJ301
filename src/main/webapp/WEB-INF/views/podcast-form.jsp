<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${podcast.id != null ? 'Edit Podcast' : 'New Podcast'}">

<style>
    .upload-area {
        border: 2px dashed #CBD5E1;
        border-radius: 16px;
        padding: 40px 20px;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s ease;
        background: #F8FAFC;
        position: relative;
    }
    .upload-area:hover, .upload-area.dragover {
        border-color: #6C5CE7;
        background: rgba(108, 92, 231, 0.04);
    }
    .upload-area.has-file {
        border-color: #059669;
        background: #ECFDF5;
        border-style: solid;
    }
    .upload-area .upload-icon {
        font-size: 48px;
        color: #94A3B8;
        margin-bottom: 12px;
        transition: color 0.3s;
    }
    .upload-area:hover .upload-icon {
        color: #6C5CE7;
    }
    .upload-area.has-file .upload-icon {
        color: #059669;
    }
    .upload-area .upload-text {
        font-size: 15px;
        font-weight: 600;
        color: #475569;
        margin-bottom: 4px;
    }
    .upload-area .upload-hint {
        font-size: 12px;
        color: #94A3B8;
    }
    .upload-area .file-info {
        display: none;
        font-size: 13px;
        font-weight: 600;
        color: #059669;
        margin-top: 8px;
    }
    .upload-area.has-file .file-info {
        display: block;
    }
    .upload-area.has-file .upload-text { color: #059669; }
    .upload-area.has-file .upload-hint { display: none; }
    .upload-area input[type="file"] {
        position: absolute;
        inset: 0;
        opacity: 0;
        cursor: pointer;
    }
    .existing-audio {
        background: #F1F5F9;
        border-radius: 12px;
        padding: 16px;
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 12px;
    }
    .existing-audio .audio-badge {
        width: 42px;
        height: 42px;
        background: linear-gradient(135deg, #6C5CE7, #A29BFE);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        font-size: 18px;
    }
    .existing-audio .audio-details {
        flex: 1;
    }
    .existing-audio .audio-name {
        font-size: 13px;
        font-weight: 600;
        color: #1E293B;
    }
    .existing-audio .audio-status {
        font-size: 11px;
        color: #059669;
        font-weight: 500;
    }
</style>

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="lucy-form">
            <form method="post" action="/podcasts/save" enctype="multipart/form-data">
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

                <div class="mb-3">
                    <label class="form-label">Source Room</label>
                    <select name="roomId" class="form-select">
                        <option value="">— Optional —</option>
                        <c:forEach var="r" items="${rooms}">
                            <option value="${r.id}" <c:if test="${podcast.room != null && podcast.room.id == r.id}">selected</c:if>>${r.title} (${r.status})</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Audio Upload -->
                <div class="mb-3">
                    <label class="form-label"><i class="bi bi-music-note-beamed me-1"></i>Audio File</label>

                    <c:if test="${podcast.id != null && podcast.audioUrl != null && !podcast.audioUrl.contains('example.com')}">
                        <div class="existing-audio">
                            <div class="audio-badge"><i class="bi bi-file-earmark-music"></i></div>
                            <div class="audio-details">
                                <div class="audio-name">${podcast.audioUrl}</div>
                                <div class="audio-status"><i class="bi bi-check-circle-fill me-1"></i>Audio file uploaded</div>
                            </div>
                            <audio controls style="height: 36px; max-width: 200px;">
                                <source src="${podcast.audioUrl}" type="audio/mpeg">
                            </audio>
                        </div>
                        <p class="text-muted" style="font-size: 12px; margin-bottom: 8px;">Upload a new file below to replace the existing audio:</p>
                    </c:if>

                    <div class="upload-area" id="uploadArea">
                        <input type="file" name="audioFile" id="audioFileInput" accept="audio/*" />
                        <div class="upload-icon"><i class="bi bi-cloud-arrow-up" id="uploadIcon"></i></div>
                        <div class="upload-text" id="uploadText">Drop audio file here or click to browse</div>
                        <div class="upload-hint">MP3, WAV, OGG, M4A — Max 20MB</div>
                        <div class="file-info" id="fileInfo"></div>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Duration (seconds)</label>
                        <input type="number" name="durationSeconds" class="form-control" value="${podcast.durationSeconds}" min="0" placeholder="Auto-estimated if empty" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Status <span class="text-danger">*</span></label>
                        <select name="status" class="form-select" required>
                            <option value="DRAFT" <c:if test="${podcast.status == null || podcast.status == 'DRAFT'}">selected</c:if>>Draft</option>
                            <option value="PUBLISHED" <c:if test="${podcast.status == 'PUBLISHED'}">selected</c:if>>Published</option>
                        </select>
                    </div>
                </div>

                <div class="mb-4">
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

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/podcasts" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const uploadArea = document.getElementById('uploadArea');
        const fileInput = document.getElementById('audioFileInput');
        const uploadIcon = document.getElementById('uploadIcon');
        const uploadText = document.getElementById('uploadText');
        const fileInfo = document.getElementById('fileInfo');

        function formatFileSize(bytes) {
            if (bytes >= 1048576) return (bytes / 1048576).toFixed(1) + ' MB';
            if (bytes >= 1024) return (bytes / 1024).toFixed(0) + ' KB';
            return bytes + ' B';
        }

        fileInput.addEventListener('change', function () {
            if (fileInput.files.length > 0) {
                const file = fileInput.files[0];
                uploadArea.classList.add('has-file');
                uploadIcon.className = 'bi bi-file-earmark-music';
                uploadText.textContent = file.name;
                fileInfo.textContent = formatFileSize(file.size);
            } else {
                uploadArea.classList.remove('has-file');
                uploadIcon.className = 'bi bi-cloud-arrow-up';
                uploadText.textContent = 'Drop audio file here or click to browse';
                fileInfo.textContent = '';
            }
        });

        // Drag & drop visual feedback
        ['dragenter', 'dragover'].forEach(evt => {
            uploadArea.addEventListener(evt, function (e) {
                e.preventDefault();
                uploadArea.classList.add('dragover');
            });
        });
        ['dragleave', 'drop'].forEach(evt => {
            uploadArea.addEventListener(evt, function (e) {
                e.preventDefault();
                uploadArea.classList.remove('dragover');
            });
        });
        uploadArea.addEventListener('drop', function (e) {
            if (e.dataTransfer.files.length > 0) {
                fileInput.files = e.dataTransfer.files;
                fileInput.dispatchEvent(new Event('change'));
            }
        });
    });
</script>

</layout:main>
