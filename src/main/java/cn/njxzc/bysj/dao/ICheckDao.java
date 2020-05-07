package cn.njxzc.bysj.dao;


import cn.njxzc.bysj.domain.Check;
import cn.njxzc.bysj.domain.Export;
import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.StatusCount;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

public interface ICheckDao {

    @Select("select * from midcheck")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "status", column = "status"),
            @Result(property = "fileurl", column = "fileurl"),
            @Result(property = "paper", column = "pid", javaType = Paper.class, one = @One(select = "cn.njxzc.bysj.dao.IPaperDao.findByPid"))
    })
    List<Check> adminFindAll() throws Exception;


    @Select("select * from midcheck where pid in " +
            "(" +
            "   select pid from paper where teacherId=#{username} and status=3 " +
            ")")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "status", column = "status"),
            @Result(property = "fileurl", column = "fileurl"),
            @Result(property = "paper", column = "pid", javaType = Paper.class, one = @One(select = "cn.njxzc.bysj.dao.IPaperDao.findByPid"))
    })
    List<Check> teacherFindAll(@Param("username") String username) throws Exception;


    @Select("select * from midcheck where pid in " +
            "(" +
            "   select pid from paper where studentId=#{username} and status=3 " +
            ")")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "status", column = "status"),
            @Result(property = "fileurl", column = "fileurl"),
            @Result(property = "paper", column = "pid", javaType = Paper.class, one = @One(select = "cn.njxzc.bysj.dao.IPaperDao.findByPid"))
    })
    List<Check> studentFindAll(@Param("username") String username) throws Exception;


    @Select("select * from midcheck where pid=#{pid}")
    Check searchByPid(@Param("pid") Integer pid) throws Exception;


    @Select("select * from midcheck where pid=#{pid}")
    Check findByPid(Integer pid) throws Exception;


    @Update("UPDATE midcheck SET status=1,fileurl=#{uri} where pid = " +
            "(" +
            "   select pid from paper where studentId=#{username}" +
            ")")
    void uploadByUsername(@Param("username") String username, @Param("uri") String uri) throws Exception;


    @Select("select u.college,u.major,u.classname,u.username,u.name,t.status " +
            "from paper as p,midcheck as t,user as u " +
            "where p.pid=t.pid and u.username=p.studentId")
    List<Export> export() throws Exception;

    @Update("update midcheck set status=2 where pid =#{pid}")
    void confirmTrueByPid(Integer pid) throws Exception;

    @Update("update midcheck set status=0 where pid =#{pid}")
    void confirmFalseByPid(Integer pid) throws Exception;

    @MapKey("status")
    @Select("select IFNULL(t1.status,0) as status,count(*) as count " +
            "from midcheck as t1 left join paper as t2 on t1.pid=t2.pid " +
            "where t1.status=0 and t2.teacherId is not NULL and t2.studentId is not NULL " +
            "UNION " +
            "select IFNULL(t1.status,1),count(*) as count " +
            "from midcheck as t1 left join paper as t2 on t1.pid=t2.pid " +
            "where t1.status=1 and t2.teacherId is not NULL and t2.studentId is not NULL " +
            "UNION " +
            "select IFNULL(t1.status,2),count(*) as count " +
            "from midcheck as t1 left join paper as t2 on t1.pid=t2.pid " +
            "where t1.status=2 and t2.teacherId is not NULL and t2.studentId is not NULL ")
    Map<Integer, StatusCount> getCount() throws Exception;
}
