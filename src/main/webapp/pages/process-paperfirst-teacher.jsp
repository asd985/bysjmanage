<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <title>论文初稿</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <!-- 自定义模板加入表单元素 -->
        <script type="text/html" id="paperStatus">
            {{d.status==0?'未开始':''}}
            {{d.status==1?'<a class="layui-btn layui-btn-xs data-wait-confirm" lay-event="confirm">待审核</a>':''}}
            {{d.status==2?'已完成':''}}
        </script>


        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-detail" lay-event="detail">课题详情</a>
            <a class="layui-btn layui-btn-xs data-count-detail" lay-event="view">论文初稿</a>
        </script>

    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    layui.config({
        base: '${pageContext.request.contextPath}/js/lay-module/layui_exts/'
    }).extend({
        excel: 'excel'
    });
</script>
<script>
    layui.use(['form', 'table', 'excel'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table,
            excel = layui.excel,
            layuimini = layui.layuimini;

        table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/paperFirst/findAll.do',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print'],
            cols: [[
                {type: "checkbox", width: 50, fixed: "left", align: "center"},
                {field: 'pid', width: 80, title: 'ID', sort: true, templet: '<div>{{d.paper.pid}}</div>'},
                {field: 'paperName', width: 400, title: '课题名', templet: '<div>{{d.paper.paperName?d.paper.paperName:""}}</div>'},
                {field: 'status', width: 120, title: '状态', templet:'#paperStatus'},
                {field: 'college', width: 150,title: '指定系别', sort: true, templet: '<div>{{d.paper.college?d.paper.college:""}}</div>'},
                {field: 'major', width: 150, title: '指定专业', sort: true, templet: '<div>{{d.paper.major?d.paper.major:""}}</div>'},
                {field: 'className', width: 150, title: '指定班级', sort: true, templet: '<div>{{d.paper.className?d.paper.className:""}}</div>'},
                {field: 'teacherName', width: 150, title: '指导教师', sort: true, templet: '<div>{{d.paper.teacherName?d.paper.teacherName:""}}</div>'},
                {field: 'teacherId', width: 150, title: '教师工号', sort: true, templet: '<div>{{d.paper.teacherId?d.paper.teacherId:""}}</div>'},
                {field: 'studentName', width: 150, title: '选题学生', sort: true, templet: '<div>{{d.paper.studentName?d.paper.studentName:""}}</div>'},
                {field: 'studentId', width: 150, title: '学生学号', sort: true, templet: '<div>{{d.paper.studentId?d.paper.studentId:""}}</div>'},
                {title: '操作', minWidth: 160, templet: '#currentTableBar', fixed: "right", align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 10,
            page: true
        });


        //tool功能
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            var tr = obj.tr;
            if (obj.event === 'view') {
                var index = layer.open({
                    title: '论文初稿',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['50%', '40%'],
                    content: '${pageContext.request.contextPath}/paperFirst/viewByPid.do?pid='+data.paper.pid
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'detail') {
                var index = layer.open({
                    title: '课题详情',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['50%', '40%'],
                    content: '${pageContext.request.contextPath}/paper/detailByPid.do?pid='+data.paper.pid
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'confirm') {
                var index = layer.open({
                    title: '待确认',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['550', '130'],
                    content: '${pageContext.request.contextPath}/paperFirst/confirmPageByPid.do?pid='+data.paper.pid
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            }
        });
    });
</script>
<script>

</script>

</body>
</html>