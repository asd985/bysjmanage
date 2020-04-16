package cn.njxzc.bysj.service;

import cn.njxzc.bysj.domain.Export;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.PaperEnd;

import java.util.List;

public interface IPaperEndService {
    List<PaperEnd> adminFindAll(Integer page, Integer limit) throws Exception;

    List<PaperEnd> teacherFindAll(Integer page, Integer limit, String username) throws Exception;

    List<PaperEnd> studentFindAll(Integer page, Integer limit, String username) throws Exception;

    List<PaperEnd> search(Integer page, Integer limit, Paper paper) throws Exception;

    PaperEnd findByPid(Integer pid) throws Exception;

    void uploadByUsername(String username, String uri) throws Exception;

    List<Export> export() throws Exception;

    void confirmTrueByPid(Integer pid) throws Exception;

    void confirmFalseByPid(Integer pid) throws Exception;
}
