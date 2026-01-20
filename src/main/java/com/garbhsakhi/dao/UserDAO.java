package com.garbhsakhi.dao;

import com.garbhsakhi.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public static User getUserById(int userId) {
        User u = null;

        try (Connection conn = DatabaseConnection.getConnection()) {

            String sql = """
                    SELECT
                        id,
                        name,
                        full_name,
                        email,
                        age,
                        phone,
                        due_date,
                        doctor_name,
                        hospital_name,
                        complications,
                        avatar_path,
                        profile_complete
                    FROM users
                    WHERE id = ?
                    """;

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                u = new User();

                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setAge(rs.getInt("age"));
                u.setPhone(rs.getString("phone"));
                u.setDueDate(rs.getString("due_date"));
                u.setDoctorName(rs.getString("doctor_name"));
                u.setHospitalName(rs.getString("hospital_name"));
                u.setComplications(rs.getString("complications"));
                u.setAvatarPath(rs.getString("avatar_path"));
                u.setProfileComplete(rs.getInt("profile_complete"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return u;
    }
}