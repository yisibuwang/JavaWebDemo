package top.buwang.demo.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import top.buwang.demo.dao.merchantDao;
import top.buwang.demo.vo.merchant;

@WebServlet("/index")                               //前台用接口
public class MerchantController extends HttpServlet {
    merchantDao merchantDao = new merchantDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {       //查询所有商户信息
        response.setContentType("application/json; charset=UTF-8");

        String action = request.getParameter("action");
        String list = null;
        if (Objects.equals(action, "all")) {
            List<merchant> merchants = merchantDao.getAllMerchant();
            list = JSON.toJSONString(merchants);
        }
        else if (Objects.equals(action, "get")) {
            List<merchant> allMerchants = merchantDao.getAllMerchant();
            // 过滤状态为0的商家
            List<merchant> activeMerchants = new ArrayList<>();
            for (merchant m : allMerchants) {
                if (m.getStatus() != 0) {  // 只保留状态不为0的商家
                    activeMerchants.add(m);
                }
            }
            list = JSON.toJSONString(activeMerchants);
        }
        else{
            list = "{\"message\": \"无效的操作\"}";
        }
        PrintWriter out = response.getWriter();
        out.write(list);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 读取请求体
        InputStream inputStream = request.getInputStream();
        byte[] buffer = new byte[request.getContentLength()];
        inputStream.read(buffer);
        String requestBody = new String(buffer, "UTF-8");
        
        // 解析JSON
        JSONObject jsonObject = JSON.parseObject(requestBody);
        String mname = jsonObject.getString("mname");
        String phone = jsonObject.getString("phone");
        String address = jsonObject.getString("address");
        String score = jsonObject.getString("score");
        int status = jsonObject.getIntValue("status");
        
        // 调用DAO方法添加商家
        boolean success = merchantDao.addMerchant(mname, phone, address, null, score, status);
        
        // 返回结果
        JSONObject responseObject = new JSONObject();
        responseObject.put("success", success);
        responseObject.put("message", success ? "商家添加成功" : "商家添加失败");
        response.getWriter().write(responseObject.toJSONString());
    }
    
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        // 读取请求体
        InputStream inputStream = request.getInputStream();
        byte[] buffer = new byte[request.getContentLength()];
        inputStream.read(buffer);
        String requestBody = new String(buffer, "UTF-8");
        
        // 解析JSON
        JSONObject jsonObject = JSON.parseObject(requestBody);
        int mid = jsonObject.getIntValue("mid");
        String mname = jsonObject.getString("mname");
        String phone = jsonObject.getString("phone");
        String address = jsonObject.getString("address");
        String score = jsonObject.getString("score");
        int status = jsonObject.getIntValue("status");
        
        // 调用DAO方法更新商家
        boolean success = merchantDao.updateMerchant(mid, mname, phone, address, null, score, status);
        
        // 返回结果
        JSONObject responseObject = new JSONObject();
        responseObject.put("success", success);
        responseObject.put("message", success ? "商家更新成功" : "商家更新失败");
        response.getWriter().write(responseObject.toJSONString());
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        // 获取商家ID
        String midStr = request.getParameter("mid");
        int mid = Integer.parseInt(midStr);
        
        // 调用DAO方法删除商家
        boolean success = merchantDao.deleteMerchant(mid);
        
        // 返回结果
        JSONObject responseObject = new JSONObject();
        responseObject.put("success", success);
        responseObject.put("message", success ? "商家删除成功" : "商家删除失败");
        response.getWriter().write(responseObject.toJSONString());
    }
}
