package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.AppointmentDAO;
import com.garbhsakhi.model.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.*;

@WebServlet("/update-appointment")
public class UpdateAppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req,HttpServletResponse res)
            throws IOException {

        HttpSession session=req.getSession(false);
        User user=(User)session.getAttribute("user");

        Appointment a=new Appointment();

        a.setId(Integer.parseInt(req.getParameter("id")));
        a.setUserId(user.getId());
        a.setTitle(req.getParameter("title"));
        a.setDoctorName(req.getParameter("doctor"));
        a.setHospitalName(req.getParameter("hospital"));
        a.setAppointmentDate(LocalDate.parse(req.getParameter("date")));
        a.setAppointmentTime(LocalTime.parse(req.getParameter("time")));
        a.setNotes(req.getParameter("notes"));

        AppointmentDAO.updateAppointment(a);

        res.sendRedirect("appointments");
    }
}
