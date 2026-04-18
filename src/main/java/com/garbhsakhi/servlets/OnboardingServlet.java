package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.DatabaseConnection;
import com.garbhsakhi.model.User;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // ✅ SINGLE user object
        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        // ✅ FORM DATA
        String fullName = request.getParameter("full_name");
        int age = Integer.parseInt(request.getParameter("age"));
        Date dueDate = Date.valueOf(request.getParameter("due_date"));
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String hospital = request.getParameter("hospital_name");
        String doctor = request.getParameter("doctor_name");
        String complications = request.getParameter("complications");

        String sql = """
            UPDATE users
            SET
                full_name = ?,
                name = ?,
                age = ?,
                phone = ?,
                due_date = ?,
                doctor_name = ?,
                hospital_name = ?,
                complications = ?,
                profile_complete = true
            WHERE id = ?
        """;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, fullName);
            ps.setString(2, username);
            ps.setInt(3, age);
            ps.setString(4, phone);
            ps.setDate(5, dueDate);
            ps.setString(6, doctor);
            ps.setString(7, hospital);
            ps.setString(8, complications);
            ps.setInt(9, userId);

            ps.executeUpdate();

            // 🔥 UPDATE SESSION USER (ONCE, CORRECTLY)
            user.setFullName(fullName);
            user.setName(username);
            user.setAge(age);
            user.setPhone(phone);
            user.setDueDate(dueDate.toString());
            user.setDoctorName(doctor);
            user.setHospitalName(hospital);
            user.setComplications(complications);
            user.setProfileComplete(true);

            session.setAttribute("user", user);

            // ✅ REDIRECT
            response.sendRedirect(request.getContextPath() + "/dashboard");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/onboarding.jsp?error=db");
        }
    }
}
