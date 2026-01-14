package top.buwang.demo.vo;

public class cart {
    int cartid;
    int skuid;
    int Productid;
    int quantity;

    public cart(){

    }

    public cart(int cartid, int skuid, int productid, int quantity) {
        this.cartid = cartid;
        this.skuid = skuid;
        Productid = productid;
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
        return Productid;
    }

    public void setProductid(int productid) {
        Productid = productid;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
