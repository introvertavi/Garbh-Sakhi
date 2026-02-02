package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.UserDAO;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        String current = req.getParameter("currentPassword");
        String newPass = req.getParameter("newPassword");
        String confirm = req.getParameter("confirmPassword");

        if (current == null || newPass == null ||
            confirm == null || !newPass.equals(confirm)) {

            res.sendRedirect(req.getContextPath() + "/change-password.jsp?error=1");
            return;
        }

        boolean ok = UserDAO.changePassword(userId, current, newPass);

        if (ok) {
            // 🔒 SECURITY: invalidate session after password change
            session.invalidate();

            // Redirect to login so user logs in again with new password
            res.sendRedirect(req.getContextPath() + "/login.jsp?password=changed");
        } else {
            res.sendRedirect(req.getContextPath() + "/change-password.jsp?error=1");
        }
    }
}
