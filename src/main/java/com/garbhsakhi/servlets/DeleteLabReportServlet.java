package com.garbhsakhi.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import com.garbhsakhi.dao.LabReportDAO;

@WebServlet("/delete-report")
public class DeleteLabReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
            LabReportDAO dao = new LabReportDAO(conn);

            dao.deleteReport(id);

            response.sendRedirect("lab-reports");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}