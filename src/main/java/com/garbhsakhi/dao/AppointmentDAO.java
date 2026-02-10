package com.garbhsakhi.dao;

import com.garbhsakhi.model.Appointment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    public static void addAppointment(Appointment appt) {

        String sql = """
            INSERT INTO appointments (
                user_id, title, doctor_name, hospital_name,
                appointment_date, appointment_time, notes, status
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, 'UPCOMING')
        """;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, appt.getUserId());
            ps.setString(2, appt.getTitle());
            ps.setString(3, appt.getDoctorName());
            ps.setString(4, appt.getHospitalName());
            ps.setDate(5, Date.valueOf(appt.getAppointmentDate()));
            ps.setTime(6, Time.valueOf(appt.getAppointmentTime()));
            ps.setString(7, appt.getNotes());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<Appointment> getAppointmentsByUser(int userId) {

        List<Appointment> list = new ArrayList<>();

        String sql = """
            SELECT * FROM appointments
            WHERE user_id = ?
            ORDER BY appointment_date, appointment_time
        """;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id"));
                a.setUserId(rs.getInt("user_id"));
                a.setTitle(rs.getString("title"));
                a.setDoctorName(rs.getString("doctor_name"));
                a.setHospitalName(rs.getString("hospital_name"));
                a.setAppointmentDate(rs.getDate("appointment_date").toLocalDate());
                a.setAppointmentTime(rs.getTime("appointment_time").toLocalTime());
                a.setNotes(rs.getString("notes"));
                a.setStatus(rs.getString("status"));
                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
