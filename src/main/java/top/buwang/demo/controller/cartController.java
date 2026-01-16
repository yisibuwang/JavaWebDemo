package top.buwang.demo.controller;

import com.alibaba.fastjson2.JSONObject;
import top.buwang.demo.vo.cart;
import top.buwang.demo.dao.cartDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.alibaba.fastjson2.JSON;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.Objects;

@WebServlet("/cart")
public class cartController extends HttpServlet{
    cartDao cartDao = new cartDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        String cartList = null;
        List<cart> cart = cartDao.getAllCart();
        response.getWriter().write(JSON.toJSONString(cart));
        PrintWriter out = response.getWriter();
        out.write(cartList);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 读取请求体
        InputStream inputStream = request.getInputStream();
        byte[] buffer = new byte[request.getContentLength()];
        inputStream.read(buffer);
        String requestBody = new String(buffer, "UTF-8");

//        // 解析JSON
//        JSONObject jsonObject = JSON.parseObject(requestBody);
//        String cartid = jsonObject.getIntValue("cartid");
//        String skuid = jsonObject.getIntValue("skuid");
//        String productid = jsonObject.getIntValue("productid");
//        String quantity = jsonObject.getIntValue("quantity");
//        // 调用DAO方法添加商家
//        boolean success = cartDao.addCart("skuid","productid","quantity")
//
//        // 返回结果
//        JSONObject responseObject = new JSONObject();
//        responseObject.put("success", success);
//        responseObject.put("message", success ? "商家添加成功" : "商家添加失败");
//        response.getWriter().write(responseObject.toJSONString());
    }
}
