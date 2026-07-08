<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="${importFile.id != null ? 'Edit Import Record' : 'New DOCX Import'}">

<div class="row justify-content-center">
    <div class="col-lg-8">

        <!-- Upload Form -->
        <div class="lucy-form mb-4">
            <h6 style="font-weight: 600; margin-bottom: 16px;"><i class="bi bi-upload me-1"></i> Upload DOCX File</h6>
            <form method="post" action="/import-files/preview" enctype="multipart/form-data">
                <div class="row g-3 align-items-end">
                    <div class="col-md-5">
                        <label class="form-label">Course <span class="text-danger">*</span></label>
                        <select name="courseId" class="form-select" required>
                            <option value="">— Select Course —</option>
                            <c:forEach var="c" items="${courses}">
                                <option value="${c.id}">${c.code} — ${c.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-5">
                        <label class="form-label">DOCX File <span class="text-danger">*</span></label>
                        <input type="file" name="file" class="form-control" accept=".docx" required />
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-lucy w-100"><i class="bi bi-eye me-1"></i> Preview</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Manual Edit Form -->
        <div class="lucy-form">
            <h6 style="font-weight: 600; margin-bottom: 16px;"><i class="bi bi-pencil-square me-1"></i> Manual Record</h6>
            <form method="post" action="/import-files/save">
                <c:if test="${importFile.id != null}">
                    <input type="hidden" name="id" value="${importFile.id}" />
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Course <span class="text-danger">*</span></label>
                    <select name="courseId" class="form-select" required>
                        <option value="">— Select Course —</option>
                        <c:forEach var="c" items="${courses}">
                            <option value="${c.id}" <c:if test="${importFile.course != null && importFile.course.id == c.id}">selected</c:if>>${c.code} — ${c.title}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">File Name <span class="text-danger">*</span></label>
                    <input type="text" name="fileName" class="form-control" value="${importFile.fileName}" required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Status</label>
                    <select name="status" class="form-select">
                        <option value="">— Select —</option>
                        <option value="SUCCESS" <c:if test="${importFile.status == 'SUCCESS'}">selected</c:if>>Success</option>
                        <option value="FAILED" <c:if test="${importFile.status == 'FAILED'}">selected</c:if>>Failed</option>
                        <option value="PENDING" <c:if test="${importFile.status == 'PENDING'}">selected</c:if>>Pending</option>
                    </select>
                </div>

                <div class="mb-4">
                    <label class="form-label">Error/Info Message</label>
                    <textarea name="errorMessage" class="form-control" rows="3">${importFile.errorMessage}</textarea>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/import-files" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

</layout:main>
