package com.garbhsakhi.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.garbhsakhi.dao.DatabaseConnection;
import com.garbhsakhi.util.PasswordUtil;

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

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT id, password, profile_complete FROM users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("id");
                String dbPassword = rs.getString("password");
                int profileComplete = rs.getInt("profile_complete");

                // Check password
                if (password.equals(dbPassword) || PasswordUtil.verify(password, dbPassword)) {

                    HttpSession session = request.getSession();
                    session.setAttribute("userId", userId);

                    // 👇 NEW LOGIC
                    if (profileComplete == 0) {
                        response.sendRedirect(request.getContextPath() + "/onboarding.jsp");
                        return;
                    } else {
                        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
                        return;
                    }
                }
            }

            response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=db");
        }
    }
}