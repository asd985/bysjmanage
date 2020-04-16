package cn.njxzc.bysj.service.impl;

import cn.njxzc.bysj.dao.IPaperDao;
import cn.njxzc.bysj.dao.IPaperFirstDao;
import cn.njxzc.bysj.domain.Export;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.PaperFirst;
import cn.njxzc.bysj.service.IPaperFirstService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class PaperFirstServiceImpl implements IPaperFirstService {

    @Autowired
    private IPaperFirstDao paperFirstDao;
    @Autowired
    private IPaperDao paperDao;

    @Override
    public List<PaperFirst> adminFindAll(Integer page, Integer limit) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperFirstDao.adminFindAll();
    }

    @Override
    public List<PaperFirst> teacherFindAll(Integer page, Integer limit, String username) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperFirstDao.teacherFindAll(username);
    }

    @Override
    public List<PaperFirst> studentFindAll(Integer page, Integer limit, String username) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperFirstDao.studentFindAll(username);
    }

    @Override
    public List<PaperFirst> search(Integer page, Integer limit, Paper paper) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        if(paper.getPaperName().length()!=0)
            paper.setPaperName('%'+paper.getPaperName()+'%');
        if(paper.getTeacherName().length()!=0)
            paper.setTeacherName('%'+paper.getTeacherName()+'%');
        if(paper.getStudentName().length()!=0)
            paper.setStudentName('%'+paper.getStudentName()+'%');
        List<Paper> paperList = paperDao.search(paper);
        List<PaperFirst> paperFirstList = new ArrayList<>();
        for (Paper paper1 : paperList) {
            PaperFirst paperFirst = paperFirstDao.searchByPid(paper1.getPid());
            paperFirst.setPaper(paper1);
            paperFirstList.add(paperFirst);
        }

        return paperFirstList;
    }

    @Override
    public PaperFirst findByPid(Integer pid) throws Exception {
        return paperFirstDao.findByPid(pid);
    }

    @Override
    public void uploadByUsername(String username,String uri) throws Exception {
        paperFirstDao.uploadByUsername(username,uri);
    }

    @Override
    public List<Export> export() throws Exception {
        return paperFirstDao.export();
    }

    @Override
    public void confirmTrueByPid(Integer pid) throws Exception {
        paperFirstDao.confirmTrueByPid(pid);
    }

    @Override
    public void confirmFalseByPid(Integer pid) throws Exception {
        paperFirstDao.confirmFalseByPid(pid);
    }
}
