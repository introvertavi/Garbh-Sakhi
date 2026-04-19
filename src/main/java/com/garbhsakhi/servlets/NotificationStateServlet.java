package com.garbhsakhi.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@WebServlet("/notification-state")
public class NotificationStateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String action = req.getParameter("action");
        String signature = req.getParameter("signature");

        if ("seen".equalsIgnoreCase(action)) {
            session.setAttribute("seenNotificationSignature", signature == null ? "" : signature);
        } else if ("dismiss".equalsIgnoreCase(action)) {
            String key = req.getParameter("key");

            @SuppressWarnings("unchecked")
            Set<String> dismissedNotifications =
                    (Set<String>) session.getAttribute("dismissedNotifications");

            if (dismissedNotifications == null) {
                dismissedNotifications = new HashSet<>();
            }

            if (key != null && !key.isBlank()) {
                dismissedNotifications.add(key);
            }

            session.setAttribute("dismissedNotifications", dismissedNotifications);
        }

        resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
    }
}
