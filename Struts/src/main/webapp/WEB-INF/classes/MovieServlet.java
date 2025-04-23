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

public class MovieServlet extends HttpServlet {
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

        String movieName = request.getParameter("movieName");
        String categoryIdStr = request.getParameter("categoryId");
        String description = request.getParameter("description");

        // 验证输入
        if (movieName == null || movieName.trim().isEmpty()) {
            request.setAttribute("movieErrorMessage", "影片名称不能为空！");
            doGet(request, response); // 重新加载分类
            return;
        }
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            request.setAttribute("movieErrorMessage", "请选择影片分类！");
            doGet(request, response);
            return;
        }

        int categoryId;
        try {
            categoryId = Integer.parseInt(categoryIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("movieErrorMessage", "无效的分类ID！");
            doGet(request, response);
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO movie (name, category_id, description) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, movieName);
            pstmt.setInt(2, categoryId);
            pstmt.setString(3, description != null && !description.trim().isEmpty() ? description : null);
            pstmt.executeUpdate();
            request.setAttribute("movieSuccessMessage", "影片上传成功！");
            doGet(request, response); // 重新加载分类
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("movieErrorMessage", "上传影片失败: " + e.getMessage());
            doGet(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 加载分类列表
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
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("movieErrorMessage", "加载分类失败: " + e.getMessage());
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