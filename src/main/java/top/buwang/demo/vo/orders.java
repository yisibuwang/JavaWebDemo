package top.buwang.demo.vo;

public class orders {
    int ordersid;
    int cartid;

    public orders(){

    }

    public orders(int ordersid, int cartid) {
        this.ordersid = ordersid;
        this.cartid = cartid;
    }

    public int getOrdersid() {
        return ordersid;
    }

    public void setOrdersid(int ordersid) {
        this.ordersid = ordersid;
    }

    public int getCartid() {
        return cartid;
    }

    public void setCartid(int cartid) {
        this.cartid = cartid;
    }
}
