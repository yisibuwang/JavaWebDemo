package top.buwang.demo.controller;

import top.buwang.demo.vo.merchant;
import top.buwang.demo.dao.merchantDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.alibaba.fastjson2.JSON;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/merchant")
public class MerchantController extends HttpServlet {
    merchantDao merchantDao = new merchantDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        List<merchant> merchants = merchantDao.getAllMerchant();
        response.getWriter().write(JSON.toJSONString(merchants));
    }
}
