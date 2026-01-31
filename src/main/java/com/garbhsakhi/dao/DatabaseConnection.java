package com.garbhsakhi.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    static {
        try {
            // ✅ PostgreSQL JDBC Driver
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {

        // ✅ Render environment variables
        String host = System.getenv("DB_HOST");
        String port = System.getenv("DB_PORT");
        String database = System.getenv("DB_NAME");
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");

        // ❌ DO NOT allow localhost fallback in production
        if (host == null || port == null || database == null ||
            user == null || password == null) {
            throw new RuntimeException("Database environment variables are not set");
        }

        // ✅ PostgreSQL JDBC URL
        String url = "jdbc:postgresql://" + host + ":" + port + "/" + database;

        return DriverManager.getConnection(url, user, password);
    }
}
