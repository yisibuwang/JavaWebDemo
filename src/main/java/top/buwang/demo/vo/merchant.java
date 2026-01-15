package top.buwang.demo.vo;

public class merchant {
    int mid;
    String mname;
    String phone;
    String address;
    byte[] picture;  // 改为小写
    String score;
    int status;

    public merchant() {

    }

    public merchant(int mid, String mname, String phone, String address, byte[] picture, String score, int status) {
        this.mid = mid;
        this.mname = mname;
        this.phone = phone;
        this.address = address;
        this.picture = picture;  // 改为小写
        this.score = score;
        this.status = status;
    }

    public int getMid() {
        return mid;
    }

    public void setMid(int mid) {
        this.mid = mid;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public byte[] getPicture() {
        return picture;  // 改为小写
    }

    public void setPicture(byte[] picture) {
        this.picture = picture;  // 改为小写
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}