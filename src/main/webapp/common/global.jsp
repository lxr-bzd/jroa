<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

	<c:set var="path" value="${pageContext.request.contextPath}"/>
	<script src="${path }/jslib/jquery.min-1.11.js"></script>
	<script src="${path }/jslib/browser.js"></script>
	
	<%-- common js class --%>
	<script type="text/javascript" src="${path}/js/foxtail/Tools.js"></script>
	<script type="text/javascript" src="${path}/js/foxtail/app.js"></script>
	<script type="text/javascript" src="${path}/js/foxtail/util.js"></script>
	<!-- 日期 -->
	<script type="text/javascript" src="${path}/jslib/My97DatePicker/4.7/WdatePicker.js"></script>
	<link href="${path}/css/layout/style.css" rel="stylesheet" type="text/css" />
	
	
	<script src="${path}/jslib/artDialog/jquery.artDialog.js?skin=blue"></script>   
	<script src="${path}/jslib/artDialog/plugins/iframeTools.js"></script>  
	<script src="${path}/js/foxtail/artDialogExt.js"></script>
	
	<!-- bootstrap table 引入 -->
<%--<link rel="stylesheet" href="${path }/jslib/table/docs/assets/bootstrap/css/bootstrap-theme.min.css"> --%>
	
	<link rel="stylesheet" href="${path }/jslib/table/docs/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path }/jslib/table/dist/bootstrap-table.min.css">
    <script src="${path }/jslib/table/docs/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="${path }/jslib/table/dist/bootstrap-table.js"></script>
    <script src="${path }/jslib/table/dist/locale/bootstrap-table-zh-CN.min.js"></script>
    
    <!--layui插件-->
    <link rel="stylesheet" href="${path }/jslib/layui/css/layui.css" />
    <script src="${path }/jslib/layui/layui.js"></script>
    <!--<link rel="stylesheet" href="${path }/jslib/layer/skin/default/layer.css" />
    <script src="${path }/jslib/layer/layer.js"></script>-->
    <!-- bootstrap table 操作公共方法 -->
	<script src="${path }/js/foxtail/tableCommon.js"></script>
	<%-- <!-- 字体样式 -->
	<link rel="stylesheet" href="${path }/css/font-awesome-4.4.0/css/font-awesome.min.css"> --%>
	<%-- jquery --%>
	<script type="text/javascript" src="${path}/jslib/jquery.form.js"></script>
	
	<script type="text/javascript" src="${path}/js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${path}/js/jquery.validate.messages.js"></script>
	<script type="text/javascript" src="${path}/js/template-web.js"></script>
		
	<script type="text/javascript">
	//屏蔽readonly下按backspace键返回的功能
		$(document).keydown(function(e){
			var event=arguments.callee.caller.arguments[0]||window.event;// 修正浏览器兼容 
			var target = e.target ;
			var tag = e.target.tagName.toUpperCase();
			if(event.keyCode == 8){
				if((tag == 'INPUT' && !$(target).attr("readonly"))||(tag == 'TEXTAREA' && !$(target).attr("readonly"))){
					if((target.type.toUpperCase() == "RADIO") || (target.type.toUpperCase() == "CHECKBOX")){
						return false ;
					}else{
						return true ;
					}
				}else{
					
					return false ;
				}
			}
		}); 
		layui.use('form', function(){
		  form = layui.form;
		});
	</script>
