package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.DatabaseConnection;
import com.garbhsakhi.model.User;
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

        String sql = """
            SELECT
                id,
                email,
                name,
                full_name,
                age,
                due_date,
                doctor_name,
                hospital_name,
                complications,
                password,
                profile_complete
            FROM users
            WHERE email = ?
        """;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {

                if (!rs.next()) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
                    return;
                }

                String storedPassword = rs.getString("password");

                // 🔐 NULL / EMPTY SAFETY
                if (storedPassword == null || storedPassword.isBlank()) {
                    System.err.println("❌ Login failed: NULL password for " + email);
                    response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
                    return;
                }

                // 🔐 PASSWORD VERIFY (SHA-256 + BCrypt)
                if (!PasswordUtil.verify(password, storedPassword)) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
                    return;
                }

                // ✅ BUILD USER OBJECT
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setName(rs.getString("name"));
                user.setFullName(rs.getString("full_name"));
                user.setAge(rs.getInt("age"));

                if (rs.getDate("due_date") != null) {
                    user.setDueDate(rs.getDate("due_date").toString());
                }

                user.setDoctorName(rs.getString("doctor_name"));
                user.setHospitalName(rs.getString("hospital_name"));
                user.setComplications(rs.getString("complications"));
                user.setProfileComplete(rs.getBoolean("profile_complete"));

                // ✅ SESSION
                HttpSession session = request.getSession(true);
                session.setAttribute("userId", user.getId());
                session.setAttribute("user", user);

                // ✅ ROUTING
                if (user.isProfileComplete()) {
                    response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/onboarding.jsp");
                }
            }

        } catch (Exception e) {
            System.err.println("🔥 LOGIN DB ERROR for email: " + email);
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=db");
        }
    }
}

