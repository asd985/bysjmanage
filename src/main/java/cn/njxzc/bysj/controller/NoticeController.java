package cn.njxzc.bysj.controller;

import cn.njxzc.bysj.common.TableResponse;
import cn.njxzc.bysj.domain.Notice;
import cn.njxzc.bysj.service.INoticeService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private INoticeService noticeService;

    /*@RequestMapping("/findById.do")
    @ResponseBody
    public Notice findById(Integer id) throws Exception{
        return noticeService.findById(id);
    }*/

    //主页公告预览
    @RequestMapping("/findMain.do")
    @ResponseBody
    public TableResponse findMain() throws Exception{
        List<Notice> noticeList = noticeService.findMain();
        TableResponse<List<Notice>> response = new TableResponse<>(0, 0, noticeList);
        return response;
    }

    //查找所有
    @RequestMapping("/findAll.do")
    @ResponseBody
    public TableResponse findAll(@RequestParam(name="page",required = true,defaultValue = "1") Integer page, @RequestParam(name = "limit",required = true,defaultValue = "10") Integer limit) throws Exception{
        List<Notice> paperList = noticeService.findAll(page,limit);
        PageInfo pageInfo = new PageInfo(paperList);
        TableResponse<List> response = new TableResponse<>(0, (int)pageInfo.getTotal(), pageInfo.getList());
        return response;
    }

    //新建
    @RequestMapping("/save.do")
    @ResponseBody
    public String save(@RequestBody Notice notice) throws Exception{
        SecurityContext context = SecurityContextHolder.getContext();
        User user = (User) context.getAuthentication().getPrincipal();
        String username = user.getUsername();
        notice.setUsername(username);
        noticeService.save(notice);
        return "success";
    }

    //跳转编辑页面
    @RequestMapping("/findById.do")
    public ModelAndView findEditById(Integer id) throws Exception{
        ModelAndView mv = new ModelAndView();
        Notice notice = noticeService.findById(id);
        mv.addObject("notice", notice);
        mv.setViewName("notice/edit");
        return mv;
    }

    //根据id修改
    @RequestMapping("/updateById.do")
    @ResponseBody
    public String updateById(@RequestBody Notice notice) throws Exception{
        noticeService.updateById(notice);
        return "success";
    }

    //根据pid删除
    @RequestMapping("/deleteById.do")
    @ResponseBody
    public String deleteById(Integer id) throws Exception{
        noticeService.deleteById(id);
        return "success";
    }
}
