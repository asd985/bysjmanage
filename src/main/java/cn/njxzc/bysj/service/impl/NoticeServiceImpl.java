package cn.njxzc.bysj.service.impl;

import cn.njxzc.bysj.dao.INoticeDao;
import cn.njxzc.bysj.domain.Notice;
import cn.njxzc.bysj.service.INoticeService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;


@Service
@Transactional
public class NoticeServiceImpl implements INoticeService {

    @Autowired
    private INoticeDao noticeDao;

    @Override
    public Notice findById(Integer id) throws Exception {
        return noticeDao.findById(id);
    }

    @Override
    public List<Notice> findMain() throws Exception {
        int total = 6;  //默认显示6条
        List<Notice> noticeList = new ArrayList<>();
        noticeList = noticeDao.findAll();   //从数据库查询
        return noticeList;
    }

    @Override
    public List<Notice> findAll(Integer page, Integer limit) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return noticeDao.findAll();
    }

    //新建
    @Override
    public void save(Notice notice) throws Exception {
        noticeDao.save(notice);
    }

    //更改
    @Override
    public void updateById(Notice notice) throws Exception {
        noticeDao.updateById(notice);
    }

    //删除
    @Override
    public void deleteById(Integer id) throws Exception {
        String nid = id.toString();
        noticeDao.deleteById(id);
    }


}
