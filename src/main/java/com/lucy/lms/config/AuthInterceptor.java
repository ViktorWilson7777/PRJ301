package com.lucy.lms.config;

import com.lucy.lms.entity.AppUser;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(
            @org.springframework.lang.NonNull HttpServletRequest request,
            @org.springframework.lang.NonNull HttpServletResponse response,
            @org.springframework.lang.NonNull Object handler
    ) throws Exception {
        String uri = request.getRequestURI();

        // Allow static resources, swagger, login, register, public APIs, and room browsing/viewing
        if (uri.startsWith("/login") || uri.startsWith("/register") || uri.startsWith("/css/") || uri.startsWith("/js/")
                || uri.startsWith("/images/") || uri.startsWith("/api/") || uri.startsWith("/swagger-ui") || uri.startsWith("/v3/api-docs")
                || uri.equals("/rooms") || uri.matches("/rooms/\\d+")) {
            return true;
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("/login");
            return false;
        }

        AppUser user = (AppUser) session.getAttribute("currentUser");
        String role = user.getRole() != null ? user.getRole() : "LEARNER";

        // Admin-only route checks
        boolean isAdminRoute = uri.startsWith("/users")
                || uri.startsWith("/billing/plans")
                || uri.startsWith("/billing/transactions")
                || uri.startsWith("/programs/create")
                || (uri.startsWith("/programs/") && uri.contains("/edit"))
                || (uri.startsWith("/programs/") && uri.contains("/delete"));

        if (isAdminRoute && !"ADMIN".equals(role)) {
            response.sendRedirect("/dashboard?error=access_denied");
            return false;
        }

        // PRO_MENTOR+ routes: create/manage/delete rooms
        boolean isMentorRoute = uri.equals("/rooms/create")
                || uri.matches("/rooms/\\d+/end")
                || uri.matches("/rooms/\\d+/next-stage")
                || uri.matches("/rooms/\\d+/add-participant")
                || uri.matches("/rooms/\\d+/pin-material")
                || uri.matches("/rooms/\\d+/approve-join/\\d+")
                || uri.matches("/rooms/\\d+/deny-join/\\d+")
                || uri.matches("/rooms/\\d+/toggle-role/\\d+")
                || uri.matches("/rooms/delete/\\d+");

        if (isMentorRoute && !("PRO_MENTOR".equals(role) || "SUPER_CREATOR".equals(role) || "ADMIN".equals(role))) {
            response.sendRedirect("/dashboard?error=access_denied");
            return false;
        }

        // SUPER_CREATOR+ routes: recording
        boolean isCreatorRoute = uri.matches("/rooms/\\d+/toggle-recording");

        if (isCreatorRoute && !("SUPER_CREATOR".equals(role) || "ADMIN".equals(role))) {
            response.sendRedirect("/dashboard?error=access_denied");
            return false;
        }

        // Podcast creator routes: PRO_MENTOR, SUPER_CREATOR, ADMIN
        boolean isPodcastCreatorRoute = uri.equals("/podcasts/create")
                || uri.equals("/podcasts/save")
                || uri.matches("/podcasts/edit/\\d+")
                || uri.matches("/podcasts/delete/\\d+")
                || uri.matches("/podcasts/publish/\\d+");

        if (isPodcastCreatorRoute && !("SUPER_CREATOR".equals(role) || "ADMIN".equals(role))) {
            response.sendRedirect("/podcasts?error=access_denied");
            return false;
        }

        return true;
    }
}
