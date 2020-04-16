package cn.njxzc.bysj.controller;

import cn.njxzc.bysj.common.TableResponse;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.service.IPaperService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/paper")
public class PaperController {

    @Autowired
    private IPaperService paperService;

    //查找所有
    @RequestMapping("/findAll.do")
    @ResponseBody
    public TableResponse findAll(@RequestParam(name="page",required = true,defaultValue = "1") Integer page, @RequestParam(name = "limit",required = true,defaultValue = "10") Integer limit) throws Exception{
        List<Paper> paperList = paperService.findAll(page,limit);
        PageInfo pageInfo = new PageInfo(paperList);
        TableResponse<List> response = new TableResponse<>(0, (int)pageInfo.getTotal(), pageInfo.getList());
        return response;
    }

    //查找本人课题
    @RequestMapping("/findMine.do")
    @ResponseBody
    public TableResponse findMine(@RequestParam(name="page",required = true,defaultValue = "1") Integer page, @RequestParam(name = "limit",required = true,defaultValue = "10") Integer limit) throws Exception{
        String teacherId = null;
        String studentId = null;
        //SpringSecurity获取操作的用户信息
        SecurityContext context = SecurityContextHolder.getContext();
        User user = (User) context.getAuthentication().getPrincipal();
        String username = user.getUsername();
        String auth = user.getAuthorities().toString();

        if("[ROLE_TEACHER]".equals(auth))
            teacherId = username;
        else if("[ROLE_STUDENT]".equals(auth))
            studentId = username;
        List<Paper> paperList = paperService.findMine(page,limit,teacherId,studentId);
        PageInfo pageInfo = new PageInfo(paperList);
        TableResponse<List> response = new TableResponse<>(0, (int)pageInfo.getTotal(), pageInfo.getList());
        return response;
    }

    //查找所有未审批的
    @RequestMapping("/findAllReview.do")
    @ResponseBody
    public TableResponse findAllReview(@RequestParam(name="page",required = true,defaultValue = "1") Integer page, @RequestParam(name = "limit",required = true,defaultValue = "10") Integer limit) throws Exception{
        List<Paper> paperList = paperService.findAllReview(page,limit);
        PageInfo pageInfo = new PageInfo(paperList);
        TableResponse<List> response = new TableResponse<>(0, (int)pageInfo.getTotal(), pageInfo.getList());
        return response;
    }

    //学生选题 查找所有已审核的
    @RequestMapping("/stuFindAllReviewed.do")
    @ResponseBody
    public TableResponse stuFindAllReviewed(@RequestParam(name="page",required = true,defaultValue = "1") Integer page, @RequestParam(name = "limit",required = true,defaultValue = "10") Integer limit) throws Exception{
        List<Paper> paperList = paperService.stuFindAllReviewed(page,limit);
        PageInfo pageInfo = new PageInfo(paperList);
        TableResponse<List> response = new TableResponse<>(0, (int)pageInfo.getTotal(), pageInfo.getList());
        return response;
    }
    //教师选题 查找所有已审核的
    @RequestMapping("/teaFindAllReviewed.do")
    @ResponseBody
    public TableResponse teaFindAllReviewed(@RequestParam(name="page",required = true,defaultValue = "1") Integer page, @RequestParam(name = "limit",required = true,defaultValue = "10") Integer limit) throws Exception{
        List<Paper> paperList = paperService.teaFindAllReviewed(page,limit);
        PageInfo pageInfo = new PageInfo(paperList);
        TableResponse<List> response = new TableResponse<>(0, (int)pageInfo.getTotal(), pageInfo.getList());
        return response;
    }

    //
    @RequestMapping("/findByPid.do")
    public ModelAndView findByPid(Integer pid) throws Exception{
        ModelAndView mv = new ModelAndView();
        Paper paper = paperService.findByPid(pid);
        mv.addObject("paper", paper);
        mv.setViewName("paper/edit");
        return mv;
    }

    @RequestMapping("/findMineByPid.do")
    public ModelAndView findMineByPid(Integer pid) throws Exception{
        ModelAndView mv = new ModelAndView();
        Paper paper = paperService.findByPid(pid);
        mv.addObject("paper", paper);
        mv.setViewName("paper/edit-mine");
        return mv;
    }

    //查看简介
    @RequestMapping("/detailByPid.do")
    public ModelAndView detailByPid(Integer pid) throws Exception{
        ModelAndView mv = new ModelAndView();
        Paper paper = paperService.findByPid(pid);
        mv.addObject("paper", paper);
        mv.setViewName("paper/detail");
        return mv;
    }

    //选题
    @RequestMapping("/Select.do")
    @ResponseBody
    public Map<String,Object> Select(Integer pid) throws Exception{
        SecurityContext context = SecurityContextHolder.getContext();
        User user = (User) context.getAuthentication().getPrincipal();
        Integer status = paperService.Select(user.getUsername(),user.getAuthorities().toString(), pid);
        Map<String,Object> response = new HashMap<>();
        if(status==1){
            response.put("status","ok");
            response.put("msg","选题成功");
        }
        else {
            response.put("status", "err");
            response.put("msg","手慢啦，选题失败");
        }
        return response;
    }

    //根据pid修改
    @RequestMapping("/updateByPid.do")
    @ResponseBody
    public String updateById(@RequestBody Paper paper) throws Exception{
        paperService.updateByPid(paper);
        return "success";
    }

