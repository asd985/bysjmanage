package cn.njxzc.bysj.service.impl;

import cn.njxzc.bysj.dao.ICheckDao;
import cn.njxzc.bysj.dao.IPaperDao;
import cn.njxzc.bysj.domain.Check;
import cn.njxzc.bysj.domain.Export;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.service.ICheckService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class CheckServiceImpl implements ICheckService {

    @Autowired
    private ICheckDao checkDao;
    @Autowired
    private IPaperDao paperDao;

    @Override
    public List<Check> adminFindAll(Integer page, Integer limit) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return checkDao.adminFindAll();
    }

    @Override
    public List<Check> teacherFindAll(Integer page, Integer limit, String username) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return checkDao.teacherFindAll(username);
    }

    @Override
    public List<Check> studentFindAll(Integer page, Integer limit, String username) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return checkDao.studentFindAll(username);
    }

    @Override
    public List<Check> search(Integer page, Integer limit, Paper paper) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        if(paper.getPaperName().length()!=0)
            paper.setPaperName('%'+paper.getPaperName()+'%');
        if(paper.getTeacherName().length()!=0)
            paper.setTeacherName('%'+paper.getTeacherName()+'%');
        if(paper.getStudentName().length()!=0)
            paper.setStudentName('%'+paper.getStudentName()+'%');
        List<Paper> paperList = paperDao.search(paper);
        List<Check> checkList = new ArrayList<>();
        for (Paper paper1 : paperList) {
            Check check = checkDao.searchByPid(paper1.getPid());
            check.setPaper(paper1);
            checkList.add(check);
        }

        return checkList;
    }

    @Override
    public Check findByPid(Integer pid) throws Exception {
        return checkDao.findByPid(pid);
    }

    @Override
    public void uploadByUsername(String username,String uri) throws Exception {
        checkDao.uploadByUsername(username,uri);
    }

    @Override
    public List<Export> export() throws Exception {
        return checkDao.export();
    }

    @Override
    public void confirmTrueByPid(Integer pid) throws Exception {
        checkDao.confirmTrueByPid(pid);
    }

    @Override
    public void confirmFalseByPid(Integer pid) throws Exception {
        checkDao.confirmFalseByPid(pid);
    }
}
