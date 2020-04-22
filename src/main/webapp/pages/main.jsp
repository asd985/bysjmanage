<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ page import="cn.njxzc.bysj.domain.StatusCount" %>
<%@ page import="java.util.Map" %> 
<html>
<head>
    <meta charset="utf-8">
    <title>首页</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        .layui-card {border:1px solid #f2f2f2;border-radius:5px;}
        .icon {margin-right:10px;color:#1aa094;}
        .icon-tip {color:#ff5722!important;}
        .layuimini-qiuck-module a i {display:inline-block;width:100%;height:60px;line-height:60px;text-align:center;border-radius:2px;font-size:30px;background-color:#F8F8F8;color:#333;transition:all .3s;-webkit-transition:all .3s;}
        .layuimini-qiuck-module a cite {position:relative;top:2px;display:block;color:#666;text-overflow:ellipsis;overflow:hidden;white-space:nowrap;font-size:14px;}
        .panel {background-color:#fff;border:1px solid transparent;border-radius:3px;-webkit-box-shadow:0 1px 1px rgba(0,0,0,.05);box-shadow:0 1px 1px rgba(0,0,0,.05)}
        .panel-body {padding:10px}
        .panel-title {margin-top:0;margin-bottom:0;font-size:12px;color:inherit}
        .label {display:inline;padding:.2em .6em .3em;font-size:75%;font-weight:700;line-height:1;color:#fff;text-align:center;white-space:nowrap;vertical-align:baseline;border-radius:.25em;margin-top: .3em;}
        .main_btn > p {height:40px;}
        .layuimini-notice:hover {background:#f6f6f6;}
        .layuimini-notice {padding:7px 16px;clear:both;font-size:12px !important;cursor:pointer;position:relative;transition:background 0.2s ease-in-out;}
        .layuimini-notice-title,.layuimini-notice-label {
            padding-right: 70px !important;text-overflow:ellipsis!important;overflow:hidden!important;white-space:nowrap!important;}
        .layuimini-notice-title {line-height:28px;font-size:14px;}
        .layuimini-notice-extra {position:absolute;top:50%;margin-top:-8px;right:16px;display:inline-block;height:16px;color:#999;}


    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md15">
                <div class="layui-row layui-col-space15">
                    <security:authorize access="hasRole('ADMIN')">
                    <div class="layui-col-md12">
                        <div class="layui-card">
                            <div class="layui-card-header"><i class="fa fa-warning icon"></i>数据统计</div>
                            <div class="layui-card-body">
                                <div class="layuimini-main layui-top-box">
                                    <div class="layui-row layui-col-space15">
                                        <div class="layui-col-md2">
                                            <div class="col-xs-4 col-md-2">
                                                <div class="panel layui-bg-cyan">
                                                    <div class="panel-body">
                                                        <div class="panel-title">
                                                            <span class="label pull-right layui-bg-blue">实时</span>
                                                            <h2>论文选题</h2>
                                                        </div>
                                                        <div class="panel-content">
                                                            <h3>总学生数：<%=((Map<String, Map<Integer, StatusCount>>)request.getAttribute("count")).get("paper").get(4).getCount()%></h3>
                                                            <h3>已完成选题：<%=((Map<String, Map<Integer, StatusCount>>)request.getAttribute("count")).get("paper").get(3).getCount()%></h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-md2">
                                            <div class="col-xs-4 col-md-2">
                                                <div class="panel layui-bg-cyan">
                                                    <div class="panel-body">
                                                        <div class="panel-title">
                                                            <span class="label pull-right layui-bg-blue">实时</span>
                                                            <h2>任务书</h2>
                                                        </div>
                                                        <div class="panel-content">
                                                            <h3>未开始：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("task").get(0).getCount()%></h3>
                                                            <h3>进行中：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("task").get(1).getCount()%></h3>
                                                            <h3>已完成：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("task").get(2).getCount()%></h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-md2">
                                            <div class="col-xs-4 col-md-2">
                                                <div class="panel layui-bg-cyan">
                                                    <div class="panel-body">
                                                        <div class="panel-title">
                                                            <span class="label pull-right layui-bg-blue">实时</span>
                                                            <h2>开题报告</h2>
                                                        </div>
                                                        <div class="panel-content">
                                                            <h3>未开始：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("report").get(0).getCount()%></h3>
                                                            <h3>进行中：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("report").get(1).getCount()%></h3>
                                                            <h3>已完成：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("report").get(2).getCount()%></h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-md2">
                                            <div class="col-xs-4 col-md-2">
                                                <div class="panel layui-bg-cyan">
                                                    <div class="panel-body">
                                                        <div class="panel-title">
                                                            <span class="label pull-right layui-bg-blue">实时</span>
                                                            <h2>中期检查</h2>
                                                        </div>
                                                        <div class="panel-content">
                                                            <h3>未开始：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("check").get(0).getCount()%></h3>
                                                            <h3>进行中：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("check").get(1).getCount()%></h3>
                                                            <h3>已完成：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("check").get(2).getCount()%></h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-md2">
                                            <div class="col-xs-4 col-md-2">
                                                <div class="panel layui-bg-cyan">
                                                    <div class="panel-body">
                                                        <div class="panel-title">
                                                            <span class="label pull-right layui-bg-blue">实时</span>
                                                            <h2>论文初稿</h2>
                                                        </div>
                                                        <div class="panel-content">
                                                            <h3>未开始：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("paperFirst").get(0).getCount()%></h3>
                                                            <h3>进行中：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("paperFirst").get(1).getCount()%></h3>
                                                            <h3>已完成：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("paperFirst").get(2).getCount()%></h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-md2">
                                            <div class="col-xs-4 col-md-2">
                                                <div class="panel layui-bg-cyan">
                                                    <div class="panel-body">
                                                        <div class="panel-title">
                                                            <span class="label pull-right layui-bg-blue">实时</span>
                                                            <h2>论文终稿</h2>
                                                        </div>
                                                        <div class="panel-content">
                                                            <h3>未开始：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("paperEnd").get(0).getCount()%></h3>
                                                            <h3>进行中：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("paperEnd").get(1).getCount()%></h3>
                                                            <h3>已完成：<%=((Map<String, Map<Integer, StatusCount>>) request.getAttribute("count")).get("paperEnd").get(2).getCount()%></h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </security:authorize>
                    <div class="layui-col-md12">
                        <div class="layui-card">
                            <div class="layui-card-header"><i class="fa fa-bullhorn icon icon-tip"></i>最新公告</div>
                            <div class="layui-card-body layui-text" id="notice">
                                <c:if test="${empty noticeList}">
                                    当前没有任何公告！
                                </c:if>
                                <c:forEach items="${noticeList}" var="notice" >
                                    <div class="layuimini-notice">
                                        <div class="layuimini-notice-title">标  题：${notice.title}</div>
                                        <div class="layuimini-notice-username">发布者：${notice.name}</div>
                                        <div class="layuimini-notice-extra">${notice.createTime}</div>
                                        <div class="layuimini-notice-content layui-hide">
                                            ${notice.content}
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['layer', 'miniTab','echarts'], function () {
        var $ = layui.jquery,
            miniTab = layui.miniTab;

        miniTab.listen();

        /**
         * 查看公告信息
         **/
        $('body').on('click', '.layuimini-notice', function () {
            var title = $(this).children('.layuimini-notice-title').text(),
                noticeTime = $(this).children('.layuimini-notice-extra').text(),
                content = $(this).children('.layuimini-notice-content').html();
            var html = '<div style="padding:15px 20px; text-align:justify; line-height: 22px;border-bottom:1px solid #e2e2e2;background-color: #2f4056;color: #ffffff">\n' +
                '<div style="text-align: center;margin-bottom: 20px;font-weight: bold;border-bottom:1px solid #718fb5;padding-bottom: 5px"><h4 class="text-danger">' + title + '</h4></div>\n' +
                '<div style="font-size: 12px">' + content + '</div>\n' +
                '</div>\n';
            parent.layer.open({
                type: 1,
                title: '系统公告'+'<span style="float: right;right: 1px;font-size: 12px;color: #b1b3b9;margin-top: 1px">'+noticeTime+'</span>',
                area: '300px;',
                shade: 0.8,
                id: 'layuimini-notice',
                btn: ['查看', '取消'],
                btnAlign: 'c',
                moveType: 1,
                content:html,
                success: function (layero) {
                    var btn = layero.find('.layui-layer-btn');
                    btn.find('.layui-layer-btn0').attr({
                        href: 'https://gitee.com/zhongshaofa/layuimini',
                        target: '_blank'
                    });
                }
            });
        });


    });
</script>
</body>
</html>
