package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.DatabaseConnection;
import com.garbhsakhi.dao.UserDAO;
import com.garbhsakhi.model.User;
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

        String hashedPassword = PasswordUtil.hash(password);

        String sql = """
            INSERT INTO users (email, password, profile_complete)
            VALUES (?, ?, false)
            RETURNING id
        """;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, hashedPassword);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    int userId = rs.getInt(1);

                    // ✅ LOAD FULL USER OBJECT
                    User user = UserDAO.getUserById(userId);

                    HttpSession session = request.getSession(true);
                    session.setAttribute("userId", userId);
                    session.setAttribute("user", user);

                    // ✅ NEW USER → ONBOARDING
                    response.sendRedirect(request.getContextPath() + "/onboarding.jsp");
                    return;
                }
            }

            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=db");

        } catch (SQLException e) {

            if (e.getMessage() != null && e.getMessage().toLowerCase().contains("unique")) {
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
