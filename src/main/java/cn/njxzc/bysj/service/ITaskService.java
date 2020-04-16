package cn.njxzc.bysj.service;

import cn.njxzc.bysj.domain.Export;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.Task;

import java.util.List;

public interface ITaskService {
    List<Task> adminFindAll(Integer page, Integer limit) throws Exception;

    List<Task> teacherFindAll(Integer page, Integer limit, String username) throws Exception;

    List<Task> studentFindAll(Integer page, Integer limit, String username) throws Exception;

    List<Task> search(Integer page, Integer limit, Paper paper) throws Exception;

    Task findByPid(Integer pid) throws Exception;

    void uploadByUsername(String username,String uri) throws Exception;

    List<Export> export() throws Exception;

    void confirmTrueByPid(Integer pid) throws Exception;

    void confirmFalseByPid(Integer pid) throws Exception;
}
