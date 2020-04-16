package cn.njxzc.bysj.controller;

import cn.njxzc.bysj.common.BcryptPasswordEncoderUtils;
import cn.njxzc.bysj.common.TableResponse;
import cn.njxzc.bysj.domain.UserInfo;
import cn.njxzc.bysj.service.IUserService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.net.URLDecoder;
import java.util.List;


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
    @RequestMapping("/changeStatus.do")
    @ResponseBody
    public String changeStatus(String username) throws Exception{
        userService.changeStatus(username);
        return "success";
    }

    //管理员根据username修改密码
    @RequestMapping("/setPassword.do")
    @ResponseBody
    public String setPassword(@RequestBody UserInfo user) throws Exception{
        userService.setPassword(user);
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
    @RequestMapping("/updateByUsername.do")
    @ResponseBody
    public String updateById(@RequestBody UserInfo user) throws Exception{
    //public void updateById(@RequestBody UserInfo user) throws Exception{
        //System.out.println(user.getName());
        userService.updateByUsername(user);
        return "success";
    }

    //根据id删除
    @RequestMapping("/deleteByUsername.do")
    @ResponseBody
    public String deleteById(String username) throws Exception{
        userService.deleteByUsername(username);
        return "success";
    }

    //新建用户
    @RequestMapping("/save.do")
    @ResponseBody
    public String save(@RequestBody UserInfo user) throws Exception{
        user.setPassword(BcryptPasswordEncoderUtils.encodePassword(user.getPassword()));
        userService.save(user);
        return "success";
    }

    //批量删除
    @RequestMapping("/deleteUsers.do")
    @ResponseBody
    public String deleteUsers(@RequestBody UserInfo[] users) throws Exception{

        for (UserInfo user : users) {
            userService.deleteByUsername(user.getUsername());
        }
        return "success";
    }

    //批量导入
    @RequestMapping("/import.do")
    @ResponseBody
    public String importUsers(@RequestBody UserInfo[] users) throws Exception{
        for (UserInfo user : users) {
            if("学号/工号".equals(user.getUsername()))  //跳过表格第一行
                continue;
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
