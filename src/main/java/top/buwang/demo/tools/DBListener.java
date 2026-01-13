package top.buwang.demo.tools;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.*;

@WebListener
public class DBListener implements ServletContextListener {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/wspc?" + "useSSL=false&serverTimezone=UTC";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "123456";
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";

    //加载MySQL数据库驱动类,建立MySQL数据库连接
    public Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName(DB_DRIVER);
            conn = DriverManager.getConnection(DB_URL,DB_USERNAME,DB_PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
//            throw new RuntimeException(e);
            System.out.println(e.getMessage());
        }
        return conn;
    }

    //添加insert、修改update、删除delete（只要操作，不注重结果）
    public void executeUpdate(Connection conn, String sql, Object... objs) {
        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(sql);
            setParam(pstmt, objs);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
        }
    }
    //查询select（既要操作，又要结果）
    public ResultSet executeQuery(Connection conn, String sql, Object... objs) {
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(sql);
            setParam(pstmt, objs);
            rs= pstmt.executeQuery();
        } catch (SQLException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
        }
        return rs;
    }

    //    update books set author = ? where id=?
    //    objs = ["李兴华", 1];
    //给占位符传参数
    private void setParam(PreparedStatement pstmt, Object... objs){
        try {
            for(int i = 0; i < objs.length; i++){
                pstmt.setObject(i+1, objs[i]);
            }
        } catch (SQLException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
        }
    }

    public void closeResource(Connection conn){
        try {
            if(null != conn){
                conn.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("starting.......................................");
        DBListener db = new DBListener();
        Connection conn = db.getConnection();
        //先删表
        String drop_sql = "drop table if exists student";
        db.executeUpdate(conn, drop_sql);
        //再建表
        String create_sql = "create table student(\n" +
                "\tsno int primary key not null auto_increment,\n" +
                "\tsname varchar(20),\n" +
                "\tsbirth date,\n" +
                "\tsclass varchar(20)\n" +
                ")";
        db.executeUpdate(conn, create_sql);
        //插入数据
        String insert_sql = "insert into student(sname,sbirth,sclass) values(?,?,?)"; //模板语句
        db.executeUpdate(conn, insert_sql, new Object[]{"xiaozhao","2006-01-01","751"});
        db.executeUpdate(conn, insert_sql, new Object[]{"xiaoqian","2006-02-01","752"});
        db.executeUpdate(conn, insert_sql, new Object[]{"xiaosun","2006-03-01","753"});
        db.executeUpdate(conn, insert_sql, new Object[]{"xiaoli","2006-04-01","754"});
        //关闭数据库连接
        db.closeResource(conn);
    }

    public void contextDestroyed(ServletContextEvent sce) {
    }
}
