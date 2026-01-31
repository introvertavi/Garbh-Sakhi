package com.garbhsakhi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class UserProfileDAO {

    public static boolean saveProfile(
            int userId,
            String fullName,
            int age,
            String dueDate,
            String doctorName,
            String hospitalName,
            String complications
    ) {

        String sql = """
            INSERT INTO user_profile
            (user_id, full_name, age, due_date, doctor_name, hospital_name, complications, profile_complete)
            VALUES (?, ?, ?, ?, ?, ?, ?, true)
            ON CONFLICT (user_id)
            DO UPDATE SET
                full_name = EXCLUDED.full_name,
                age = EXCLUDED.age,
                due_date = EXCLUDED.due_date,
                doctor_name = EXCLUDED.doctor_name,
                hospital_name = EXCLUDED.hospital_name,
                complications = EXCLUDED.complications,
                profile_complete = true
        """;

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, fullName);
            ps.setInt(3, age);
            ps.setDate(4, java.sql.Date.valueOf(dueDate));
            ps.setString(5, doctorName);
            ps.setString(6, hospitalName);
            ps.setString(7, complications);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
