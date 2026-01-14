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
            throw new RuntimeException(e);
        }
        return conn;
    }

    public int executeUpdate(Connection conn, String sql, Object... objs) {        //更新
        PreparedStatement pstmt = null;     //sql预编译语句
        try {
            pstmt = conn.prepareStatement(sql);         //在连接对象中创建一个预编译语句对象pstmt
            setParam(pstmt, objs);                      //设置参数
            pstmt.executeUpdate();                      //执行更新
            return pstmt.getUpdateCount();              //返回更新行数用来判断是否更新成功，试着写一下如果出错回来删了
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
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
            throw new RuntimeException(e);
        }
        return rs;      //返回查询
    }

    private void setParam(PreparedStatement pstmt, Object... objs){         //参数绑定
        try {
            for(int i = 0; i < objs.length; i++){               //遍历参数
                pstmt.setObject(i+1, objs[i]);      //位置映射
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
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
        String checkTable = "SHOW TABLES LIKE 'merchant'";// 检查表是否存在，不存在时才创建
        ResultSet rs = db.executeQuery(conn, checkTable);
        try {
            if (!rs.next()) {
                String create_merchant = "create table merchant(\n" +                       //商家表
                        "\tmid int primary key not null auto_increment,\n" +    //商家id
                        "\tmname varchar(20),\n" +                              //商家名字
                        "\tphone varchar(11),\n" +                              //商家电话
                        "\taddress varchar(255),\n" +                            //商家地址
                        "\tPicture blob,\n" +                                   //商家图片
                        "\tscore varchar(20) default 0,\n" +                              //商家评分
                        "\tstatus tinyint(1) default 1\n" +                               //商家状态
                        ")";
                db.executeUpdate(conn, create_merchant);

                String create_Type = "create table type(\n" +                               //商品分类表
                        "\ttypeid int primary key not null auto_increment,\n" +//分类id
                        "\ttypename varchar(20) not null,\n" +                 //分类名字
                        "\tmid int not null\n" +                               //商家id
                        ")";
                db.executeUpdate(conn, create_Type);

                String create_Product = "create table Product(\n" +                         //商品表
                        "\tProductid int primary key not null auto_increment,\n" +//商品id
                        "\tProductname varchar(100) not null,\n" +                 //商品名字
                        "\tDescription varchar(255),\n" +                         //商品描述
                        "\tPrice decimal default 1,\n" +                                    //商品价格
                        "\tPicture blob,\n" +                                     //商品图片
                        "\tProductstatus tinyint(1) default 1,\n" +                         //商品状态
                        "\tmid int not null\n" +                                  //商家id
                        ")";
                db.executeUpdate(conn, create_Product);

                String create_sku = "create table sku(\n" +                                 //商品规格表
                        "\tskuid int primary key not null auto_increment,\n" +    //规格id
                        "\tProductid int not null,\n" +                           //商品id
                        "\tDescription varchar(255),\n" +                         //规格描述
                        "\tChange decimal default 0,\n" +                                   //变化
                        "\tInventory int default 1\n" +                                    //库存
                        ")";
                db.executeUpdate(conn, create_sku);

                String create_cart = "create table cart(\n" +                                 //购物车表
                        "\tcartid int primary key not null auto_increment,\n" +    //id
                        "\tskuid int not null,\n" +                               //规格id
                        "\tProductid int not null,\n" +                           //商品id
                        "\tquantity int not null default 1,\n" +                            //数量
                        ")";
                db.executeUpdate(conn, create_cart);

                String create_orders = "create table orders(\n" +                                 //订单表
                        "\tordersid int primary key not null auto_increment,\n" +    //id
                        "\tcartid int not null,\n" +                               //规格id
                        ")";
                db.executeUpdate(conn, create_orders);

                String insert_merchant = "insert into merchant(mid,mname,phone,address,score,status) values(?,?,?,?,?)"; //模板语句
                db.executeUpdate(conn, insert_merchant, new Object[]{"1","沙县小吃","114514","下北泽23-14号","2","1"});
                String insert_Type = "insert into type(typeid,typename,mid) values(?,?,?)"; //模板语句
                db.executeUpdate(conn, insert_Type, new Object[]{"1","美食小吃","1"});
                String insert_Product = "insert into Product(Productid,Productname,Description,Price,Productstatus,mid) values(?,?,?,?,?)"; //模板语句
                db.executeUpdate(conn, insert_Product, new Object[]{"1","鸡腿饭","我是描述","10","1","1"});
                String insert_sku1 = "insert into sku(skuid,Productid,Description,Change,Inventory) values(?,?,?,?,?)"; //模板语句
                db.executeUpdate(conn, insert_sku1, new Object[]{"1","1","加根香肠","2","99"});
                String insert_sku2 = "insert into sku(skuid,Productid,Description,Change,Inventory) values(?,?,?,?,?)"; //模板语句
                db.executeUpdate(conn, insert_sku2, new Object[]{"2","1","不要鸡腿","-2","99"});

                db.closeResource(conn);//关闭数据库连接
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void contextDestroyed(ServletContextEvent sce) {                     //关闭的时候会执行
    }
}