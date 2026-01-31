package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Date;

@WebServlet("/onboarding")
public class OnboardingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        String fullName = req.getParameter("full_name");
        int age = Integer.parseInt(req.getParameter("age"));
        Date dueDate = Date.valueOf(req.getParameter("due_date"));
        String doctor = req.getParameter("doctor_name");
        String hospital = req.getParameter("hospital_name");
        String complications = req.getParameter("complications");

        String sql = """
            INSERT INTO user_profile
            (user_id, full_name, age, due_date, doctor_name, hospital_name, complications, profile_complete)
            VALUES (?, ?, ?, ?, ?, ?, ?, true)
            ON CONFLICT (user_id)
            DO UPDATE SET
                full_name = EXCLUDED.full_name,
                age = EXCLUDED.age,
                due_date = EXCLUDED.due_date,
                doctor_name = EXCLUDED.doctor_name,
                hospital_name = EXCLUDED.hospital_name,
                complications = EXCLUDED.complications,
                profile_complete = true
        """;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, fullName);
            ps.setInt(3, age);
            ps.setDate(4, dueDate);
            ps.setString(5, doctor);
            ps.setString(6, hospital);
            ps.setString(7, complications);

            ps.executeUpdate();

            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/onboarding.jsp?error=db");
        }
    }
}
