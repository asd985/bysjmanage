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
    <div class="layui-form-item">
        <label class="layui-form-label required">课题名</label>
        <div class="layui-input-block">
            <input type="text" name="paperName" lay-verify="required" lay-reqtext="课题名不能为空" placeholder="请输入课题名" value="" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label ">指导教师工号</label>
        <div class="layui-input-block">
            <input type="text" name="teacherId"   placeholder="请输入教师工号" value="" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label ">选题学生学号</label>
        <div class="layui-input-block">
            <input type="text" name="studentId"  placeholder="请输入学生学号" value="" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">限定系别</label>
        <div class="layui-input-block">
            <input type="text" name="college" placeholder="请输入系别" value="" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">限定专业</label>
        <div class="layui-input-block">
            <input type="text" name="major" placeholder="请输入专业" value="" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">限定班级</label>
        <div class="layui-input-block">
            <input type="text" name="className" placeholder="请输入班级" value="" class="layui-input">
        </div>
    </div>
    <%--<div class="layui-form-item">
        <label class="layui-form-label">简介</label>
        <div class="layui-input-block">
            <input type="text" name="introduction" placeholder="请输入简介" value="" class="layui-input">
        </div>
    </div>--%>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">简介</label>
        <div class="layui-input-block">
            <textarea name="introduction" placeholder="请输入简介" class="layui-textarea" ></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="saveBtn">确认保存</button>
        </div>
    </div>
</div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;

        //监听提交
        form.on('submit(saveBtn)', function (data) {

            $.ajax({
                type:"POST",
                url:"${pageContext.request.contextPath}/paper/save.do",
                contentType: "application/json;charset=UTF-8", //必须这样写
                data:JSON.stringify(data.field),
                success:function () {
                    var index = layer.alert("保存成功！", {
                        //title: '最终的提交信息'
                    }, function () {

                        // 关闭弹出层
                        layer.close(index);
                        var iframeIndex = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(iframeIndex);
                        //修改成功后刷新父界面
                        window.parent.location.reload();
                    });
                    return false;
                },
                error:function () {
                    layer.msg('保存失败');
                }
            });

            return false;
        });

    });
</script>
</body>
</html>