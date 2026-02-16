package com.garbhsakhi.dao;

import com.garbhsakhi.model.Appointment;
import java.sql.*;
import java.util.*;
import java.time.*;
import java.sql.Date;

public class AppointmentDAO {

    public static void addAppointment(Appointment appt) {

        String sql = """
            INSERT INTO appointments (
                user_id,title,doctor_name,hospital_name,
                appointment_date,appointment_time,notes,status
            )
            VALUES (?,?,?,?,?,?,?,'UPCOMING')
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

        } catch(Exception e){ e.printStackTrace(); }
    }

    public static List<Appointment> getAppointmentsByUser(int userId){

        List<Appointment> list=new ArrayList<>();

        String sql="""
            SELECT * FROM appointments
            WHERE user_id=?
            ORDER BY appointment_date,appointment_time
        """;

        try(Connection conn=DatabaseConnection.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql)){

            ps.setInt(1,userId);
            ResultSet rs=ps.executeQuery();

            while(rs.next()){
                Appointment a=new Appointment();
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

        }catch(Exception e){e.printStackTrace();}

        return list;
    }

    public static void deleteAppointment(int id,int userId){

        String sql="DELETE FROM appointments WHERE id=? AND user_id=?";

        try(Connection conn=DatabaseConnection.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql)){

            ps.setInt(1,id);
            ps.setInt(2,userId);
            ps.executeUpdate();

        }catch(Exception e){e.printStackTrace();}
    }

    public static Appointment getSingleAppointment(int id){

    String sql = "SELECT * FROM appointments WHERE id=?";

    try(Connection conn = DatabaseConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)){

        ps.setInt(1,id);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){

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

            return a;
        }

    }catch(Exception e){
        e.printStackTrace();
    }

    return null;
}



    public static void updateAppointment(Appointment a){

        String sql="""
            UPDATE appointments SET
            title=?,doctor_name=?,hospital_name=?,
            appointment_date=?,appointment_time=?,notes=?
            WHERE id=? AND user_id=?
        """;

        try(Connection conn=DatabaseConnection.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql)){

            ps.setString(1,a.getTitle());
            ps.setString(2,a.getDoctorName());
            ps.setString(3,a.getHospitalName());
            ps.setDate(4,Date.valueOf(a.getAppointmentDate()));
            ps.setTime(5,Time.valueOf(a.getAppointmentTime()));
            ps.setString(6,a.getNotes());
            ps.setInt(7,a.getId());
            ps.setInt(8,a.getUserId());

            ps.executeUpdate();

        }catch(Exception e){e.printStackTrace();}
    }
}
