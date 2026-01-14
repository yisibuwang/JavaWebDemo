package top.buwang.demo.service;

import top.buwang.demo.dao.merchantDao;
import top.buwang.demo.vo.merchant;
import java.util.List;

public class merchantService {
    merchantDao merchantDao = new merchantDao();    //创建实例

    public List<merchant> getAllMerchant(){         //获取
        return merchantDao.getAllMerchant();
    }
    public boolean addMerchant(String mname, int phone, String address, byte[] picture, String score, int status) {     //添加
        return merchantDao.addMerchant(mname, phone, address, picture, score, status);
    }
    public boolean updateMerchant(int mid, String mname, int phone, String address, byte[] picture, String score, int status) {     //修改
        return merchantDao.updateMerchant(mid, mname, phone, address, picture, score, status);
    }
    public boolean deleteMerchant(int mid) {        //删除
        return merchantDao.deleteMerchant(mid);
    }
}
