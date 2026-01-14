package top.buwang.demo.dao;

import top.buwang.demo.vo.merchant;
import top.buwang.demo.util.DB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class merchantDao {          //数据用的操作类
    DB db = new DB();
    public List<merchant> getAllMerchant(){     //获取所有商户信息
        List<merchant> merchantList = new ArrayList<merchant>();        //创建空的商户列表，用于存储查询结果
        Connection conn = null;
        try {
        conn = db.getConnection();       //调用db的getConnection方法，获取数据库连接
        String sql = "select * from merchant";
        ResultSet rs = db.executeQuery(conn, sql);  //查询商户信息
            while(rs.next()) {
                merchant m = new merchant();
                m.setMid(rs.getInt("mid"));
                m.setMname(rs.getString("mname"));
                m.setPhone(rs.getInt("phone"));
                m.setAddress(rs.getString("address"));
                m.setPicture(rs.getBytes("picture"));
                m.setScore(rs.getString("score"));
                m.setStatus(rs.getInt("status"));
                merchantList.add(m);                                //将封装好的对象添加到列表中
            }
        }
        catch (SQLException | RuntimeException e) {         //DB类抛出的异常是RuntimeException，先甩锅传上去再说
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn);     //关闭连接
        }
        return merchantList;
    }

    public boolean addMerchant(String mname, int phone, String address, byte[] picture, String score, int status) {    //添加商户，不需要mid让他自己自增
        Connection conn = null;
        try {
            conn = db.getConnection();
            String insert_merchant = "insert into merchant(mname,phone,address,picture,score,status) values(?,?,?,?,?,?)";  //依旧模板
            int row = db.executeUpdate(conn, insert_merchant, new Object[]{mname, phone,address,picture, score, status});
            return row > 0;         //返回更新结果总数大于0即为成功
        }
        catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn); //关闭连接
        }
    }

    public boolean updateMerchant(int mid, String mname, int phone, String address, byte[] picture, String score, int status) {     //修改商户信息,这个得要mid
        Connection conn = null;
        try {
            conn = db.getConnection();
            String update_merchant = "update merchant set mname=?,phone=?,address=?,picture=?,score=?,status=? where mid=?";
            int row = db.executeUpdate(conn, update_merchant, new Object[]{mname, phone, address, picture ,score, status, mid});
            return row > 0;
        }
        catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn);
        }
    }

    public boolean deleteMerchant(int mid) {     //删除商户信息,只需要一个mid跟着一起删了就行
        Connection conn = null;
        try {
            conn = db.getConnection();
            String delete_merchant = "delete from merchant where mid=?";
            int row = db.executeUpdate(conn, delete_merchant, new Object[]{mid});
            return row > 0;
        }
        catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
        finally{
            db.closeResource(conn);
        }
    }
}
