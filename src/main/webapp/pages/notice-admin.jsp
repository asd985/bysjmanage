<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <title>公告管理</title>
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
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm data-add-btn"> 添加公告 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit"  lay-event="edit"  >编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete"  lay-event="delete">删除</a>
        </script>

    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table', 'util'], function () {
        var $ = layui.jquery,
            util = layui.util,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/notice/findAll.do',
            toolbar: '#toolbarDemo',
            defaultToolbar:false,
            cols: [[
                {field: 'id', title: 'ID', hide:true},
                {field: 'title', width: '60%', title: '标题'},
                {field: 'name', width: '10%', title: '发布人'},
                {field: 'createTime', width: '10%', title: '发布时间',templet: function(d){return util.toDateString(d.createTime, "yyyy-MM-dd HH:mm:ss");}},
                {title: '操作', width: 190, templet: '#currentTableBar', fixed: "right", align: "center"}
            ]],
            limits: [5, 10, 15, 20],
            limit: 10,
            page: true,
            done: function () {
                bindTableToolbarFunction();
            }
        });

        //tool编辑、删除功能
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            var tr = obj.tr;
            //console.log(obj)
            if (obj.event === 'edit') {

                var index = layer.open({
                    title: '编辑公告',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['80%', '600px'],
                    content: '${pageContext.request.contextPath}/notice/findById.do?id='+data.id
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                layui.close(obj);//防止row事件
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('确认删除？', function (index) {

                    $.get("${pageContext.request.contextPath}/notice/deleteById.do?id="+data.id,function () {
                        layer.alert("删除成功");
                        obj.del();
                        layer.close(index);
                    });
                });
                layui.close(obj);//防止row事件
                return false;
            }
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


// ==================== 解决table.reload后toolbar失效问题 ====================
        // 绑定事件集合处理(表格加载完毕和表格刷新的时候调用)
        function bindTableToolbarFunction() {
            // 监听添加操作
            $(".data-add-btn").on("click", function () {

                var index = layer.open({
                    title: '添加公告',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['80%', '600px'],
                    content: '${pageContext.request.contextPath}/pages/notice/add.jsp'
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            });

        }
    });
</script>
<script>

</script>

</body>
</html>