package cn.njxzc.bysj.service;

import cn.njxzc.bysj.domain.Paper;

import java.util.List;

public interface IPaperService {
    List<Paper> findAll(int page, int limit) throws Exception;

    Paper findByPid(Integer pid) throws Exception;

    void updateByPid(Paper paper) throws Exception;

    void save(Paper paper) throws Exception;

    void deleteByPid(Integer pid) throws Exception;

    List<Paper> search(Integer page, Integer limit, Paper paper) throws Exception;

    List<Paper> selectStudentSearch(Integer page, Integer limit, Paper paper) throws Exception;

    List<Paper> selectTeacherSearch(Integer page, Integer limit, Paper paper) throws Exception;

    void changeStatus(Integer pid) throws Exception;

    List<Paper> findAllReview(Integer page, Integer limit) throws Exception;

    void reviewByPid(Integer pid) throws Exception;

    void updateMineByPid(Paper paper) throws Exception;

    List<Paper> findMine(Integer page, Integer limit, String teacherId, String studentId) throws Exception;

    Integer Select(String username, String auth, Integer pid) throws Exception;

    List<Paper> stuFindAllReviewed(Integer page, Integer limit) throws Exception;

    List<Paper> teaFindAllReviewed(Integer page, Integer limit) throws Exception;

    void confirmTrueByPid(Integer pid) throws Exception;

    void confirmFalseByPid(Integer pid) throws Exception;

}
