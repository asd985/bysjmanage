package cn.njxzc.bysj.service;

import cn.njxzc.bysj.domain.Notice;

import java.util.List;

public interface INoticeService {

    Notice findById(Integer id) throws Exception;

    List<Notice> findMain() throws Exception;

    List<Notice> findAll(Integer page, Integer limit) throws Exception;

    void save(Notice notice) throws Exception;

    void updateById(Notice notice) throws Exception;

    void deleteById(Integer id) throws Exception;
}
