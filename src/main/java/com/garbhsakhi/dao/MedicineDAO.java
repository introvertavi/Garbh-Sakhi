package com.garbhsakhi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.garbhsakhi.model.Medicine;

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
        autoExpireMedicines();
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

                m.setTakenMorning(rs.getBoolean("taken_morning"));
                m.setTakenAfternoon(rs.getBoolean("taken_afternoon"));
                m.setTakenNight(rs.getBoolean("taken_night"));

                // ✅ NEW FIELD
                m.setLastTakenDate(rs.getDate("last_taken_date"));

                // ✅ DAILY RESET LOGIC
                Date today = new Date(System.currentTimeMillis());

                if (m.getLastTakenDate() == null || !m.getLastTakenDate().equals(today)) {
                    m.setTakenMorning(false);
                    m.setTakenAfternoon(false);
                    m.setTakenNight(false);
                }

                // ✅ ALWAYS ADD
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

                m.setTakenMorning(rs.getBoolean("taken_morning"));
                m.setTakenAfternoon(rs.getBoolean("taken_afternoon"));
                m.setTakenNight(rs.getBoolean("taken_night"));

                // ✅ ADD HERE ALSO
                m.setLastTakenDate(rs.getDate("last_taken_date"));

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

    // ===== TODAY MEDICINES =====
    public List<Medicine> getTodayMedicines(int userId) {

        List<Medicine> list = new ArrayList<>();

        String sql = "SELECT * FROM medicines WHERE user_id=? AND status='ACTIVE' " +
                     "AND (start_date IS NULL OR start_date <= CURRENT_DATE) " +
                     "AND (end_date IS NULL OR end_date >= CURRENT_DATE) " +
                     "ORDER BY created_at DESC";

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

                m.setTakenMorning(rs.getBoolean("taken_morning"));
                m.setTakenAfternoon(rs.getBoolean("taken_afternoon"));
                m.setTakenNight(rs.getBoolean("taken_night"));

                m.setLastTakenDate(rs.getDate("last_taken_date"));

                list.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===== MARK MEDICINE TAKEN (TOGGLE + DATE) =====
    public void markMedicineTaken(int medicineId, String timeOfDay) {

        String column = "";

        switch(timeOfDay){

            case "morning":
                column = "taken_morning";
                break;

            case "afternoon":
                column = "taken_afternoon";
                break;

            case "night":
                column = "taken_night";
                break;
        }

        String sql = "UPDATE medicines SET " + column + " = NOT " + column +
                     ", last_taken_date = CURRENT_DATE WHERE id = ?";

        try(Connection con = DatabaseConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, medicineId);
            ps.executeUpdate();

        } catch(Exception e){
            e.printStackTrace();
        }
    }

    // ===== MARK AS COMPLETED =====
    public boolean markCompleted(int id) {

        String sql = "UPDATE medicines SET status='COMPLETED' WHERE id=?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ===== STOP MEDICINE =====
    public boolean stopMedicine(int id) {

        String sql = "UPDATE medicines SET status='STOPPED' WHERE id=?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ===== AUTO EXPIRE MEDICINES =====
    public void autoExpireMedicines() {

        String sql = "UPDATE medicines SET status='COMPLETED' " +
                     "WHERE end_date < CURRENT_DATE AND status='ACTIVE'";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

public int getPendingDoseCount(int userId) {

    int count = 0;

    String sql = "SELECT * FROM medicines WHERE user_id=? AND status='ACTIVE'";

    try (Connection con = DatabaseConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        Date today = new Date(System.currentTimeMillis());

        while (rs.next()) {

            Date lastTaken = rs.getDate("last_taken_date");

            boolean takenMorning = rs.getBoolean("taken_morning");
            boolean takenAfternoon = rs.getBoolean("taken_afternoon");
            boolean takenNight = rs.getBoolean("taken_night");

            String time = rs.getString("time_of_day");

            boolean isToday = (lastTaken != null && lastTaken.equals(today));

            if (!isToday) {
                // nothing taken today
                if (time.equals("Morning")) count++;
                else if (time.equals("Afternoon")) count++;
                else if (time.equals("Night")) count++;
                else if (time.equals("3 Times")) count += 3;
            } else {
                if (time.equals("Morning") && !takenMorning) count++;
                if (time.equals("Afternoon") && !takenAfternoon) count++;
                if (time.equals("Night") && !takenNight) count++;

                if (time.equals("3 Times")) {
                    if (!takenMorning) count++;
                    if (!takenAfternoon) count++;
                    if (!takenNight) count++;
                }
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return count;
}

public int getMissedDoseCount(int id) {
	
	throw new UnsupportedOperationException("Unimplemented method 'getMissedDoseCount'");
}
}