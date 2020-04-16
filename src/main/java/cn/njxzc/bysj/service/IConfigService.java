package cn.njxzc.bysj.service;

import cn.njxzc.bysj.domain.StatusCount;

import java.util.Map;

public interface IConfigService {

    Map<String, Map<Integer, StatusCount>> getCount() throws Exception;

    void clear() throws Exception;
}
