<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Course Detail">

    <!-- Header Section -->
    <div class="mb-4">
        <a href="/courses" class="text-decoration-none text-muted mb-3 d-inline-block"><i class="bi bi-arrow-left"></i> Back to Courses</a>
        <div class="d-flex align-items-center gap-3 mb-2">
            <h2 style="font-weight: 800; color: #1E293B; margin-bottom: 0;">${course.title}</h2>
            <span class="badge-status badge-purple" style="font-size: 14px;">${course.level}</span>
        </div>
        <p style="color: #64748B; font-size: 15px;">Course Code: <strong>${course.code}</strong> <c:if test="${course.program != null}">| Program: <strong>${course.program.code}</strong></c:if></p>
    </div>

    <!-- Description -->
    <c:if test="${not empty course.description}">
        <div class="stat-card mb-4" style="background: #F8FAFC; border: 1px solid #E2E8F0;">
            <h6 style="font-weight: 700; color: #334155; margin-bottom: 12px;"><i class="bi bi-info-circle me-2"></i> About this course</h6>
            <p style="color: #475569; margin-bottom: 0; line-height: 1.6;">${course.description}</p>
        </div>
    </c:if>

    <!-- Syllabus -->
    <h4 style="font-weight: 700; color: #1E293B; margin-bottom: 20px;">Syllabus</h4>
    
    <c:choose>
        <c:when test="${empty chapters}">
            <div class="empty-state" style="background: #fff; border-radius: 16px; border: 1px dashed #CBD5E1;">
                <i class="bi bi-journal-x" style="color: #94A1B2;"></i>
                <p style="color: #64748B;">No chapters added to this course yet.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="accordion" id="syllabusAccordion">
                <c:forEach var="chapter" items="${chapters}" varStatus="status">
                    <div class="accordion-item" style="border: 1px solid #E2E8F0; border-radius: 12px; margin-bottom: 12px; overflow: hidden; background: #fff;">
                        <h2 class="accordion-header" id="heading${chapter.id}">
                            <button class="accordion-button ${status.first ? '' : 'collapsed'}" type="button" data-bs-toggle="collapse" data-bs-toggle="collapse" data-bs-target="#collapse${chapter.id}" aria-expanded="${status.first ? 'true' : 'false'}" aria-controls="collapse${chapter.id}" style="background: #fff; color: #1E293B; font-weight: 600; box-shadow: none; padding: 20px;">
                                <div class="d-flex align-items-center gap-3 w-100">
                                    <div style="width: 32px; height: 32px; border-radius: 8px; background: #EEF2FF; color: #4F46E5; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 14px;">${chapter.orderIndex}</div>
                                    <div>
                                        <div style="font-size: 16px;">${chapter.title}</div>
                                        <div style="font-size: 13px; color: #94A1B2; font-weight: 400; margin-top: 4px;">${chapterLessonsMap[chapter.id].size()} lessons</div>
                                    </div>
                                </div>
                            </button>
                        </h2>
                        <div id="collapse${chapter.id}" class="accordion-collapse collapse ${status.first ? 'show' : ''}" aria-labelledby="heading${chapter.id}" data-bs-parent="#syllabusAccordion">
                            <div class="accordion-body" style="padding: 0; border-top: 1px solid #F1F5F9;">
                                <c:if test="${not empty chapter.description}">
                                    <div style="padding: 16px 20px; background: #F8FAFC; color: #64748B; font-size: 14px; border-bottom: 1px solid #F1F5F9;">
                                        ${chapter.description}
                                    </div>
                                </c:if>
                                
                                <div class="list-group list-group-flush">
                                    <c:choose>
                                        <c:when test="${empty chapterLessonsMap[chapter.id]}">
                                            <div class="list-group-item text-muted" style="padding: 16px 20px; font-style: italic;">No lessons in this chapter yet.</div>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="lesson" items="${chapterLessonsMap[chapter.id]}">
                                                <div class="list-group-item list-group-item-action" style="padding: 16px 20px; display: flex; justify-content: space-between; align-items: center; border-color: #F1F5F9;">
                                                    <div class="d-flex align-items-center gap-3">
                                                        <c:choose>
                                                            <c:when test="${lesson.type == 'VIDEO'}">
                                                                <div style="width: 36px; height: 36px; border-radius: 50%; background: #FEF2F2; color: #DC2626; display: flex; align-items: center; justify-content: center;"><i class="bi bi-play-fill" style="font-size: 20px;"></i></div>
                                                            </c:when>
                                                            <c:when test="${lesson.type == 'DOCUMENT'}">
                                                                <div style="width: 36px; height: 36px; border-radius: 50%; background: #F0FDF4; color: #16A34A; display: flex; align-items: center; justify-content: center;"><i class="bi bi-file-earmark-text"></i></div>
                                                            </c:when>
                                                            <c:when test="${lesson.type == 'QUIZ'}">
                                                                <div style="width: 36px; height: 36px; border-radius: 50%; background: #FFFBEB; color: #D97706; display: flex; align-items: center; justify-content: center;"><i class="bi bi-ui-checks"></i></div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div style="width: 36px; height: 36px; border-radius: 50%; background: #F1F5F9; color: #64748B; display: flex; align-items: center; justify-content: center;"><i class="bi bi-journal-text"></i></div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        
                                                        <div>
                                                            <div style="font-weight: 600; color: #334155;">${lesson.title}</div>
                                                            <c:if test="${not empty lesson.type}">
                                                                <div style="font-size: 12px; color: #94A1B2; margin-top: 2px;">${lesson.type}</div>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                    <a href="/lessons/${lesson.id}" class="btn btn-sm btn-light" style="border-radius: 6px; font-weight: 600; color: #4F46E5;">Study</a>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</layout:main>
