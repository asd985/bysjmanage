package cn.njxzc.bysj.dao;

import cn.njxzc.bysj.domain.Access;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface IAccessDao {

    @Select("select access from access where url = #{url}")
    int accessByUrl(@Param("url") String url);

    @Select("select * from access")
    List<Access> findAll() throws Exception;

    @Update("update access set access=ABS(access-1) where url=#{url}")
    void change(String url) throws Exception;
}
