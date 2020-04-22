<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <title>公告浏览</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table', 'util'], function () {
        var $ = layui.jquery,
            util = layui.util,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/notice/findAll.do',
            defaultToolbar:false,
            cols: [[
                {field: 'id', title: 'ID', hide:true},
                {field: 'title', title: '标题'},
                {field: 'name', width: 200, title: '发布人'},
                {field: 'createTime', width: 200, title: '发布时间',templet: function(d){return util.toDateString(d.createTime, "yyyy-MM-dd HH:mm:ss");}}
            ]],
            limits: [5, 10, 15, 20],
            limit: 10,
            page: true
        });

        //监听行单击事件
        table.on('row(currentTableFilter)', function(obj){
            console.log(obj.data);//得到当前行数据
            var data = obj.data;
            var title = data.title,
                noticeTime = util.toDateString(data.createTime, "yyyy-MM-dd HH:mm:ss"),
                content = data.content;
            var html = '<div style="padding:15px 20px; text-align:justify; line-height: 22px;border-bottom:1px solid #e2e2e2;background-color: #2f4056;color: #ffffff">\n' +
                '<div style="text-align: center;margin-bottom: 20px;font-weight: bold;border-bottom:1px solid #718fb5;padding-bottom: 5px"><h4 class="text-danger">' + title + '</h4></div>\n' +
                '<div style="font-size: 12px">' + content + '</div>\n' +
                '</div>\n';
            parent.layer.open({
                type: 1,
                title: '系统公告'+'<span style="float: right;right: 1px;font-size: 12px;color: #b1b3b9;margin-top: 1px">'+noticeTime+'</span>',
                area: ['700px'],
                shade: 0.8,
                id: 'layuimini-notice',
                btn: [ '关闭'],
                btnAlign: 'c',
                moveType: 1,
                content:html
            });
            //obj.del(); //删除当前行
            //obj.update(fields) //修改当前行数据
        });
    });
</script>
<script>

</script>

</body>
</html>