package top.buwang.demo.vo;

public class Product {
    int Productid;
    String Productname;
    String Description;
    int Price;
    byte[] Picture;
    int Productstatus;
    int mid;

    public Product() {

    }

    public Product(int productid, String productname, String description, int price, byte[] picture, int productstatus, int mid) {
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

    public int getPrice() {
        return Price;
    }

    public void setPrice(int price) {
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
