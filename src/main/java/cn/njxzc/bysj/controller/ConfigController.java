package cn.njxzc.bysj.controller;

import cn.njxzc.bysj.domain.Notice;
import cn.njxzc.bysj.domain.StatusCount;
import cn.njxzc.bysj.service.IConfigService;
import cn.njxzc.bysj.service.INoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/config")
public class ConfigController {

    @Autowired
    private IConfigService configService;

    @Autowired
    private INoticeService noticeService;

    @RequestMapping("/init.do")
    public String init() throws Exception{
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if("anonymousUser".equals(principal)) {
            //model.addAttribute("name","anonymous");
            return "forward:login";
        }else {
            User user = (User) principal;
            //model.addAttribute("name",user.getUsername());
            String auth = user.getAuthorities().toArray()[0].toString();
            if (auth.equals("ROLE_ADMIN"))
                return "redirect:/api/init_admin.json";
            else if (auth.equals("ROLE_TEACHER"))
                return "redirect:/api/init_tea.json";
            else if (auth.equals("ROLE_STUDENT"))
                return "redirect:/api/init_stu.json";
            else
                return null;
        }
    }

    @RequestMapping("/main.do")
    public ModelAndView main() throws Exception{
        ModelAndView mv = new ModelAndView();
        Map<String, Map<Integer,StatusCount>> count = configService.getCount();
        List<Notice> noticeList = noticeService.findMain();
        mv.addObject("noticeList",noticeList);
        mv.addObject("count", count);
        mv.setViewName("main");
        return mv;
    }

    //清空redis缓存
    @RequestMapping("/clear.do")
    public String clear() throws Exception{
        configService.clear();
        return "redirect:/api/clear.json";
    }
}
