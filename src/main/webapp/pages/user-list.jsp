<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <title>用户查询</title>
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
                            <label class="layui-form-label">学号/工号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="name" autocomplete="off" class="layui-input">
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
        <script type="text/html" id="userStatus">
            <input type="checkbox" name="checked" value={{d.username}} lay-skin="switch" lay-filter="changeStatus" lay-text="启用|禁用" {{d.status==1?'checked':''}}>
        </script>

        <script type="text/html" id="userRole">
            {{d.role=='ADMIN'?'管理员':''}}
            {{d.role=='STUDENT'?'学生':''}}
            {{d.role=='TEACHER'?'教师':''}}
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-view" lay-event="view">查看</a>
        </script>

    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    var setpassIndex;
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table,
            //excel = layui.excel,
            layuimini = layui.layuimini;

        table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/user/findAll.do',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print'],
            cols: [[
                {type:'numbers'},
                {field: 'username', title: '学号/工号'},
                {field: 'name', title: '姓名'},
                {field: 'role',width: 80, title: '角色', templet:'#userRole'},
                {title: '操作', width: 200, templet: '#currentTableBar', fixed: "right", align: "center"}
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
                ,url:'${pageContext.request.contextPath}/user/search.do'
            }, 'data');

            return false;
        });

        //tool
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            var tr = obj.tr;
            if (obj.event === 'view') {
                setpassIndex = layer.open({
                    title: '查看用户',
                    type: 1,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['50%', '80%'],
                    content: '\
                    <div class="layuimini-container">\
                        <div class="layuimini-main">\
                            <div class="layui-form layuimini-form">\
                                <div class="layui-form-item" >\
                                    <label class="layui-form-label ">学号/工号</label>\
                                    <div class="layui-input-block">\
                                        <input type="text" id="username" name="username"   class="layui-input" readonly>\
                                    </div>\
                                </div>\
                                <div class="layui-form-item">\
                                    <label class="layui-form-label ">姓名</label>\
                                    <div class="layui-input-block">\
                                        <input type="text" id="name" name="name" class="layui-input" readonly>\
                                    </div>\
                                </div>\
                                <div class="layui-form-item">\
                                    <label class="layui-form-label ">手机</label>\
                                    <div class="layui-input-block">\
                                        <input type="text" name="phoneNum" id="phoneNum" class="layui-input" readonly>\
                                    </div>\
                                </div>\
                                <div class="layui-form-item">\
                                    <label class="layui-form-label ">系别</label>\
                                    <div class="layui-input-block">\
                                        <input type="text" name="college" id="college"  " class="layui-input" readonly>\
                                    </div>\
                                </div>\
                                <div class="layui-form-item">\
                                    <label class="layui-form-label">专业</label>\
                                    <div class="layui-input-block">\
                                        <input type="text" name="major" id="major" class="layui-input" readonly>\
                                    </div>\
                                </div>\
                                <div class="layui-form-item">\
                                    <label class="layui-form-label">班级</label>\
                                    <div class="layui-input-block">\
                                        <input type="text" name="className" id="className" class="layui-input" readonly>\
                                    </div>\
                                </div>\
                                <div class="layui-form-item">\
                                    <label class="layui-form-label">角色</label>\
                                    <div class="layui-input-block">\
                                        <input type="text" name="role" id="role" class="layui-input" readonly>\
                                    </div>\
                                </div>\
                                <div class="layui-form-item layui-form-text">\
                                    <label class="layui-form-label">备注</label>\
                                    <div class="layui-input-block">\
                                        <textarea name="remark" id="remark" placeholder="请输入备注信息，如QQ、擅长领域" class="layui-textarea" readonly></textarea>\
                                    </div>\
                                </div>\
                            </div>\
                        </div>\
                    </div>\
                    '
                });
                $("#username").val(data.username);
                $("#name").val(data.name);
                $("#phoneNum").val(data.phoneNum);
                $("#college").val(data.college);
                $("#major").val(data.major);
                $("#className").val(data.className);
                if(data.role=="STUDENT")
                    $("#role").val("学生");
                else if(data.role=="TEACHER")
                    $("#role").val("教师");
                else if(data.role=="ADMIN")
                    $("#role").val("管理员");
                $("#remark").val(data.remark);
                $(window).on("resize", function () {
                    layer.full(setpassIndex);
                });
                return false;
            }
        });
    });
</script>
<script>

</script>

</body>
</html>