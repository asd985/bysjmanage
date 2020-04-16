package cn.njxzc.bysj.service.impl;

import cn.njxzc.bysj.dao.IPaperDao;
import cn.njxzc.bysj.dao.IReportDao;
import cn.njxzc.bysj.domain.Export;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.Report;
import cn.njxzc.bysj.service.IReportService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class ReportServiceImpl implements IReportService {

    @Autowired
    private IReportDao reportDao;
    @Autowired
    private IPaperDao paperDao;

    @Override
    public List<Report> adminFindAll(Integer page, Integer limit) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return reportDao.adminFindAll();
    }

    @Override
    public List<Report> teacherFindAll(Integer page, Integer limit, String username) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return reportDao.teacherFindAll(username);
    }

    @Override
    public List<Report> studentFindAll(Integer page, Integer limit, String username) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return reportDao.studentFindAll(username);
    }

    @Override
    public List<Report> search(Integer page, Integer limit, Paper paper) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        if(paper.getPaperName().length()!=0)
            paper.setPaperName('%'+paper.getPaperName()+'%');
        if(paper.getTeacherName().length()!=0)
            paper.setTeacherName('%'+paper.getTeacherName()+'%');
        if(paper.getStudentName().length()!=0)
            paper.setStudentName('%'+paper.getStudentName()+'%');
        List<Paper> paperList = paperDao.search(paper);
        List<Report> reportList = new ArrayList<>();
        for (Paper paper1 : paperList) {
            Report report = reportDao.searchByPid(paper1.getPid());
            report.setPaper(paper1);
            reportList.add(report);
        }

        return reportList;
    }

    @Override
    public Report findByPid(Integer pid) throws Exception {
        return reportDao.findByPid(pid);
    }

    @Override
    public void uploadByUsername(String username,String uri) throws Exception {
        reportDao.uploadByUsername(username,uri);
    }

    @Override
    public List<Export> export() throws Exception {
        return reportDao.export();
    }

    @Override
    public void confirmTrueByPid(Integer pid) throws Exception {
        reportDao.confirmTrueByPid(pid);
    }

    @Override
    public void confirmFalseByPid(Integer pid) throws Exception {
        reportDao.confirmFalseByPid(pid);
    }
}
