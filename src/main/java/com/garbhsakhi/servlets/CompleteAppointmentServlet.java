package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.AppointmentDAO;
import com.garbhsakhi.model.User;

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
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        int id = Integer.parseInt(request.getParameter("id"));

        AppointmentDAO.markCompleted(id, user.getId());

        response.sendRedirect("appointments");
    }
}
