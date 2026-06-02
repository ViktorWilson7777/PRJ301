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
                        <label class="form-label">Language Code</label>
                        <select name="languageCode" class="form-select">
                            <option value="">— Select —</option>
                            <option value="EN" <c:if test="${room.languageCode == 'EN'}">selected</c:if>>EN (English)</option>
                            <option value="ZH" <c:if test="${room.languageCode == 'ZH'}">selected</c:if>>ZH (Chinese)</option>
                            <option value="JA" <c:if test="${room.languageCode == 'JA'}">selected</c:if>>JA (Japanese)</option>
                        </select>
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
                        <label class="form-label">Host User</label>
                        <select name="hostUserId" class="form-select">
                            <option value="">— Select Host —</option>
                            <c:forEach var="u" items="${users}">
                                <option value="${u.id}" <c:if test="${room.hostUser != null && room.hostUser.id == u.id}">selected</c:if>>${u.displayName} (${u.role})</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Level #</label>
                        <input type="number" name="levelNumber" class="form-control" value="${room.levelNumber}" min="1" />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Max Participants</label>
                        <input type="number" name="maxParticipants" class="form-control" value="${room.maxParticipants != null ? room.maxParticipants : 20}" min="1" />
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Course</label>
                        <select name="courseId" class="form-select">
                            <option value="">— Optional —</option>
                            <c:forEach var="c" items="${courses}">
                                <option value="${c.id}" <c:if test="${room.course != null && room.course.id == c.id}">selected</c:if>>${c.code} — ${c.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Chapter</label>
                        <select name="chapterId" class="form-select">
                            <option value="">— Optional —</option>
                            <c:forEach var="ch" items="${chapters}">
                                <option value="${ch.id}" <c:if test="${room.chapter != null && room.chapter.id == ch.id}">selected</c:if>>${ch.title}</option>
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

</layout:main>
