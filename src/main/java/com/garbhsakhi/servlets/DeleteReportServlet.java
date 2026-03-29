package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.LabReportDAO;
import com.garbhsakhi.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/delete-report")
public class DeleteReportServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            User user = (User) request.getSession().getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int reportId = Integer.parseInt(request.getParameter("reportId"));

            Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
            LabReportDAO dao = new LabReportDAO(conn);

            // ✅ GET FILE PATH BEFORE DELETE
            String filePath = dao.getFilePathById(reportId);

            // ✅ DELETE FROM DB
            dao.deleteReport(reportId);

            // ✅ DELETE FILE FROM SERVER
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
            response.getWriter().println("Error deleting report");
        }
    }
}