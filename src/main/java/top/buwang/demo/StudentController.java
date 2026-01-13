package top.buwang.demo;

import com.alibaba.fastjson2.JSON;
import top.buwang.demo.tools.DBListener;
import top.buwang.demo.vo.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "studentServlet", value = "/student")
public class StudentController extends HttpServlet {

    //查询
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        List<Student> students = queryStudent();
        String liststr = JSON.toJSONString(students);
        PrintWriter out = response.getWriter();
        out.write(liststr);
    }

    //增加
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        try {
            String sname_add = req.getParameter("sname_add");
            String sbirth_add = req.getParameter("sbirth_add");
            String sclass_add = req.getParameter("sclass_add");
            DBListener db = new DBListener();
            Connection conn = db.getConnection();
            String insert_sql = "insert into student(sname,sbirth,sclass) values(?,?,?)"; //模板语句
            db.executeUpdate(conn, insert_sql, new Object[]{sname_add, sbirth_add,sclass_add});
            out.write("{\"isok\":\"yes\"}");
        }catch (Exception e){
            out.write("{\"isok\":\"no\"}");
        }
    }

    //修改
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        try {
            String sno_edit = req.getParameter("sno_edit");
            String sname_edit = req.getParameter("sname_edit");
            String sbirth_edit = req.getParameter("sbirth_edit");
            String sclass_edit = req.getParameter("sclass_edit");
            DBListener db = new DBListener();
            Connection conn = db.getConnection();
            String edit_sql = "update student set sname=?, sbirth=?, sclass=? where sno=?"; //模板语句
            db.executeUpdate(conn, edit_sql, new Object[]{sname_edit,sbirth_edit, sclass_edit,sno_edit});
            out.write("{\"isok\":\"yes\"}");
        }catch (Exception e){
            out.write("{\"isok\":\"no\"}");
        }
    }

    //删除
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        try {
            String snos = req.getParameter("snos");
            DBListener db = new DBListener();
            Connection conn = db.getConnection();
            String delete_sql = "delete from student where sno in ("+snos+")"; //模板语句
            db.executeUpdate(conn, delete_sql);
            out.write("{\"isok\":\"yes\"}");
        }catch (Exception e){
            out.write("{\"isok\":\"no\"}");
        }
    }


    private List<Student> queryStudent(){
        List<Student> students = new ArrayList<Student>();
        try{
            String query_sql = "select * from student";
            DBListener db = new DBListener();
            Connection conn = db.getConnection();
            ResultSet rs = db.executeQuery(conn, query_sql);
            while(rs.next()){
                Student s= new Student();
                s.setSno(rs.getInt("sno"));
                s.setSname(rs.getString("sname"));
                s.setSbirth(rs.getDate("sbirth"));
                s.setSclass(rs.getString("sclass"));
                students.add(s);
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return students;
    }
}
