<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="utf-8">
    <title>编辑公告</title>
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
        <label class="layui-form-label required">隐藏id</label>
        <div class="layui-input-block">
            <input type="text" name="id" lay-verify="required" lay-reqtext="" placeholder="" value="${notice.id}" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">标题</label>
        <div class="layui-input-block">
            <input type="text" name="title" lay-verify="required" lay-reqtext="标题不能为空" placeholder="请输入标题" value="${notice.title}" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">内容</label>
        <div class="layui-input-block">
            <div id="editor" name="content"  style="margin: 50px 0 50px 0">
                ${notice.content}
            </div>
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
<script src="${pageContext.request.contextPath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['form','wangEditor'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$,
            wangEditor = layui.wangEditor;

        //富文本编辑器
        var editor = new wangEditor('#editor');
        editor.customConfig.uploadImgServer = "../api/upload.json";
        editor.customConfig.uploadFileName = 'image';
        editor.customConfig.pasteFilterStyle = false;
        editor.customConfig.uploadImgMaxLength = 5;
        editor.customConfig.uploadImgHooks = {
            // 上传超时
            timeout: function (xhr, editor) {
                layer.msg('上传超时！')
            },
            // 如果服务器端返回的不是 {errno:0, data: [...]} 这种格式，可使用该配置
            customInsert: function (insertImg, result, editor) {
                console.log(result);
                if (result.code == 1) {
                    var url = result.data.url;
                    url.forEach(function (e) {
                        insertImg(e);
                    })
                } else {
                    layer.msg(result.msg);
                }
            }
        };
        editor.customConfig.customAlert = function (info) {
            layer.msg(info);
        };
        editor.create();

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            // 读取 editor的html
            data.field.content=editor.txt.html();

            $.ajax({
                type:"POST",
                url:"${pageContext.request.contextPath}/notice/updateById.do",
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