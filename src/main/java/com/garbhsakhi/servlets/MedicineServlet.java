package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.MedicineDAO;
import com.garbhsakhi.model.Medicine;
import com.garbhsakhi.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/medicines")
public class MedicineServlet extends HttpServlet {

    private final MedicineDAO medicineDAO = new MedicineDAO();

    // =====================================
    // LOAD MEDICINES PAGE
    // =====================================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔐 session protection
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // fetch medicines
        List<Medicine> medicines =
                medicineDAO.getMedicinesByUser(user.getId());

        // send data to JSP
        req.setAttribute("medicines", medicines);

        // ⭐ IMPORTANT: controls sidebar active style
        req.setAttribute("pageTitle", "Medicines");

        req.getRequestDispatcher("medicines.jsp")
                .forward(req, res);
    }

    // =====================================
    // ADD MEDICINE
    // =====================================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            Medicine med = new Medicine();

            med.setUserId(user.getId());

            // -------- SAFE PARAM READ --------
            String name = req.getParameter("medicineName");
            String dosage = req.getParameter("dosage");
            String frequency = req.getParameter("frequency");
            String timeOfDay = req.getParameter("timeOfDay");
            String notes = req.getParameter("notes");

            med.setMedicineName(name != null ? name.trim() : null);
            med.setDosage(dosage != null ? dosage.trim() : null);
            med.setFrequency(frequency);
            med.setTimeOfDay(timeOfDay);
            med.setNotes(notes != null ? notes.trim() : null);

            // -------- SAFE DATE PARSING --------
            String start = req.getParameter("startDate");
            String end = req.getParameter("endDate");

            if (start != null && !start.isBlank()) {
                med.setStartDate(Date.valueOf(start));
            }

            if (end != null && !end.isBlank()) {
                med.setEndDate(Date.valueOf(end));
            }

            // -------- DEBUG LOGS --------
            System.out.println("ADDING MEDICINE -> " + med.getMedicineName());

            boolean saved = medicineDAO.addMedicine(med);

            System.out.println("MEDICINE SAVED = " + saved);

        } catch (Exception e) {
            System.out.println("ERROR ADDING MEDICINE");
            e.printStackTrace();
        }

        // reload page (PRG pattern)
        res.sendRedirect(req.getContextPath() + "/medicines");
    }
}