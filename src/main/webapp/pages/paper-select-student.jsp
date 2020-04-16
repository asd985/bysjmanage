<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <title>选课列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">课题名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="paperName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">指导教师</label>
                            <div class="layui-input-inline">
                                <input type="text" name="teacherName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary" lay-submit  lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <!-- 自定义模板加入表单元素 -->
        <script type="text/html" id="paperStatus">
            {{d.status==0?'待审核':''}}
            {{d.status==1?'已审核':''}}
            {{d.status==2?'待确认':''}}
            {{d.status==3?'已确认':''}}
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-detail" lay-event="detail">查看</a>
            <a class="layui-btn layui-btn-xs data-count-select" lay-event="select">选题</a>
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
            url: '${pageContext.request.contextPath}/paper/stuFindAllReviewed.do',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print'],
            cols: [[
                {type: "checkbox", width: 50, fixed: "left", align: "center"},
                {field: 'pid', width: 80, title: 'ID', sort: true},
                {field: 'paperName', width: 400, title: '课题名'},
                {field: 'teacherName', width: 150, title: '指导教师', sort: true},
                {field: 'teacherId', width: 150, title: '教师工号', sort: true},
                {field: 'college', width: 150,title: '指定系别', sort: true},
                {field: 'major', width: 150, title: '指定专业', sort: true},
                {field: 'className', width: 150, title: '指定班级', sort: true},
                {field: 'status', width: 120, title: '状态', templet:'#paperStatus'},
                {title: '操作', minWidth: 100, templet: '#currentTableBar', fixed: "right", align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 10,
            page: true
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            var result = JSON.stringify(data.field);
            /*layer.alert(result, {
                title: '最终的搜索信息'
            });*/

            //执行搜索重载
            table.reload('currentTableId', {
                page: {         //分页设置
                    curr: 1     //起始页？
                }
                , where: {      //接口的其他参数
                    searchParams: result
                }
                ,url:'${pageContext.request.contextPath}/paper/selectStudentSearch.do'
            }, 'data');

            return false;
        });


        //tool编辑、删除功能
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            var tr = obj.tr;
            if (obj.event === 'detail') {
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
            } else if(obj.event === 'select') {
                $.ajax({
                    type:"GET",
                    url:"${pageContext.request.contextPath}/paper/Select.do?pid="+data.pid,
                    dataType:"json",
                    success:function(response){
                        //console.log(response);
                        layer.alert(response.msg,function () {
                            window.location.reload();//刷新页面
                        });
                    },
                    error:function () {
                        layer.msg('服务器繁忙');
                    }
                });
            }
        });

    });
</script>
<script>

</script>

</body>
</html>