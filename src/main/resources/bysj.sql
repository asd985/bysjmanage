/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1 MySQL
 Source Server Type    : MySQL
 Source Server Version : 50648
 Source Host           : localhost:3306
 Source Schema         : bysj

 Target Server Type    : MySQL
 Target Server Version : 50648
 File Encoding         : 65001

 Date: 12/04/2021 22:48:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for access
-- ----------------------------
DROP TABLE IF EXISTS `access`;
CREATE TABLE `access`  (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `access` int(4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of access
-- ----------------------------
INSERT INTO `access` VALUES (1, '选题', 'paper', 1);
INSERT INTO `access` VALUES (2, '任务书', 'task', 1);
INSERT INTO `access` VALUES (3, '开题报告', 'report', 1);
INSERT INTO `access` VALUES (4, '中期检查', 'check', 1);
INSERT INTO `access` VALUES (5, '论文初稿', 'paperFirst', 1);
INSERT INTO `access` VALUES (6, '论文终稿', 'paperEnd', 1);

-- ----------------------------
-- Table structure for midcheck
-- ----------------------------
DROP TABLE IF EXISTS `midcheck`;
CREATE TABLE `midcheck`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pid` int(11) NULL DEFAULT NULL COMMENT 'paper表pid',
  `status` int(4) NULL DEFAULT 0 COMMENT '0未开始 1待审核  2已完成',
  `fileurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `midcheck_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `paper` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of midcheck
-- ----------------------------
INSERT INTO `midcheck` VALUES (2, 41, 0, NULL);
INSERT INTO `midcheck` VALUES (3, 43, 0, NULL);
INSERT INTO `midcheck` VALUES (4, 44, 0, NULL);
INSERT INTO `midcheck` VALUES (5, 45, 0, NULL);
INSERT INTO `midcheck` VALUES (7, 48, 0, NULL);
INSERT INTO `midcheck` VALUES (8, 49, 0, NULL);
INSERT INTO `midcheck` VALUES (9, 51, 0, NULL);
INSERT INTO `midcheck` VALUES (10, 52, 0, NULL);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `createTime` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (18, 'admin', '信息工程学院2020 届本科毕业设计（论文）工作后续流程时间安排', '<p><span style=\"font-weight: bold;\">学生线下提交任务书截止日期：<span style=\"font-style: italic; text-decoration-line: underline; color: rgb(194, 79, 74);\">2019年12月6日</span></span></p><p><span style=\"font-weight: bold;\">学生在系统中提交任务书、开题报告截止时间：<span style=\"font-style: italic; text-decoration-line: underline; color: rgb(194, 79, 74);\">2019年12月26日</span>（论文系统近期开放，具体时间待通知）</span></p><p><span style=\"font-weight: bold;\">学生在系统中提交中期检查报告截止日期：<span style=\"text-decoration-line: underline; font-style: italic; color: rgb(194, 79, 74);\">2020 年 3 月 10 日</span></span></p><p><span style=\"font-weight: bold;\">学生线下提交初稿截止日期：<span style=\"font-style: italic; text-decoration-line: underline; color: rgb(194, 79, 74);\">2020年3月30日</span></span></p><p><span style=\"font-weight: bold;\">指导教师指导学生修改初稿至基本定稿、完成首次查重：2020年4月15日（查重系统开放时间待通知）</span></p><p><span style=\"font-weight: bold;\">学生系统中提交毕业设计（论文）答辩定稿截止日期：2020 年4 月25 日</span></p><p><span style=\"font-weight: bold;\">论文抽检盲审开始时间：2020年4月29日&nbsp;</span></p><p><span style=\"font-weight: bold;\">教务处反馈抽检盲审结果截止时间：2020 年 5 月 13 日&nbsp;</span></p><p><span style=\"font-weight: bold;\">学院安排答辩时间：2020 年5月16 日-2020 年6月1日&nbsp;</span></p><p><span style=\"font-weight: bold;\">成绩评定截止日期：2020 年 6月5日</span></p>', '2020-04-22 15:56:07');
INSERT INTO `notice` VALUES (19, 'admin', '关于做好 2020 届本科生毕业设计（论文）工作的通知', '<h2><span style=\"font-weight: bold;\">2020届本科毕业设计（论文）工作各流程时间安排如下：</span></h2><p><br>指导教师提供课题审核截止日期：2019年10月31日<br>学生确定选题审核截止日期：2019年11月10日<br>指导教师审核提交任务书截止日期：2019年11月30日<br>开题报告审核截止日期：2019年12月31日<br>提交中期检查报告截止日期：2020年3月10日<br>提交毕业设计（论文）答辩定稿截止日期：2020年4月25日<br>指导教师完成审核答辩稿截止日期：2020年4月28日<br>论文抽检盲审开始时间：2020年4月29日<br>教务处反馈抽检盲审结果截止时间：2020年5月13日<br>学院安排答辩时间：2020年5月16日-6月1日<br>各专业答辩、成绩评定截止日期：2020年6月5日<br>毕业设计（论文）推优、抽检、工作总结、质量分析截止日期：2020年6月10日。请同学们阅读通知和南京晓庄学院毕业设计（论文）工作管理规定（南晓院[2017]11号）等附件，根据时间节点安排好论文写作计划。</p>', '2020-04-22 16:37:24');
INSERT INTO `notice` VALUES (21, 'admin', '调整学生毕业论文进度时间段', '<h2>测试转教务处通知，考虑到疫情及学生陆续返校情况，决定调整学生毕业论文进度时间段，具体调整如下：</h2><h3><span style=\"font-weight: bold;\">学生系统提交毕业设计（论文）答辩稿（定稿）截止日期：2020 年5月2日<br></span><span style=\"font-weight: bold;\">指导教师系统中完成审核提交答辩稿截止日期：2020 年 5 月4 日<br></span><span style=\"font-weight: bold;\">论文抽检盲审开始时间：2020 年 5 月 6日<br></span><span style=\"font-weight: bold;\">教务处反馈抽检盲审结果截止时间：2020 年 5 月 13 日<br></span><span style=\"font-weight: bold;\">学院安排答辩时间：5 月 16 日-6 月 1 日<br></span><span style=\"font-weight: bold;\">各专业答辩、成绩评定截止日期：2020 年 6 月 5 日</span></h3>', '2020-04-23 17:11:42');
INSERT INTO `notice` VALUES (22, 'admin', '毕业设计（论文）查重要求', '<h3>分别引用维普和中国知网查重数据库。经由两个系统查重检测，中文撰写的毕业设计（论文）重复率均小于25%视为通过检测，外文撰写的毕业设计（论文）重复率均小于20%视为通过检测。。</h3><p><span style=\"font-weight: bold; font-style: italic;\">知网查重系统教务处已统一配置上传权限，学生查重请登录链接（<a href=\"https://pmlc.cnki.net/user/\" target=\"_blank\" style=\"background-color: rgb(194, 79, 74);\">https://pmlc.cnki.net/user/</a>），目前每位学生仅有一次查重机会。<br>如果知网查重未达标，论文充分修改后可以向学院教务办申请第二次查重机会，两次机会都用完后需自费查重。<br>登录账号：学生本人学号，密码：xz+身份证后8位。为了防止账号密码被盗，请务必提醒学生注意保密个人信息。<br>知网第二次查重权限申请方式：填写“知网第二次查重权限申请登记表”发给学委。学委注意做好登记表的留存，不可重复申请。<br>维普论文系统是提交答辩稿后自动查重（注意维普论文系统共两次查重机会，一次是提交答辩稿时，一次是提交最终稿（即答辩后按照答辩组意见修改过后的定稿）时）。<br>目前维普论文系统内提交答辩稿权限还未开放，待通知权限开放后，请先满足知网查重要求，并征得导师同意，再上传系统。</span></p><p><br></p>', '2020-04-23 17:11:49');

-- ----------------------------
-- Table structure for paper
-- ----------------------------
DROP TABLE IF EXISTS `paper`;
CREATE TABLE `paper`  (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `paperName` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课题名',
  `teacherid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '教师工号',
  `studentId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学生学号',
  `status` int(1) NOT NULL DEFAULT 0 COMMENT '状态',
  `college` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学院',
  `major` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专业',
  `classname` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '班级',
  `introduction` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '简介',
  PRIMARY KEY (`pid`) USING BTREE,
  INDEX `teacherid`(`teacherid`) USING BTREE,
  INDEX `studentId`(`studentId`) USING BTREE,
  CONSTRAINT `studentId` FOREIGN KEY (`studentId`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `teacherid` FOREIGN KEY (`teacherid`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of paper
-- ----------------------------
INSERT INTO `paper` VALUES (41, '考研院校数据可视化与分析系统', 'teacher', 'student', 3, '信工院', '', '', 'test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1vvv');
INSERT INTO `paper` VALUES (43, '基于Node平台和Vue框架的购物APP的设计与实现', NULL, 'admin', 2, '1', '', '', '111111');
INSERT INTO `paper` VALUES (44, '校内购物网站的设计与实现校内购物网站的设计与实现', 'teacher', 'student4', 3, '', '', '', '');
INSERT INTO `paper` VALUES (45, '测试课题', 'admin', NULL, 1, '', '', '', '');
INSERT INTO `paper` VALUES (48, '电子图书馆的设计与实现', 'teacher', 'student2', 3, '', '', '', '');
INSERT INTO `paper` VALUES (49, '校内二手图书交易平台的设计与实现', 'teacher', 'student1', 3, '', '', '', '');
INSERT INTO `paper` VALUES (51, 'SSM框架网上水果销售系统的设计与实现', 'teacher', NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `paper` VALUES (52, 'SSM框架网上水果销售系统的设计与实现', NULL, NULL, 0, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for paperend
-- ----------------------------
DROP TABLE IF EXISTS `paperend`;
CREATE TABLE `paperend`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pid` int(11) NULL DEFAULT NULL COMMENT 'paper表pid',
  `status` int(4) NULL DEFAULT 0 COMMENT '0未开始 1待审核  2已完成',
  `fileurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `paperend_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `paper` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of paperend
-- ----------------------------
INSERT INTO `paperend` VALUES (2, 41, 0, NULL);
INSERT INTO `paperend` VALUES (3, 43, 0, NULL);
INSERT INTO `paperend` VALUES (4, 44, 0, NULL);
INSERT INTO `paperend` VALUES (5, 45, 0, NULL);
INSERT INTO `paperend` VALUES (7, 48, 0, NULL);
INSERT INTO `paperend` VALUES (8, 49, 0, NULL);
INSERT INTO `paperend` VALUES (9, 51, 0, NULL);
INSERT INTO `paperend` VALUES (10, 52, 0, NULL);

-- ----------------------------
-- Table structure for paperfirst
-- ----------------------------
DROP TABLE IF EXISTS `paperfirst`;
CREATE TABLE `paperfirst`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pid` int(11) NULL DEFAULT NULL COMMENT 'paper表pid',
  `status` int(4) NULL DEFAULT 0 COMMENT '0未开始 1待审核  2已完成',
  `fileurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `paperfirst_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `paper` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of paperfirst
-- ----------------------------
INSERT INTO `paperfirst` VALUES (2, 41, 0, NULL);
INSERT INTO `paperfirst` VALUES (3, 43, 0, NULL);
INSERT INTO `paperfirst` VALUES (4, 44, 0, NULL);
INSERT INTO `paperfirst` VALUES (5, 45, 0, NULL);
INSERT INTO `paperfirst` VALUES (7, 48, 0, NULL);
INSERT INTO `paperfirst` VALUES (8, 49, 0, NULL);
INSERT INTO `paperfirst` VALUES (9, 51, 0, NULL);
INSERT INTO `paperfirst` VALUES (10, 52, 0, NULL);

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pid` int(11) NULL DEFAULT NULL COMMENT 'paper表pid',
  `status` int(4) NULL DEFAULT 0 COMMENT '0未开始 1待审核  2已完成',
  `fileurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `report_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `paper` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of report
-- ----------------------------
INSERT INTO `report` VALUES (2, 41, 0, NULL);
INSERT INTO `report` VALUES (3, 43, 0, NULL);
INSERT INTO `report` VALUES (4, 44, 0, NULL);
INSERT INTO `report` VALUES (5, 45, 0, NULL);
INSERT INTO `report` VALUES (7, 48, 0, NULL);
INSERT INTO `report` VALUES (8, 49, 0, NULL);
INSERT INTO `report` VALUES (9, 51, 0, NULL);
INSERT INTO `report` VALUES (10, 52, 0, NULL);

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pid` int(11) NULL DEFAULT NULL COMMENT 'paper表pid',
  `status` int(4) NULL DEFAULT 0 COMMENT '0未开始 1待审核  2已完成',
  `fileurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `pid` FOREIGN KEY (`pid`) REFERENCES `paper` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES (3, 41, 1, 'uploads/task/student/答辩记录表_2020-05-23_13-49-20.docx');
INSERT INTO `task` VALUES (4, 43, 0, NULL);
INSERT INTO `task` VALUES (5, 44, 0, NULL);
INSERT INTO `task` VALUES (6, 45, 0, NULL);
INSERT INTO `task` VALUES (8, 48, 0, NULL);
INSERT INTO `task` VALUES (9, 49, 0, NULL);
INSERT INTO `task` VALUES (10, 51, 0, NULL);
INSERT INTO `task` VALUES (11, 52, 0, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工号/学号',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `role` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色',
  `createtime` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `status` int(1) NULL DEFAULT 1 COMMENT '状态',
  `college` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学院',
  `major` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专业',
  `classname` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '班级',
  `phonenum` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  PRIMARY KEY (`username`) USING BTREE,
  INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('admin', '$2a$10$KRvR6jco323VZ06509mrrOjJ07rfNTcapXkCobPZsEbDh9NRCHX9O', '管理员', 'ADMIN', NULL, 1, '信工院1', '', '', '13033520121', 'JAVA   邮箱985587301@qq.com');
INSERT INTO `user` VALUES ('admin2', '$2a$10$3FN0HjWdcTkgLqRzz1PtYuAu2oUi5lHpRdaqUG72no3roVvyPtVcS', '管理员2', 'ADMIN', NULL, 1, '信工院', '', '', '13033520121', NULL);
INSERT INTO `user` VALUES ('student', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '学生', 'STUDENT', NULL, 1, '信工院', '软件工程', '16软工', '13033520121', NULL);
INSERT INTO `user` VALUES ('student1', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '学生1', 'STUDENT', NULL, 1, '信工院', '软件工程', '16软转2班', '13033520121', NULL);
INSERT INTO `user` VALUES ('student2', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '学生2', 'STUDENT', NULL, 1, '信工院', '软件工程', '16软转2班', '13033520121', NULL);
INSERT INTO `user` VALUES ('student3', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '学生3', 'STUDENT', NULL, 1, '信工院', '软件工程', '16软转0班', '13033520121', NULL);
INSERT INTO `user` VALUES ('student4', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '学生4', 'STUDENT', NULL, 1, '信工院', '软件工程', '16软转1班', '13033520121', NULL);
INSERT INTO `user` VALUES ('student5', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '学生5', 'STUDENT', NULL, 1, '信工院', '软件工程', '16软转2班', '13033520121', NULL);
INSERT INTO `user` VALUES ('student6', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '学生6', 'STUDENT', NULL, 1, '信工院', '软件工程', '16软转2班', '13033520121', NULL);
INSERT INTO `user` VALUES ('teacher', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '老师', 'TEACHER', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('teacher1', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '教师1', 'TEACHER', NULL, 1, '信工院', '软件工程', '', '13033520121', NULL);
INSERT INTO `user` VALUES ('teacher2', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '教师2', 'TEACHER', NULL, 1, '信工院', '软件工程', '16软转1班', '13033520121', NULL);
INSERT INTO `user` VALUES ('teacher3', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '教师3', 'TEACHER', '2020-03-05 15:31:05', 1, '信工院', '软件工程', '16软转2班', '13033520121', NULL);
INSERT INTO `user` VALUES ('teacher4', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '教师4', 'TEACHER', '2020-03-05 15:31:05', 1, '信工院', '软件工程', '16软转2班', '13033520121', NULL);
INSERT INTO `user` VALUES ('teacher5', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '教师5', 'TEACHER', '2020-03-05 15:31:05', 1, '信工院', '软件工程', '16软转2班', '13033520121', NULL);
INSERT INTO `user` VALUES ('teacher6', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '教师6', 'TEACHER', '2020-03-05 15:31:05', 1, '信工院', '软件工程', '16软转2班', '13033520121', NULL);
INSERT INTO `user` VALUES ('teacher7', '$2a$10$w/NlJF2QZb/pvAo1IserZu5NLMI/TOcSg7oS6r89ttTy9/oa3DNdK', '教师7', 'TEACHER', '2020-03-05 15:31:05', 1, '信工院', '软件工程', '16软转2班', '13033520121', NULL);
INSERT INTO `user` VALUES ('user13', '$2a$10$GZnjDebfL1ebIp2gWf13OuHh0wuSuE7MtVNK2StfrrTswbNgv/wF6', '用户13', 'STUDENT', NULL, 1, '信工院', '软件工程', '16软转2班', '13033520121', NULL);

-- ----------------------------
-- Triggers structure for table paper
-- ----------------------------
DROP TRIGGER IF EXISTS `新建论文`;
delimiter ;;
CREATE TRIGGER `新建论文` AFTER INSERT ON `paper` FOR EACH ROW begin
	insert into task(pid) values(new.pid);
	insert into report(pid) values(new.pid);
	insert into midcheck(pid) values(new.pid);
	insert into paperfirst(pid) values(new.pid);
	insert into paperend(pid) values(new.pid);
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
