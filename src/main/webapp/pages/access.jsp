<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <title>主页一</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<style>
    .main_btn > p {height:40px;}
    .layui-top-box {padding:40px 40px 40px 40px;color:#fff}
</style>
<body>

<div class="layuimini-container">
    <div class="layuimini-main layui-top-box">
        <table class="layui-hide" id="access"></table>
    </div>
</div>



<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>

<script type="text/html" id="switchTpl">
    <input type="checkbox" name="checked" value="{{d.url}}" lay-skin="switch" lay-text="开启|关闭" lay-filter="accessChange" {{d.access==1?'checked':''}}>
</script>

<script>
    layui.use('table', function(){
        var table = layui.table
            ,form = layui.form
            ,$ = layui.jquery;

        table.render({
            elem: '#access'
            ,url:'${pageContext.request.contextPath}/access/findAll.do'
            ,cols: [[
                {type:'numbers'}
                ,{field:'url', title:'流程'}
                ,{field:'name',title:'流程名'}
                ,{field:'access', title:'状态', width:120, templet: '#switchTpl', unresize: true}
            ]]
        });

        //监听修改状态操作
        form.on('switch(accessChange)', function(data){
            //获取url
            //console.log(data.value);
            $.ajax({
                type:"GET",
                url:"${pageContext.request.contextPath}/access/change.do?url="+data.value,
                error:function () {
                    layer.alert('修改失败',function () {
                        window.location.reload();
                    });
                }
            });
        });

    });
</script>

</body>
</html>