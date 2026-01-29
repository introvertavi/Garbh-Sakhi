package com.garbhsakhi.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.garbhsakhi.dao.DatabaseConnection;
import com.garbhsakhi.util.PasswordUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/auth/signup")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // ✅ Basic validation
        if (name == null || email == null || password == null ||
            name.isEmpty() || email.isEmpty() || password.isEmpty()) {

            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=empty");
            return;
        }

        String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, PasswordUtil.hash(password));

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        int userId = rs.getInt(1);

                        HttpSession session = request.getSession(true);
                        session.setAttribute("userId", userId);
                        session.setAttribute("email", email);

                        System.out.println("✅ Signup success: " + email);

                        response.sendRedirect(request.getContextPath() + "/onboarding.jsp");
                        return;
                    }
                }
            }

            // fallback
            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=unknown");

        } catch (Exception e) {
            System.out.println("❌ SIGNUP FAILED --> " + e.getMessage());
            e.printStackTrace();

            // duplicate email or DB error
            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=db");
        }
    }
}
