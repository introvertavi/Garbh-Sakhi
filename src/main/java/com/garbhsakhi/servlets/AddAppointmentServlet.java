package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.AppointmentDAO;
import com.garbhsakhi.model.Appointment;
import com.garbhsakhi.model.User;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet("/add-appointment")
public class AddAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Appointment appt = new Appointment();
        appt.setUserId(user.getId()); // 🔥 FIXED
        appt.setTitle(request.getParameter("title"));
        appt.setDoctorName(request.getParameter("doctorName"));
        appt.setHospitalName(request.getParameter("hospitalName"));
        appt.setAppointmentDate(
                LocalDate.parse(request.getParameter("appointmentDate"))
        );
        appt.setAppointmentTime(
                LocalTime.parse(request.getParameter("appointmentTime"))
        );
        appt.setNotes(request.getParameter("notes"));

        AppointmentDAO.addAppointment(appt);

        response.sendRedirect("appointments");
    }
}
