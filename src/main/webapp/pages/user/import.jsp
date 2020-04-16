<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>excel导出扩展分享</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
	<style>
		.layui-container {
			padding-bottom: 50px;
		}
	</style>
	<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
	<script type="text/javascript">
	layui.config({
		base: '${pageContext.request.contextPath}/js/lay-module/layui_exts/'
	}).extend({
		excel: 'excel'
	});
	</script>
	<!-- IE需要把JS放在上边，否则onclick失效 -->
<%--	<script src="./import.js"></script>--%>
	<script>
		/**
		 * 阅读指南：
		 * 导出数据测试：搜索 「exportDataByUser」关键字，找到函数即可
		 * 导出接口数据：搜索「exportApiDemo」关键字，找到函数即可
		 * 导出复杂表头：搜索「exportExtendDemo」关键字，找到函数即可
		 * 批量设置样式：搜索「exportStyleDemo」关键字，找到函数即可
		 * 简单文件导入：搜索「uploadExcel」可找到导入的处理逻辑，拖拽文件/选择文件回调获取files对象请搜索「#LAY-excel-import-excel」
		 * upload模块：搜索「uploadInst」查看使用逻辑，导入相关逻辑同上
		 */

		layui.use(['jquery', 'layer', 'upload', 'excel', 'laytpl', 'element', 'code'], function () {
			var $ = layui.jquery;
			var layer = layui.layer;
			var upload = layui.upload;
			var excel = layui.excel;
			var laytpl = layui.laytpl;
			var element = layui.element;


			/**
			 * 上传excel的处理函数，传入文件对象数组
			 * @param  {FileList} files [description]
			 * @return {[type]}       [description]
			 */
			function uploadExcel(files) {
				try {
					excel.importExcel(files, {
						// 可以在读取数据的同时梳理数据
						/*fields: {
                          'id': 'A'
                          , 'username': 'B'
                          , 'experience': 'C'
                          , 'sex': 'D'
                          , 'score': 'E'
                          , 'city': 'F'
                          , 'classify': 'G'
                          , 'wealth': 'H'
                          , 'sign': 'I'
                        }*/
					}, function (data, book) {
						// data: {1: {sheet1: [{id: 1, name: 2}, {...}]}}// 工作表的数据对象
						// book: {1: {Sheets: {}, Props: {}, ....}} // 工作表的整个原生对象，https://github.com/SheetJS/js-xlsx#workbook-object
						// 也可以全部读取出来再进行数据梳理
						data = excel.filterImportData(data, {
							'username': 'A'
							, 'name': 'B'
							, 'phoneNum': 'C'
							, 'college': 'D'
							, 'major': 'E'
							, 'className': 'F'
							, 'role': 'G'
                            , 'password': 'H'
						})
						//console.log(JSON.stringify(data))
						$.ajax({
							type:"POST",
							url:"${pageContext.request.contextPath}/user/import.do",
							contentType: "application/json;charset=UTF-8", //必须这样写
							data:JSON.stringify(data['0']['Sheet1']),
							success:function () {
                                var index = layer.alert("导入成功！",function () {
                                    // 关闭弹出层
                                    layer.close(index);
                                    var iframeIndex = parent.layer.getFrameIndex(window.name);
                                    parent.layer.close(iframeIndex);
                                    //修改成功后刷新父界面
                                    window.parent.location.reload();
								});

							}
						});

					})
				} catch (e) {
					layer.alert(e.message)
				}
			}

			$(function () {
				// 监听上传文件的事件
				$('#LAY-excel-import-excel').change(function (e) {
					// 注意：这里直接引用 e.target.files 会导致 FileList 对象在读取之前变化，导致无法弹出文件
					var files = Object.values(e.target.files)
					uploadExcel(files)
					// 变更完清空，否则选择同一个文件不触发此事件
					e.target.value = ''
				})
				// 文件拖拽
				document.body.ondragover = function (e) {
					e.preventDefault()
				}
				document.body.ondrop = function (e) {
					e.preventDefault()
					var files = e.dataTransfer.files
					uploadExcel(files)
				}


			})
		})

	</script>
</head>
<body>
<div class="layui-container" >
	<div class="layui-row">
		<div class="layui-col-md11 layui-col-md-offset1">
			<div class="layui-form">
				<div class="layui-form-item">
					<div class="layui-form-label">导入模板</div>
					<div class="layui-form-block">
						<a class="layui-btn layui-btn-primary" href="${pageContext.request.contextPath}/static/import.xlsx">点击下载导入模版</a>
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-form-label">导入操作</div>
					<div class="layui-form-block">
						<input type="file" class="layui-btn layui-btn-primary" id="LAY-excel-import-excel" multiple="multiple">
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-form-label"></div>
					<div class="layui-form-block">
						<p class="help-block" style="color: #f00;">高级浏览器可以在本页面上直接将文件拖入</p>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>
</body>
<script type="text/html" id="LAY-excel-export-ans">
	{{# layui.each(d.data, function(file_index, item){ }}
		<blockquote class="layui-elem-quote">{{d.files[file_index].name}}</blockquote>
		<div class="layui-tab">
		  <ul class="layui-tab-title">
		  	{{# layui.each(item, function(sheet_name, content) { }}
			    <li>{{sheet_name}}</li>
		  	{{# }); }}
		  </ul>
		  <div class="layui-tab-content">
		  	{{# layui.each(item, function(sheet_name, content) { }}
			    <div class="layui-tab-item">
						<table class="layui-table">
							{{# layui.each(content, function(row_index, value) { }}
                {{# var col_index = 0 }}
								<tr>
									{{# layui.each(value, function(col_key, val) { }}
									<td id="table-export-{{file_index}}-{{sheet_name}}-{{row_index}}-{{col_index++}}">{{val}}</td>
									{{# });}}
								</tr>
							{{# });}}
						</table>
						<pre class="layui-code">{{JSON.stringify(content, null, 2)}}</pre>
					</div>
		  	{{# }); }}
		  </div>
		</div>
	{{# }) }}
</script>

</html>
