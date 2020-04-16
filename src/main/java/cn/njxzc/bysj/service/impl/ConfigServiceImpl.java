package cn.njxzc.bysj.service.impl;

import cn.njxzc.bysj.dao.*;
import cn.njxzc.bysj.domain.StatusCount;
import cn.njxzc.bysj.service.IConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
public class ConfigServiceImpl implements IConfigService {

    @Autowired
    private IReportDao reportDao;
    @Autowired
    private ITaskDao taskDao;
    @Autowired
    private ICheckDao checkDao;
    @Autowired
    private IPaperFirstDao paperFirstDao;
    @Autowired
    private IPaperEndDao paperEndDao;
    @Autowired
    private IPaperDao paperDao;
    @Autowired
    private RedisTemplate template;


    @Override
    public Map<String, Map<Integer,StatusCount>> getCount() throws Exception {
        Map<String, Map<Integer,StatusCount>> map = new HashMap<>();
        Map<Integer, StatusCount> paper = paperDao.getCount();
        Map<Integer, StatusCount> report = reportDao.getCount();
        Map<Integer, StatusCount> task = taskDao.getCount();
        Map<Integer, StatusCount> check = checkDao.getCount();
        Map<Integer, StatusCount> paperFirst = paperFirstDao.getCount();
        Map<Integer, StatusCount> paperEnd = paperEndDao.getCount();
        map.put("paper", paper);
        map.put("report", report);
        map.put("task", task);
        map.put("check", check);
        map.put("paperFirst", paperFirst);
        map.put("paperEnd", paperEnd);
        return map;
    }

    @Override
    public void clear() throws Exception {
        template.delete("Notice");
        template.delete("Notices");
    }
}
