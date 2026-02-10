package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.DatabaseConnection;
import com.garbhsakhi.model.User;
import com.garbhsakhi.util.PasswordUtil;

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
            throws IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null ||
                email.isBlank() || password.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=empty");
            return;
        }

        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
                return;
            }

            String hash = rs.getString("password");

            if (!PasswordUtil.verify(password, hash)) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
                return;
            }

            // ✅ BUILD FULL USER OBJECT
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setEmail(rs.getString("email"));
            user.setName(rs.getString("name"));
            user.setFullName(rs.getString("full_name"));
            user.setAge(rs.getInt("age"));
            user.setPhone(rs.getString("phone"));
            user.setDueDate(rs.getString("due_date"));
            user.setDoctorName(rs.getString("doctor_name"));
            user.setHospitalName(rs.getString("hospital_name"));
            user.setComplications(rs.getString("complications"));
            user.setAvatarPath(rs.getString("avatar_path"));
            user.setProfileComplete(rs.getBoolean("profile_complete"));

            // ✅ SESSION
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", user.getId());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("user", user);

            // ✅ FLOW
            if (!user.isProfileComplete()) {
                response.sendRedirect(request.getContextPath() + "/onboarding.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=db");
        }
    }
}
