package com.garbhsakhi.dao;

import com.garbhsakhi.model.Notification;
import java.sql.*;
import java.util.*;

public class NotificationDAO {

    public List<Notification> getUserNotifications(int userId){

        List<Notification> list = new ArrayList<>();

        String sql = "SELECT * FROM notifications WHERE user_id=? ORDER BY created_at DESC";

        try(Connection con = DatabaseConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setInt(1,userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                Notification n = new Notification();

                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("title"));
                n.setMessage(rs.getString("message"));
                n.setType(rs.getString("type"));
                n.setRead(rs.getBoolean("is_read"));
                n.setCreatedAt(rs.getTimestamp("created_at"));

                list.add(n);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
}