package top.buwang.demo.service;

import top.buwang.demo.dao.skuDao;
import top.buwang.demo.vo.sku;

import java.util.List;
public class skuService {
    skuDao skuDao = new skuDao();
    public List<sku> getAllSku(){
        return skuDao.getAllSku();
    }
    public boolean addSku(int productid, String description, int change, int inventory) {
        return skuDao.addSku(productid, description, change, inventory);
    }
    public boolean updateSku(int skuid, int productid, String description, int change, int inventory) {
        return skuDao.updateSku(skuid, productid, description, change, inventory);
    }
    public boolean deleteSku(int skuid) {
        return skuDao.deleteSku(skuid);
    }
}
