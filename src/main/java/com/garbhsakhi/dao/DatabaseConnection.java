package com.garbhsakhi.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {

        // 🔹 Railway environment variables
        String host = System.getenv("MYSQLHOST");
        String port = System.getenv("MYSQLPORT");
        String database = System.getenv("MYSQLDATABASE");
        String user = System.getenv("MYSQLUSER");
        String password = System.getenv("MYSQLPASSWORD");

        String url;

        // 🔹 If running locally (Railway vars not present)
        if (host == null || port == null || database == null) {
            url = "jdbc:mysql://localhost:3306/garbh_sakhi"
                + "?useSSL=false"
                + "&allowPublicKeyRetrieval=true"
                + "&serverTimezone=UTC";

            user = "garbh_sakhi";
            password = "Avinash@1080";
        } 
        // 🔹 If running on Railway
        else {
            url = "jdbc:mysql://" + host + ":" + port + "/" + database
                + "?useSSL=false"
                + "&allowPublicKeyRetrieval=true"
                + "&serverTimezone=UTC";
        }

        return DriverManager.getConnection(url, user, password);
    }
}

