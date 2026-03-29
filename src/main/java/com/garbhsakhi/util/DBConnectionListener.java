package com.garbhsakhi.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Connection;
import java.sql.DriverManager;

@WebListener
public class DBConnectionListener implements ServletContextListener {

    private Connection conn;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            Class.forName("org.postgresql.Driver");

            conn = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/garbh_sakhi",
                "garbh_sakhi_user",
                "avinash"
            );

            sce.getServletContext().setAttribute("DBConnection", conn);

            System.out.println("✅ DB Connected Successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
