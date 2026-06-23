<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

            <c:set var="isAdmin"
                value="${sessionScope.currentUser.role == 'ADMIN'}" />

            <layout:main pageTitle="${isAdmin ? 'Admin Dashboard' : 'Home'}">

                <c:if test="${param.error == 'access_denied'}">
                    <div class="alert alert-danger alert-dismissible fade show animate-in" role="alert"
                        style="border-radius: 12px; margin-bottom: 24px; font-size: 14px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> <strong>Access Denied:</strong> You do not
                        have permission to access that section.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${isAdmin}">
                        <!-- ============================================== -->
                        <!--                ADMIN DASHBOARD                 -->
                        <!-- ============================================== -->
                        <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                            <div class="row g-3 mb-4">
                                <div class="col-xl-4 col-md-6">
                                    <div class="stat-card">
                                        <div class="d-flex align-items-center justify-content-between mb-2">
                                            <div class="stat-icon" style="background: #F3E8FF;"><i class="bi bi-collection"
                                                    style="color: #7C3AED;"></i></div>
                                            <a href="/programs" class="text-decoration-none" style="font-size: 12px;">View
                                                all →</a>
                                        </div>
                                        <div class="stat-value">${programCount}</div>
                                        <div class="stat-label">Programs</div>
                                    </div>
                                </div>
                                <div class="col-xl-4 col-md-6">
                                    <div class="stat-card">
                                        <div class="d-flex align-items-center justify-content-between mb-2">
                                            <div class="stat-icon" style="background: #EFF6FF;"><i class="bi bi-book"
                                                    style="color: #2563EB;"></i></div>
                                            <a href="/courses" class="text-decoration-none" style="font-size: 12px;">View
                                                all →</a>
                                        </div>
                                        <div class="stat-value">${courseCount}</div>
                                        <div class="stat-label">Courses</div>
                                    </div>
                                </div>
                                <div class="col-xl-4 col-md-6">
                                    <div class="stat-card">
                                        <div class="d-flex align-items-center justify-content-between mb-2">
                                            <div class="stat-icon" style="background: #FFFBEB;"><i
                                                    class="bi bi-person-video3" style="color: #D97706;"></i></div>
                                            <a href="/lessons" class="text-decoration-none" style="font-size: 12px;">View
                                                all →</a>
                                        </div>
                                        <div class="stat-value">${lessonCount}</div>
                                        <div class="stat-label">Lessons (Questions)</div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <div class="row g-3 mb-4">
                        <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                            <div class="col-xl-3 col-md-6">
                                <div class="stat-card">
                                    <div class="d-flex align-items-center justify-content-between mb-2">
                                        <div class="stat-icon" style="background: #FFF7ED;"><i class="bi bi-layers"
                                                style="color: #EA580C;"></i></div>
                                        <a href="/chapters" class="text-decoration-none" style="font-size: 12px;">View
                                            all →</a>
                                    </div>
                                    <div class="stat-value">${chapterCount}</div>
                                    <div class="stat-label">Chapters (Levels)</div>
                                </div>
                            </div>
                        </c:if>
                            <div class="col-xl-3 col-md-6">
                                <div class="stat-card">
                                    <div class="d-flex align-items-center justify-content-between mb-2">
                                        <div class="stat-icon" style="background: #F0F9FF;"><i class="bi bi-people"
                                                style="color: #0284C7;"></i></div>
                                        <a href="/users" class="text-decoration-none" style="font-size: 12px;">View all
                                            →</a>
                                    </div>
                                    <div class="stat-value">${userCount}</div>
                                    <div class="stat-label">Users</div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="stat-card">
                                    <div class="d-flex align-items-center justify-content-between mb-2">
                                        <div class="stat-icon" style="background: #FFFBEB;"><i class="bi bi-mic"
                                                style="color: #D97706;"></i></div>
                                        <a href="/rooms" class="text-decoration-none" style="font-size: 12px;">View all
                                            →</a>
                                    </div>
                                    <div class="stat-value">${roomCount}</div>
                                    <div class="stat-label">Live Rooms</div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="stat-card">
                                    <div class="d-flex align-items-center justify-content-between mb-2">
                                        <div class="stat-icon" style="background: #FEF2F2;"><i
                                                class="bi bi-cloud-upload" style="color: #DC2626;"></i></div>
                                        <a href="/import-files" class="text-decoration-none"
                                            style="font-size: 12px;">View all →</a>
                                    </div>
                                    <div class="stat-value">${importFileCount}</div>
                                    <div class="stat-label">Import Files</div>
                                </div>
                            </div>
                        </div>

                        <div class="row g-3">
                            <div class="col-xl-3 col-md-6">
                                <div class="stat-card">
                                    <div class="d-flex align-items-center justify-content-between mb-2">
                                        <div class="stat-icon" style="background: #FFF1F2;"><i class="bi bi-gift"
                                                style="color: #E11D48;"></i></div>
                                        <a href="/gifts" class="text-decoration-none" style="font-size: 12px;">View all
                                            →</a>
                                    </div>
                                    <div class="stat-value">${giftTxCount}</div>
                                    <div class="stat-label">Gift Transactions</div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="stat-card">
                                    <div class="d-flex align-items-center justify-content-between mb-2">
                                        <div class="stat-icon" style="background: #F0FDF4;"><i class="bi bi-chat-dots"
                                                style="color: #16A34A;"></i></div>
                                        <a href="/ai-generated-questions" class="text-decoration-none"
                                            style="font-size: 12px;">View all →</a>
                                    </div>
                                    <div class="stat-value">${aiQuestionCount}</div>
                                    <div class="stat-label">AI Questions</div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="stat-card"
                                    style="background: linear-gradient(135deg, #6C5CE7, #A29BFE); border: none; height: 100%;">
                                    <div
                                        style="color: rgba(255,255,255,0.85); font-size: 13px; font-weight: 600; margin-bottom: 12px;">
                                        <i class="bi bi-lightning-charge-fill" style="color: #fff;"></i> Quick Actions
                                    </div>
                                    <div class="d-flex flex-wrap gap-2">
                                        <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                                            <a href="/programs/create" class="btn btn-sm"
                                                style="background: rgba(255,255,255,0.2); color: #fff; border-radius: 6px;">+
                                                Program</a>
                                            <a href="/courses/create" class="btn btn-sm"
                                                style="background: rgba(255,255,255,0.2); color: #fff; border-radius: 6px;">+
                                                Course</a>
                                        </c:if>
                                        <a href="/rooms/create" class="btn btn-sm"
                                            style="background: rgba(255,255,255,0.2); color: #fff; border-radius: 6px;">+
                                            Live Room</a>
                                        <a href="/users/create" class="btn btn-sm"
                                            style="background: rgba(255,255,255,0.2); color: #fff; border-radius: 6px;">+
                                            User</a>
                                        <a href="/import-files/create" class="btn btn-sm"
                                            style="background: rgba(255,255,255,0.2); color: #fff; border-radius: 6px;"><i
                                                class="bi bi-upload"></i> Import DOCX</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <!-- ============================================== -->
                        <!--              LEARNER HOME PAGE                 -->
                        <!-- ============================================== -->

                        <div
                            style="background: linear-gradient(135deg, #F8FAFC, #E2E8F0); border-radius: 24px; padding: 60px 40px; margin-bottom: 40px; text-align: center; position: relative; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.02);">
                            <!-- Decorative blobs -->
                            <div
                                style="position: absolute; top: -50px; left: -50px; width: 200px; height: 200px; background: rgba(108, 92, 231, 0.1); border-radius: 50%; filter: blur(30px);">
                            </div>
                            <div
                                style="position: absolute; bottom: -50px; right: -50px; width: 250px; height: 250px; background: rgba(0, 206, 201, 0.1); border-radius: 50%; filter: blur(40px);">
                            </div>

                            <h1
                                style="font-size: 36px; font-weight: 800; color: #1E293B; margin-bottom: 16px; position: relative;">
                                Welcome back, <span
                                    style="color: var(--lucy-primary);">${sessionScope.currentUser.displayName}</span>!
                            </h1>
                            <p
                                style="font-size: 16px; color: #64748B; max-width: 600px; margin: 0 auto 30px; position: relative;">
                                Ready to continue your language learning journey? Join a live audio room to practice
                                speaking, or explore new structured courses today.
                            </p>
                            <div class="d-flex gap-3 justify-content-center position-relative">
                                <a href="/courses" class="btn btn-lucy px-4 py-2"
                                    style="font-size: 15px; border-radius: 12px;">
                                    <i class="bi bi-book me-1"></i> Browse Courses
                                </a>
                            </div>
                        </div>

                        <h4 style="font-weight: 700; color: #1E293B; margin-bottom: 20px;"><i class="bi bi-compass"
                                style="color: var(--lucy-primary);"></i> Explore LUCY</h4>

                        <div class="row g-4 mb-5">
                            <!-- Courses Card -->
                            <div class="col-md-6">
                                <a href="/courses" style="text-decoration: none;">
                                    <div class="stat-card"
                                        style="height: 100%; border: 2px solid transparent; transition: 0.2s;">
                                        <div
                                            style="width: 50px; height: 50px; background: #EFF6FF; border-radius: 16px; display: flex; align-items: center; justify-content: center; font-size: 24px; color: #2563EB; margin-bottom: 16px;">
                                            <i class="bi bi-journal-richtext"></i>
                                        </div>
                                        <h5 style="font-weight: 600; color: #1E293B; margin-bottom: 8px;">Structured
                                            Courses</h5>
                                        <p style="font-size: 13px; color: #64748B; margin-bottom: 16px;">Follow
                                            step-by-step lessons, grammar guides, and vocabulary builders.</p>
                                        <div style="font-size: 12px; font-weight: 600; color: #2563EB;">${courseCount}
                                            courses available →</div>
                                    </div>
                                </a>
                            </div>

                            <!-- Podcasts Card -->
                            <div class="col-md-6">
                                <a href="/podcasts" style="text-decoration: none;">
                                    <div class="stat-card"
                                        style="height: 100%; border: 2px solid transparent; transition: 0.2s;">
                                        <div
                                            style="width: 50px; height: 50px; background: #F3E8FF; border-radius: 16px; display: flex; align-items: center; justify-content: center; font-size: 24px; color: #7C3AED; margin-bottom: 16px;">
                                            <i class="bi bi-headphones"></i>
                                        </div>
                                        <h5 style="font-weight: 600; color: #1E293B; margin-bottom: 8px;">Podcasts</h5>
                                        <p style="font-size: 13px; color: #64748B; margin-bottom: 16px;">Improve your
                                            listening skills with engaging stories and conversations.</p>
                                        <div style="font-size: 12px; font-weight: 600; color: #7C3AED;">${podcastCount}
                                            episodes →</div>
                                    </div>
                                </a>
                            </div>
                        </div>

                        <c:if test="${sessionScope.currentUser.role == 'PRO_MENTOR'}">
                            <div class="stat-card"
                                style="background: linear-gradient(135deg, #FFFBEB, #FEF3C7); border: 1px solid #FDE68A;">
                                <h5 style="font-weight: 600; color: #B45309;"><i class="bi bi-stars"></i> Pro Mentor
                                    Actions</h5>
                                <p style="font-size: 13px; color: #92400E; margin-bottom: 16px;">As a Mentor, you can
                                    create and host Live Rooms.</p>
                                <a href="/rooms/create" class="btn btn-sm"
                                    style="background: #D97706; color: white; border-radius: 8px; padding: 6px 16px;">
                                    <i class="bi bi-plus-lg"></i> Create Live Room
                                </a>
                            </div>
                        </c:if>

                        <c:if test="${sessionScope.currentUser.role == 'SUPER_CREATOR'}">
                            <!-- ============================================== -->
                            <!--           SUPER CREATOR DASHBOARD              -->
                            <!-- ============================================== -->

                            <!-- Creator Stats Row -->
                            <h4 style="font-weight: 700; color: #1E293B; margin-bottom: 20px; margin-top: 10px;"><i class="bi bi-lightning-charge-fill" style="color: #DB2777;"></i> Creator Hub</h4>
                            <div class="row g-3 mb-4">
                                <div class="col-md-4">
                                    <div class="stat-card" style="border-left: 4px solid #DB2777;">
                                        <div class="d-flex align-items-center justify-content-between mb-2">
                                            <div class="stat-icon" style="background: #FDF2F8;"><i class="bi bi-mic-fill" style="color: #DB2777;"></i></div>
                                            <a href="/my-rooms" class="text-decoration-none" style="font-size: 12px;">Manage →</a>
                                        </div>
                                        <div class="stat-value">${roomCount}</div>
                                        <div class="stat-label">Live Rooms</div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="stat-card" style="border-left: 4px solid #7C3AED;">
                                        <div class="d-flex align-items-center justify-content-between mb-2">
                                            <div class="stat-icon" style="background: #F3E8FF;"><i class="bi bi-headphones" style="color: #7C3AED;"></i></div>
                                            <a href="/podcasts" class="text-decoration-none" style="font-size: 12px;">View all →</a>
                                        </div>
                                        <div class="stat-value">${podcastCount}</div>
                                        <div class="stat-label">Podcast Episodes</div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="stat-card" style="border-left: 4px solid #2563EB;">
                                        <div class="d-flex align-items-center justify-content-between mb-2">
                                            <div class="stat-icon" style="background: #EFF6FF;"><i class="bi bi-gem" style="color: #2563EB;"></i></div>
                                            <a href="/premium-content" class="text-decoration-none" style="font-size: 12px;">Browse →</a>
                                        </div>
                                        <div class="stat-value">${importFileCount}</div>
                                        <div class="stat-label">Premium Content</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Quick Actions -->
                            <div class="stat-card mb-4" style="background: linear-gradient(135deg, #FDF2F8, #FAE8FF); border: 1px solid #F9A8D4;">
                                <h5 style="font-weight: 600; color: #831843; margin-bottom: 16px;"><i class="bi bi-lightning-charge-fill"></i> Super Creator Quick Actions</h5>
                                <p style="font-size: 13px; color: #9D174D; margin-bottom: 20px;">As a Super Creator, you can host live rooms, publish podcasts, and sell premium course content.</p>
                                <div class="d-flex flex-wrap gap-2">
                                    <a href="/rooms/create" class="btn btn-sm" style="background: #DB2777; color: white; border-radius: 10px; padding: 8px 18px; font-weight: 500;">
                                        <i class="bi bi-plus-lg me-1"></i> Create Live Room
                                    </a>
                                    <a href="/podcasts/create" class="btn btn-sm" style="background: #7C3AED; color: white; border-radius: 10px; padding: 8px 18px; font-weight: 500;">
                                        <i class="bi bi-headphones me-1"></i> New Podcast
                                    </a>
                                    <a href="/premium-content" class="btn btn-sm" style="background: #2563EB; color: white; border-radius: 10px; padding: 8px 18px; font-weight: 500;">
                                        <i class="bi bi-gem me-1"></i> Premium Content
                                    </a>
                                    <a href="/billing/topup" class="btn btn-sm" style="background: #D97706; color: white; border-radius: 10px; padding: 8px 18px; font-weight: 500;">
                                        <i class="bi bi-coin me-1"></i> Top Up Credits
                                    </a>
                                </div>
                            </div>

                            <!-- Creator Perks Info -->
                            <div class="stat-card" style="background: linear-gradient(135deg, #F0F9FF, #E0F2FE); border: 1px solid #BAE6FD;">
                                <h5 style="font-weight: 600; color: #0C4A6E; margin-bottom: 16px;"><i class="bi bi-trophy-fill" style="color: #0284C7;"></i> Your Super Creator Perks</h5>
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <div style="background: #fff; padding: 16px; border-radius: 12px; text-align: center; border: 1px solid #E0F2FE;">
                                            <div style="font-size: 28px; margin-bottom: 8px;">🎙️</div>
                                            <div style="font-weight: 600; color: #1E293B; font-size: 14px;">Audio Recording</div>
                                            <div style="font-size: 12px; color: #64748B; margin-top: 4px;">Record live classroom sessions</div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div style="background: #fff; padding: 16px; border-radius: 12px; text-align: center; border: 1px solid #E0F2FE;">
                                            <div style="font-size: 28px; margin-bottom: 8px;">🎧</div>
                                            <div style="font-weight: 600; color: #1E293B; font-size: 14px;">Auto-Publish Podcasts</div>
                                            <div style="font-size: 12px; color: #64748B; margin-top: 4px;">Convert recordings to podcasts</div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div style="background: #fff; padding: 16px; border-radius: 12px; text-align: center; border: 1px solid #E0F2FE;">
                                            <div style="font-size: 28px; margin-bottom: 8px;">💎</div>
                                            <div style="font-weight: 600; color: #1E293B; font-size: 14px;">Sell Premium Content</div>
                                            <div style="font-size: 12px; color: #64748B; margin-top: 4px;">Monetize your course materials</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                    </c:otherwise>
                </c:choose>

            </layout:main>