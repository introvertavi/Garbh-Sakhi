package com.garbhsakhi.dao;

import com.garbhsakhi.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;

public class UserDAO {

    // =========================
    // SIGNUP (users table only)
    // =========================
    public static Integer register(String email, String hashedPassword) {

        String sql = """
            INSERT INTO users (email, password)
            VALUES (?, ?)
            RETURNING id
        """;

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, hashedPassword);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // =========================
    // LOGIN
    // =========================
    public static Integer login(String email, String hashedPassword) {

        String sql = """
            SELECT id
            FROM users
            WHERE email = ? AND password = ?
        """;

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, hashedPassword);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // =========================
    // USER + PROFILE (DASHBOARD)
    // =========================
    public static User getUserById(int userId) {

        User user = null;

        String sql = """
            SELECT
                u.id,
                u.email,
                p.full_name,
                p.age,
                p.due_date,
                p.doctor_name,
                p.hospital_name,
                p.complications,
                p.profile_complete
            FROM users u
            LEFT JOIN user_profile p ON u.id = p.user_id
            WHERE u.id = ?
        """;

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setAge(rs.getInt("age"));

                Date due = rs.getDate("due_date");
                user.setDueDate(due != null ? due.toString() : null);

                user.setDoctorName(rs.getString("doctor_name"));
                user.setHospitalName(rs.getString("hospital_name"));
                user.setComplications(rs.getString("complications"));
                user.setProfileComplete(rs.getBoolean("profile_complete"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // JSP safety overload
    public static User getUserById(Integer userId) {
        if (userId == null) return null;
        return getUserById(userId);
    }
}
