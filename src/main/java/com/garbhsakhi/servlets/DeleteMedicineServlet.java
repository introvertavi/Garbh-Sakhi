package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.MedicineDAO;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/delete-medicine")
public class DeleteMedicineServlet extends HttpServlet {

    private final MedicineDAO medicineDAO = new MedicineDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        try {

            int id = Integer.parseInt(req.getParameter("id"));

            medicineDAO.deleteMedicine(id);

        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect("medicines");
    }
}
