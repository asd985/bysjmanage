package cn.njxzc.bysj.service.impl;

import cn.njxzc.bysj.dao.INoticeDao;
import cn.njxzc.bysj.domain.Notice;
import cn.njxzc.bysj.service.INoticeService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;


@Service
@Transactional
public class NoticeServiceImpl implements INoticeService {

    @Autowired
    private INoticeDao noticeDao;

    @Autowired
    private RedisTemplate template;

    @Override
    public Notice findById(Integer id) throws Exception {
        String nid = id.toString();
        Notice notice = (Notice) template.opsForHash().get("Notice",nid);
        if(notice==null){
            System.out.println("当前查询id为空，查询mysql.....");
            notice = noticeDao.findById(id);
            if(notice!=null){
                template.opsForHash().put("Notice",nid,notice);
                System.out.println("插入redis....");
            }
        }
        return notice;
    }

    @Override
    public List<Notice> findMain() throws Exception {
        int total = 6;  //默认显示6条
        List<Notice> noticeList = new ArrayList<>();
        Set mainNotice = template.opsForZSet().reverseRange("Notices", 0, total - 1);//倒序
        if(mainNotice.isEmpty()){   //redis为空
            noticeList = noticeDao.findAll();   //从数据库查询
            if(!noticeList.isEmpty()){          //数据库有数据
                for (Notice notice : noticeList) {
                    template.opsForZSet().add("Notices", notice, notice.getId());
                }
            }
        }
        mainNotice = template.opsForZSet().reverseRange("Notices", 0, total - 1);//重新查redis
        System.out.println(mainNotice);
        noticeList.clear(); //清空
        for (Object notice : mainNotice) {
            noticeList.add((Notice) notice);
        }
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
        notice = noticeDao.findById(notice.getId());
        template.opsForZSet().add("Notices", notice, notice.getId());
        System.out.println("插入redis....");
    }

    //更改
    @Override
    public void updateById(Notice notice) throws Exception {
        String nid = notice.getId().toString();
        noticeDao.updateById(notice);
        template.opsForHash().delete("Notice",nid);
        template.opsForZSet().removeRangeByScore("Notices",notice.getId(),notice.getId());
        template.opsForZSet().add("Notices", notice, notice.getId());
    }

    //删除
    @Override
    public void deleteById(Integer id) throws Exception {
        String nid = id.toString();
        noticeDao.deleteById(id);
        template.opsForHash().delete("Notice",nid);
        template.opsForZSet().removeRangeByScore("Notices",id,id);
        System.out.println("从redis移除....");
    }


}
