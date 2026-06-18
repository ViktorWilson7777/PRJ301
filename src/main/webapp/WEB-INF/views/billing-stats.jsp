<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="Financial Overview">

<!-- Include Chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="row g-4 mb-4">
    <!-- Stat 1: Total Credits Sold -->
    <div class="col-md-4">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-3">
                <div class="stat-label">Total Credits Sold</div>
                <div class="stat-icon" style="background: #eef2ff; color: #4f46e5;"><i class="bi bi-coin"></i></div>
            </div>
            <div class="stat-value"><c:out value="${totalCreditsSold}" /></div>
            <div style="font-size: 11px; color: #10b981; font-weight: 600;" class="mt-2">
                <i class="bi bi-graph-up-arrow me-1"></i> All time revenue
            </div>
        </div>
    </div>

    <!-- Stat 2: Top Buyer -->
    <div class="col-md-4">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-3">
                <div class="stat-label">Top Contributor</div>
                <div class="stat-icon" style="background: #fffbeb; color: #d97706;"><i class="bi bi-star-fill"></i></div>
            </div>
            <div class="stat-value" style="font-size: 22px; padding: 4px 0;">
                <c:choose>
                    <c:when test="${not empty topBuyers}">
                        <c:out value="${topBuyers[0].key.displayName}" />
                    </c:when>
                    <c:otherwise>N/A</c:otherwise>
                </c:choose>
            </div>
            <div style="font-size: 11.5px; color: #64748b; font-weight: 500;" class="mt-2">
                Spent: <span class="fw-bold text-dark">
                    <c:choose>
                        <c:when test="${not empty topBuyers}">
                            <c:out value="${topBuyers[0].value}" />
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span> credits
            </div>
        </div>
    </div>

    <!-- Stat 3: Month Count -->
    <div class="col-md-4">
        <div class="stat-card">
            <div class="d-flex align-items-center justify-content-between mb-3">
                <div class="stat-label">Billing Cycle Months</div>
                <div class="stat-icon" style="background: #fdf2f8; color: #db2777;"><i class="bi bi-calendar-check"></i></div>
            </div>
            <div class="stat-value"><c:out value="${monthlyLabels.size()}" /></div>
            <div style="font-size: 11px; color: #64748b; font-weight: 500;" class="mt-2">
                Active monthly cohorts
            </div>
        </div>
    </div>
</div>

<div class="row g-4">
    <!-- Chart Column -->
    <div class="col-lg-8">
        <div class="stat-card" style="min-height: 400px;">
            <h5 class="mb-4" style="font-weight: 700; color: #1e293b;">
                <i class="bi bi-bar-chart-line me-2 text-primary"></i>Monthly Top-Up Revenues
            </h5>
            <div style="position: relative; height: 320px; width: 100%;">
                <canvas id="revenueChart"></canvas>
            </div>
        </div>
    </div>

    <!-- Top Buyers Column -->
    <div class="col-lg-4">
        <div class="stat-card" style="min-height: 400px; display: flex; flex-direction: column;">
            <h5 class="mb-3" style="font-weight: 700; color: #1e293b;">
                <i class="bi bi-people me-2 text-warning"></i>Top Contributors
            </h5>
            <p class="text-muted mb-4" style="font-size: 12px;">Users who purchased the most credits</p>

            <div class="list-group list-group-flush flex-grow-1">
                <c:choose>
                    <c:when test="${empty topBuyers}">
                        <div class="text-center text-muted py-5">
                            <i class="bi bi-inbox fs-2"></i>
                            <p class="mt-2 mb-0">No buyer statistics available</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="entry" items="${topBuyers}" varStatus="status">
                            <div class="d-flex align-items-center justify-content-between py-3" style="border-bottom: 1px solid #f1f5f9;">
                                <div class="d-flex align-items-center">
                                    <div style="width: 32px; height: 32px; border-radius: 50%; background: #e0e7ff; color: #4f46e5; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 13px; margin-right: 12px;">
                                        ${entry.key.displayName.substring(0,1).toUpperCase()}
                                    </div>
                                    <div>
                                        <div class="fw-semibold text-dark" style="font-size: 13.5px;">${entry.key.displayName}</div>
                                        <div class="text-muted" style="font-size: 11px;">Role: ${entry.key.role}</div>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <span class="badge rounded-pill bg-light text-dark border px-2.5 py-1.5" style="font-size: 12px; font-weight: 700;">
                                        ${entry.value} cr
                                    </span>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const labels = [
            <c:forEach var="lbl" items="${monthlyLabels}" varStatus="status">
                "${lbl}"<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        const data = [
            <c:forEach var="val" items="${monthlyValues}" varStatus="status">
                ${val}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        const ctx = document.getElementById('revenueChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Credits Purchased',
                    data: data,
                    backgroundColor: 'rgba(79, 70, 229, 0.75)',
                    borderColor: 'rgba(79, 70, 229, 1)',
                    borderWidth: 2,
                    borderRadius: 6,
                    hoverBackgroundColor: 'rgba(79, 70, 229, 0.9)'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: '#f1f5f9'
                        },
                        ticks: {
                            color: '#94a3b8',
                            font: {
                                family: 'Inter'
                            }
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            color: '#94a3b8',
                            font: {
                                family: 'Inter'
                            }
                        }
                    }
                }
            }
        });
    });
</script>

</layout:main>
