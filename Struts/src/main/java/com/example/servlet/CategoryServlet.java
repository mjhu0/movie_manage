package com.example.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CategoryServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/login_db?serverTimezone=Asia/Shanghai&useSSL=false&characterEncoding=utf8";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError("MySQL驱动加载失败: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String categoryName = request.getParameter("name");

        if (categoryName == null || categoryName.trim().isEmpty()) {
            request.setAttribute("errorMessage", "类别名称不能为空！");
            request.getRequestDispatcher("/main.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO category (name) VALUES (?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, categoryName);
            pstmt.executeUpdate();
            response.sendRedirect("success.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "添加类别失败: " + e.getMessage());
            request.getRequestDispatcher("/main.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("query".equals(action)) {
            List<Category> categories = new ArrayList<>();
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT id, name FROM category";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    Category category = new Category();
                    category.setId(rs.getInt("id"));
                    category.setName(rs.getString("name"));
                    categories.add(category);
                }
                request.setAttribute("categories", categories);
                System.out.println("查询类别成功，找到 " + categories.size() + " 条记录");
                if (categories.isEmpty()) {
                    request.setAttribute("queryMessage", "查询成功，但类别列表为空");
                } else {
                    request.setAttribute("queryMessage", "查询成功，找到 " + categories.size() + " 条记录");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("查询类别失败: " + e.getMessage());
                request.setAttribute("errorMessage", "查询类别失败: " + e.getMessage());
            }
        }

        request.getRequestDispatcher("/main.jsp").forward(request, response);
    }

    // 内部类用于存储类别数据
    public static class Category {
        private int id;
        private String name;

        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
    }
}