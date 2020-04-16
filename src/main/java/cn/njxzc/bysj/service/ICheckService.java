package cn.njxzc.bysj.service;

import cn.njxzc.bysj.domain.Check;
import cn.njxzc.bysj.domain.Export;
import cn.njxzc.bysj.domain.Paper;


import java.util.List;

public interface ICheckService {
    List<Check> adminFindAll(Integer page, Integer limit) throws Exception;

    List<Check> teacherFindAll(Integer page, Integer limit, String username) throws Exception;

    List<Check> studentFindAll(Integer page, Integer limit, String username) throws Exception;

    List<Check> search(Integer page, Integer limit, Paper paper) throws Exception;

    Check findByPid(Integer pid) throws Exception;

    void uploadByUsername(String username, String uri) throws Exception;

    List<Export> export() throws Exception;

    void confirmTrueByPid(Integer pid) throws Exception;

    void confirmFalseByPid(Integer pid) throws Exception;
}
