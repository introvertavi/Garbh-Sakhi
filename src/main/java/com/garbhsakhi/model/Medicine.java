package com.garbhsakhi.model;

import java.sql.Date;

public class Medicine {

    private int id;
    private int userId;

    private String medicineName;
    private String dosage;
    private String frequency;
    private String timeOfDay;

    private Date startDate;
    private Date endDate;

    private String notes;
    private String status;

    // ===== Getters & Setters =====

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getMedicineName() { return medicineName; }
    public void setMedicineName(String medicineName) { this.medicineName = medicineName; }

    public String getDosage() { return dosage; }
    public void setDosage(String dosage) { this.dosage = dosage; }

    public String getFrequency() { return frequency; }
    public void setFrequency(String frequency) { this.frequency = frequency; }

    public String getTimeOfDay() { return timeOfDay; }
    public void setTimeOfDay(String timeOfDay) { this.timeOfDay = timeOfDay; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}