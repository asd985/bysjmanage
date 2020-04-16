package cn.njxzc.bysj.dao;


import cn.njxzc.bysj.domain.Export;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.PaperFirst;
import cn.njxzc.bysj.domain.StatusCount;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

public interface IPaperFirstDao {

    @Select("select * from PaperFirst")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "status", column = "status"),
            @Result(property = "fileurl", column = "fileurl"),
            @Result(property = "paper", column = "pid", javaType = Paper.class, one = @One(select = "cn.njxzc.bysj.dao.IPaperDao.findByPid"))
    })
    List<PaperFirst> adminFindAll() throws Exception;


    @Select("select * from PaperFirst where pid in " +
            "(" +
            "   select pid from paper where teacherId=#{username} and status=3 " +
            ")")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "status", column = "status"),
            @Result(property = "fileurl", column = "fileurl"),
            @Result(property = "paper", column = "pid", javaType = Paper.class, one = @One(select = "cn.njxzc.bysj.dao.IPaperDao.findByPid"))
    })
    List<PaperFirst> teacherFindAll(@Param("username") String username) throws Exception;


    @Select("select * from PaperFirst where pid in " +
            "(" +
            "   select pid from paper where studentId=#{username} and status=3 " +
            ")")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "status", column = "status"),
            @Result(property = "fileurl", column = "fileurl"),
            @Result(property = "paper", column = "pid", javaType = Paper.class, one = @One(select = "cn.njxzc.bysj.dao.IPaperDao.findByPid"))
    })
    List<PaperFirst> studentFindAll(@Param("username") String username) throws Exception;


    @Select("select * from PaperFirst where pid=#{pid}")
    PaperFirst searchByPid(@Param("pid") Integer pid) throws Exception;


    @Select("select * from PaperFirst where pid=#{pid}")
    PaperFirst findByPid(Integer pid) throws Exception;


    @Update("UPDATE PaperFirst SET status=1,fileurl=#{uri} where pid = " +
            "(" +
            "   select pid from paper where studentId=#{username}" +
            ")")
    void uploadByUsername(@Param("username") String username, @Param("uri") String uri) throws Exception;


    @Select("select u.college,u.major,u.classname,u.username,u.name,t.status " +
            "from paper as p,PaperFirst as t,user as u " +
            "where p.pid=t.pid and u.username=p.studentId")
    List<Export> export() throws Exception;

    @Update("update PaperFirst set status=2 where pid =#{pid}")
    void confirmTrueByPid(Integer pid) throws Exception;

    @Update("update PaperFirst set status=0 where pid =#{pid}")
    void confirmFalseByPid(Integer pid) throws Exception;

    @MapKey("status")
    @Select("select IFNULL(status,0) as status,count(*) as count from PaperFirst where `status`=0 " +
            "UNION " +
            "select IFNULL(status,1),count(*) as count from PaperFirst where `status`=1 " +
            "UNION " +
            "select IFNULL(status,2),count(*) as count from PaperFirst where `status`=2 ")
    Map<Integer, StatusCount> getCount() throws Exception;
}
