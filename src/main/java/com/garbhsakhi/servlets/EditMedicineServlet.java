package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.MedicineDAO;
import com.garbhsakhi.model.Medicine;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/edit-medicine")
public class EditMedicineServlet extends HttpServlet {

    private final MedicineDAO medicineDAO = new MedicineDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        Medicine med = medicineDAO.getMedicineById(id);

        req.setAttribute("medicine", med);

        req.getRequestDispatcher("edit-medicine.jsp")
                .forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        try {

            Medicine med = new Medicine();

            med.setId(Integer.parseInt(req.getParameter("id")));
            med.setMedicineName(req.getParameter("medicineName"));
            med.setDosage(req.getParameter("dosage"));
            med.setFrequency(req.getParameter("frequency"));
            med.setTimeOfDay(req.getParameter("timeOfDay"));

            String start = req.getParameter("startDate");
            String end = req.getParameter("endDate");

            if(start != null && !start.isBlank())
                med.setStartDate(Date.valueOf(start));

            if(end != null && !end.isBlank())
                med.setEndDate(Date.valueOf(end));

            med.setNotes(req.getParameter("notes"));
// ✅ ADD THIS
med.setStatus(req.getParameter("status"));
            medicineDAO.updateMedicine(med);

        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect("medicines");
    }
}
