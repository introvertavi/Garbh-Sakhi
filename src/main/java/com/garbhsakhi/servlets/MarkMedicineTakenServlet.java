package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.MedicineDAO;
import com.garbhsakhi.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/medicine/taken")
public class MarkMedicineTakenServlet extends HttpServlet {

    private final MedicineDAO medicineDAO = new MedicineDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {

            int medicineId = Integer.parseInt(req.getParameter("id"));
            String time = req.getParameter("time");

            medicineDAO.markMedicineTaken(medicineId, user.getId(), time);

        } catch (Exception e) {
            e.printStackTrace();
        }

        String redirect = req.getParameter("redirect");
        if ("medicines".equalsIgnoreCase(redirect)) {
            res.sendRedirect(req.getContextPath() + "/medicines");
            return;
        }

        res.sendRedirect(req.getContextPath() + "/dashboard");
    }
}
