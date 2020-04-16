package cn.njxzc.bysj.service.impl;

import cn.njxzc.bysj.dao.IPaperDao;
import cn.njxzc.bysj.dao.ITaskDao;
import cn.njxzc.bysj.domain.Export;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.Task;
import cn.njxzc.bysj.service.ITaskService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class TaskServiceImpl implements ITaskService {

    @Autowired
    private ITaskDao taskDao;
    @Autowired
    private IPaperDao paperDao;

    @Override
    public List<Task> adminFindAll(Integer page, Integer limit) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return taskDao.adminFindAll();
    }

    @Override
    public List<Task> teacherFindAll(Integer page, Integer limit, String username) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return taskDao.teacherFindAll(username);
    }

    @Override
    public List<Task> studentFindAll(Integer page, Integer limit, String username) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return taskDao.studentFindAll(username);
    }

    @Override
    public List<Task> search(Integer page, Integer limit, Paper paper) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        if(paper.getPaperName().length()!=0)
            paper.setPaperName('%'+paper.getPaperName()+'%');
        if(paper.getTeacherName().length()!=0)
            paper.setTeacherName('%'+paper.getTeacherName()+'%');
        if(paper.getStudentName().length()!=0)
            paper.setStudentName('%'+paper.getStudentName()+'%');
        List<Paper> paperList = paperDao.search(paper);
        List<Task> taskList = new ArrayList<>();
        for (Paper paper1 : paperList) {
            Task task = taskDao.searchByPid(paper1.getPid());
            task.setPaper(paper1);
            taskList.add(task);
        }

        return taskList;
    }

    @Override
    public Task findByPid(Integer pid) throws Exception {
        return taskDao.findByPid(pid);
    }

    @Override
    public void uploadByUsername(String username,String uri) throws Exception {
        taskDao.uploadByUsername(username,uri);
    }

    @Override
    public List<Export> export() throws Exception {
        return taskDao.export();
    }

    @Override
    public void confirmTrueByPid(Integer pid) throws Exception {
        taskDao.confirmTrueByPid(pid);
    }

    @Override
    public void confirmFalseByPid(Integer pid) throws Exception {
        taskDao.confirmFalseByPid(pid);
    }
}
