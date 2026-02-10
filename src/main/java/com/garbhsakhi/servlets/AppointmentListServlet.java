package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.AppointmentDAO;
import com.garbhsakhi.model.Appointment;
import com.garbhsakhi.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/appointments")
public class AppointmentListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Appointment> appointments =
                AppointmentDAO.getAppointmentsByUser(user.getId());

        request.setAttribute("appointments", appointments);
        request.getRequestDispatcher("appointments.jsp").forward(request, response);
    }
}
