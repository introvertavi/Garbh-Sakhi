package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.AppointmentDAO;
import com.garbhsakhi.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/delete-appointment")
public class DeleteAppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req,HttpServletResponse res)
            throws IOException {

        HttpSession session=req.getSession(false);
        User user=(User)session.getAttribute("user");

        if(user==null){
            res.sendRedirect("login.jsp");
            return;
        }

        int id=Integer.parseInt(req.getParameter("id"));

        AppointmentDAO.deleteAppointment(id,user.getId());

        res.sendRedirect("appointments");
    }
}
