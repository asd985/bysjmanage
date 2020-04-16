<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <title>我的课题</title>
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
            <%--<input type="checkbox" name="status" value=${paper.status} lay-skin="switch" lay-text="已审核|待审核" ${ paper.status == 1 ? 'checked' : '' }>--%>
            <%--<input type="checkbox" name="checked" value={{d.pid}} lay-skin="switch" lay-filter="changeStatus" lay-text="已审核|待审核" disabled {{d.status==1?'checked':''}}>--%>
            {{d.status==0?'待审核':''}}
            {{d.status==1?'已审核':''}}
            {{d.status==2?'<a class="layui-btn layui-btn-xs data-wait-confirm" lay-event="confirm">待确认</a>':''}}
            {{d.status==3?'已确认':''}}
        </script>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm data-add-btn"> 添加课题 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn"> 删除课题 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-detail" lay-event="detail">查看</a>
            <a class="layui-btn layui-btn-xs data-count-edit"  lay-event="edit"  >编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete"  lay-event="delete">删除</a>
        </script>

    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table,
            layuimini = layui.layuimini;

        table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/paper/findMine.do',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print'],
            cols: [[
                {type: "checkbox", width: 50, fixed: "left", align: "center"},
                {field: 'pid', width: 80, title: 'ID', sort: true},
                {field: 'paperName', width: 400, title: '课题名'},
                {field: 'status', width: 80, title: '状态', templet:'#paperStatus'},
                {field: 'teacherName', width: 150, title: '指导教师', sort: true},
                {field: 'teacherId', width: 150, title: '教师工号', sort: true},
                {field: 'studentName', width: 150, title: '选题学生', sort: true},
                {field: 'studentId', width: 150, title: '学生学号', sort: true},
                {field: 'college', width: 150,title: '指定系别', sort: true},
                {field: 'major', width: 150, title: '指定专业', sort: true},
                {field: 'className', width: 150, title: '指定班级', sort: true},
                {title: '操作', minWidth: 160, templet: '#currentTableBar', fixed: "right", align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
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
                    title: '编辑课题',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['50%', '80%'],
                    content: '${pageContext.request.contextPath}/paper/findMineByPid.do?pid='+data.pid
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('确认删除？', function (index) {

                    $.get("${pageContext.request.contextPath}/paper/deleteByPid.do?pid="+data.pid,function () {
                        layer.alert("删除成功");
                        obj.del();
                        layer.close(index);
                    });

                });
            } else if (obj.event === 'detail') {
                var index = layer.open({
                    title: '课题详情',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['50%', '40%'],
                    content: '${pageContext.request.contextPath}/paper/detailByPid.do?pid='+data.pid
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
                    content: '${pageContext.request.contextPath}/paper/confirmPageByPid.do?pid='+data.pid
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } /*else if (obj.event === 'confirmTrue') {
                $.get("${pageContext.request.contextPath}/paper/confirmTrueByPid.do?pid="+data.pid,function () {
                    layer.msg("确认成功");
                    window.location.reload();
                });//
            } else if (obj.event === 'confirmFalse') {
                $.get("${pageContext.request.contextPath}/paper/confirmFalseByPid.do?pid="+data.pid,function () {
                    layer.msg("驳回成功");
                    window.location.reload();
                });//
            }*/
        });
// ==================== 解决table.reload后toolbar失效问题 ====================
        // 绑定事件集合处理(表格加载完毕和表格刷新的时候调用)
        function bindTableToolbarFunction() {
            // 监听添加操作
            $(".data-add-btn").on("click", function () {

                var index = layer.open({
                    title: '添加课题',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['40%', '80%'],
                    content: '${pageContext.request.contextPath}/pages/paper/add-mine.jsp',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });

                return false;
            });


            // 监听删除操作
            $(".data-delete-btn").on("click", function () {
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                if(JSON.stringify(data)=='[]')
                    layer.alert('未选择任何数据！');
                else {
                    $.ajax({
                        type:"POST",
                        url:"${pageContext.request.contextPath}/paper/deletePapers.do",
                        contentType: "application/json;charset=UTF-8", //必须这样写
                        data:JSON.stringify(data),
                        success:function () {
                            layer.alert("删除成功！",function () {
                                window.location.reload();
                            });

                        }
                    });
                }
            });

            //监听表格复选框选择
            table.on('checkbox(currentTableFilter)', function (obj) {
                console.log(obj)
            });

        }
    });
</script>
<script>

</script>

</body>
</html>