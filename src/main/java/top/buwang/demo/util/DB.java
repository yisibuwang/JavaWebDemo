package top.buwang.demo.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.*;

@WebListener
public class DB implements ServletContextListener {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/waimai?" + "useSSL=false&serverTimezone=UTC";         //MySQL数据库不使用SSL加密连接设置时区为UTC
    private static final String DB_USERNAME = "root";                                                                       //数据库用户名
    private static final String DB_PASSWORD = "123456";                                                                     //数据库密码
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";                                                     //mysql驱动类

    public Connection getConnection() {         //建立连接
        Connection conn = null;     //声明连接对象
        try {
            Class.forName(DB_DRIVER);       //加载数据库驱动
            conn = DriverManager.getConnection(DB_URL,DB_USERNAME,DB_PASSWORD);     //建立连接
        }
        catch (ClassNotFoundException | SQLException e) {       //错误处理
            System.out.println(e.getMessage());
        }
        return conn;
    }

    public void executeUpdate(Connection conn, String sql, Object... objs) {        //更新
        PreparedStatement pstmt = null;     //sql预编译语句
        try {
            pstmt = conn.prepareStatement(sql);         //在连接对象中创建一个预编译语句对象pstmt
            setParam(pstmt, objs);                      //设置参数
            pstmt.executeUpdate();                      //执行更新
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public ResultSet executeQuery(Connection conn, String sql, Object... objs) {        //查询
        ResultSet rs = null;            //存储查询结果
        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(sql);
            setParam(pstmt, objs);
            rs= pstmt.executeQuery();       //执行查询
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return rs;      //返回查询
    }

    private void setParam(PreparedStatement pstmt, Object... objs){         //参数绑定
        try {
            for(int i = 0; i < objs.length; i++){               //遍历参数
                pstmt.setObject(i+1, objs[i]);      //位置映射
            }
        } catch (SQLException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
        }
    }

    public void closeResource(Connection conn){     //关闭连接
        try {
            if(null != conn){
                conn.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void contextInitialized(ServletContextEvent sce) {                       //web启动时候会自动执行
        DB db = new DB();
        Connection conn = db.getConnection();
        String checkTable = "SHOW TABLES LIKE 'student'";// 检查表是否存在，不存在时才创建
        ResultSet rs = db.executeQuery(conn, checkTable);
        try {
            if (!rs.next()) {
                String create_sql = "create table student(\n" +
                        "\tsno int primary key not null auto_increment,\n" +
                        "\tsname varchar(20),\n" +
                        "\tsbirth date,\n" +
                        "\tsclass varchar(20)\n" +
                        ")";
                db.executeUpdate(conn, create_sql);
                String insert_sql = "insert into student(sname,sbirth,sclass) values(?,?,?)"; //模板语句
                db.executeUpdate(conn, insert_sql, new Object[]{"xiaozhao","2006-01-01","751"});
                db.executeUpdate(conn, insert_sql, new Object[]{"xiaoqian","2006-02-01","752"});
                db.executeUpdate(conn, insert_sql, new Object[]{"xiaosun","2006-03-01","753"});
                db.executeUpdate(conn, insert_sql, new Object[]{"xiaoli","2006-04-01","754"});

                db.closeResource(conn);//关闭数据库连接
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void contextDestroyed(ServletContextEvent sce) {                     //关闭的时候会执行
    }
}