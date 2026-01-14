package top.buwang.demo.service;

import top.buwang.demo.dao.ordersDao;
import top.buwang.demo.vo.orders;

import java.util.List;
public class ordersService {
    ordersDao ordersDao = new ordersDao();
    public List<orders> getAllOrders(){
        return ordersDao.getAllOrders();
    }
    public boolean addOrders(int cartid) {
        return ordersDao.addOrders(cartid);
    }
    public boolean updateOrders(int ordersid, int cartid) {
        return ordersDao.updateOrders(ordersid, cartid);
    }
    public boolean deleteOrders(int ordersid) {
        return ordersDao.deleteOrders(ordersid);
    }
}
