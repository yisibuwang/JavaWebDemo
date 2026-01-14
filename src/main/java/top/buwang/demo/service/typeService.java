package top.buwang.demo.service;

import top.buwang.demo.dao.typeDao;
import top.buwang.demo.vo.Type;
import java.util.List;
public class typeService {
    typeDao typeDao = new typeDao();

    public List<Type> getAllType(){
        return typeDao.getAllType();
    }
    public boolean addType(String typename, int mid) {
        return typeDao.addType(typename, mid);
    }
    public boolean updateType(int typeid, String typename, int mid) {
        return typeDao.updateType(typeid, typename, mid);
    }
    public boolean deleteType(int typeid) {
        return typeDao.deleteType(typeid);
    }
}
