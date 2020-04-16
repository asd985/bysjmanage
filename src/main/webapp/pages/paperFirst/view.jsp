<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>流程文件</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
	<style>
		.layui-container {
			padding-bottom: 50px;
		}
	</style>
	<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>

	<!-- IE需要把JS放在上边，否则onclick失效 -->
	<script>
		layui.use(['upload', 'jquery'], function(){
			var $ = layui.jquery;
			var upload = layui.upload;

			//执行实例
			var uploadInst = upload.render({
				elem: '#upload1' //绑定元素
				,url: '${pageContext.request.contextPath}/paperfirst/upload.do' //上传接口
				,accept: 'file' //普通文件
				,exts: 'doc|docx' //只允许上传word文档
				,acceptMime:'application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document' //文件选择筛选
				,done: function(res){
				    console.log(res);
					//上传完毕回调
					if(res.result=="success")
						layer.alert('上传成功',function () {
							window.location.reload();
						});
					else{
						layer.msg(res.msg);
					}
				}
				,error: function(){
					//请求异常回调
					layer.msg('上传失败');
				}
			});

		});

	</script>
</head>
<body>
	<div class="layui-form">
		<div class="layui-form-item">

		</div>
	</div>
	<div class="layui-form">
		<div class="layui-form-item">
			<div class="layui-form-label">论文模版</div>
			<div class="layui-form-block">
				<a class="layui-btn layui-btn-primary" href="${pageContext.request.contextPath}/static/paper.xlsx">点击下载模版</a>
			</div>
		</div>
		<div class="layui-form-item">
			<c:if test="${paperFirst.status==0}">
				<div class="layui-form-block">
					<div class="layui-form-label"></div>
					当前状态为未开始，请尽快上传文件！
				</div>
			</c:if>
			<c:if test="${paperFirst.status>0}">
				<div class="layui-form-label">已上传文件</div>
				<div class="layui-form-block">
					<a class="layui-btn layui-btn-primary" name="fileurl" href="${pageContext.request.contextPath}/${paperFirst.fileurl}">点击下载文件</a>
				</div>
			</c:if>
		</div>
		<div class="layui-form-item">
			<div class="layui-form-label"></div>
			<button type="button" class="layui-btn" id="upload1">
				<i class="layui-icon">&#xe67c;</i>上传文件
			</button>
		</div>

	</div>


</body>
</html>
