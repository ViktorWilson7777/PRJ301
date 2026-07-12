<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="isAdmin" value="${sessionScope.currentUser.role == 'ADMIN'}" />

<layout:main pageTitle="Courses">

<c:choose>
    <c:when test="${isAdmin}">
        <!-- ADMIN VIEW -->
        <div class="d-flex align-items-center justify-content-between mb-4">
            <p class="text-muted mb-0" style="font-size: 13px;">Manage course stages within each program</p>
            <a href="/courses/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> New Course</a>
        </div>

        <div class="lucy-table mb-4">
            <c:choose>
                <c:when test="${empty coursePage.content}">
                    <div class="empty-state"><i class="bi bi-book"></i><p>No courses yet. Create a course within a program.</p></div>
                </c:when>
                <c:otherwise>
                    <table class="table mb-0">
                        <thead>
                            <tr><th>ID</th><th>Code</th><th>Title</th><th>Program</th><th>Level</th><th>Order</th><th style="width: 100px;">Actions</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${coursePage.content}">
                                <tr>
                                    <td><strong>#${c.id}</strong></td>
                                    <td><span class="badge-status badge-info">${c.code}</span></td>
                                    <td>${c.title}</td>
                                    <td><c:if test="${c.program != null}"><span class="badge-status badge-purple">${c.program.code}</span></c:if></td>
                                    <td>${c.level}</td>
                                    <td>${c.orderIndex}</td>
                                    <td>
                                        <a href="/courses/edit/${c.id}" class="btn-action edit"><i class="bi bi-pencil"></i></a>
                                        <button class="btn-action delete" onclick="confirmDelete('/courses/delete/${c.id}')"><i class="bi bi-trash"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </c:when>

    <c:otherwise>
        <!-- LEARNER VIEW -->
        <div class="mb-4 d-flex justify-content-between align-items-end flex-wrap gap-3">
            <div>
                <h3 style="font-weight: 700; color: #1E293B;">Courses Catalog</h3>
                <p style="color: #64748B; margin-bottom: 0;">Explore structured lessons to improve your skills.</p>
            </div>
            <form action="/courses" method="GET" class="d-flex gap-2 align-items-center">
                <input type="text" name="keyword" list="courseCodesList" class="form-control form-control-sm" placeholder="Search by code or title..." value="${keyword}" style="border-radius: 8px; border: 1px solid #E2E8F0; width: 200px;">
                <datalist id="courseCodesList">
                    <c:forEach var="c" items="${allCourses}">
                        <option value="${c.code}">${c.title}</option>
                    </c:forEach>
                </datalist>

                <button type="submit" class="btn btn-lucy btn-sm" style="border-radius: 8px;"><i class="bi bi-search"></i></button>
            </form>
        </div>

        <c:choose>
            <c:when test="${empty coursePage.content}">
                <div class="empty-state" style="background: #fff; border-radius: 16px; border: 1px dashed #CBD5E1;">
                    <i class="bi bi-book" style="color: #94A1B2;"></i>
                    <p style="color: #64748B;">No courses found matching your criteria.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4 mb-4">
                    <c:forEach var="c" items="${coursePage.content}">
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <div class="stat-card" style="height: 100%; display: flex; flex-direction: column; padding: 0; overflow: hidden; transition: transform 0.2s, box-shadow 0.2s;" onmouseover="this.style.transform='translateY(-4px)'; this.style.boxShadow='0 12px 20px rgba(0,0,0,0.08)';" onmouseout="this.style.transform='none'; this.style.boxShadow='0 4px 6px rgba(0,0,0,0.05)';">
                                <div style="height: 140px; background: linear-gradient(135deg, #F8FAFC, #E2E8F0); border-bottom: 1px solid #E2E8F0; display: flex; align-items: center; justify-content: center; position: relative;">
                                    <i class="bi bi-journal-bookmark-fill" style="font-size: 50px; color: var(--lucy-primary); opacity: 0.2;"></i>
                                    <div style="position: absolute; top: 12px; right: 12px;">
                                        <c:if test="${c.program != null}">
                                            <span class="badge-status badge-purple" style="background: rgba(124, 58, 237, 0.1); backdrop-filter: blur(4px); border: 1px solid rgba(124, 58, 237, 0.2);">${c.program.code}</span>
                                        </c:if>
                                    </div>
                                    <div style="position: absolute; bottom: -16px; left: 20px; width: 40px; height: 40px; background: #fff; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-weight: 700; color: var(--lucy-primary); border: 1px solid #E2E8F0; box-shadow: 0 4px 6px rgba(0,0,0,0.05); z-index: 10;">
                                        ${c.level}
                                    </div>
                                </div>
                                <div style="padding: 24px 20px 20px; flex: 1; display: flex; flex-direction: column;">
                                    <h6 style="font-weight: 700; color: #1E293B; margin-bottom: 6px; line-height: 1.4;">${c.title}</h6>
                                    <p style="font-size: 12px; color: #94A1B2; margin-bottom: 16px;">Course Code: ${c.code}</p>
                                    <div style="margin-top: auto;">
                                        <a href="/courses/${c.id}" class="btn btn-outline-lucy w-100" style="font-size: 13px; border-radius: 8px;">View Detail</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>

<!-- PAGINATION -->
<c:if test="${coursePage.totalPages > 1}">
    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center mb-0">
            <c:set var="prevUrl" value="/courses?page=${coursePage.number - 1}&keyword=${keyword}&level=${level}" />
            <c:set var="nextUrl" value="/courses?page=${coursePage.number + 1}&keyword=${keyword}&level=${level}" />
            
            <li class="page-item ${coursePage.first ? 'disabled' : ''}">
                <a class="page-link border-0" href="${prevUrl}" style="border-radius: 8px; margin-right: 4px; color: #64748B;"><i class="bi bi-chevron-left"></i></a>
            </li>
            <c:forEach begin="0" end="${coursePage.totalPages - 1}" var="i">
                <li class="page-item ${coursePage.number == i ? 'active' : ''}">
                    <a class="page-link border-0 ${coursePage.number == i ? 'bg-primary text-white' : 'text-muted'}" 
                       href="/courses?page=${i}&keyword=${keyword}&level=${level}" 
                       style="border-radius: 8px; margin-right: 4px; width: 36px; text-align: center;">${i + 1}</a>
                </li>
            </c:forEach>
            <li class="page-item ${coursePage.last ? 'disabled' : ''}">
                <a class="page-link border-0" href="${nextUrl}" style="border-radius: 8px; margin-left: 4px; color: #64748B;"><i class="bi bi-chevron-right"></i></a>
            </li>
        </ul>
    </nav>
</c:if>

</layout:main>
