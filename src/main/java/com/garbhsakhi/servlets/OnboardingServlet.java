package com.garbhsakhi.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.garbhsakhi.dao.DatabaseConnection;

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

        int userId = ((Number) session.getAttribute("userId")).intValue();

        // -------- READ & TRIM INPUTS --------
        String fullName = trim(req.getParameter("full_name"));
        String phone = trim(req.getParameter("phone"));
        String ageStr = trim(req.getParameter("age"));
        String dueDateStr = trim(req.getParameter("due_date"));

        String doctor = trim(req.getParameter("doctor_name"));
        String hospital = trim(req.getParameter("hospital_name"));
        String complications = trim(req.getParameter("complications"));

        String ec1Name = trim(req.getParameter("ec1_name"));
        String ec1Phone = trim(req.getParameter("ec1_phone"));

        String ec2Name = trim(req.getParameter("ec2_name"));
        String ec2Phone = trim(req.getParameter("ec2_phone"));

        String ec3Name = trim(req.getParameter("ec3_name"));
        String ec3Phone = trim(req.getParameter("ec3_phone"));

        // -------- DEBUG (REMOVE AFTER TESTING) --------
        System.out.println("Onboarding for userId=" + userId);
        System.out.println("Full Name = " + fullName);
        System.out.println("Age = " + ageStr);
        System.out.println("Due Date = " + dueDateStr);

        try (Connection conn = DatabaseConnection.getConnection()) {

            conn.setAutoCommit(false); // 🔒 TRANSACTION START

            Integer age = (ageStr != null && !ageStr.isBlank())
                    ? Integer.parseInt(ageStr)
                    : null;

            Date dueDate = (dueDateStr != null && !dueDateStr.isBlank())
                    ? Date.valueOf(dueDateStr)
                    : null;

            // -------- UPDATE USERS --------
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

            try (PreparedStatement ps = conn.prepareStatement(updateUserSql)) {
                ps.setString(1, fullName);
                ps.setString(2, phone);

                if (age != null) ps.setInt(3, age);
                else ps.setNull(3, java.sql.Types.INTEGER);

                if (dueDate != null) ps.setDate(4, dueDate);
                else ps.setNull(4, java.sql.Types.DATE);

                ps.setString(5, doctor);
                ps.setString(6, hospital);
                ps.setString(7, complications);
                ps.setInt(8, userId);

                ps.executeUpdate();
            }

            // -------- CLEAR OLD EMERGENCY CONTACTS --------
            try (PreparedStatement del = conn.prepareStatement(
                    "DELETE FROM emergency_contacts WHERE user_id = ?")) {
                del.setInt(1, userId);
                del.executeUpdate();
            }

            // -------- INSERT EMERGENCY CONTACTS --------
            String insertEC = """
                INSERT INTO emergency_contacts (user_id, name, phone, relation)
                VALUES (?, ?, ?, ?)
            """;

            try (PreparedStatement psEC = conn.prepareStatement(insertEC)) {

                if (isFilled(ec1Name, ec1Phone))
                    addEC(psEC, userId, ec1Name, ec1Phone, "Primary");

                if (isFilled(ec2Name, ec2Phone))
                    addEC(psEC, userId, ec2Name, ec2Phone, "Secondary");

                if (isFilled(ec3Name, ec3Phone))
                    addEC(psEC, userId, ec3Name, ec3Phone, "Backup");

                psEC.executeBatch();
            }

            conn.commit(); // ✅ SUCCESS
            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/onboarding.jsp?error=db");
        }
    }

    // -------- HELPERS --------

    private String trim(String s) {
        return (s == null) ? null : s.trim();
    }

    private boolean isFilled(String name, String phone) {
        return name != null && phone != null &&
               !name.isBlank() && !phone.isBlank();
    }

    private void addEC(PreparedStatement ps, int userId,
                       String name, String phone, String relation) throws Exception {
        ps.setInt(1, userId);
        ps.setString(2, name);
        ps.setString(3, phone);
        ps.setString(4, relation);
        ps.addBatch();
    }
}

