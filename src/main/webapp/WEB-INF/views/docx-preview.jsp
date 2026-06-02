<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="DOCX Preview">

<div class="row justify-content-center">
    <div class="col-lg-10">
        <div class="lucy-form mb-4">
            <h6 style="font-weight: 600; margin-bottom: 16px;"><i class="bi bi-eye me-1"></i> Preview DOCX Format</h6>
            <form method="post" action="/docx-preview" enctype="multipart/form-data">
                <div class="row g-3 align-items-end">
                    <div class="col-md-9">
                        <label class="form-label">DOCX File</label>
                        <input type="file" name="file" class="form-control" accept=".docx" required />
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-lucy w-100"><i class="bi bi-search me-1"></i> Preview</button>
                    </div>
                </div>
            </form>
        </div>

        <c:if test="${fileName != null}">
            <div class="stat-card mb-3">
                <h6 style="font-weight: 600;"><i class="bi bi-file-earmark-word me-1" style="color: #2563EB;"></i> ${fileName}</h6>
                <p class="text-muted mb-0" style="font-size: 12px;">Total paragraphs: ${paragraphs.size()}</p>
            </div>
        </c:if>

        <c:if test="${not empty paragraphs}">
            <div class="lucy-table">
                <table class="table mb-0">
                    <thead>
                        <tr><th style="width: 80px;">Line #</th><th>Content</th><th style="width: 120px;">Type</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${paragraphs}">
                            <tr>
                                <td><strong>${p.index}</strong></td>
                                <td style="font-family: monospace; font-size: 13px;">
                                    <c:choose>
                                        <c:when test="${p.text.toUpperCase().startsWith('LEVEL ')}">
                                            <span style="color: #7C3AED; font-weight: 600;">${p.text}</span>
                                        </c:when>
                                        <c:when test="${p.text.toUpperCase().startsWith('SUBLEVEL ')}">
                                            <span style="color: #2563EB; font-weight: 500;">${p.text}</span>
                                        </c:when>
                                        <c:when test="${p.text.startsWith('ERROR:')}">
                                            <span style="color: #DC2626;">${p.text}</span>
                                        </c:when>
                                        <c:otherwise>${p.text}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.text.toUpperCase().startsWith('LEVEL ')}">
                                            <span class="badge-status badge-purple">LEVEL</span>
                                        </c:when>
                                        <c:when test="${p.text.toUpperCase().startsWith('SUBLEVEL ')}">
                                            <span class="badge-status badge-info">SUBLEVEL</span>
                                        </c:when>
                                        <c:when test="${p.text.startsWith('ERROR:')}">
                                            <span class="badge-status badge-danger">ERROR</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-status badge-gray">Content</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>
</div>

</layout:main>
