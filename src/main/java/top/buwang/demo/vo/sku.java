package top.buwang.demo.vo;

import java.math.BigDecimal;

public class sku {
    int skuid;
    int Productid;
    String Description;
    BigDecimal ChangePrice;  // 改为BigDecimal
    int Inventory;

    public sku(){

    }

    public sku(int skuid, int productid, String description, BigDecimal change, BigDecimal inventory) {
        this.skuid = skuid;
        Productid = productid;
        Description = description;
        ChangePrice = change;
        Inventory = inventory.intValue(); // 如果传入的是BigDecimal则转换为int
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

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public BigDecimal getChangePrice() {
        return ChangePrice;
    }

    public void setChangePrice(BigDecimal changePrice) {
        ChangePrice = changePrice;
    }

    public int getInventory() {
        return Inventory;
    }

    public void setInventory(int inventory) {
        Inventory = inventory;
    }
}