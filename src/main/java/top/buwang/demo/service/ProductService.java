package top.buwang.demo.service;

import top.buwang.demo.dao.ProductDao;
import top.buwang.demo.vo.Product;

import java.util.List;
public class ProductService {
    ProductDao productDao = new ProductDao();

    public List<Product> getAllProduct(){
        return productDao.getAllProduct();
    }
    public boolean addProduct(String productname, String description, int price, byte[] picture, int productstatus, int mid) {
        return productDao.addProduct(productname, description, price, picture, productstatus, mid);
    }
    public boolean updateProduct(int productid, String productname, String description, int price, byte[] picture, int productstatus, int mid) {
        return productDao.updateProduct(productid, productname, description, price, picture, productstatus, mid);
    }
    public boolean deleteProduct(int productid) {
        return productDao.deleteProduct(productid);
    }
}
