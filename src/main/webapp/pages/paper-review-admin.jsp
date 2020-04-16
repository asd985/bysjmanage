<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <title>课题审核</title>
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
                            <label class="layui-form-label">选题学生</label>
                            <div class="layui-input-inline">
                                <input type="text" name="studentName" autocomplete="off" class="layui-input">
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
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm data-review-btn"> 批量审核 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-detail" lay-event="detail">查看</a>
            <input type="checkbox" name="checked" value={{d.pid}} lay-skin="switch" lay-filter="changeStatus" lay-text="已审核|待审核" {{d.status==1?'checked':''}}>
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
            url: '${pageContext.request.contextPath}/paper/findAllReview.do',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print'],
            cols: [[
                {type: "checkbox", width: 50, fixed: "left", align: "center"},
                {field: 'pid', width: 80, title: 'ID', sort: true},
                {field: 'paperName', width: 400, title: '课题名'},
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
                ,url:'${pageContext.request.contextPath}/paper/search.do'
                ,done: function () {
                    bindTableToolbarFunction();
                }
            }, 'data');

            return false;
        });

        //审核
        form.on('switch(changeStatus)',function (data) {
            //获取id
            //console.log(data.value);
            $.ajax({
                type:"GET",
                url:"${pageContext.request.contextPath}/paper/changeStatus.do?pid="+data.value,
                error:function () {
                    layer.alert('修改失败',function () {
                        window.location.reload();
                    });
                }
            });
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
            }
        });

// ==================== 解决table.reload后toolbar失效问题 ====================
        // 绑定事件集合处理(表格加载完毕和表格刷新的时候调用)
        function bindTableToolbarFunction() {

            // 监听批量审核操作
            $(".data-review-btn").on("click", function () {
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                if(JSON.stringify(data)=='[]')
                    layer.alert('未选择任何数据！');
                else {
                    $.ajax({
                        type:"POST",
                        url:"${pageContext.request.contextPath}/paper/reviewPapers.do",
                        contentType: "application/json;charset=UTF-8", //必须这样写
                        data:JSON.stringify(data),
                        success:function () {
                            layer.alert("操作成功！",function () {
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