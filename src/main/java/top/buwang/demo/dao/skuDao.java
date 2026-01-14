package top.buwang.demo.dao;

import top.buwang.demo.util.DB;
import top.buwang.demo.vo.sku;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class skuDao {
    DB db = new DB();

    public List<sku> getAllSku(){
        List<sku> skuList = new ArrayList<sku>();
        Connection conn = null;
        try {
            conn = db.getConnection();
            String get_sku = "select * from sku";
            ResultSet rs = db.executeQuery(conn, get_sku);
            while(rs.next()) {
                sku s = new sku();
                s.setSkuid(rs.getInt("skuid"));
                s.setProductid(rs.getInt("productid"));
                s.setDescription(rs.getString("description"));
                s.setChange(rs.getInt("change"));
                s.setInventory(rs.getInt("inventory"));
                skuList.add(s);
            }
        }
        catch (SQLException | RuntimeException e) {
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn);
        }
        return skuList;
    }

    public boolean addSku(int productid, String description, int change, int inventory) {
        Connection conn = null;
        try{
            conn = db.getConnection();
            String add_sku = "insert into sku(productid,description,change,inventory) values(?,?,?,?)";
            int row = db.executeUpdate(conn, add_sku, new Object[]{productid,description,change,inventory});
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

    public boolean updateSku(int skuid, int productid, String description, int change, int inventory) {
        Connection conn = null;
        try{
            conn = db.getConnection();
            String update_sku = "update sku set productid = ?,description = ?,change = ?,inventory = ? where skuid = ?";
            int row = db.executeUpdate(conn, update_sku, new Object[]{productid,description,change,inventory,skuid});
            return row > 0;
        }
        catch (RuntimeException e)
        {
            throw new RuntimeException(e);
        }
    }

    public boolean deleteSku(int skuid) {
        Connection conn = null;
        try{
            conn = db.getConnection();
            String delete_sku = "delete from sku where skuid = ?";
            int row = db.executeUpdate(conn, delete_sku, new Object[]{skuid});
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
