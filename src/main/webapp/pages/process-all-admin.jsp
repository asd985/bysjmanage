<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <title>进度管理</title>
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
        <script type="text/html" id="processStatus">
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
            url: '${pageContext.request.contextPath}/paper/findProcess.do',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'print'],
            cols: [[
                {field: 'id', width: 50, fixed: "left", title: '序号', type:'numbers'},
                {field: 'paperName', width: 400, title: '课题名'},
                {field: 'studentName', width: 150, title: '选题学生'},
                {field: 'studentId', width: 150, title: '学生学号'},
                {field: 'college', width: 150,title: '系别'},
                {field: 'major', width: 150, title: '专业'},
                {field: 'className', width: 150, title: '班级'},
                {field: 'teacherName', width: 150, title: '指导教师'},
                {field: 'teacherId', width: 150, title: '教师工号'},
                {field: 'taskStatus', width: 120, title: '任务书', templet:'#processStatus'},
                {field: 'reportStatus', width: 120, title: '开题报告', templet:'#processStatus'},
                {field: 'checkStatus', width: 120, title: '中期检查', templet:'#processStatus'},
                {field: 'paperfirstStatus', width: 120, title: '论文初稿', templet:'#processStatus'},
                {field: 'paperendStatus', width: 120, title: '论文终稿', templet:'#processStatus'}
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

        function val(value) {
            if(value==0)
                return '未开始';
            else if(value==1)
                return '待审核';
            else if(value==2)
                return '已完成';
            return value;
        }

        // ==================== 解决table.reload后toolbar失效问题 ====================
        // 绑定事件集合处理(表格加载完毕和表格刷新的时候调用)
        function bindTableToolbarFunction() {
            // 监听添加操作
            $(".data-export").on("click", function () {

                // 从后端接口读取需要导出的数据
                $.ajax({
                    url:'${pageContext.request.contextPath}/paper/exportProcess.do'
                    , dataType: 'json'
                    , success: function (res) {
                        var data = res.data
                        // 重点！！！如果后端给的数据顺序和映射关系不对，请执行梳理函数后导出
                        data = excel.filterExportData(data, {
                            paperName: 'paperName'
                            , studentName: 'studentName'
                            , studentId: 'studentId'
                            , college:'college'
                            , major:'major'
                            , className: 'className'
                            , teacherName: 'teacherName'
                            , teacherId: 'teacherId'
                            , taskStatus: function (value) {
                                if(value==0)
                                    return '未开始';
                                else if(value==1)
                                    return '待审核';
                                else if(value==2)
                                    return '已通过';
                                return value;
                            }
                            , reportStatus: function (value) {
                                if(value==0)
                                    return '未开始';
                                else if(value==1)
                                    return '待审核';
                                else if(value==2)
                                    return '已通过';
                                return value;
                            }
                            , checkStatus: function (value) {
                                if(value==0)
                                    return '未开始';
                                else if(value==1)
                                    return '待审核';
                                else if(value==2)
                                    return '已通过';
                                return value;
                            }
                            , paperfirstStatus: function (value) {
                                if(value==0)
                                    return '未开始';
                                else if(value==1)
                                    return '待审核';
                                else if(value==2)
                                    return '已通过';
                                return value;
                            }
                            , paperendStatus: function (value) {
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
                            paperName: '课题名'
                            , studentName: '学生姓名'
                            , studentId: '学号'
                            , college:'学院'
                            , major:'专业'
                            , className: '班级'
                            , teacherName: '教师姓名'
                            , teacherId: '工号'
                            , taskStatus: '任务书'
                            , reportStatus: '开题报告'
                            , checkStatus: '中期检查'
                            , paperfirstStatus: '论文初稿'
                            , paperendStatus: '论文终稿'
                        })

                        var timestart = Date.now()
                        excel.exportExcel({
                            sheet1: data
                        }, '课题完成情况汇总.xlsx', 'xlsx')
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