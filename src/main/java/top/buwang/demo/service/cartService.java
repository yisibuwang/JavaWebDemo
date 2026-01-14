package top.buwang.demo.service;

import top.buwang.demo.dao.cartDao;
import top.buwang.demo.vo.cart;

import java.util.List;
public class cartService {
    cartDao cartDao = new cartDao();
    public List<cart> getAllCart(){
        return cartDao.getAllCart();
    }
    public boolean addCart(int skuid, int productid, int quantity) {
        return cartDao.addCart(skuid, productid, quantity);
    }
    public boolean updateCart(int cartid, int skuid, int productid, int quantity) {
        return cartDao.updateCart(cartid, skuid, productid, quantity);
    }
    public boolean deleteCart(int cartid) {
        return cartDao.deleteCart(cartid);
    }
}
