<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="My Live Rooms">

    <div class="mb-4 d-flex justify-content-between align-items-end">
        <div>
            <h3 style="font-weight: 700; color: #1E293B;">My Live Rooms</h3>
            <p style="color: #64748B; margin-bottom: 0;">Manage the live conversations you host.</p>
        </div>
        <a href="/rooms/create" class="btn btn-lucy"><i class="bi bi-plus-lg me-1"></i> Host a Room</a>
    </div>

    <c:choose>
        <c:when test="${empty rooms}">
            <div class="empty-state" style="background: #fff; border-radius: 16px; border: 1px dashed #CBD5E1; padding: 40px; text-align: center;">
                <i class="bi bi-mic" style="color: #94A1B2; font-size: 32px; margin-bottom: 16px; display: block;"></i>
                <p style="color: #64748B; margin-bottom: 0;">You haven't created any live rooms yet.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <c:forEach var="r" items="${rooms}">
                    <div class="col-xl-4 col-md-6">
                        <div class="stat-card" style="height: 100%; display: flex; flex-direction: column; position: relative;">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <div style="width: 48px; height: 48px; background: linear-gradient(135deg, #1E293B, #0F172A); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-weight: 700;">
                                    ${r.languageCode}
                                </div>
                                <div>
                                    <c:choose>
                                        <c:when test="${r.status == 'LIVE'}">
                                            <span class="badge-status badge-danger animate-pulse"><i class="bi bi-broadcast me-1"></i> LIVE</span>
                                        </c:when>
                                        <c:when test="${r.status == 'SCHEDULED'}">
                                            <span class="badge-status badge-warning"><i class="bi bi-clock me-1"></i> UPCOMING</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-status badge-gray"><i class="bi bi-check-circle me-1"></i> ENDED</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <h5 style="font-weight: 700; color: #1E293B; margin-bottom: 8px;">${r.title}</h5>
                            <div class="d-flex align-items-center mb-4" style="font-size: 13px; color: #64748B;">
                                <i class="bi bi-calendar-event me-1"></i> ${r.roomType}
                            </div>
                            
                            <div class="mt-auto d-flex justify-content-between align-items-center">
                                <div style="font-size: 12px; color: #94A1B2; font-weight: 500;">
                                    <i class="bi bi-people-fill me-1"></i> Max: ${r.maxParticipants}
                                </div>
                                <div class="d-flex gap-2">
                                    <c:if test="${r.status != 'LIVE' && r.status != 'ENDED'}">
                                        <a href="/rooms/create?id=${r.id}" class="btn btn-outline-lucy px-3" style="border-radius: 20px;">Edit</a>
                                    </c:if>
                                    <a href="/rooms/${r.id}" class="btn btn-lucy px-4" style="border-radius: 20px;">
                                        <c:choose>
                                            <c:when test="${r.status == 'LIVE'}">Enter Room</c:when>
                                            <c:otherwise>View Details</c:otherwise>
                                        </c:choose>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</layout:main>
