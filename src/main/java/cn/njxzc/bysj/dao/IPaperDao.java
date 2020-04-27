package cn.njxzc.bysj.dao;

import cn.njxzc.bysj.domain.Paper;
import cn.njxzc.bysj.domain.Process;
import cn.njxzc.bysj.domain.StatusCount;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

public interface IPaperDao {
    /*private Integer pid;
    private String paperName;
    private String college;
    private String major;
    private String className;
    private String introduction;
    private int status;         //状态
    private String teacherId;
    private String studentId;

    //userInfo表中name
    private String teacherName;
    private String studentName;*/
    //@Select("select paper.*,u1.name as teacherName,u2.name as studentName from paper LEFT JOIN user as u1 ON teacherId=u1.username LEFT JOIN user as u2 ON  studentId=u2.username")
    @Select("select * from paper")
    @Results({
            @Result(id = true, property = "pid", column = "pid"),
            @Result(property = "paperName", column = "paperName"),
            @Result(property = "college", column = "college"),
            @Result(property = "major", column = "major"),
            @Result(property = "className", column = "className"),
            @Result(property = "introduction", column = "introduction"),
            @Result(property = "status", column = "status"),
            @Result(property = "teacherId", column = "teacherId"),
            @Result(property = "studentId", column = "studentId"),
            @Result(property = "teacherName", column = "teacherId",
                    javaType = String.class, one = @One(select = "cn.njxzc.bysj.dao.IUserDao.findNameByUsername")),
            @Result(property = "studentName", column = "studentId",
                    javaType = String.class, one = @One(select = "cn.njxzc.bysj.dao.IUserDao.findNameByUsername"))
    })
    List<Paper> findAll() throws Exception;

    @Select("select * from paper where pid = #{pid}")
    @Results({
            @Result(id = true, property = "pid", column = "pid"),
            @Result(property = "paperName", column = "paperName"),
            @Result(property = "college", column = "college"),
            @Result(property = "major", column = "major"),
            @Result(property = "className", column = "className"),
            @Result(property = "introduction", column = "introduction"),
            @Result(property = "status", column = "status"),
            @Result(property = "teacherId", column = "teacherId"),
            @Result(property = "studentId", column = "studentId"),
            @Result(property = "teacherName", column = "teacherId",
                    javaType = String.class, one = @One(select = "cn.njxzc.bysj.dao.IUserDao.findNameByUsername")),
            @Result(property = "studentName", column = "studentId",
                    javaType = String.class, one = @One(select = "cn.njxzc.bysj.dao.IUserDao.findNameByUsername"))
    })
    Paper findByPid(Integer pid) throws Exception;

    @Update("<script>" +
            "update paper set paperName=#{paperName}," +
            "<if test='teacherId!=\"\"'>teacherId=#{teacherId},</if>" +
            "<if test='teacherId==\"\"'>teacherId=NULL,</if>" +
            "<if test='studentId!=\"\"'>studentId=#{studentId},</if>" +
            "<if test='studentId==\"\"'>studentId=NULL,</if>" +
            "college=#{college},major=#{major},className=#{className},introduction=#{introduction} " +
            "where pid=#{pid}" +
            "</script>")
    void updateByPid(Paper paper) throws Exception;

    @Insert("insert into paper(paperName,teacherId,studentId,college,major,className,introduction) values(#{paperName},#{teacherId},#{studentId},#{college},#{major},#{className},#{introduction})")
    void save(Paper paper) throws Exception;

    @Delete("delete from paper where pid=#{pid}")
    void deleteByPid(Integer pid) throws Exception;

    //搜索
    @Select("<script>" +
            "select paper.*,u1.name as teacherName,u2.name as studentName from paper " +
            "LEFT JOIN user as u1 ON teacherId=u1.username " +
            "LEFT JOIN user as u2 ON studentId=u2.username " +
            "where 1=1 " +
            "<if test='paperName!=\"\"'>and paperName like #{paperName} </if> " +
            "<if test='teacherName!=\"\"'>and u1.name like #{teacherName} </if> " +
            "<if test='studentName!=\"\"'>and u2.name like #{studentName} </if>" +
            "</script>")
    List<Paper> search(Paper paper) throws Exception;

    //学生选题搜索
    @Select("<script>" +
            "select paper.*,u1.name as teacherName from paper " +
            "LEFT JOIN user as u1 ON teacherId=u1.username " +
            "where paper.status=1 " +
            "<if test='paperName!=\"\"'>and paperName like #{paperName} </if> " +
            "<if test='teacherName!=\"\"'>and u1.name like #{teacherName} </if> " +
            "</script>")
    List<Paper> selectStudentSearch(Paper paper) throws Exception;

