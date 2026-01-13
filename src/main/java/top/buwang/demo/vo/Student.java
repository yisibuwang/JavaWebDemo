package top.buwang.demo.vo;
import java.util.Date;

public class Student {
    int sno;
    String sname;
    Date sbirth;
    String sclass;

    public Student() {
    }

    public Student(int sno, String sname, Date sbirth, String sclass) {
        this.sno = sno;
        this.sname = sname;
        this.sbirth = sbirth;
        this.sclass = sclass;
    }

    public int getSno() {
        return sno;
    }

    public void setSno(int sno) {
        this.sno = sno;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public Date getSbirth() {
        return sbirth;
    }

    public void setSbirth(Date sbirth) {
        this.sbirth = sbirth;
    }

    public String getSclass() {
        return sclass;
    }

    public void setSclass(String sclass) {
        this.sclass = sclass;
    }

    @Override
    public String toString() {
        return "Student{" +
                "sno=" + sno +
                ", sname='" + sname + '\'' +
                ", sbirth=" + sbirth +
                ", sclass='" + sclass + '\'' +
                '}';
    }
}
