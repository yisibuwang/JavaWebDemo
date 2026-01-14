package top.buwang.demo.vo;

public class merchant {
    int mid;
    String mname;
    int phone;
    String address;
    byte[] Picture;
    String score;
    int status;

    public merchant() {

    }

    public merchant(int mid, String mname, int phone, String address, byte[] picture, String score, int status) {
        this.mid = mid;
        this.mname = mname;
        this.phone = phone;
        this.address = address;
        Picture = picture;
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

    public int getPhone() {
        return phone;
    }

    public void setPhone(int phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public byte[] getPicture() {
        return Picture;
    }

    public void setPicture(byte[] picture) {
        Picture = picture;
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
