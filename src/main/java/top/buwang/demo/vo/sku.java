package top.buwang.demo.vo;

public class sku {
    int skuid;
    int Productid;
    String Description;
    int ChangePrice;
    int Inventory;

    public sku(){

    }

    public sku(int skuid, int productid, String description, int change, int inventory) {
        this.skuid = skuid;
        Productid = productid;
        Description = description;
        ChangePrice = change;
        Inventory = inventory;
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

    public int getChangePrice() {
        return ChangePrice;
    }

    public void setChangePrice(int changePrice) {
        ChangePrice = changePrice;
    }

    public int getInventory() {
        return Inventory;
    }

    public void setInventory(int inventory) {
        Inventory = inventory;
    }
}
