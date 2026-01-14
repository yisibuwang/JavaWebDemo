package top.buwang.demo.vo;

public class sku {
    int skuid;
    int Productid;
    String Description;
    int Change;
    int Inventory;

    public sku(){

    }

    public sku(int skuid, int productid, String description, int change, int inventory) {
        this.skuid = skuid;
        Productid = productid;
        Description = description;
        Change = change;
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

    public int getChange() {
        return Change;
    }

    public void setChange(int change) {
        Change = change;
    }

    public int getInventory() {
        return Inventory;
    }

    public void setInventory(int inventory) {
        Inventory = inventory;
    }
}
