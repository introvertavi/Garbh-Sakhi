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

@WebServlet("/auth/signup")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.getConnection()) {

            String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, PasswordUtil.hash(password));

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    int userId = rs.getInt(1);

                    HttpSession session = request.getSession();
                    session.setAttribute("userId", userId);
                    session.setAttribute("email", email);

                    System.out.println("Signup success: " + email);

                    response.sendRedirect(request.getContextPath() + "/onboarding.jsp");
                    return;
                }
            }

        } catch (Exception e) {
            System.out.println("❌ SIGNUP FAILED --> " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=db");
        }
    }
}