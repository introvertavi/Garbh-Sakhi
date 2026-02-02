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
import java.sql.SQLException;

@WebServlet("/auth/signup")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null ||
            email.isBlank() || password.isBlank()) {

            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=empty");
            return;
        }

        // 🔐 ALWAYS HASH WITH BCrypt
        String hashed = PasswordUtil.hash(password);

        String sql = """
            INSERT INTO users (email, password)
            VALUES (?, ?)
            RETURNING id
        """;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, hashed);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    int userId = rs.getInt(1);

                    HttpSession session = request.getSession(true);
                    session.setAttribute("userId", userId);

                    response.sendRedirect(request.getContextPath() + "/onboarding.jsp");
                    return;
                }
            }

            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=db");

        } catch (SQLException e) {

            // 🔴 DUPLICATE EMAIL (UNIQUE CONSTRAINT)
            if (e.getMessage() != null && e.getMessage().contains("unique")) {
                response.sendRedirect(request.getContextPath() + "/signup.jsp?error=exists");
            } else {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/signup.jsp?error=db");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=db");
        }
    }
}
