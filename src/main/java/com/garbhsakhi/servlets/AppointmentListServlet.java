package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.AppointmentDAO;
import com.garbhsakhi.model.Appointment;
import com.garbhsakhi.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/appointments")
public class AppointmentListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException, ServletException {

        // ✅ Correct UTF-8 handling (SAFE)
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Auto update missed appointments
        AppointmentDAO.updateMissedAppointments(user.getId());

        List<Appointment> all =
                AppointmentDAO.getAppointmentsByUser(user.getId());

        List<Appointment> today = new ArrayList<>();
        List<Appointment> upcoming = new ArrayList<>();
        List<Appointment> missed = new ArrayList<>();
        List<Appointment> completed = new ArrayList<>();

        LocalDate now = LocalDate.now();

        for (Appointment a : all) {

            if ("COMPLETED".equalsIgnoreCase(a.getStatus())) {
                completed.add(a);
            }
            else if ("MISSED".equalsIgnoreCase(a.getStatus())) {
                missed.add(a);
            }
            else if (a.getAppointmentDate().equals(now)) {
                today.add(a);
            }
            else {
                upcoming.add(a);
            }
        }

        request.setAttribute("todayAppointments", today);
        request.setAttribute("upcomingAppointments", upcoming);
        request.setAttribute("missedAppointments", missed);
        request.setAttribute("completedAppointments", completed);

        request.getRequestDispatcher("appointments.jsp")
               .forward(request, response);
    }
}
