package com.garbhsakhi.model;

import java.time.LocalDate;
import java.time.LocalTime;

public class Appointment {

    private int id;
    private int userId;
    private String title;
    private String doctorName;
    private String hospitalName;
    private LocalDate appointmentDate;
    private LocalTime appointmentTime;
    private String notes;
    private String status;

    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getTitle() { return title; }
    public String getDoctorName() { return doctorName; }
    public String getHospitalName() { return hospitalName; }
    public LocalDate getAppointmentDate() { return appointmentDate; }
    public LocalTime getAppointmentTime() { return appointmentTime; }
    public String getNotes() { return notes; }
    public String getStatus() { return status; }

    public void setId(int id) { this.id = id; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setTitle(String title) { this.title = title; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }
    public void setHospitalName(String hospitalName) { this.hospitalName = hospitalName; }
    public void setAppointmentDate(LocalDate appointmentDate) { this.appointmentDate = appointmentDate; }
    public void setAppointmentTime(LocalTime appointmentTime) { this.appointmentTime = appointmentTime; }
    public void setNotes(String notes) { this.notes = notes; }
    public void setStatus(String status) { this.status = status; }
}
