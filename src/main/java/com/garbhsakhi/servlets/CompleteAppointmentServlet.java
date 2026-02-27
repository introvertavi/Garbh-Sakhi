package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.AppointmentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/complete-appointment")
public class CompleteAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        AppointmentDAO.markCompleted(id);

        response.sendRedirect("appointments");
    }
}