package com.garbhsakhi.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {

    private static final String URL =
            "jdbc:postgresql://localhost:5432/garbh_sakhi";

    private static final String USER = "garbh_sakhi_user";
    private static final String PASSWORD = "avinash";

    public static Connection getConnection() {
        try {
            Class.forName("org.postgresql.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("DB connection failed", e);
        }
    }
}

