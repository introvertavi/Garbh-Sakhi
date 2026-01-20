package com.garbhsakhi.model;

public class User {

    private int id;
    private String name;              // original signup name
    private String fullName;
    private String email;
    private int age;
    private String phone;
    private String dueDate;

    private String doctorName;
    private String hospitalName;
    private String complications;

    private String avatarPath;
    private int profileComplete;      // 0 or 1

    // ====== GETTERS & SETTERS ======

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getDueDate() { return dueDate; }
    public void setDueDate(String dueDate) { this.dueDate = dueDate; }

    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }

    public String getHospitalName() { return hospitalName; }
    public void setHospitalName(String hospitalName) { this.hospitalName = hospitalName; }

    public String getComplications() { return complications; }
    public void setComplications(String complications) { this.complications = complications; }

    public String getAvatarPath() { return avatarPath; }
    public void setAvatarPath(String avatarPath) { this.avatarPath = avatarPath; }

    public int getProfileComplete() { return profileComplete; }
    public void setProfileComplete(int profileComplete) { this.profileComplete = profileComplete; }
}