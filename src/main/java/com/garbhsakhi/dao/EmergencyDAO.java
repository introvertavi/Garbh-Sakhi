package com.garbhsakhi.dao;

import com.garbhsakhi.model.EmergencyContact;
import java.sql.*;
import java.util.*;

public class EmergencyDAO {

    private Connection conn;

    public EmergencyDAO(Connection conn) {
        this.conn = conn;
    }

    // GET CONTACTS
    public List<EmergencyContact> getContactsByUser(int userId) {
        List<EmergencyContact> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM emergency_contacts WHERE user_id=? ORDER BY id DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                EmergencyContact c = new EmergencyContact();
                c.setId(rs.getInt("id"));
                c.setUserId(rs.getInt("user_id"));
                c.setLabel(rs.getString("label"));
                c.setName(rs.getString("name"));
                c.setPhone(rs.getString("phone"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ADD CONTACT
    public boolean addContact(EmergencyContact c) {
        try {
            String sql = "INSERT INTO emergency_contacts(user_id,label,name,phone) VALUES(?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, c.getUserId());
            ps.setString(2, c.getLabel());
            ps.setString(3, c.getName());
            ps.setString(4, c.getPhone());

            int rows = ps.executeUpdate();
            System.out.println("ROWS INSERTED: " + rows);

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // DELETE CONTACT (FIXED 🔥)
    public boolean deleteContact(int id, int userId) {
        try {
            String sql = "DELETE FROM emergency_contacts WHERE id=? AND user_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, id);
            ps.setInt(2, userId);

            int rows = ps.executeUpdate();
            System.out.println("ROWS DELETED: " + rows);

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}