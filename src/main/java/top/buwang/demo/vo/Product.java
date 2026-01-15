package top.buwang.demo.vo;

import java.math.BigDecimal;

public class Product {
    int Productid;
    String Productname;
    String Description;
    BigDecimal Price;  // 改为BigDecimal以适应数据库中的decimal类型
    byte[] Picture;
    int Productstatus;
    int mid;

    public Product() {

    }

    public Product(int productid, String productname, String description, BigDecimal price, byte[] picture, int productstatus, int mid) {
        Productid = productid;
        Productname = productname;
        Description = description;
        Price = price;
        Picture = picture;
        Productstatus = productstatus;
        this.mid = mid;
    }

    public int getProductid() {
        return Productid;
    }

    public void setProductid(int productid) {
        Productid = productid;
    }

    public String getProductname() {
        return Productname;
    }

    public void setProductname(String productname) {
        Productname = productname;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public BigDecimal getPrice() {
        return Price;
    }

    public void setPrice(BigDecimal price) {
        Price = price;
    }

    public byte[] getPicture() {
        return Picture;
    }

    public void setPicture(byte[] picture) {
        Picture = picture;
    }

    public int getProductstatus() {
        return Productstatus;
    }

    public void setProductstatus(int productstatus) {
        Productstatus = productstatus;
    }

    public int getMid() {
        return mid;
    }

    public void setMid(int mid) {
        this.mid = mid;
    }
}