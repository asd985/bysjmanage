package cn.njxzc.bysj.service;

import cn.njxzc.bysj.domain.Export;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.PaperFirst;

import java.util.List;

public interface IPaperFirstService {
    List<PaperFirst> adminFindAll(Integer page, Integer limit) throws Exception;

    List<PaperFirst> teacherFindAll(Integer page, Integer limit, String username) throws Exception;

    List<PaperFirst> studentFindAll(Integer page, Integer limit, String username) throws Exception;

    List<PaperFirst> search(Integer page, Integer limit, Paper paper) throws Exception;

    PaperFirst findByPid(Integer pid) throws Exception;

    void uploadByUsername(String username, String uri) throws Exception;

    List<Export> export() throws Exception;

    void confirmTrueByPid(Integer pid) throws Exception;

    void confirmFalseByPid(Integer pid) throws Exception;
}
