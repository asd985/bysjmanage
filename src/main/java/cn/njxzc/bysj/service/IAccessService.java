package cn.njxzc.bysj.service;

import cn.njxzc.bysj.domain.Access;

import java.util.List;

public interface IAccessService {

    int accessByUrl(String url) throws Exception;

    List<Access> findAll() throws Exception;

    void change(String url) throws Exception;
}
