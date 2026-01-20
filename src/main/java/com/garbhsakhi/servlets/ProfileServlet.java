package com.garbhsakhi.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.servlet.http.HttpSession;

import com.garbhsakhi.dao.DatabaseConnection;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/profile")
@MultipartConfig(fileSizeThreshold = 1024 * 100,  // 100KB
                 maxFileSize = 1024 * 1024 * 5,    // 5MB
                 maxRequestSize = 1024 * 1024 * 6) // 6MB
public class ProfileServlet extends HttpServlet {

    // Set this to a folder where Tomcat can write. Recommended: external uploads directory.
    private static final String UPLOAD_DIR = "uploads/avatars";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        int userId = (int) session.getAttribute("userId");

        String fullName = req.getParameter("full_name");
        String username = req.getParameter("username");
        String ageStr = req.getParameter("age");
        String phone = req.getParameter("phone");
        String dueDate = req.getParameter("due_date");
        String doctor = req.getParameter("doctor_name");
        String hospital = req.getParameter("hospital_name");
        String complications = req.getParameter("complications");

        Integer age = null;
        try { if (ageStr != null && !ageStr.isBlank()) age = Integer.parseInt(ageStr); } catch (Exception ignored) {}

        String avatarPath = null;

        // Handle file upload
        Part avatarPart = req.getPart("avatar");
        if (avatarPart != null && avatarPart.getSize() > 0) {
            String submitted = avatarPart.getSubmittedFileName();
            String ext = "";
            int dot = submitted.lastIndexOf('.');
            if (dot > 0) ext = submitted.substring(dot);

            long ts = System.currentTimeMillis();
            String filename = "avatar_" + userId + "_" + ts + ext;

            // Real path inside the deployed app (not recommended for production)
            String appPath = getServletContext().getRealPath("/");
            File uploadDir = new File(appPath, UPLOAD_DIR);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            File file = new File(uploadDir, filename);
            try (InputStream in = avatarPart.getInputStream()) {
                Files.copy(in, file.toPath());
            }

            // store relative path so it works when deployed
            avatarPath = UPLOAD_DIR + "/" + filename;
        }

        // Update DB
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE users SET full_name = ?, name = ?, age = ?, phone = ?, due_date = ?, doctor_name = ?, hospital_name = ?, complications = ?, profile_complete = 1"
                       + (avatarPath != null ? ", avatar_path = ?" : "")
                       + " WHERE id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setString(idx++, fullName);
            ps.setString(idx++, username);
            if (age != null) ps.setInt(idx++, age); else ps.setNull(idx++, java.sql.Types.INTEGER);
            ps.setString(idx++, phone);
            if (dueDate == null || dueDate.isBlank()) ps.setNull(idx++, java.sql.Types.DATE);
            else ps.setDate(idx++, java.sql.Date.valueOf(dueDate));
            ps.setString(idx++, doctor);
            ps.setString(idx++, hospital);
            ps.setString(idx++, complications);
            if (avatarPath != null) {
                ps.setString(idx++, avatarPath);
            }
            ps.setInt(idx++, userId);

            ps.executeUpdate();

            // Update session attribute(s) if needed
            session.setAttribute("profileComplete", 1);

            resp.sendRedirect(req.getContextPath() + "/profile.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/profile.jsp?error=db");
        }
    }
}
