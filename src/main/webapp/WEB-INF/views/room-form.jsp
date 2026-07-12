<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${room.id != null ? 'Edit Room' : 'New Room'}">

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="lucy-form">
            <form method="post" action="/rooms/save">
                <c:if test="${room.id != null}">
                    <input type="hidden" name="id" value="${room.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Title <span class="text-danger">*</span></label>
                    <input type="text" name="title" class="form-control" value="${room.title}" required placeholder="e.g. English Beginner — Daily Conversation" />
                </div>

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label class="form-label">Program <span class="text-danger">*</span></label>
                        <select id="programSelect" class="form-select" data-live-search required>
                            <option value="">— Select Program —</option>
                            <c:forEach var="p" items="${programs}">
                                <option value="${p.id}" data-code="${p.code}" <c:if test="${room.course != null && room.course.program.id == p.id}">selected</c:if>>${p.title}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" name="languageCode" id="hiddenLanguageCode" value="${room.languageCode}" />
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Room Type <span class="text-danger">*</span></label>
                        <select name="roomType" class="form-select" required>
                            <option value="PUBLIC" <c:if test="${room.roomType == 'PUBLIC'}">selected</c:if>>Public</option>
                            <option value="PRO_CLASS" <c:if test="${room.roomType == 'PRO_CLASS'}">selected</c:if>>Pro Class</option>
                            <option value="PREMIUM" <c:if test="${room.roomType == 'PREMIUM'}">selected</c:if>>Premium</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Status <span class="text-danger">*</span></label>
                        <select name="status" class="form-select" required>
                            <option value="SCHEDULED" <c:if test="${room.status == 'SCHEDULED'}">selected</c:if>>Scheduled</option>
                            <option value="LIVE" <c:if test="${room.status == 'LIVE'}">selected</c:if>>Live</option>
                            <option value="ENDED" <c:if test="${room.status == 'ENDED'}">selected</c:if>>Ended</option>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Max Participants</label>
                        <input type="number" name="maxParticipants" class="form-control" value="${room.maxParticipants != null ? room.maxParticipants : 20}" min="1" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Chapter (Level) <span class="text-danger">*</span></label>
                        <select name="chapterId" id="chapterSelect" class="form-select" data-live-search required disabled>
                            <option value="">— Select Chapter —</option>
                            <c:forEach var="ch" items="${chapters}">
                                <option value="${ch.id}" data-program-id="${ch.course.program.id}" <c:if test="${room.chapter != null && room.chapter.id == ch.id}">selected</c:if>>${ch.course.title} — ${ch.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>


                <div class="mb-4">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3">${room.description}</textarea>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/rooms" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const programSelect = document.getElementById('programSelect');
        const chapterSelect = document.getElementById('chapterSelect');
        const hiddenLanguageCode = document.getElementById('hiddenLanguageCode');
        const allChapters = Array.from(chapterSelect.options).slice(1); // Exclude "-- Select Chapter --"

        function filterChapters() {
            const selectedOpt = programSelect.options[programSelect.selectedIndex];
            const programId = programSelect.value;
            const programCode = selectedOpt ? selectedOpt.getAttribute('data-code') : null;
            
            // Set hidden language code for backend
            if (programCode && programCode.length >= 2) {
                hiddenLanguageCode.value = programCode.substring(0, 2);
            } else {
                hiddenLanguageCode.value = '';
            }

            let firstVisible = null;
            
            allChapters.forEach(opt => {
                const chapterProgramId = opt.getAttribute('data-program-id');
                if (programId && chapterProgramId === programId) {
                    opt.style.display = '';
                    opt.disabled = false;
                    if (!firstVisible) firstVisible = opt;
                } else {
                    opt.style.display = 'none';
                    opt.disabled = true;
                }
            });

            if (!programId) {
                chapterSelect.value = '';
                chapterSelect.disabled = true;
            } else {
                chapterSelect.disabled = false;
            }
            const searchShell = chapterSelect.closest('.live-search-select');
            if (searchShell) {
                const searchInput = searchShell.querySelector('input[type="search"]');
                if (searchInput) {
                    searchInput.disabled = !programId;
                    if (!programId) searchInput.value = '';
                }
            }

            // Reset chapter selection if currently selected option is hidden
            if (chapterSelect.selectedIndex > 0 && chapterSelect.options[chapterSelect.selectedIndex].style.display === 'none') {
                chapterSelect.value = '';
                chapterSelect.dispatchEvent(new Event('change', { bubbles: true }));
            }
        }

        programSelect.addEventListener('change', filterChapters);
        filterChapters(); // Initial filter
    });
</script>

</layout:main>
