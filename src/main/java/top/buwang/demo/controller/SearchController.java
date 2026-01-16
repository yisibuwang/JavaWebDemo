package top.buwang.demo.controller;

import top.buwang.demo.vo.merchant;
import top.buwang.demo.dao.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.alibaba.fastjson2.JSON;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Objects;

@WebServlet("/search")
public class SearchController extends HttpServlet{
    ordersDao ordersDao = new ordersDao();
    merchantDao merchantDao = new merchantDao();
    ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword");
        String list = null;
        if (Objects.equals(action, "merchant")) {
            List<merchant> merchants = merchantDao.searchMerchant(keyword);
            list = JSON.toJSONString(merchants);
        }
        else if (Objects.equals(action, "product")) {
            List products = productDao.searchProduct(keyword);
            list = JSON.toJSONString(products);
        }
        else if (Objects.equals(action, "order")) {
            List products = ordersDao.searchorders(Integer.parseInt(keyword));
            list = JSON.toJSONString(products);
        }
        PrintWriter out = response.getWriter();
        out.write(list);
    }
}