    @RequestMapping("/updateMineByPid.do")
    @ResponseBody
    public String updateMineByPid(@RequestBody Paper paper) throws Exception{
        paperService.updateMineByPid(paper);
        return "success";
    }
    //新建课题
    @RequestMapping("/save.do")
    @ResponseBody
    public String save(@RequestBody Paper paper) throws Exception{
        paperService.save(paper);
        return "success";
    }

    //新建本人的课题
    @RequestMapping("/saveMine.do")
    @ResponseBody
    public String saveMine(@RequestBody Paper paper) throws Exception{
        /*SecurityContext context = SecurityContextHolder.getContext();
        User user = (User) context.getAuthentication().getPrincipal();
        String username = user.getUsername();
        String auth = user.getAuthorities().toString();
        if()*/
        paperService.save(paper);
        return "success";
    }

    //根据pid删除
    @RequestMapping("/deleteByPid.do")
    @ResponseBody
    public String deleteByPid(Integer pid) throws Exception{
        paperService.deleteByPid(pid);
        return "success";
    }

    //修改课题状态
    @RequestMapping("/changeStatus.do")
    @ResponseBody
    public String changeStatus(Integer pid) throws Exception{
        paperService.changeStatus(pid);
        return "success";
    }

    //批量删除
    @RequestMapping("/deletePapers.do")
    @ResponseBody
    public String deletePapers(@RequestBody Paper[] papers) throws Exception{

        for (Paper paper : papers) {
            paperService.deleteByPid(paper.getPid());
        }
        return "success";
    }

    //批量审批
    @RequestMapping("/reviewPapers.do")
    @ResponseBody
    public String reviewPapers(@RequestBody Paper[] papers) throws Exception{

        for (Paper paper : papers) {
            paperService.reviewByPid(paper.getPid());
        }
        return "success";
    }

    //搜索
    @RequestMapping("/search.do")
    @ResponseBody
    public TableResponse search(@RequestParam(name="page",required = true,defaultValue = "1") Integer page, @RequestParam(name = "limit",required = true,defaultValue = "15") Integer limit ,String searchParams) throws Exception{
        String decode = URLDecoder.decode(searchParams, "UTF-8");
        ObjectMapper objectMapper = new ObjectMapper();
        Paper paper = objectMapper.readValue(decode, Paper.class);
        if(paper.getPaperName().length()!=0)
            paper.setPaperName('%'+paper.getPaperName()+'%');
        if(paper.getStudentName().length()!=0)
            paper.setTeacherName('%'+paper.getStudentName()+'%');
        if(paper.getTeacherName().length()!=0)
            paper.setTeacherName('%'+paper.getTeacherName()+'%');
        List<Paper> paperList = paperService.search(page,limit,paper);
        PageInfo pageInfo = new PageInfo(paperList);
        TableResponse<List> response = new TableResponse<>(0, (int)pageInfo.getTotal(), pageInfo.getList());
        return response;
    }

    //学生选题搜索
    @RequestMapping("/selectStudentSearch.do")
    @ResponseBody
    public TableResponse selectStudentSearch(@RequestParam(name="page",required = true,defaultValue = "1") Integer page, @RequestParam(name = "limit",required = true,defaultValue = "15") Integer limit ,String searchParams) throws Exception{
        String decode = URLDecoder.decode(searchParams, "UTF-8");
        ObjectMapper objectMapper = new ObjectMapper();
        Paper paper = objectMapper.readValue(decode, Paper.class);
        if(paper.getTeacherName().length()!=0)
            paper.setTeacherName('%'+paper.getTeacherName()+'%');
        if(paper.getPaperName().length()!=0)
            paper.setPaperName('%'+paper.getPaperName()+'%');
        List<Paper> paperList = paperService.selectStudentSearch(page,limit,paper);
        PageInfo pageInfo = new PageInfo(paperList);
        TableResponse<List> response = new TableResponse<>(0, (int)pageInfo.getTotal(), pageInfo.getList());
        return response;
    }

    //教师选题搜索
    @RequestMapping("/selectTeacherSearch.do")
    @ResponseBody
    public TableResponse selectTeacherSearch(@RequestParam(name="page",required = true,defaultValue = "1") Integer page, @RequestParam(name = "limit",required = true,defaultValue = "15") Integer limit ,String searchParams) throws Exception{
        String decode = URLDecoder.decode(searchParams, "UTF-8");
        ObjectMapper objectMapper = new ObjectMapper();
        Paper paper = objectMapper.readValue(decode, Paper.class);
        if(paper.getPaperName().length()!=0)
            paper.setPaperName('%'+paper.getPaperName()+'%');
        if(paper.getStudentName().length()!=0)
            paper.setStudentName('%'+paper.getStudentName()+'%');
        List<Paper> paperList = paperService.selectTeacherSearch(page,limit,paper);
        PageInfo pageInfo = new PageInfo(paperList);
        TableResponse<List> response = new TableResponse<>(0, (int)pageInfo.getTotal(), pageInfo.getList());
        return response;
    }

    //跳转到确认页面
    @RequestMapping("/confirmPageByPid")
    public ModelAndView confirmPageByPid(Integer pid) throws Exception{
        ModelAndView mv = new ModelAndView();
        mv.addObject("pid", pid);
        mv.setViewName("paper/confirm-mine");
        return mv;
    }

    //确认课题
    @RequestMapping("/confirmTrueByPid")
    @ResponseBody
    public String confirmTrueByPid(Integer pid) throws Exception{
        paperService.confirmTrueByPid(pid);
        return "success";
    }
    //驳回课题
    @RequestMapping("/confirmFalseByPid")
    @ResponseBody
    public String confirmFalseByPid(Integer pid) throws Exception{
        paperService.confirmFalseByPid(pid);
        return "success";
    }

}
