package cn.njxzc.bysj.service.impl;

import cn.njxzc.bysj.dao.*;
import cn.njxzc.bysj.domain.StatusCount;
import cn.njxzc.bysj.service.IConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
public class ConfigServiceImpl implements IConfigService {

    @Autowired
    private IPaperDao paperDao;


    @Override
    public Map<String, Map<Integer,StatusCount>> getCount() throws Exception {
        Map<String, Map<Integer,StatusCount>> map = new HashMap<>();
        Map<Integer, StatusCount> paper = paperDao.getCount();
        map.put("paper", paper);
        return map;
    }
}
