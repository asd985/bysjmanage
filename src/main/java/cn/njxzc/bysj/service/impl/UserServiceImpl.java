package cn.njxzc.bysj.service.impl;

import cn.njxzc.bysj.common.BcryptPasswordEncoderUtils;
import cn.njxzc.bysj.dao.IUserDao;
import cn.njxzc.bysj.domain.UserInfo;
import cn.njxzc.bysj.service.IUserService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service("UserService")
@Transactional
public class UserServiceImpl implements IUserService {

    @Autowired
    private IUserDao userDao;

    @Override
    public List<UserInfo> findAll(int page,int limit) throws Exception {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return userDao.findAll();
    }

    @Override
    public UserInfo findByUsername(String username) throws Exception {
        return userDao.findById(username);
    }

    @Override
    public void updateByUsername(UserInfo user) throws Exception {
        userDao.updateById(user);
    }

    @Override
    public void deleteByUsername(String username) throws Exception {
        userDao.deleteById(username);
    }

    @Override
    public void save(UserInfo user) throws Exception{
        userDao.save(user);
    }

    @Override
    public List<UserInfo> search(Integer page, Integer limit, UserInfo searchParams) {
        //pageNum是页码值  pageSize是每页显示条数
        PageHelper.startPage(page, limit);
        return userDao.search(searchParams);
    }

    @Override
    public void changeStatus(String username) throws Exception {
        userDao.changeStatus(username);
    }

    @Override
    public void setPassword(UserInfo user) throws Exception {
        user.setPassword(BcryptPasswordEncoderUtils.encodePassword(user.getPassword()));
        userDao.setPassword(user);
    }

    //SpringSecurity框架认证
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserInfo userInfo = null;
        try {
            userInfo = userDao.findByUsername(username);
        } catch (Exception e) {
            e.printStackTrace();
        }
        User user = new User(userInfo.getUsername(), userInfo.getPassword(),userInfo.getStatus()==1,true,true,true, getAuthority(userInfo.getRole()) );
        return user;
    }

    //作用就是返回一个List集合，集合中装入的是角色的藐视
    public List<SimpleGrantedAuthority> getAuthority(String role){

        List<SimpleGrantedAuthority> list = new ArrayList<>();

        list.add(new SimpleGrantedAuthority("ROLE_"+role));

        return list;
    }
}
