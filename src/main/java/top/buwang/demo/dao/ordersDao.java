package top.buwang.demo.dao;

import top.buwang.demo.vo.orders;
import top.buwang.demo.util.DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class ordersDao {
    DB db = new DB();
    public List<orders> getAllOrders(){
        List<orders> ordersList = new ArrayList<orders>();
        Connection conn = null;
        try {
            conn = db.getConnection();
            String get_orders = "select * from orders";
            ResultSet rs = db.executeQuery(conn, get_orders);
            while(rs.next()) {
                orders o = new orders();
                o.setOrdersid(rs.getInt("ordersid"));
                o.setCartid(rs.getInt("cartid"));
                ordersList.add(o);
            }
        }
        catch (SQLException | RuntimeException e) {
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn);
        }
        return ordersList;
    }

    public boolean addOrders(int cartid) {
        Connection conn = null;
        try{
            conn = db.getConnection();
            String add_orders = "insert into orders(cartid) values(?)";
            int row = db.executeUpdate(conn, add_orders, new Object[]{cartid});
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

    public boolean updateOrders(int ordersid, int cartid) {
        Connection conn = null;
        try{
            conn = db.getConnection();
            String update_orders = "update orders set cartid = ? where ordersid = ?";
            int row = db.executeUpdate(conn, update_orders, new Object[]{cartid, ordersid});
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
    public boolean deleteOrders(int ordersid) {
        Connection conn = null;
        try{
            conn = db.getConnection();
            String delete_orders = "delete from orders where ordersid = ?";
            int row = db.executeUpdate(conn, delete_orders, new Object[]{ordersid});
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