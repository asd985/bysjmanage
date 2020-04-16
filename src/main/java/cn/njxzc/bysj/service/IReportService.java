package cn.njxzc.bysj.service;

import cn.njxzc.bysj.domain.Export;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.Report;

import java.util.List;

public interface IReportService {
    List<Report> adminFindAll(Integer page, Integer limit) throws Exception;

    List<Report> teacherFindAll(Integer page, Integer limit, String username) throws Exception;

    List<Report> studentFindAll(Integer page, Integer limit, String username) throws Exception;

    List<Report> search(Integer page, Integer limit, Paper paper) throws Exception;

    Report findByPid(Integer pid) throws Exception;

    void uploadByUsername(String username, String uri) throws Exception;

    List<Export> export() throws Exception;

    void confirmTrueByPid(Integer pid) throws Exception;

    void confirmFalseByPid(Integer pid) throws Exception;
}
