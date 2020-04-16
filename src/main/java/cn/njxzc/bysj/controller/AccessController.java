package cn.njxzc.bysj.controller;

import cn.njxzc.bysj.common.TableResponse;
import cn.njxzc.bysj.domain.Access;
import cn.njxzc.bysj.service.IAccessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.security.RolesAllowed;
import java.util.List;

@Controller
@RequestMapping("/access")
public class AccessController {

    @Autowired
    private IAccessService accessService;

    @RolesAllowed({"ADMIN"})
    @RequestMapping("/findAll.do")
    @ResponseBody
    public TableResponse findAll() throws Exception{
        List<Access> accessList = accessService.findAll();
        return new TableResponse<>(0, 0,accessList);
    }

    @RolesAllowed({"ADMIN"})
    @RequestMapping("/change.do")
    @ResponseBody
    public String change(String url) throws Exception{
        accessService.change(url);
        return "success";
    }

}
