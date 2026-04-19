package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.DatabaseConnection;
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

            try (Connection conn = DatabaseConnection.getConnection()) {
                LabReportDAO dao = new LabReportDAO(conn);

                // Only allow deleting the logged-in user's reports.
                String filePath = dao.getFilePathById(reportId, user.getId());

                dao.deleteReport(reportId, user.getId());

                if (filePath != null) {
                    File file = new File("/home/avinash", filePath);
                    if (file.exists()) {
                        file.delete();
                    }
                }
            }

            response.sendRedirect(request.getContextPath() + "/lab-reports");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error deleting report");
        }
    }
}
