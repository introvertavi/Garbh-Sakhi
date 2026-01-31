package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.DatabaseConnection;
import com.garbhsakhi.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null ||
            email.isBlank() || password.isBlank()) {

            response.sendRedirect(request.getContextPath() + "/login.jsp?error=empty");
            return;
        }

        String userSql = """
            SELECT id, password
            FROM users
            WHERE email = ?
        """;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(userSql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
                return;
            }

            int userId = rs.getInt("id");
            String hashedPassword = rs.getString("password");

            // ✅ PASSWORD CHECK (ONLY HASHED)
            if (!PasswordUtil.verify(password, hashedPassword)) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
                return;
            }

            // ✅ CREATE SESSION
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", userId);
            session.setAttribute("email", email);

            // ✅ CHECK PROFILE COMPLETION
            String profileSql = """
                SELECT profile_complete
                FROM user_profile
                WHERE user_id = ?
            """;

            try (PreparedStatement ps2 = conn.prepareStatement(profileSql)) {
                ps2.setInt(1, userId);
                ResultSet rs2 = ps2.executeQuery();

                if (rs2.next() && rs2.getBoolean("profile_complete")) {
                    response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/onboarding.jsp");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=db");
        }
    }
}
