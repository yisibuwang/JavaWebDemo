package top.buwang.demo.controller;

import top.buwang.demo.vo.orders;
import top.buwang.demo.dao.ordersDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.alibaba.fastjson2.JSON;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/order")
public class OrderController extends HttpServlet {
    ordersDao ordersDao = new ordersDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        List<orders> ordersList = ordersDao.getAllOrders();
        response.getWriter().write(JSON.toJSONString(ordersList));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        // 这里可以添加订单提交的逻辑
        // 由于我们简化了用户管理，这里直接返回成功
        response.getWriter().write(JSON.toJSONString("{\"success\": true, \"message\": \"订单提交成功\"}"));
    }
}
