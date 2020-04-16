package cn.njxzc.bysj.service.impl;

import cn.njxzc.bysj.dao.IAccessDao;
import cn.njxzc.bysj.domain.Access;
import cn.njxzc.bysj.service.IAccessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AccessServiceImpl implements IAccessService {

    @Autowired
    private IAccessDao accessDao;


    @Override
    public int accessByUrl(String url) throws Exception {
        return accessDao.accessByUrl(url);
    }

    @Override
    public List<Access> findAll() throws Exception {
        return accessDao.findAll();
    }

    @Override
    public void change(String url) throws Exception {
        accessDao.change(url);
    }
}
