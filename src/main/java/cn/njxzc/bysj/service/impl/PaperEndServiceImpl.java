package cn.njxzc.bysj.service.impl;

import cn.njxzc.bysj.dao.IPaperDao;
import cn.njxzc.bysj.dao.IPaperEndDao;
import cn.njxzc.bysj.domain.Export;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.PaperEnd;
import cn.njxzc.bysj.service.IPaperEndService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class PaperEndServiceImpl implements IPaperEndService {

    @Autowired
    private IPaperEndDao paperEndDao;
    @Autowired
    private IPaperDao paperDao;

    @Override
    public List<PaperEnd> adminFindAll(Integer page, Integer limit) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperEndDao.adminFindAll();
    }

    @Override
    public List<PaperEnd> teacherFindAll(Integer page, Integer limit, String username) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperEndDao.teacherFindAll(username);
    }

    @Override
    public List<PaperEnd> studentFindAll(Integer page, Integer limit, String username) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperEndDao.studentFindAll(username);
    }

    @Override
    public List<PaperEnd> search(Integer page, Integer limit, Paper paper) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        if(paper.getPaperName().length()!=0)
            paper.setPaperName('%'+paper.getPaperName()+'%');
        if(paper.getTeacherName().length()!=0)
            paper.setTeacherName('%'+paper.getTeacherName()+'%');
        if(paper.getStudentName().length()!=0)
            paper.setStudentName('%'+paper.getStudentName()+'%');
        List<Paper> paperList = paperDao.search(paper);
        List<PaperEnd> paperEndList = new ArrayList<>();
        for (Paper paper1 : paperList) {
            PaperEnd paperEnd = paperEndDao.searchByPid(paper1.getPid());
            paperEnd.setPaper(paper1);
            paperEndList.add(paperEnd);
        }

        return paperEndList;
    }

    @Override
    public PaperEnd findByPid(Integer pid) throws Exception {
        return paperEndDao.findByPid(pid);
    }

    @Override
    public void uploadByUsername(String username,String uri) throws Exception {
        paperEndDao.uploadByUsername(username,uri);
    }

    @Override
    public List<Export> export() throws Exception {
        return paperEndDao.export();
    }

    @Override
    public void confirmTrueByPid(Integer pid) throws Exception {
        paperEndDao.confirmTrueByPid(pid);
    }

    @Override
    public void confirmFalseByPid(Integer pid) throws Exception {
        paperEndDao.confirmFalseByPid(pid);
    }
}
