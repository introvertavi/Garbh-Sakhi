package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.DatabaseConnection;
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

    // ✅ FILE VALIDATION CONSTANTS
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB

    private static final String[] ALLOWED_TYPES = {
        "application/pdf",
        "image/jpeg",
        "image/png",
        "image/jpg"
    };

    // ✅ FILE TYPE CHECK METHOD
    private boolean isValidFileType(String contentType) {
        for (String type : ALLOWED_TYPES) {
            if (type.equalsIgnoreCase(contentType)) {
                return true;
            }
        }
        return false;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // ✅ CHECK USER SESSION
            User user = (User) request.getSession().getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // ✅ GET DB CONNECTION
            Connection conn = DatabaseConnection.getConnection();

            if (conn == null) {
                response.getWriter().println("DB Connection is NULL");
                return;
            }

            LabReportDAO dao = new LabReportDAO(conn);
            List<LabReport> reports = dao.getReportsByUser(user.getId());

            request.setAttribute("reports", reports);

            // ✅ FORWARD TO JSP
            request.getRequestDispatcher("/WEB-INF/views/lab-reports.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("ERROR: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // ✅ CHECK USER
            User user = (User) request.getSession().getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String title = request.getParameter("title");
            Part filePart = request.getPart("file");

            // ✅ FILE NOT SELECTED
            if (filePart == null || filePart.getSize() == 0) {
                request.setAttribute("errorMessage", "Please select a file to upload.");
                doGet(request, response);
                return;
            }

            // ✅ FILE SIZE VALIDATION
            if (filePart.getSize() > MAX_FILE_SIZE) {
                request.setAttribute("errorMessage", "File size must be less than 5MB.");
                doGet(request, response);
                return;
            }

            // ✅ FILE TYPE VALIDATION
            String contentType = filePart.getContentType();

            if (!isValidFileType(contentType)) {
                request.setAttribute("errorMessage", "Only PDF and Image files (JPG, PNG) are allowed.");
                doGet(request, response);
                return;
            }

            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // ✅ SAVE TO DB
            Connection conn = DatabaseConnection.getConnection();

            LabReportDAO dao = new LabReportDAO(conn);

            LabReport report = new LabReport();
            report.setUserId(user.getId());
            report.setTitle(title);
            report.setFilePath("uploads/lab-reports/" + fileName);

            dao.addReport(report);

            response.sendRedirect("lab-reports");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("ERROR: " + e.getMessage());
        }
    }
}