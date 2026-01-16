package top.buwang.demo.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;
import java.util.Objects;
import java.util.ArrayList;


import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import top.buwang.demo.dao.ProductDao;
import top.buwang.demo.vo.Product;

@WebServlet("/product")
public class ProductController extends HttpServlet {
    ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String list = null;
        if(Objects.equals(action, "all")) {
            response.setContentType("application/json; charset=UTF-8");
            List<Product> allProducts = productDao.getAllProduct();
            list=JSON.toJSONString(allProducts);
        }
        else if (Objects.equals(action, "get")) {
            int mid = Integer.parseInt(request.getParameter("mid"));
            List<Product> products = productDao.searchProductid(mid);
            // 过滤掉状态为0的商品
            List<Product> activeProducts = new ArrayList<>();
            for (Product product : products) {
                if (product.getProductstatus() != 0) {
                    activeProducts.add(product);
                }
            }
            list=JSON.toJSONString(activeProducts);
            list=JSON.toJSONString(activeProducts);
        }
        else
            response.getWriter().write("{\"message\":\"无效的操作\"}");
        PrintWriter out = response.getWriter();
        out.write(list);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        // 读取请求体
        InputStream inputStream = request.getInputStream();
        byte[] buffer = new byte[request.getContentLength()];
        inputStream.read(buffer);
        String requestBody = new String(buffer, "UTF-8");
        
        // 解析JSON
        JSONObject jsonObject = JSON.parseObject(requestBody);
        String productname = jsonObject.getString("productname");
        String description = jsonObject.getString("description");
        BigDecimal price = jsonObject.getBigDecimal("price");
        int productstatus = jsonObject.getIntValue("productstatus");
        int mid = jsonObject.getIntValue("mid");
        
        // 调用DAO方法添加商品
        boolean success = productDao.addProduct(productname, description, price, null, productstatus, mid);
        
        // 返回结果
        JSONObject responseObject = new JSONObject();
        responseObject.put("success", success);
        responseObject.put("message", success ? "商品添加成功" : "商品添加失败");
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
        int productid = jsonObject.getIntValue("productid");
        String productname = jsonObject.getString("productname");
        String description = jsonObject.getString("description");
        BigDecimal price = jsonObject.getBigDecimal("price");
        int productstatus = jsonObject.getIntValue("productstatus");
        int mid = jsonObject.getIntValue("mid");
        
        // 调用DAO方法更新商品
        boolean success = productDao.updateProduct(productid, productname, description, price, null, productstatus, mid);
        
        // 返回结果
        JSONObject responseObject = new JSONObject();
        responseObject.put("success", success);
        responseObject.put("message", success ? "商品更新成功" : "商品更新失败");
        response.getWriter().write(responseObject.toJSONString());
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        // 获取商品ID
        String productidStr = request.getParameter("productid");
        int productid = Integer.parseInt(productidStr);
        
        // 调用DAO方法删除商品
        boolean success = productDao.deleteProduct(productid);
        
        // 返回结果
        JSONObject responseObject = new JSONObject();
        responseObject.put("success", success);
        responseObject.put("message", success ? "商品删除成功" : "商品删除失败");
        response.getWriter().write(responseObject.toJSONString());
    }
}
