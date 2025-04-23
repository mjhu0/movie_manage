package com.example.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NewsServlet extends HttpServlet {
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

        String title = request.getParameter("title");
        String publishTimeStr = request.getParameter("publishTime");
        String description = request.getParameter("description");

        // 验证输入
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("newsErrorMessage", "新闻标题不能为空！");
            request.getRequestDispatcher("/main.jsp").forward(request, response);
            return;
        }
        if (publishTimeStr == null || publishTimeStr.trim().isEmpty()) {
            request.setAttribute("newsErrorMessage", "发布时间不能为空！");
            request.getRequestDispatcher("/main.jsp").forward(request, response);
            return;
        }

        // 转换发布时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        java.sql.Timestamp publishTime;
        try {
            publishTime = new java.sql.Timestamp(sdf.parse(publishTimeStr).getTime());
        } catch (ParseException e) {
            request.setAttribute("newsErrorMessage", "发布时间格式无效！");
            request.getRequestDispatcher("/main.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO news (title, publish_time, description) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setTimestamp(2, publishTime);
            pstmt.setString(3, description != null && !description.trim().isEmpty() ? description : null);
            pstmt.executeUpdate();
            request.setAttribute("newsSuccessMessage", "新闻添加成功！");
            request.getRequestDispatcher("/main.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("newsErrorMessage", "添加新闻失败: " + e.getMessage());
            request.getRequestDispatcher("/main.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.getRequestDispatcher("/main.jsp").forward(request, response);
    }
}