package top.buwang.demo.dao;

import top.buwang.demo.vo.cart;
import top.buwang.demo.util.DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class cartDao {
    DB db = new DB();
    public List<cart> getAllCart(){
        List<cart> cartList = new ArrayList<cart>();
        Connection conn = null;
        try {
            conn = db.getConnection();
            String get_cart = "select * from cart";
            ResultSet rs = db.executeQuery(conn, get_cart);
            while(rs.next()) {
                cart c = new cart();
                c.setCartid(rs.getInt("cartid"));
                c.setSkuid(rs.getInt("skuid"));
                c.setProductid(rs.getInt("productid"));
                c.setQuantity(rs.getInt("quantity"));
                cartList.add(c);
            }
        }
        catch (SQLException | RuntimeException e) {
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn);
        }
        return cartList;
    }

    public boolean addCart(int skuid, int productid, int quantity) {
        Connection conn = null;
        try{
            conn = db.getConnection();
            String add_cart = "insert into cart(skuid,productid,quantity) values(?,?,?)";
            int row = db.executeUpdate(conn, add_cart, new Object[]{skuid,productid,quantity});
            return row > 0;
        }
        catch (RuntimeException e)
        {
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn);
        }
    }

    public boolean updateCart(int cartid, int skuid, int productid, int quantity) {
        Connection conn = null;
        try{
            conn = db.getConnection();
            String update_cart = "update cart set skuid = ?,productid = ?,quantity = ? where cartid = ?";
            int row = db.executeUpdate(conn, update_cart, new Object[]{skuid,productid,quantity,cartid});
            return row > 0;

        }
        catch (RuntimeException e)
        {
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn);
        }
    }

    public boolean deleteCart(int cartid) {
        Connection conn = null;
        try{
            conn = db.getConnection();
            String delete_cart = "delete from cart where cartid = ?";
            int row = db.executeUpdate(conn, delete_cart, new Object[]{cartid});
            return row > 0;
        }
        catch (RuntimeException e)
        {
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn);
        }
    }
}