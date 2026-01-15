package top.buwang.demo.vo;

public class cart {
    int cartid;
    int skuid;
    int productid;  // 改为小写
    int quantity;

    public cart(){

    }

    public cart(int cartid, int skuid, int productid, int quantity) {
        this.cartid = cartid;
        this.skuid = skuid;
        this.productid = productid;  // 改为小写
        this.quantity = quantity;
    }

    public int getCartid() {
        return cartid;
    }

    public void setCartid(int cartid) {
        this.cartid = cartid;
    }

    public int getSkuid() {
        return skuid;
    }

    public void setSkuid(int skuid) {
        this.skuid = skuid;
    }

    public int getProductid() {
        return productid;  // 改为小写
    }

    public void setProductid(int productid) {
        this.productid = productid;  // 改为小写
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}