package com.garbhsakhi.dao;

import com.garbhsakhi.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;

public class UserDAO {

    // SIGNUP
    public static boolean register(String name, String email, String password, String phone) {
        String sql = "INSERT INTO users (name, email, password, phone) VALUES (?, ?, ?, ?)";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone);

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // LOGIN → returns userId
    public static Integer login(String email, String password) {
        String sql = "SELECT id FROM users WHERE email=? AND password=?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ OVERLOAD FOR JSP (FIXES Integer vs int ISSUE)
    public static User getUserById(Integer userId) {
        if (userId == null) return null;
        return getUserById(userId.intValue());
    }

    // DASHBOARD / PROFILE
    public static User getUserById(int userId) {
        User user = null;

        String sql = "SELECT * FROM users WHERE id = ?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setFullName(rs.getString("full_name"));
                user.setAge(rs.getInt("age"));

                Date due = rs.getDate("due_date");
                user.setDueDate(due != null ? due.toString() : null);

                user.setDoctorName(rs.getString("doctor_name"));
                user.setHospitalName(rs.getString("hospital_name"));
                user.setComplications(rs.getString("complications"));
                user.setProfileComplete(rs.getInt("profile_complete"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}