    //教师选题搜索
    @Select("<script>" +
            "select paper.*,u1.name as studentName from paper " +
            "LEFT JOIN user as u1 ON studentId=u1.username " +
            "where paper.status=1 " +
            "<if test='paperName!=\"\"'>and paperName like #{paperName} </if> " +
            "<if test='studentName!=\"\"'>and u1.name like #{studentName} </if> " +
            "</script>")
    List<Paper> selectTeacherSearch(Paper paper) throws Exception;

    //修改课题状态
    @Update("update paper set status=ABS(status-1) where pid=#{pid}")
    void changeStatus(Integer pid) throws Exception;

    //查找所有未审核
    @Select("select paper.*,u1.name as teacherName,u2.name as studentName from paper" +
            " LEFT JOIN user as u1 ON teacherId=u1.username" +
            " LEFT JOIN user as u2 ON  studentId=u2.username" +
            " where paper.status=0")
    List<Paper> findAllReview() throws Exception;

    //根据pid审核
    @Update("update paper set status=1 where pid=#{pid}")
    void reviewByPid(Integer pid) throws Exception;

    //修改本人课题
    @Update("update paper set paperName=#{paperName},college=#{college},major=#{major},className=#{className},introduction=#{introduction} where pid=#{pid}")
    void updateMineByPid(Paper paper) throws Exception;

    //本人课题
    @Select("<script>" +
            "select paper.*,u1.name as teacherName,u2.name as studentName from paper" +
            " LEFT JOIN user as u1 ON teacherId=u1.username" +
            " LEFT JOIN user as u2 ON  studentId=u2.username" +
            " where 1=1" +
            "<if test='teacherId!=null'> and teacherId=#{teacherId}</if>" +
            "<if test='studentId!=null'> and studentId=#{studentId}</if>" +
            "</script>")
    List<Paper> findMine(@Param("teacherId") String teacherId,@Param("studentId") String studentId) throws Exception;

    @Select("select status from paper where pid=#{pid}")
    Integer findStatusByPid(Integer pid) throws Exception;

    //学生选课
    @Update("<script>" +
            "update paper set status=2," +
            "<if test='auth==\"[ROLE_TEACHER]\"'>teacherId=#{username}</if>" +
            "<if test='auth==\"[ROLE_STUDENT]\"'>studentId=#{username}</if>" +
            " where pid=#{pid}" +
            "</script>")
    void Select(@Param("username")String username, @Param("auth")String auth, @Param("pid")Integer pid) throws Exception;

    @Select("select paper.*,user.name as teacherName from paper " +
            "LEFT JOIN user ON teacherId=user.username " +
            "where paper.status=1 and teacherId is not null " )
    List<Paper> stuFindAllReviewed() throws Exception;

    @Select("select paper.*,user.name as studentName from paper " +
            "LEFT JOIN user ON studentId=user.username " +
            "where paper.status=1 and studentId is not null " )
    List<Paper> teaFindAllReviewed() throws Exception;

    @Update("update paper set status=3 where pid =#{pid}")
    void confirmTrueByPid(Integer pid) throws Exception;

    @Update("update paper set status=1 where pid =#{pid}")
    void confirmFalseByPid(Integer pid) throws Exception;

    //总人数 status=4  完成人数 status=3
    @MapKey("status")
    @Select("select IFNULL(NULL,4) as status, COUNT(*) as count from user where role='STUDENT' " +
            "UNION " +
            "select IFNULL(status,3),COUNT(*) from paper where `status`=3 ")
    Map<Integer, StatusCount> getCount() throws Exception;

    @Select("SELECT " +
            "p.paperName,p.studentid,u.name AS studentName,u.college,u.major,u.classname,p.teacherid,u2.name AS teacherName,task.status AS taskStatus,report.status AS reportStatus,midcheck.status AS checkStatus,paperfirst.status AS paperfirstStatus,paperend.status AS paperendStatus " +
            "FROM " +
            "paper AS p INNER JOIN user AS u ON p.studentid = u.username " +
            "INNER JOIN user AS u2 ON p.teacherid = u2.username " +
            "LEFT JOIN task ON task.pid=p.pid " +
            "LEFT JOIN report ON report.pid=p.pid " +
            "LEFT JOIN midcheck ON midcheck.pid=p.pid " +
            "LEFT JOIN paperfirst ON paperfirst.pid=p.pid " +
            "LEFT JOIN paperend ON paperend.pid=p.pid")
    List<Process> findProcess();

}
