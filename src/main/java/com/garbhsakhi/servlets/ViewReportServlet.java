package com.garbhsakhi.servlets;

import com.garbhsakhi.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.*;

@WebServlet("/view-report")
public class ViewReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String fileName = request.getParameter("file");

        if (fileName == null) {
            response.getWriter().println("File not found");
            return;
        }

        String filePath = getServletContext().getRealPath("") +
                File.separator + "uploads/lab-reports/" + fileName;

        File file = new File(filePath);

        if (!file.exists()) {
            response.getWriter().println("File does not exist");
            return;
        }

        // Set content type
        if (fileName.endsWith(".pdf")) {
            response.setContentType("application/pdf");
        } else {
            response.setContentType("image/jpeg");
        }

        response.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");

        FileInputStream fis = new FileInputStream(file);
        OutputStream os = response.getOutputStream();

        byte[] buffer = new byte[4096];
        int bytesRead;

        while ((bytesRead = fis.read(buffer)) != -1) {
            os.write(buffer, 0, bytesRead);
        }

        fis.close();
        os.close();
    }
}