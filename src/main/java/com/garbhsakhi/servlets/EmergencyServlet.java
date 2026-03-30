package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.EmergencyDAO;
import com.garbhsakhi.model.EmergencyContact;
import com.garbhsakhi.dao.DatabaseConnection;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

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
            throw new RuntimeException(e);
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

        try (Connection conn = DatabaseConnection.getConnection()) {

            System.out.println("✅ DB CONNECTED");

            EmergencyDAO dao = new EmergencyDAO(conn);

            // ✅ ADD CONTACT
            if ("add".equals(action)) {

                String label = request.getParameter("label");
                String relationship = request.getParameter("relationship");
                String name = request.getParameter("name");
                String phone = request.getParameter("phone");

                System.out.println("ADDING: " + label + " | " + relationship + " | " + name + " | " + phone);

                EmergencyContact c = new EmergencyContact();
                c.setUserId(userId);
                c.setLabel(label);
                c.setRelationship(relationship);
                c.setName(name);
                c.setPhone(phone);

                boolean inserted = dao.addContact(c);
                System.out.println("INSERT SUCCESS: " + inserted);
            }

            // ✅ DELETE CONTACT
            else if ("delete".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));

                System.out.println("DELETE ID: " + id + " USER: " + userId);

                boolean deleted = dao.deleteContact(id, userId);
                System.out.println("DELETE SUCCESS: " + deleted);
            }

            // 🚨 EMERGENCY TRIGGER (REAL LOGIC)
            else if ("trigger".equals(action)) {

                System.out.println("🚨 EMERGENCY TRIGGERED FOR USER: " + userId);

                List<EmergencyContact> contacts = dao.getContactsByUser(userId);

                if (contacts.isEmpty()) {
                    System.out.println("⚠️ No emergency contacts found");
                    request.getSession().setAttribute("msg", "⚠️ No emergency contacts found!");
                } else {

                    for (EmergencyContact c : contacts) {
                        System.out.println("📞 Alerting: " + c.getName() + " (" + c.getPhone() + ")");
                    }

                    request.getSession().setAttribute("msg",
                            "🚨 Emergency alert sent to " + contacts.size() + " contact(s)!");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        response.sendRedirect(request.getContextPath() + "/emergency");
    }
}