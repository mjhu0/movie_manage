package com.example.actions;

import java.sql.*;

public class LoginBean {
    // 仅保留传统驱动加载方式
    static {
        try {
            // 关键点：仅使用 Class.forName 加载驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError("MySQL驱动加载失败: " + e.getMessage());
        }
    }

    // 保留时区参数（重要！）
    private static final String DB_URL = "jdbc:mysql://localhost:3306/login_db?serverTimezone=Asia/Shanghai&useSSL=false";
    
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456";

    public boolean validate(String username, String password) {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            return pstmt.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}