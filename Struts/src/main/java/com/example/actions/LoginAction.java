package com.example.actions;


import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport {
    private String username;
    private String password;

    public String execute() {
        LoginBean loginBean = new LoginBean();
        if (loginBean.validate(username, password)) {
            return "success";
        } else {
            addActionError("Invalid username or password!");
            return "error";
        }
    }

    // Getters and Setters
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}