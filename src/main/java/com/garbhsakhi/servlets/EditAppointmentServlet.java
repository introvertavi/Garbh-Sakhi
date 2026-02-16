package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.AppointmentDAO;
import com.garbhsakhi.model.Appointment;
import com.garbhsakhi.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/edit-appointment")
public class EditAppointmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // ✅ session safety
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        // logged user exists (not used for filtering now)
        User user = (User) session.getAttribute("user");

        // get id safely
        String idParam = req.getParameter("id");

        if (idParam == null) {
            res.sendRedirect("appointments");
            return;
        }

        int id = Integer.parseInt(idParam);

        // 🔥 IMPORTANT CHANGE HERE
        // fetch appointment ONLY by id
         Appointment appt = AppointmentDAO.getSingleAppointment(id);
System.out.println("DEBUG APPOINTMENT = " + appt);


        if (appt == null) {
            res.sendRedirect("appointments");
            return;
        }

        req.setAttribute("appt", appt);
        req.getRequestDispatcher("edit-appointment.jsp").forward(req, res);
    }
}
