<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <title>任务书-查询列表</title>
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
        <script type="text/html" id="paperStatus">
            {{d.status==0?'未开始':''}}
            {{d.status==1?'待审核':''}}
            {{d.status==2?'已完成':''}}
        </script>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm data-export"> 导出 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-detail" lay-event="detail">课题详情</a>
            <a class="layui-btn layui-btn-xs data-count-detail" lay-event="view">任务书</a>
        </script>

    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    layui.config({
        base: '${pageContext.request.contextPath}/js/lay-module/layui_exts/'
    }).extend({
        excel: 'excel'
    });
</script>
<script>
    layui.use(['form', 'table', 'excel'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table,
            excel = layui.excel,
            layuimini = layui.layuimini;

        table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/task/findAll.do',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print'],
            cols: [[
                {type: "checkbox", width: 50, fixed: "left", align: "center"},
                {field: 'pid', width: 80, title: 'ID', sort: true, templet: '<div>{{d.paper.pid}}</div>'},
                {field: 'paperName', width: 400, title: '课题名', templet: '<div>{{d.paper.paperName?d.paper.paperName:""}}</div>'},
                {field: 'college', width: 150,title: '指定系别', sort: true, templet: '<div>{{d.paper.college?d.paper.college:""}}</div>'},
                {field: 'major', width: 150, title: '指定专业', sort: true, templet: '<div>{{d.paper.major?d.paper.major:""}}</div>'},
                {field: 'className', width: 150, title: '指定班级', sort: true, templet: '<div>{{d.paper.className?d.paper.className:""}}</div>'},
                {field: 'teacherName', width: 150, title: '指导教师', sort: true, templet: '<div>{{d.paper.teacherName?d.paper.teacherName:""}}</div>'},
                {field: 'teacherId', width: 150, title: '教师工号', sort: true, templet: '<div>{{d.paper.teacherId?d.paper.teacherId:""}}</div>'},
                {field: 'studentName', width: 150, title: '选题学生', sort: true, templet: '<div>{{d.paper.studentName?d.paper.studentName:""}}</div>'},
                {field: 'studentId', width: 150, title: '学生学号', sort: true, templet: '<div>{{d.paper.studentId?d.paper.studentId:""}}</div>'},
                {field: 'status', width: 120, title: '状态', templet:'#paperStatus'},
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
                ,url:'${pageContext.request.contextPath}/task/search.do'
                ,done: function () {
                    bindTableToolbarFunction();
                }
            }, 'data');

            return false;
        });


        //tool功能
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            var tr = obj.tr;
            if (obj.event === 'view') {
                var index = layer.open({
                    title: '任务书',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['50%', '40%'],
                    content: '${pageContext.request.contextPath}/task/viewByPid.do?pid='+data.paper.pid
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'detail') {
                var index = layer.open({
                    title: '课题详情',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['50%', '40%'],
                    content: '${pageContext.request.contextPath}/paper/detailByPid.do?pid='+data.paper.pid
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
            // 监听添加操作
            $(".data-export").on("click", function () {

                // 从后端接口读取需要导出的数据
                $.ajax({
                    url:'${pageContext.request.contextPath}/task/export.do'
                    , dataType: 'json'
                    , success: function (res) {
                        var data = res.data
                        // 重点！！！如果后端给的数据顺序和映射关系不对，请执行梳理函数后导出
                        data = excel.filterExportData(data, {
                            college: 'college'
                            , major: 'major'
                            , classname: 'classname'
                            , username:'username'
                            , name: 'name'
                            , status: function (value) {
                                if(value==0)
                                    return '未开始';
                                else if(value==1)
                                    return '待审核';
                                else if(value==2)
                                    return '已通过';
                                return value;
                            }
                        })
                        // 重点2！！！一般都需要加一个表头，表头的键名顺序需要与最终导出的数据一致
                        data.unshift({
                            college: '学院'
                            , major: '专业'
                            , classname: '班级'
                            , username:'学号'
                            , name: '姓名'
                            , status: '状态'
                        })

                        var timestart = Date.now()
                        excel.exportExcel({
                            sheet1: data
                        }, '任务书完成情况.xlsx', 'xlsx')
                        var timeend = Date.now()

                        var spent = (timeend - timestart) / 1000
                        layer.alert('单纯导出耗时 ' + spent + ' s')
                    }
                    , error: function () {
                        layer.alert('获取数据失败')
                    }
                })
            });


        }
    });
</script>
<script>

</script>

</body>
</html>