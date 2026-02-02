package com.garbhsakhi.model;

public class User {

    private int id;
    private String name;          // signup name
    private String fullName;      // profile full name
    private String email;
    private int age;
    private String phone;
    private String dueDate;

    private String doctorName;
    private String hospitalName;
    private String complications;

    private String avatarPath;
    private boolean profileComplete;

    // ===== GETTERS =====

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public int getAge() {
        return age;
    }

    public String getPhone() {
        return phone;
    }

    public String getDueDate() {
        return dueDate;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public String getHospitalName() {
        return hospitalName;
    }

    public String getComplications() {
        return complications;
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public boolean isProfileComplete() {
        return profileComplete;
    }

    // ===== SETTERS =====

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setDueDate(String dueDate) {
        this.dueDate = dueDate;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public void setHospitalName(String hospitalName) {
        this.hospitalName = hospitalName;
    }

    public void setComplications(String complications) {
        this.complications = complications;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }

    public void setProfileComplete(boolean profileComplete) {
        this.profileComplete = profileComplete;
    }
}
