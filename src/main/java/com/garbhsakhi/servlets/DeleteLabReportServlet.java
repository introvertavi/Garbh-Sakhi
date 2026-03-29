package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.LabReportDAO;
import com.garbhsakhi.dao.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/deleteReport")
public class DeleteLabReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Connection conn = DatabaseConnection.getConnection();
            LabReportDAO dao = new LabReportDAO(conn);

            // 🔥 Get file path before delete
            String filePath = dao.getFilePathById(id);

            // 🔥 Delete from DB
            dao.deleteReport(id);

            // 🔥 Delete file from server
            if (filePath != null) {
                String fullPath = getServletContext().getRealPath("") + File.separator + filePath;
                File file = new File(fullPath);

                if (file.exists()) {
                    file.delete();
                }
            }

            response.sendRedirect("lab-reports");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Delete Error: " + e.getMessage());
        }
    }
}