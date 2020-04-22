package cn.njxzc.bysj.dao;

import cn.njxzc.bysj.domain.Notice;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface INoticeDao {

    @Select("select * from notice order by id desc")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
            @Result(property = "title", column = "title"),
            @Result(property = "content", column = "content"),
            @Result(property = "createTime", column = "createTime"),
            @Result(property = "name", column = "username", javaType = String.class, one = @One(select = "cn.njxzc.bysj.dao.IUserDao.findNameByUsername"))
    })
    List<Notice> findAll() throws Exception;

    @Select("select * from notice where id=#{id}")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
            @Result(property = "title", column = "title"),
            @Result(property = "content", column = "content"),
            @Result(property = "createTime", column = "createTime"),
            @Result(property = "name", column = "username", javaType = String.class, one = @One(select = "cn.njxzc.bysj.dao.IUserDao.findNameByUsername"))
    })
    Notice findById(@Param("id") Integer id) throws Exception;

    //返回插入id
    @Insert("insert into notice(title,content,username,createTime) values(#{title},#{content},#{username},NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int save(Notice notice) throws Exception;

    @Update("update notice set title=#{title},content=#{content} where id=#{id}")
    void updateById(Notice notice) throws Exception;

    @Delete("delete from notice where id=#{id}")
    void deleteById(Integer id) throws Exception;
}
