package com.example.actions;

import com.opensymphony.xwork2.ActionSupport;
import java.util.HashMap;
import java.util.Map;

public class HelloAction extends ActionSupport {
    // 对应 JSP 中的 <s:property value="message" />
    public String message;
    
    // 对应 JSP 中的 dataMap.status/dataMap.message
    public Map<String, Object> dataMap = new HashMap<>();

    // Struts2 默认执行的方法
    @Override
    public String execute() {
    	 System.out.println("=== Action 被调用 ==="); // 控制台输出
        this.message = "测试消息";
        dataMap.put("status", 999);
        dataMap.put("message", "测试成功");
        return SUCCESS;
    }
    //--- Getter 必须提供（Struts2 通过反射获取数据） ---//
    public String getMessage() {
        return message;
    }

    public Map<String, Object> getDataMap() {
        return dataMap;
    }
}