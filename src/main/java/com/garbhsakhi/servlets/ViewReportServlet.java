package com.garbhsakhi.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.*;

@WebServlet("/view-report")
public class ViewReportServlet extends HttpServlet {

    // 🔥 SAME BASE PATH AS UPLOAD
    private static final String BASE_PATH = "/home/avinash/";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filePath = request.getParameter("file");

        if (filePath == null || filePath.isEmpty()) {
            response.getWriter().write("Invalid file");
            return;
        }

        // remove leading slash
        if (filePath.startsWith("/")) {
            filePath = filePath.substring(1);
        }

        // 🔥 BUILD ABSOLUTE PATH
        File file = new File(BASE_PATH + filePath);

        System.out.println("FINAL PATH: " + file.getAbsolutePath());

        if (!file.exists()) {
            response.getWriter().write("File does not exist");
            return;
        }

        // 🔥 CONTENT TYPE
        if (filePath.toLowerCase().endsWith(".pdf")) {
            response.setContentType("application/pdf");
        } else if (filePath.toLowerCase().endsWith(".png")) {
            response.setContentType("image/png");
        } else if (filePath.toLowerCase().endsWith(".jpg") || filePath.toLowerCase().endsWith(".jpeg")) {
            response.setContentType("image/jpeg");
        } else {
            response.setContentType("application/octet-stream");
        }

        response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");

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