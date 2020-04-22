package cn.njxzc.bysj.controller;

import cn.njxzc.bysj.common.TableResponse;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.PaperFirst;
import cn.njxzc.bysj.service.IPaperFirstService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.security.RolesAllowed;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/paperFirst")
public class PaperFirstController {

    @Autowired
    private IPaperFirstService paperFirstService;

    //任务书列表
    @RequestMapping("/findAll.do")
    @ResponseBody
    public TableResponse FindAll(@RequestParam(name="page",required = true,defaultValue = "1") Integer page, @RequestParam(name = "limit",required = true,defaultValue = "10") Integer limit) throws Exception{
        SecurityContext context = SecurityContextHolder.getContext();
        User user = (User) context.getAuthentication().getPrincipal();
        String auth = user.getAuthorities().toString();
        List<PaperFirst> paperList = null;
        if("[ROLE_ADMIN]".equals(auth)){
            paperList = paperFirstService.adminFindAll(page,limit);
        }else {
            String username = user.getUsername();
            if("[ROLE_TEACHER]".equals(auth)) {
                paperList = paperFirstService.teacherFindAll(page, limit, username);
            }else if("[ROLE_STUDENT]".equals(auth)){
                paperList = paperFirstService.studentFindAll(page, limit, username);
            }
        }
        PageInfo pageInfo = new PageInfo(paperList);
        TableResponse<List> response = new TableResponse<>(0, (int)pageInfo.getTotal(), pageInfo.getList());
        return response;
    }


    //导出
    @RolesAllowed({"ADMIN"})
    @RequestMapping("/export.do")
    @ResponseBody
    public TableResponse export() throws Exception{
        List exportList = paperFirstService.export();
        TableResponse<List> response = new TableResponse<>(0,exportList);
        return response;
    }

    //admin任务书搜索
    @RolesAllowed({"ADMIN"})
    @RequestMapping("/search.do")
    @ResponseBody
    public TableResponse search(@RequestParam(name="page",required = true,defaultValue = "1") Integer page, @RequestParam(name = "limit",required = true,defaultValue = "15") Integer limit ,String searchParams) throws Exception{
        String decode = URLDecoder.decode(searchParams, "UTF-8");
        ObjectMapper objectMapper = new ObjectMapper();
        Paper paper = objectMapper.readValue(decode, Paper.class);
        List<PaperFirst> paperList = paperFirstService.search(page,limit,paper);
        PageInfo pageInfo = new PageInfo(paperList);
        TableResponse<List> response = new TableResponse<>(0, (int)pageInfo.getTotal(), pageInfo.getList());
        return response;
    }

    //当前流程页面
    @RequestMapping("/viewByPid.do")
    public ModelAndView viewByPid(Integer pid) throws Exception{
        ModelAndView mv = new ModelAndView();
        PaperFirst paperFirst = paperFirstService.findByPid(pid);
        mv.addObject("paperFirst",paperFirst);
        mv.setViewName("paperFirst/view");
        return mv;
    }

    //上传 /uploads/paperFirst/"username"/"文件名"+"时间"+格式
    @RequestMapping("/upload.do")
    @ResponseBody
    public Map<String,Object> upload(HttpSession session, MultipartFile file){
        SecurityContext context = SecurityContextHolder.getContext();
        User user = (User) context.getAuthentication().getPrincipal();
        String username = user.getUsername();
        String baseFolder = "uploads/paperFirst";
        String folder = session.getServletContext().getRealPath(baseFolder);
        folder = folder+'/'+username;
        Map<String,Object> response= new HashMap<String,Object>();
        //空文件
        if(file.isEmpty()){
            response.put( "result", "error");
            response.put( "msg", "上传文件不能为空" );
        } else {
            String originalFilename = file.getOriginalFilename();
            String fileBaseName = FilenameUtils.getBaseName(originalFilename);
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
            String fileName = fileBaseName + "_" + df.format(new Date());
            if(originalFilename.endsWith(".doc")){
                fileName = fileName+".doc";
            }else if(originalFilename.endsWith(".docx")){
                fileName = fileName+".docx";
            }else{
                //上传错误格式
                response.put( "result", "error");
                response.put( "msg", "上传文件格式有误" );
                return response;
            }
            try {
                //创建要上传的路径
                File fdir = new File(folder);
                if (!fdir.exists()) {
                    fdir.mkdirs();
                }
                //文件上传到路径下
                FileUtils.copyInputStreamToFile(file.getInputStream(), new File(fdir, fileName));
                //coding
                response.put("result", "success");
                //保存路径到数据库
                paperFirstService.uploadByUsername(username,baseFolder+"/"+username+"/"+fileName);
            } catch (Exception e) {
                response.put("result", "error");
                response.put("msg", e.getMessage());
            }
        }
        return response;
    }

    //跳转到确认页面
    @RequestMapping("/confirmPageByPid")
    public ModelAndView confirmPageByPid(Integer pid) throws Exception{
        ModelAndView mv = new ModelAndView();
        mv.addObject("pid", pid);
        mv.setViewName("paperFirst/confirm");
        return mv;
    }

    //确认课题
    @RequestMapping("/confirmTrueByPid")
    @ResponseBody
    public String confirmTrueByPid(Integer pid) throws Exception{
        paperFirstService.confirmTrueByPid(pid);
        return "success";
    }
    //驳回课题
    @RequestMapping("/confirmFalseByPid")
    @ResponseBody
    public String confirmFalseByPid(Integer pid) throws Exception{
        paperFirstService.confirmFalseByPid(pid);
        return "success";
    }


}
