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
            <input type="text" name="pid" lay-verify="required" lay-reqtext="" placeholder="" value="${paper.pid}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">课题名</label>
        <div class="layui-input-block">
            <input type="text" name="paperName" readonly="readonly" lay-verify="required" lay-reqtext="课题名不能为空" placeholder="请输入课题名" value="${paper.paperName}" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">简介</label>
        <div class="layui-input-block">
            <textarea name="introduction" readonly="readonly" placeholder="请输入简介" class="layui-textarea" >${paper.introduction}</textarea>
        </div>
    </div>
    <%--<div style="padding: 20px; background-color: #F2F2F2;">
        <div class="layui-row layui-col-space15">

            <div class="layui-col-md12">
                <div class="layui-card">
                    <div class="layui-card-header">标题</div>
                    <div class="layui-card-body">
                        ${paper.introduction}
                    </div>
                </div>
            </div>
        </div>
    </div>--%>
</div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
</body>
</html>