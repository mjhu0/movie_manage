package com.example.actions;

import java.sql.*;

public class LoginBean {
    // 静态代码块显式加载驱动（在类加载时执行）
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC Driver Registered!"); // 调试日志
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError("加载数据库驱动失败: " + e.getMessage());
        }
    }

    // 修改时区为上海
    private static final String DB_URL = "jdbc:mysql://localhost:3306/login_db?serverTimezone=Asia/Shanghai&useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456";

    public boolean validate(String username, String password) {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.err.println("数据库连接异常: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}