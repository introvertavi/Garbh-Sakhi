package com.garbhsakhi.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.garbhsakhi.dao.DatabaseConnection;
import com.garbhsakhi.model.User;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/profile")
@MultipartConfig(
        fileSizeThreshold = 1024 * 100,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 6
)
public class ProfileServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads/avatars";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ✅ AUTH CHECK (CORRECT)
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        // ✅ FORM DATA
        String fullName = req.getParameter("full_name");
        String username = req.getParameter("username");
        String phone = req.getParameter("phone");
        String dueDate = req.getParameter("due_date");
        String doctor = req.getParameter("doctor_name");
        String hospital = req.getParameter("hospital_name");
        String complications = req.getParameter("complications");

        Integer age = null;
        try {
            String ageStr = req.getParameter("age");
            if (ageStr != null && !ageStr.isBlank()) {
                age = Integer.parseInt(ageStr);
            }
        } catch (Exception ignored) {}

        String avatarPath = null;

        // ✅ AVATAR UPLOAD
        Part avatarPart = req.getPart("avatar");
        if (avatarPart != null && avatarPart.getSize() > 0) {

            String filename = "avatar_" + userId + "_" + System.currentTimeMillis()
                    + avatarPart.getSubmittedFileName()
                            .substring(avatarPart.getSubmittedFileName().lastIndexOf('.'));

            String appPath = getServletContext().getRealPath("/");
            File uploadDir = new File(appPath, UPLOAD_DIR);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            File file = new File(uploadDir, filename);
            try (InputStream in = avatarPart.getInputStream()) {
                Files.copy(in, file.toPath());
            }

            avatarPath = UPLOAD_DIR + "/" + filename;
        }

        // ✅ DB UPDATE
        try (Connection conn = DatabaseConnection.getConnection()) {

            String sql = """
                UPDATE users SET
                    full_name = ?,
                    name = ?,
                    age = ?,
                    phone = ?,
                    due_date = ?,
                    doctor_name = ?,
                    hospital_name = ?,
                    complications = ?,
                    profile_complete = true
                """ + (avatarPath != null ? ", avatar_path = ?" : "") + """
                WHERE id = ?
            """;

            PreparedStatement ps = conn.prepareStatement(sql);
            int i = 1;

            ps.setString(i++, fullName);
            ps.setString(i++, username);
            if (age != null) ps.setInt(i++, age); else ps.setNull(i++, java.sql.Types.INTEGER);
            ps.setString(i++, phone);
            if (dueDate == null || dueDate.isBlank())
                ps.setNull(i++, java.sql.Types.DATE);
            else
                ps.setDate(i++, java.sql.Date.valueOf(dueDate));
            ps.setString(i++, doctor);
            ps.setString(i++, hospital);
            ps.setString(i++, complications);

            if (avatarPath != null) ps.setString(i++, avatarPath);

            ps.setInt(i++, userId);
            ps.executeUpdate();

            // ✅ UPDATE SESSION USER
            user.setFullName(fullName);
            user.setName(username);
            user.setAge(age != null ? age : 0);
            user.setPhone(phone);
            user.setDueDate(dueDate);
            user.setDoctorName(doctor);
            user.setHospitalName(hospital);
            user.setComplications(complications);
            if (avatarPath != null) user.setAvatarPath(avatarPath);
            user.setProfileComplete(true);

            session.setAttribute("user", user);

            resp.sendRedirect(req.getContextPath() + "/profile.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/profile.jsp?error=db");
        }
    }
}
