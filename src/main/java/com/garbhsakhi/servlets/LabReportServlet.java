package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.LabReportDAO;
import com.garbhsakhi.model.LabReport;
import com.garbhsakhi.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.Connection;
import java.util.List;

@MultipartConfig
@WebServlet("/lab-reports")
public class LabReportServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads/lab-reports";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            User user = (User) request.getSession().getAttribute("user");

            Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
            LabReportDAO dao = new LabReportDAO(conn);

            List<LabReport> reports = dao.getReportsByUser(user.getId());
            request.setAttribute("reports", reports);

            request.getRequestDispatcher("/WEB-INF/views/lab-reports.jsp")
       .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            User user = (User) request.getSession().getAttribute("user");

            String title = request.getParameter("title");
            Part filePart = request.getPart("file");

            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // Save to DB
            Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
            LabReportDAO dao = new LabReportDAO(conn);

            LabReport report = new LabReport();
            report.setUserId(user.getId());
            report.setTitle(title);
            report.setFilePath("uploads/lab-reports/" + fileName);

            dao.addReport(report);

            response.sendRedirect("lab-reports");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}