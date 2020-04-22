package cn.njxzc.bysj.dao;

import cn.njxzc.bysj.domain.UserInfo;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface IUserDao {

    //查询所有用户信息
    @Select("select * from user")
    List<UserInfo> findAll() throws Exception;

    @Select("select * from user where username=#{username}")
    UserInfo findByUsername(String username) throws Exception;

    //根据id查询用户
    @Select("select * from user where username=#{username}")
    UserInfo findById(String username) throws Exception;

    //根据id查询姓名
    @Select("select name from user where username=#{username}")
    String findNameByUsername(String username) throws Exception;

    //编辑用户信息
    @Update("update user set name=#{name},phoneNum=#{phoneNum},college=#{college},major=#{major},className=#{className},role=#{role} where username=#{username}")
    void updateById(UserInfo user) throws Exception;

    //根据Id删除
    @Delete("delete from user where username=#{username}")
    void deleteById(String username);

    //新建用户
    @Insert("insert into user(username,password,name,phoneNum,college,major,className,role) values(#{username},#{password},#{name},#{phoneNum},#{college},#{major},#{className},#{role})")
    void save(UserInfo user);

    //根据username、name搜索
    @Select("select * from user where username like #{username} and name like #{name}")
    List<UserInfo> search(UserInfo searchParams);

    //修改用户状态
    @Update("update user set status=ABS(status-1) where username=#{username}")
    void changeStatus(String username) throws Exception;

    //管理员修改用户密码
    @Update("update user set password=#{password} where username=#{username}")
    void setPassword(UserInfo user) throws Exception;

    @Update("update user set phoneNum=#{phoneNum}, remark=#{remark} where username=#{username}")
    void update(UserInfo user);
}
