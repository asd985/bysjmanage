package cn.njxzc.bysj.service.impl;

import cn.njxzc.bysj.dao.IPaperDao;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.Process;
import cn.njxzc.bysj.service.IPaperService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class PaperServiceImpl implements IPaperService {

    @Autowired
    private IPaperDao paperDao;

    @Override
    public List<Paper> findAll(int page,int limit) throws Exception{
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperDao.findAll();
    }

    @Override
    public Paper findByPid(Integer pid) throws Exception{
        return paperDao.findByPid(pid);
    }

    @Override
    public void updateByPid(Paper paper) throws Exception{
        paperDao.updateByPid(paper);
    }

    @Override
    public void save(Paper paper) throws Exception {
        paperDao.save(paper);
    }

    @Override
    public void deleteByPid(Integer pid) throws Exception {
        paperDao.deleteByPid(pid);
    }

    @Override
    public List<Paper> search(Integer page, Integer limit, Paper paper) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperDao.search(paper);
    }

    @Override
    public List<Paper> selectStudentSearch(Integer page, Integer limit, Paper paper) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperDao.selectStudentSearch(paper);
    }

    @Override
    public List<Paper> selectTeacherSearch(Integer page, Integer limit, Paper paper) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperDao.selectTeacherSearch(paper);
    }

    @Override
    public void changeStatus(Integer pid) throws Exception {
        paperDao.changeStatus(pid);
    }

    @Override
    public List<Paper> findAllReview(Integer page, Integer limit) throws Exception{
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperDao.findAllReview();
    }

    @Override
    public void reviewByPid(Integer pid) throws Exception{
        paperDao.reviewByPid(pid);
    }

    @Override
    public void updateMineByPid(Paper paper) throws Exception {
        paperDao.updateMineByPid(paper);
    }

    @Override
    public List<Paper> findMine(Integer page, Integer limit, String teacherId, String studentId) throws Exception {
        PageHelper.startPage(page, limit);
        return paperDao.findMine(teacherId,studentId);
    }

    @Override
    public Integer Select(String username, String auth, Integer pid) throws Exception {
        Integer status = paperDao.findStatusByPid(pid);
        if(status==1){ //已审核
            paperDao.Select(username,auth,pid);
        }
        return status;
    }

    @Override
    public List<Paper> stuFindAllReviewed(Integer page, Integer limit) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperDao.stuFindAllReviewed();
    }

    @Override
    public List<Paper> teaFindAllReviewed(Integer page, Integer limit) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperDao.teaFindAllReviewed();
    }

    @Override
    public void confirmTrueByPid(Integer pid) throws Exception {
        paperDao.confirmTrueByPid(pid);
    }

    @Override
    public void confirmFalseByPid(Integer pid) throws Exception {
        paperDao.confirmFalseByPid(pid);
    }

    @Override
    public List<Process> findProcess(Integer page, Integer limit) {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return paperDao.findProcess();
    }

    @Override
    public List<Process> exportProcess() {
        return paperDao.findProcess();
    }
}
