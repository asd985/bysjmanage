package cn.njxzc.bysj.service;

import cn.njxzc.bysj.domain.UserInfo;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface IUserService extends UserDetailsService {


    List<UserInfo> findAll(int page, int limit) throws Exception;

    UserInfo findByUsername(String username) throws Exception;

    void updateByUsername(UserInfo user) throws Exception;

    void deleteByUsername(String username) throws Exception;

    void save(UserInfo user) throws Exception;

    List<UserInfo> search(Integer page, Integer limit, UserInfo searchParams);

    void changeStatus(String username) throws Exception;

    void setPassword(UserInfo user) throws Exception;

    void update(UserInfo user);
}
