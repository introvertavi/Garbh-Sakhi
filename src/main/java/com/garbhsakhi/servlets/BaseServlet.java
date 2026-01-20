package com.garbhsakhi.servlets;

import jakarta.servlet.http.HttpServlet;

import com.garbhsakhi.dao.DatabaseConnection;
import java.sql.Connection;
import java.sql.SQLException;

public abstract class BaseServlet extends HttpServlet {
    protected Connection getConnection() throws SQLException {
        return DatabaseConnection.getConnection();
    }
}
