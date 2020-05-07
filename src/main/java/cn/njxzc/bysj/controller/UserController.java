package cn.njxzc.bysj.controller;

import cn.njxzc.bysj.common.BcryptPasswordEncoderUtils;
import cn.njxzc.bysj.common.TableResponse;
import cn.njxzc.bysj.domain.UserInfo;
import cn.njxzc.bysj.service.IUserService;
import com.fasterxml.jackson.databind.ObjectMapper;
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

import javax.annotation.security.RolesAllowed;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private IUserService userService;

    //查询所有用户
    @RequestMapping("/findAll.do")
    @ResponseBody
    public TableResponse findAll(@RequestParam(name="page",required = true,defaultValue = "1") Integer page, @RequestParam(name = "limit",required = true,defaultValue = "10") Integer limit) throws Exception{
        List<UserInfo> userList = userService.findAll(page,limit);
        PageInfo pageInfo = new PageInfo(userList);
        TableResponse<List> response = new TableResponse<>(0, (int)pageInfo.getTotal(), pageInfo.getList());
        return response;
    }

    //修改会员状态
    @RolesAllowed({"ADMIN"})
    @RequestMapping("/changeStatus.do")
    @ResponseBody
    public String changeStatus(String username) throws Exception{
        userService.changeStatus(username);
        return "success";
    }

    //管理员根据username修改密码
    @RolesAllowed({"ADMIN"})
    @RequestMapping("/setPassword.do")
    @ResponseBody
    public String setPassword(@RequestBody UserInfo user) throws Exception{
        userService.setPassword(user);
        return "success";
    }

    //修改密码
    @RequestMapping("/updatePassword.do")
    @ResponseBody
    public TableResponse updatePassword(@RequestBody Map<String,String> map) throws Exception{
        TableResponse tableResponse = null;
        String oldPassword = map.get("oldPassword");
        String newPassword = map.get("newPassword");
        String againPassword = map.get("againPassword");
        SecurityContext context = SecurityContextHolder.getContext();
        User user = (User) context.getAuthentication().getPrincipal();
        if(!newPassword.equals(againPassword)){
            tableResponse = new TableResponse(0, "两次输入密码不一致");
            return tableResponse;
        }
        UserInfo userInfo = userService.findByUsername(user.getUsername());
        if(!BcryptPasswordEncoderUtils.matches(oldPassword, userInfo.getPassword())){
            tableResponse = new TableResponse(0, "旧密码错误");
            return tableResponse;
        }
        userInfo.setPassword(newPassword);
        userService.setPassword(userInfo);
        tableResponse = new TableResponse(0, "修改成功,请重新登录");
        return tableResponse;
    }

    //跳转本人资料修改页面
    @RequestMapping("/userSetting.do")
    public ModelAndView userSetting() throws Exception{
        ModelAndView mv = new ModelAndView();
        SecurityContext context = SecurityContextHolder.getContext();
        User user = (User) context.getAuthentication().getPrincipal();
        UserInfo userInfo = userService.findByUsername(user.getUsername());
        mv.addObject("user",userInfo);
        mv.setViewName("user-setting");
        return mv;
    }

    @RequestMapping("/update.do")
    @ResponseBody
    public String update(@RequestBody UserInfo user) throws Exception{
        UserInfo update = new UserInfo();
        SecurityContext context = SecurityContextHolder.getContext();
        User contextUser = (User) context.getAuthentication().getPrincipal();
        update.setUsername(contextUser.getUsername());
        //只能修改手机号和备注
        update.setPhoneNum(user.getPhoneNum());
        update.setRemark(user.getRemark());
        userService.update(user);
        return "success";
    }

    //根据Id查找
    @RequestMapping("/findByUsername.do")
    public ModelAndView findByUsername(String username) throws Exception{
        ModelAndView mv = new ModelAndView();
        UserInfo user = userService.findByUsername(username);
        mv.addObject("user", user);
        mv.setViewName("user/edit");
        return mv;
    }

    //根据id修改
    @RolesAllowed({"ADMIN"})
    @RequestMapping("/updateByUsername.do")
    @ResponseBody
    public String updateById(@RequestBody UserInfo user) throws Exception{
    //public void updateById(@RequestBody UserInfo user) throws Exception{
        //System.out.println(user.getName());
        userService.updateByUsername(user);
        return "success";
    }

    //根据id删除
    @RolesAllowed({"ADMIN"})
    @RequestMapping("/deleteByUsername.do")
    @ResponseBody
    public String deleteById(String username) throws Exception{
        userService.deleteByUsername(username);
        return "success";
    }

    //新建用户
    @RolesAllowed({"ADMIN"})
    @RequestMapping("/save.do")
    @ResponseBody
    public String save(@RequestBody UserInfo user) throws Exception{
        user.setPassword(BcryptPasswordEncoderUtils.encodePassword(user.getPassword()));
        userService.save(user);
        return "success";
    }

    //批量删除
    @RolesAllowed({"ADMIN"})
    @RequestMapping("/deleteUsers.do")
    @ResponseBody
    public String deleteUsers(@RequestBody UserInfo[] users) throws Exception{

        for (UserInfo user : users) {
            userService.deleteByUsername(user.getUsername());
        }
        return "success";
    }

    //批量导入
    @RolesAllowed({"ADMIN"})
    @RequestMapping("/import.do")
    @ResponseBody
    public String importUsers(@RequestBody UserInfo[] users) throws Exception{
        for (UserInfo user : users) {
            if("学号/工号".equals(user.getUsername()))  //跳过表格第一行
                continue;
            user.setPassword(BcryptPasswordEncoderUtils.encodePassword(user.getPassword()));
            userService.save(user);
        }
        return "success";
    }

    //搜索用户
    @RequestMapping("/search.do")
    @ResponseBody
    public TableResponse search(@RequestParam(name="page",required = true,defaultValue = "1") Integer page, @RequestParam(name = "limit",required = true,defaultValue = "15") Integer limit ,String searchParams) throws Exception{
        String decode = URLDecoder.decode(searchParams, "UTF-8");
        ObjectMapper mapper = new ObjectMapper();
        UserInfo userInfo = mapper.readValue(decode, UserInfo.class);
        userInfo.setUsername('%'+userInfo.getUsername()+'%');
        userInfo.setName('%'+userInfo.getName()+'%');
        List<UserInfo> userList = userService.search(page,limit,userInfo);
        PageInfo pageInfo = new PageInfo(userList);
        TableResponse<List> response = new TableResponse<>(0, (int)pageInfo.getTotal(), pageInfo.getList());
        return response;
    }

}
