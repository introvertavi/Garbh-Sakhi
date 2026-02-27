package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.AppointmentDAO;
import com.garbhsakhi.model.Appointment;
import com.garbhsakhi.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // ===== SESSION VALIDATION =====
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {

            // ✅ keep appointment status updated
            AppointmentDAO.updateMissedAppointments(user.getId());

            // ===== TODAY APPOINTMENT =====
            List<Appointment> todayAppointments =
                    AppointmentDAO.getTodayAppointments(user.getId());

            if (todayAppointments != null && !todayAppointments.isEmpty()) {
                request.setAttribute("todayPreview",
                        todayAppointments.get(0));
            }

            // ===== UPCOMING APPOINTMENT =====
            List<Appointment> upcomingAppointments =
                    AppointmentDAO.getUpcomingAppointments(user.getId());

            if (upcomingAppointments != null && !upcomingAppointments.isEmpty()) {
                request.setAttribute("upcomingPreview",
                        upcomingAppointments.get(0));
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("dashboardError",
                    "Unable to load dashboard data.");
        }

        // ✅ KEEP YOUR JSP LOCATION (UNCHANGED)
        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp")
                .forward(request, response);
    }
}