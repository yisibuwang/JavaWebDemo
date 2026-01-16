package top.buwang.demo.dao;

import top.buwang.demo.vo.Product;
import top.buwang.demo.util.DB;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class ProductDao {
    DB db = new DB();
    public List<Product> getAllProduct(){
        List<Product> productList = new ArrayList<Product>();
        Connection conn = null;
        try {
            conn = db.getConnection();
            String get_product = "select * from product";
            ResultSet rs = db.executeQuery(conn, get_product);
            while(rs.next()) {
                Product p = new Product();
                p.setProductid(rs.getInt("productid"));
                p.setProductname(rs.getString("productname"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getBigDecimal("price"));  // 使用getBigDecimal
                p.setPicture(rs.getBytes("picture"));
                p.setProductstatus(rs.getInt("productstatus"));
                p.setMid(rs.getInt("mid"));
                productList.add(p);
            }
        }
        catch (SQLException | RuntimeException e) {
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn);
        }
        return productList;
    }


    public boolean addProduct(String productname, String description, BigDecimal price, byte[] picture, int productstatus, int mid) {
        Connection conn = null;
        try{
            conn = db.getConnection();
            String add_product = "insert into product(productname,description,price,picture,productstatus,mid) values(?,?,?,?,?,?)";
            int row = db.executeUpdate(conn, add_product, new Object[]{productname,description,price,picture,productstatus,mid});
            return row > 0;
        }
        catch (RuntimeException e)
        {
            throw new RuntimeException(e);
        }
    }

    public boolean updateProduct(int productid, String productname, String description, BigDecimal price, byte[] picture, int productstatus, int mid) {
        Connection conn = null;
        try{
            conn = db.getConnection();
            String update_product = "update product set productname = ?,description = ?,price = ?,picture = ?,productstatus = ?,mid = ? where productid = ?";
            int row = db.executeUpdate(conn, update_product, new Object[]{productname,description,price,picture,productstatus,mid,productid});
            return row > 0;
        }
        catch (RuntimeException e)
        {
            throw new RuntimeException(e);
        }
    }

    public boolean deleteProduct(int productid) {
        Connection conn = null;
        try{
            conn = db.getConnection();
            String delete_product = "delete from product where productid = ?";
            int row = db.executeUpdate(conn, delete_product, new Object[]{productid});
            return row > 0;
        }
        catch (RuntimeException e)
        {
            throw new RuntimeException(e);
        }
    }

    public List<Product> searchProduct(String productname){
        List<Product> productList = new ArrayList<Product>();
        Connection conn = null;
        try {
            conn = db.getConnection();
            String get_product = "select * from product where productname like ?";
            // 需要在 executeQuery 中传递参数
            ResultSet rs = db.executeQuery(conn, get_product, new Object[] {"%" + productname + "%"});
            while(rs.next()) {
                Product p = new Product();
                p.setProductid(rs.getInt("productid"));
                p.setProductname(rs.getString("productname"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getBigDecimal("price"));  // 使用getBigDecimal
                p.setPicture(rs.getBytes("picture"));
                p.setProductstatus(rs.getInt("productstatus"));
                p.setMid(rs.getInt("mid"));
                productList.add(p);
            }
        }
        catch (SQLException | RuntimeException e) {
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn);
        }
        return productList;
    }

    public List<Product> searchProductid(int product){
        List<Product> productList = new ArrayList<Product>();
        Connection conn = null;
        try {
            conn = db.getConnection();
            String get_product = "select * from product where mid like ?";
            // 需要在 executeQuery 中传递参数
            ResultSet rs = db.executeQuery(conn, get_product, new Object[] {"%" + product + "%"});
            while(rs.next()) {
                Product p = new Product();
                p.setProductid(rs.getInt("productid"));
                p.setProductname(rs.getString("productname"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getBigDecimal("price"));  // 使用getBigDecimal
                p.setPicture(rs.getBytes("picture"));
                p.setProductstatus(rs.getInt("productstatus"));
                p.setMid(rs.getInt("mid"));
                productList.add(p);
            }
        }
        catch (SQLException | RuntimeException e) {
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn);
        }
        return productList;
    }
}