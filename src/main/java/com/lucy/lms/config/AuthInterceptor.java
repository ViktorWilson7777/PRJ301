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

        // Allow static resources, swagger, login, register, and public APIs
        if (uri.startsWith("/login") || uri.startsWith("/register") || uri.startsWith("/css/") || uri.startsWith("/js/")
                || uri.startsWith("/images/") || uri.startsWith("/api/") || uri.startsWith("/swagger-ui") || uri.startsWith("/v3/api-docs")) {
            return true;
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("/login");
            return false;
        }

        AppUser user = (AppUser) session.getAttribute("currentUser");

        // Admin-only route checks
        boolean isAdminRoute = uri.startsWith("/users") 
                || uri.startsWith("/billing/plans") 
                || uri.startsWith("/billing/transactions")
                || uri.contains("/create") 
                || uri.contains("/edit") 
                || uri.contains("/delete");

        if (isAdminRoute && !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("/dashboard?error=access_denied");
            return false;
        }

        return true;
    }
}
