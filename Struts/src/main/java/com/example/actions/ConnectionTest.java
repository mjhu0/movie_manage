package com.example.actions;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionTest {
    private static final String URL = "jdbc:mysql://localhost:3306/login_db?serverTimezone=Asia/Shanghai";
    private static final String USER = "root";
    private static final String PASSWORD = "123456";

    public static void main(String[] args) {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            System.out.println("连接成功！");
        } catch (SQLException e) {
            System.err.println("连接失败: " + e.getMessage());
        }
    }
}