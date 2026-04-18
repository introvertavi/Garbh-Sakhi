package com.garbhsakhi.servlets;

import java.io.IOException;
import java.util.List;

import com.garbhsakhi.dao.AppointmentDAO;
import com.garbhsakhi.dao.LabReportDAO;
import com.garbhsakhi.dao.MedicineDAO; // ✅ ADDED
import com.garbhsakhi.model.Appointment;
import com.garbhsakhi.model.LabReport;
import com.garbhsakhi.model.User;
import com.garbhsakhi.dao.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // ===== SESSION VALIDATION =====
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // ✅ ADDED
        MedicineDAO medicineDAO = new MedicineDAO();

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

            // ✅ NEW (required for smart dashboard card)
            Appointment nextToday =
                    AppointmentDAO.getNextTodayAppointment(user.getId());

            request.setAttribute("nextTodayAppointment", nextToday);
            
            // ===== ADD THIS (appointment notification) =====
            request.setAttribute("upcomingNotification", nextToday);
            
            // ✅ ===== MEDICINE NOTIFICATIONS (ADDED) =====
            int pendingCount = medicineDAO.getPendingDoseCount(user.getId());
            int missedCount = medicineDAO.getMissedDoseCount(user.getId());

            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("missedCount", missedCount);
            int totalNotifications = pendingCount + missedCount;

            if (nextToday != null) {
            totalNotifications += 1;
            }
            try (var conn = DatabaseConnection.getConnection()) {
                LabReportDAO labDao = new LabReportDAO(conn);
                List<LabReport> recentReports = labDao.getReportsByUser(user.getId());

                if (recentReports != null && recentReports.size() > 3) {
                    recentReports = recentReports.subList(0, 3);
                }

                request.setAttribute("recentReports", recentReports);
            }
            request.setAttribute("totalNotifications", totalNotifications);
            request.setAttribute("pageTitle", "Dashboard");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("dashboardError",
                    "Unable to load dashboard data.");
        }

        request.getRequestDispatcher("/dashboard.jsp")
                .forward(request, response);
    }
}
