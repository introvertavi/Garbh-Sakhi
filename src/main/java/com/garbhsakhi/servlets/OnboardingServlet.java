package com.garbhsakhi.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.garbhsakhi.dao.DatabaseConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/onboarding")
public class OnboardingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // MAIN PROFILE FIELDS
        String fullName = req.getParameter("full_name");
        String phone = req.getParameter("phone");
        String age = req.getParameter("age");
        String dueDate = req.getParameter("due_date");

        String doctor = req.getParameter("doctor_name");
        String hospital = req.getParameter("hospital_name");
        String complications = req.getParameter("complications");

        // EMERGENCY CONTACTS
        String ec1Name = req.getParameter("ec1_name");
        String ec1Phone = req.getParameter("ec1_phone");

        String ec2Name = req.getParameter("ec2_name");
        String ec2Phone = req.getParameter("ec2_phone");

        String ec3Name = req.getParameter("ec3_name");
        String ec3Phone = req.getParameter("ec3_phone");

        try (Connection conn = DatabaseConnection.getConnection()) {

            // 1️⃣ UPDATE USER PROFILE
            String updateUserSql = """
                UPDATE users SET
                    full_name = ?,
                    phone = ?,
                    age = ?,
                    due_date = ?,
                    doctor_name = ?,
                    hospital_name = ?,
                    complications = ?,
                    profile_complete = 1
                WHERE id = ?
            """;

            PreparedStatement psUser = conn.prepareStatement(updateUserSql);

            psUser.setString(1, fullName);
            psUser.setString(2, phone);
            psUser.setString(3, age);
            psUser.setString(4, dueDate);
            psUser.setString(5, doctor);
            psUser.setString(6, hospital);
            psUser.setString(7, complications);
            psUser.setInt(8, userId);

            psUser.executeUpdate();

            // 2️⃣ INSERT EMERGENCY CONTACTS
            String insertEC = """
                INSERT INTO emergency_contacts (user_id, name, phone, relation)
                VALUES (?, ?, ?, ?)
            """;

            PreparedStatement psEC = conn.prepareStatement(insertEC);

            // Contact 1
            if (ec1Name != null && ec1Phone != null) {
                psEC.setInt(1, userId);
                psEC.setString(2, ec1Name);
                psEC.setString(3, ec1Phone);
                psEC.setString(4, "Primary");
                psEC.addBatch();
            }

            // Contact 2
            if (ec2Name != null && ec2Phone != null) {
                psEC.setInt(1, userId);
                psEC.setString(2, ec2Name);
                psEC.setString(3, ec2Phone);
                psEC.setString(4, "Secondary");
                psEC.addBatch();
            }

            // Contact 3
            if (ec3Name != null && ec3Phone != null) {
                psEC.setInt(1, userId);
                psEC.setString(2, ec3Name);
                psEC.setString(3, ec3Phone);
                psEC.setString(4, "Backup");
                psEC.addBatch();
            }

            psEC.executeBatch();

            // 3️⃣ REDIRECT TO DASHBOARD
            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("onboarding.jsp?error=db");
        }
    }
}