package com.garbhsakhi.dao;

import com.garbhsakhi.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.security.MessageDigest;

public class UserDAO {

    // =========================
    // GET USER BY ID
    // =========================
    public static User getUserById(int userId) {

        User user = null;

        String sql = """
            SELECT 
                u.id,
                u.email,
                p.full_name,
                p.profile_complete
            FROM users u
            LEFT JOIN user_profile p ON u.id = p.user_id
            WHERE u.id = ?
        """;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setProfileComplete(rs.getBoolean("profile_complete"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // =========================
    // CHANGE PASSWORD (SHA-256 → BCrypt MIGRATION SAFE)
    // =========================
    public static boolean changePassword(int userId,
                                         String currentPassword,
                                         String newPassword) {

        String getSql = "SELECT password FROM users WHERE id=?";
        String updateSql = "UPDATE users SET password=? WHERE id=?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps1 = conn.prepareStatement(getSql)) {

            ps1.setInt(1, userId);
            ResultSet rs = ps1.executeQuery();

            if (!rs.next()) return false;

            String storedHash = rs.getString("password");
            boolean matches;

            // 🔹 BCrypt (new users)
            if (storedHash.startsWith("$2a$") || storedHash.startsWith("$2b$")) {
                matches = BCrypt.checkpw(currentPassword, storedHash);
            }
            // 🔹 SHA-256 (legacy users)
            else {
                matches = sha256(currentPassword).equals(storedHash);
            }

            if (!matches) return false;

            // 🔒 Always store NEW password as BCrypt
            String newHashed = BCrypt.hashpw(newPassword, BCrypt.gensalt());

            try (PreparedStatement ps2 = conn.prepareStatement(updateSql)) {
                ps2.setString(1, newHashed);
                ps2.setInt(2, userId);
                return ps2.executeUpdate() == 1;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // =========================
    // SHA-256 HELPER (LEGACY SUPPORT)
    // =========================
    private static String sha256(String input) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(input.getBytes("UTF-8"));

        StringBuilder hex = new StringBuilder();
        for (byte b : hash) {
            String h = Integer.toHexString(0xff & b);
            if (h.length() == 1) hex.append('0');
            hex.append(h);
        }
        return hex.toString();
    }
}
