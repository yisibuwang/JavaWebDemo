package top.buwang.demo.vo;

import java.math.BigDecimal;

public class Product {
    int productid;
    String productname;
    String description;
    BigDecimal price;  // 改为BigDecimal以适应数据库中的decimal类型
    byte[] picture;
    int productstatus;
    int mid;

    public Product() {

    }

    public Product(int productid, String productname, String description, BigDecimal price, byte[] picture, int productstatus, int mid) {
        this.productid = productid;
        this.productname = productname;
        this.description = description;
        this.price = price;
        this.picture = picture;
        this.productstatus = productstatus;
        this.mid = mid;
    }

    public int getProductid() {
        return productid;
    }

    public void setProductid(int productid) {
        this.productid = productid;
    }

    public String getProductname() {
        return productname;
    }

    public void setProductname(String productname) {
        this.productname = productname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public byte[] getPicture() {
        return picture;
    }

    public void setPicture(byte[] picture) {
        this.picture = picture;
    }

    public int getProductstatus() {
        return productstatus;
    }

    public void setProductstatus(int productstatus) {
        this.productstatus = productstatus;
    }

    public int getMid() {
        return mid;
    }

    public void setMid(int mid) {
        this.mid = mid;
    }
}