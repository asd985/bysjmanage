<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <title>账号管理</title>
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
            {{d.role=='STUDENT'?'教师':''}}
            {{d.role=='TEACHER'?'学生':''}}
        </script>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm data-add-btn" > 添加用户 </button>
                <button class="layui-btn layui-btn-sm layui-btn-normal data-import-btn" > 导入用户 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn"> 删除用户 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="password">修改密码</a>
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
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
                {type: "checkbox", fixed: "left", align: "center"},
                {field: 'username', title: '学号/工号', sort: true},
                {field: 'name', title: '姓名'},
                {field: 'phoneNum', title: '手机号'},
                {field: 'college',title: '系别', sort: true},
                {field: 'major', title: '专业', sort: true},
                {field: 'className', title: '班级', sort: true},
                {field: 'role',width: 80, title: '角色', templet:'#userRole'},
                {field: 'status',width: 100, title: '状态', templet:'#userStatus'},
                {title: '操作', width: 200, templet: '#currentTableBar', fixed: "right", align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 10,
            page: true,
            done: function () {
                bindTableToolbarFunction();
            }

        });

        //监听状态开关
        form.on('switch(changeStatus)',function (data) {
            //获取id
            //console.log(data.value);
            $.ajax({
                type:"GET",
                url:"${pageContext.request.contextPath}/user/changeStatus.do?username="+data.value,
                error:function () {
                    layer.alert('修改失败',function () {
                        window.location.reload();
                    });
                }

            });
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
                ,done: function () {
                    bindTableToolbarFunction();
                }
            }, 'data');

            return false;
        });

        //监听修改密码
        form.on('submit(savePass)', function (data) {
            var load = layer.load();
            var password=data.field.password;
            if(password!=data.field.again_password){
                layer.msg("两次输入密码不一致");
            }else{
                $.ajax({
                    type:"POST",
                    url:"${pageContext.request.contextPath}/user/setPassword.do",
                    contentType: "application/json;charset=UTF-8", //必须这样写
                    data:JSON.stringify(data.field),
                    success:function () {
                        layer.close(setpassIndex);
                        layer.close(load);
                    }
                });
            }
            /*var index = layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            }, function () {
                layer.close(index);
                miniTab.deleteCurrentByIframe();
            });*/
            //layer.msg(data.new_password);
            //console.log(data.field.again_password);
            return false;
        });

        //tool编辑、删除功能
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            var tr = obj.tr;
            if (obj.event === 'edit') {

                var index = layer.open({
                    title: '编辑用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['50%', '80%'],
                    content: '${pageContext.request.contextPath}/user/findByUsername.do?username='+data.username
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('确认删除？', function (index) {

                    $.get("${pageContext.request.contextPath}/user/deleteByUsername.do?username="+data.username,function () {
                        layer.alert("删除成功");
                        obj.del();
                        layer.close(index);
                    });
                    //var result = JSON.stringify(data.field);
                    /*layer.alert(JSON.stringify(data), {
                        title: '最终的删除信息'
                    });
                    obj.del();
                    layer.alert("删除失败");
                    layer.close(index);*/

                });
            } else if (obj.event === 'password') {
                 setpassIndex = layer.open({
                    title: '修改密码',
                    type: 1,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['50%', '40%'],
                    content: '\
                    <div class="layuimini-container">\
                        <div class="layuimini-main">\
                            <div class="layui-form layuimini-form">\
                                <div class="layui-form-item">\
                                   <label class="layui-form-label ">用户名</label>\
                                    <div class="layui-input-block">\
                                        <input type="text" id="username" name="username"  lay-reqtext="" placeholder=""  value="" class="layui-input" readonly>\
                                    </div>\
                                </div>\
                                <div class="layui-form-item">\
                                    <label class="layui-form-label required">新的密码</label>\
                                    <div class="layui-input-block">\
                                        <input type="password" name="password" lay-verify="required" lay-reqtext="新的密码不能为空" placeholder="请输入新的密码"  value="" class="layui-input">\
                                    </div>\
                                </div>\
                                <div class="layui-form-item">\
                                    <label class="layui-form-label required">新的密码</label>\
                                    <div class="layui-input-block">\
                                        <input type="password" name="again_password" lay-verify="required" lay-reqtext="新的密码不能为空" placeholder="请输入新的密码"  value="" class="layui-input">\
                                    </div>\
                                </div>\
                                <div class="layui-form-item">\
                                    <div class="layui-input-block">\
                                        <button class="layui-btn" lay-submit lay-filter="savePass">确认保存</button>\
                                    </div>\
                                </div>\
                            </div>\
                        </div>\
                    </div>\
                    '
                });
                $("#username").val(data.username);
                $(window).on("resize", function () {
                    layer.full(setpassIndex);
                });
                return false;
            }
        });
        // ==================== 解决table.reload后toolbar失效问题 ====================
        // 绑定事件集合处理(表格加载完毕和表格刷新的时候调用)
        function bindTableToolbarFunction() {
            // 监听添加操作
            $(".data-add-btn").on("click", function () {

                var index = layer.open({
                    title: '添加用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['40%', '80%'],
                    content: '${pageContext.request.contextPath}/pages/user/add.jsp',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });

                return false;
            });

            // 监听导入操作
            $(".data-import-btn").on("click", function () {

                var index = layer.open({
                    title: '导入用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['50%', '50%'],
                    content: '${pageContext.request.contextPath}/pages/user/import.jsp',
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
                        url:"${pageContext.request.contextPath}/user/deleteUsers.do",
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