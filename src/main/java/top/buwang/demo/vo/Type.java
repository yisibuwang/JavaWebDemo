package top.buwang.demo.vo;

public class Type {
    int typeid;
    String typename;
    int mid;

    public Type() {
    }

    public Type(int typeid, String typename, int mid) {
        this.typeid = typeid;
        this.typename = typename;
        this.mid = mid;
    }

    public int getTypeid() {
        return typeid;
    }

    public void setTypeid(int typeid) {
        this.typeid = typeid;
    }

    public String getTypename() {
        return typename;
    }

    public void setTypename(String typename) {
        this.typename = typename;
    }

    public int getMid() {
        return mid;
    }

    public void setMid(int mid) {
        this.mid = mid;
    }
}