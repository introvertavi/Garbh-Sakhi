package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.EmergencyDAO;
import com.garbhsakhi.model.EmergencyContact;
import com.garbhsakhi.dao.DatabaseConnection;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

public class EmergencyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🔥 DO GET CALLED");

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {

            System.out.println("✅ DB CONNECTED");

            EmergencyDAO dao = new EmergencyDAO(conn);
            List<EmergencyContact> contacts = dao.getContactsByUser(userId);

            System.out.println("CONTACT COUNT: " + contacts.size());

            request.setAttribute("contacts", contacts);
            request.getRequestDispatcher("emergency.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e); // 🔥 force error visibility
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🔥 DO POST CALLED");

        HttpSession session = request.getSession(false);

        if (session == null) {
            System.out.println("❌ SESSION NULL");
            response.sendRedirect("login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            System.out.println("❌ USER ID NULL");
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        System.out.println("ACTION: " + action);
        System.out.println("LABEL: " + request.getParameter("label"));
        System.out.println("NAME: " + request.getParameter("name"));
        System.out.println("PHONE: " + request.getParameter("phone"));

        try (Connection conn = DatabaseConnection.getConnection()) {

            System.out.println("✅ DB CONNECTED");

            EmergencyDAO dao = new EmergencyDAO(conn);

            if ("add".equals(action)) {

                EmergencyContact c = new EmergencyContact();
                c.setUserId(userId);
                c.setLabel(request.getParameter("label"));
                c.setName(request.getParameter("name"));
                c.setPhone(request.getParameter("phone"));

                boolean inserted = dao.addContact(c);

                System.out.println("INSERT SUCCESS: " + inserted);
            }

            else if ("delete".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                System.out.println("DELETE ID: " + id + " USER: " + userId);

                boolean deleted = dao.deleteContact(id, userId);

                System.out.println("DELETE SUCCESS: " + deleted);
            }

            else if ("trigger".equals(action)) {

                System.out.println("🚨 EMERGENCY TRIGGERED FOR USER: " + userId);
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e); // 🔥 crash if error
        }

        response.sendRedirect(request.getContextPath() + "/emergency");
    }
}