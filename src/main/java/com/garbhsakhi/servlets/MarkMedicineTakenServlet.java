package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.MedicineDAO;

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

        try {

            int medicineId = Integer.parseInt(req.getParameter("id"));
            String time = req.getParameter("time");

            medicineDAO.markMedicineTaken(medicineId, time);

        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect(req.getContextPath() + "/dashboard.jsp");
    }
}