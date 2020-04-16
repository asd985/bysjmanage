package cn.njxzc.bysj.dao;


import cn.njxzc.bysj.domain.Export;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.PaperEnd;
import cn.njxzc.bysj.domain.StatusCount;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

public interface IPaperEndDao {

    @Select("select * from PaperEnd")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "status", column = "status"),
            @Result(property = "fileurl", column = "fileurl"),
            @Result(property = "paper", column = "pid", javaType = Paper.class, one = @One(select = "cn.njxzc.bysj.dao.IPaperDao.findByPid"))
    })
    List<PaperEnd> adminFindAll() throws Exception;


    @Select("select * from PaperEnd where pid in " +
            "(" +
            "   select pid from paper where teacherId=#{username} and status=3 " +
            ")")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "status", column = "status"),
            @Result(property = "fileurl", column = "fileurl"),
            @Result(property = "paper", column = "pid", javaType = Paper.class, one = @One(select = "cn.njxzc.bysj.dao.IPaperDao.findByPid"))
    })
    List<PaperEnd> teacherFindAll(@Param("username") String username) throws Exception;


    @Select("select * from PaperEnd where pid in " +
            "(" +
            "   select pid from paper where studentId=#{username} and status=3 " +
            ")")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "status", column = "status"),
            @Result(property = "fileurl", column = "fileurl"),
            @Result(property = "paper", column = "pid", javaType = Paper.class, one = @One(select = "cn.njxzc.bysj.dao.IPaperDao.findByPid"))
    })
    List<PaperEnd> studentFindAll(@Param("username") String username) throws Exception;


    @Select("select * from PaperEnd where pid=#{pid}")
    PaperEnd searchByPid(@Param("pid") Integer pid) throws Exception;


    @Select("select * from PaperEnd where pid=#{pid}")
    PaperEnd findByPid(Integer pid) throws Exception;


    @Update("UPDATE PaperEnd SET status=1,fileurl=#{uri} where pid = " +
            "(" +
            "   select pid from paper where studentId=#{username}" +
            ")")
    void uploadByUsername(@Param("username") String username, @Param("uri") String uri) throws Exception;


    @Select("select u.college,u.major,u.classname,u.username,u.name,t.status " +
            "from paper as p,PaperEnd as t,user as u " +
            "where p.pid=t.pid and u.username=p.studentId")
    List<Export> export() throws Exception;

    @Update("update PaperEnd set status=2 where pid =#{pid}")
    void confirmTrueByPid(Integer pid) throws Exception;

    @Update("update PaperEnd set status=0 where pid =#{pid}")
    void confirmFalseByPid(Integer pid) throws Exception;

    @MapKey("status")
    @Select("select IFNULL(status,0) as status,count(*) as count from PaperEnd where `status`=0 " +
            "UNION " +
            "select IFNULL(status,1),count(*) as count from PaperEnd where `status`=1 " +
            "UNION " +
            "select IFNULL(status,2),count(*) as count from PaperEnd where `status`=2 ")
    Map<Integer, StatusCount> getCount() throws Exception;
}
