<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/global.jsp"%>
<title>详情</title>
<script type="text/javascript">
$(function(){
	$("#content").html($("#content").text()).show();
	
	$("#ctime").html(new Date(new Number($("#ctime").attr("data-val"))).format("yyyy-MM-dd"));
	
});

</script>

</head>
<body class="pd20">
<div class="author" style="text-align: center;">
发布人：${vo.author } ，发布时间：<span id="ctime" data-val="${vo.createtime }"></span>
</div>
	<div id="content" style="display: none;">
		${vo.content}
	
	</div>
</body>



</html>
