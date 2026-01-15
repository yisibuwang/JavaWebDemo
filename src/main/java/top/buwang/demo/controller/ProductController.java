package top.buwang.demo.controller;

import top.buwang.demo.vo.Product;
import top.buwang.demo.dao.ProductDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.alibaba.fastjson2.JSON;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/product")
public class ProductController extends HttpServlet {
    ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        List<Product> products = productDao.getAllProduct();
        response.getWriter().write(JSON.toJSONString(products));
    }
}
