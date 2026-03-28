package com.garbhsakhi.dao;

import com.garbhsakhi.model.LabReport;
import java.sql.*;
import java.util.*;

public class LabReportDAO {

    private Connection conn;

    public LabReportDAO(Connection conn) {
        this.conn = conn;
    }

    // ADD
    public void addReport(LabReport report) throws Exception {
        String sql = "INSERT INTO lab_reports (user_id, title, file_path) VALUES (?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, report.getUserId());
        ps.setString(2, report.getTitle());
        ps.setString(3, report.getFilePath());
        ps.executeUpdate();
    }

    // GET ALL
    public List<LabReport> getReportsByUser(int userId) throws Exception {
        List<LabReport> list = new ArrayList<>();
        String sql = "SELECT * FROM lab_reports WHERE user_id=? ORDER BY upload_date DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            LabReport r = new LabReport();
            r.setId(rs.getInt("id"));
            r.setUserId(rs.getInt("user_id"));
            r.setTitle(rs.getString("title"));
            r.setFilePath(rs.getString("file_path"));
            r.setUploadDate(rs.getTimestamp("upload_date"));
            list.add(r);
        }
        return list;
    }

    // DELETE
    public void deleteReport(int id) throws Exception {
        String sql = "DELETE FROM lab_reports WHERE id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();
    }
}
