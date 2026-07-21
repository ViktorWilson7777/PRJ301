package com.lucy.lms.config;

import com.lucy.lms.entity.AppUser;
import com.lucy.lms.repository.AppUserRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    private final AppUserRepository userRepository;

    public AuthInterceptor(AppUserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public boolean preHandle(
            @org.springframework.lang.NonNull HttpServletRequest request,
            @org.springframework.lang.NonNull HttpServletResponse response,
            @org.springframework.lang.NonNull Object handler
    ) throws Exception {
        String uri = request.getRequestURI();
        HttpSession session = request.getSession(false);
        AppUser user = refreshSessionUser(session);

        // Allow static resources, swagger, login, register, send-otp, public read APIs, and room browsing/viewing
        if (uri.startsWith("/login") || uri.startsWith("/register") || uri.startsWith("/send-otp")
                || uri.startsWith("/forgot-password") || uri.startsWith("/reset-password")
                || uri.startsWith("/css/") || uri.startsWith("/js/")
                || uri.startsWith("/images/") || isPublicApiRead(request, uri)
                || uri.startsWith("/swagger-ui") || uri.startsWith("/v3/api-docs")
                || uri.equals("/rooms") || uri.matches("/rooms/\\d+")) {
            return true;
        }

        if (user == null) {
            if (uri.startsWith("/api/")) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return false;
            }
            response.sendRedirect("/login");
            return false;
        }

        String role = user.getRole() != null ? user.getRole() : "LEARNER";

        // Admin-only route checks
        boolean isAdminRoute = uri.startsWith("/users")
                || uri.startsWith("/pro-applications")
                || uri.startsWith("/admin/api-settings")
                || uri.equals("/api/users")
                || uri.matches("/api/users/\\d+")
                || uri.startsWith("/billing/plans")
                || uri.startsWith("/billing/transactions")
                || uri.startsWith("/courses/create")
                || uri.startsWith("/courses/save")
                || uri.startsWith("/courses/edit")
                || uri.startsWith("/courses/delete")
                || uri.startsWith("/chapters")
                || uri.startsWith("/lessons/create")
                || uri.startsWith("/lessons/save")
                || uri.startsWith("/lessons/edit")
                || uri.startsWith("/lessons/delete")
                || uri.startsWith("/programs/create")
                || (uri.startsWith("/programs/") && uri.contains("/edit"))
                || (uri.startsWith("/programs/") && uri.contains("/delete"));

        if (isAdminRoute && !"ADMIN".equals(role)) {
            response.sendRedirect("/dashboard?error=access_denied");
            return false;
        }

        if (uri.startsWith("/api/ai/")
                && !("ADMIN".equals(role) || "MODERATOR".equals(role) || "PRO_MENTOR".equals(role))) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return false;
        }

        // PRO_MENTOR+ routes: create/manage/delete rooms
        boolean isMentorRoute = uri.equals("/rooms/create")
                || uri.equals("/rooms/save")
                || uri.matches("/rooms/\\d+/end")
                || uri.matches("/rooms/\\d+/next-stage")
                || uri.matches("/rooms/\\d+/add-participant")
                || uri.matches("/rooms/\\d+/pin-material")
                || uri.matches("/rooms/\\d+/approve-join/\\d+")
                || uri.matches("/rooms/\\d+/deny-join/\\d+")
                || uri.matches("/rooms/\\d+/toggle-role/\\d+")
                || uri.matches("/rooms/delete/\\d+")
                || uri.equals("/api/rooms")
                || uri.matches("/api/rooms/\\d+/mic-permission/\\d+")
                || uri.matches("/api/rooms/\\d+/participants/\\d+")
                || uri.matches("/api/rooms/\\d+/pin-material")
                || uri.matches("/api/rooms/\\d+/unpin/\\d+")
                || uri.matches("/api/rooms/\\d+/next-stage")
                || uri.matches("/api/rooms/\\d+/end")
                || uri.matches("/api/rooms/\\d+/pending-requests")
                || uri.matches("/api/rooms/\\d+/approve-join/\\d+")
                || uri.matches("/api/rooms/\\d+/deny-join/\\d+");

        if (isMentorRoute && !("PRO_MENTOR".equals(role) || "ADMIN".equals(role))) {
            response.sendRedirect("/dashboard?error=access_denied");
            return false;
        }

        // SUPER_CREATOR+ routes: recording
        boolean isCreatorRoute = uri.matches("/rooms/\\d+/toggle-recording")
                || uri.matches("/api/rooms/\\d+/toggle-recording");

        if (isCreatorRoute && !("SUPER_CREATOR".equals(role) || "ADMIN".equals(role))) {
            response.sendRedirect("/dashboard?error=access_denied");
            return false;
        }

        // Podcast creator routes: Content Creator or ADMIN
        boolean isPodcastCreatorRoute = uri.equals("/podcasts/create")
                || uri.equals("/podcasts/mine")
                || uri.equals("/podcasts/save")
                || uri.equals("/podcasts/storage/buy")
                || uri.matches("/podcasts/edit/\\d+")
                || uri.matches("/podcasts/delete/\\d+")
                || uri.matches("/podcasts/publish/\\d+");

        if (isPodcastCreatorRoute && !("CONTENT_CREATOR".equals(user.getAccountType())
                || "SUPER_CREATOR".equals(role) || "ADMIN".equals(role))) {
            response.sendRedirect("/podcasts?error=access_denied");
            return false;
        }
        return true;
    }

    private AppUser refreshSessionUser(HttpSession session) {
        if (session == null) return null;
        AppUser sessionUser = (AppUser) session.getAttribute("currentUser");
        if (sessionUser == null || sessionUser.getId() == null) return null;
        AppUser freshUser = userRepository.findById(sessionUser.getId()).orElse(null);
        if (freshUser == null || !Boolean.TRUE.equals(freshUser.getActive())) {
            session.removeAttribute("currentUser");
            return null;
        }
        session.setAttribute("currentUser", freshUser);
        return freshUser;
    }

    private boolean isPublicApiRead(HttpServletRequest request, String uri) {
        if (!"GET".equalsIgnoreCase(request.getMethod())) {
            return false;
        }
        return uri.equals("/api/programs")
                || uri.equals("/api/courses")
                || uri.matches("/api/courses/\\d+/levels")
                || uri.equals("/api/chapters")
                || uri.equals("/api/lessons")
                || uri.startsWith("/api/learning-content")
                || uri.matches("/api/levels/\\d+/lessons")
                || uri.equals("/api/rooms")
                || uri.matches("/api/rooms/\\d+")
                || uri.startsWith("/api/v2/");
    }
}
