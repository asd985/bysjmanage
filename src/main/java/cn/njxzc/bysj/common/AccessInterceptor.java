package cn.njxzc.bysj.common;

import cn.njxzc.bysj.service.IAccessService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

@Controller
public class AccessInterceptor implements HandlerInterceptor {

    @Autowired
    private IAccessService accessService;

    //前置
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //SpringSecurity获取操作的用户信息
        SecurityContext context = SecurityContextHolder.getContext();
        User user = (User) context.getAuthentication().getPrincipal();
        String auth = user.getAuthorities().toString();
        //管理员不拦截
        if("[ROLE_ADMIN]".equals(auth))
            return true;

        String path = request.getServletPath().split("/")[1];   // "/task/findAll.do"
        //查询数据库，放行
        if (1==accessService.accessByUrl(path))
            return true;

        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");
        PrintWriter writer = response.getWriter();
        JSONObject o = new JSONObject();
        o.put("msg", "当前时间段不可进行该操作");
        o.put("code", "1");
        writer.write(o.toString());
        return false;
    }

}
