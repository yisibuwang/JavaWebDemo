package top.buwang.demo.dao;

import top.buwang.demo.vo.Type;
import top.buwang.demo.util.DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class typeDao {      //依旧操作数据的类
    DB db = new DB();
    public List<Type> getAllType(){             //获取所有商品分类表信息
        List<Type> typeList = new ArrayList<Type>();
        Connection conn = null;
        try {
            conn = db.getConnection();
            String get_type = "select * from type";  // 已经是小写
            ResultSet rs = db.executeQuery(conn, get_type);
            while(rs.next()) {
                Type t = new Type();
                t.setTypeid(rs.getInt("typeid"));
                t.setTypename(rs.getString("typename"));
                t.setMid(rs.getInt("mid"));
                typeList.add(t);
            }
        }
        catch (SQLException | RuntimeException e) {
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn);         //关闭数据库
        }
        return typeList;
    }

    public boolean addType(String typename, int mid) {          //添加商品分类
        Connection conn = null;
        try{
            conn = db.getConnection();
            String add_type = "insert into type(typename,mid) values(?,?)";  // 已经是小写
            int row = db.executeUpdate(conn, add_type, new Object[]{typename,mid});
            return row > 0;
        }
        catch (RuntimeException e)      //异常向上抛
            {
            throw new RuntimeException(e);
        }
        finally {
            db.closeResource(conn);
        }
    }

    public boolean updateType(int typeid, String typename, int mid) {       //更新商品分类
        Connection conn = null;
        try{
            conn = db.getConnection();
            String update_type = "update type set typename = ?,mid = ? where typeid = ?";  // 已经是小写
            int row = db.executeUpdate(conn, update_type, new Object[]{typename,mid,typeid});
            return row > 0;
        }
        catch (RuntimeException e)
        {
            throw new RuntimeException(e);
        }
        finally {
            db.closeResource(conn);
        }
    }

    public boolean deleteType(int typeid) {         //删除商品分类
        Connection conn = null;
        try{
            conn = db.getConnection();
            String delete_type = "delete from type where typeid = ?";  // 已经是小写
            int row = db.executeUpdate(conn, delete_type, new Object[]{typeid});
            return row > 0;
        }
        catch (RuntimeException e)
        {
            throw new RuntimeException(e);
        }
        finally {
            db.closeResource(conn);
        }
    }
}