<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">
    <div class="layui-form-item layui-hide">
        <label class="layui-form-label required">隐藏pid</label>
        <div class="layui-input-block">
            <input type="text" name="pid" lay-verify="required" lay-reqtext="" placeholder="" value="${pid}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button type="button" class="layui-btn layui-btn-lg layui-btn-radius layui-btn-normal data-confirmTrue" >确认</button>
            <button type="button" class="layui-btn layui-btn-lg layui-btn-radius  layui-btn-danger data-confirmFalse" >驳回</button>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
</body>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;
        // 监听确认操作
        $(".data-confirmTrue").on("click", function () {
            $.get("${pageContext.request.contextPath}/paperFirst/confirmTrueByPid.do?pid="+${pid},function () {
                layer.msg("确认成功");
                window.parent.location.reload();
            });
            $(window).on("resize", function () {
                layer.full(index);
            });
            return false;
        });
        // 监听驳回操作
        $(".data-confirmFalse").on("click", function () {
            $.get("${pageContext.request.contextPath}/paperFirst/confirmFalseByPid.do?pid="+${pid},function () {
                layer.msg("驳回成功");
                window.parent.location.reload();
            });
            $(window).on("resize", function () {
                layer.full(index);
            });
            return false;
        });
    });
</script>
</html>