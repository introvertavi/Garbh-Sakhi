package com.garbhsakhi.dao;

import com.garbhsakhi.model.Medicine;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MedicineDAO {

    // ===== ADD MEDICINE =====
    public boolean addMedicine(Medicine med) {

        String sql = "INSERT INTO medicines " +
                "(user_id, medicine_name, dosage, frequency, time_of_day, start_date, end_date, notes, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, med.getUserId());
            ps.setString(2, med.getMedicineName());
            ps.setString(3, med.getDosage());
            ps.setString(4, med.getFrequency());
            ps.setString(5, med.getTimeOfDay());
            ps.setDate(6, med.getStartDate());
            ps.setDate(7, med.getEndDate());
            ps.setString(8, med.getNotes());
            ps.setString(9, "ACTIVE");

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ===== GET USER MEDICINES =====
    public List<Medicine> getMedicinesByUser(int userId) {

        List<Medicine> list = new ArrayList<>();

        String sql = "SELECT * FROM medicines WHERE user_id=? ORDER BY created_at DESC";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Medicine m = new Medicine();

                m.setId(rs.getInt("id"));
                m.setUserId(rs.getInt("user_id"));
                m.setMedicineName(rs.getString("medicine_name"));
                m.setDosage(rs.getString("dosage"));
                m.setFrequency(rs.getString("frequency"));
                m.setTimeOfDay(rs.getString("time_of_day"));
                m.setStartDate(rs.getDate("start_date"));
                m.setEndDate(rs.getDate("end_date"));
                m.setNotes(rs.getString("notes"));
                m.setStatus(rs.getString("status"));

                list.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===== DELETE MEDICINE =====
    public boolean deleteMedicine(int id) {

        String sql = "DELETE FROM medicines WHERE id=?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ===== GET MEDICINE BY ID =====
    public Medicine getMedicineById(int id) {

        String sql = "SELECT * FROM medicines WHERE id=?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Medicine m = new Medicine();

                m.setId(rs.getInt("id"));
                m.setUserId(rs.getInt("user_id"));
                m.setMedicineName(rs.getString("medicine_name"));
                m.setDosage(rs.getString("dosage"));
                m.setFrequency(rs.getString("frequency"));
                m.setTimeOfDay(rs.getString("time_of_day"));
                m.setStartDate(rs.getDate("start_date"));
                m.setEndDate(rs.getDate("end_date"));
                m.setNotes(rs.getString("notes"));
                m.setStatus(rs.getString("status"));

                return m;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
// ===== UPDATE MEDICINE =====
public boolean updateMedicine(Medicine med) {

    String sql = "UPDATE medicines SET medicine_name=?, dosage=?, frequency=?, time_of_day=?, start_date=?, end_date=?, notes=? WHERE id=?";

    try (Connection con = DatabaseConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, med.getMedicineName());
        ps.setString(2, med.getDosage());
        ps.setString(3, med.getFrequency());
        ps.setString(4, med.getTimeOfDay());
        ps.setDate(5, med.getStartDate());
        ps.setDate(6, med.getEndDate());
        ps.setString(7, med.getNotes());
        ps.setInt(8, med.getId());

        return ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return false;
}
}