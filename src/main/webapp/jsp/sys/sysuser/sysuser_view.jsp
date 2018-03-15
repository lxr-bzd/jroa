<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>详情页面</title>
<script type="text/javascript">
	$(function() {

	});
	
	//返回列表
	function goBackList(){
		var index = parent.layer.getFrameIndex(window.name);
		if(isNaN(index))window.location="${path}/sys/auth/user/toList.do";
		else
		parent.layer.close(index);
	}
</script>
</head>
<body>
	<div>
		
		<div class="formbody">
   			<div class="formtitle"><span>基本信息</span></div>
   			<form id="add_form" method="post">
   				<input type="hidden" name="id" value="${vo.id}"/>
				<ul class="forminfo">
					<li><span>姓名：</span><input name="userName" id="userName" value="${vo.userName}" type="text" class="form-control input-primary input-sm w260" disabled="disabled" style="cursor: not-allowed;"  /></li>
					<li><span>账号：</span><input name="account" id="account" value="${vo.account}" type="text" class="form-control input-primary input-sm w260" disabled="disabled" style="cursor: not-allowed; "  /></li>
					<li><span>电子邮箱：</span><input name="email" id="email" value="${vo.email}" type="text" class="form-control input-primary input-sm w260" disabled="disabled" style="cursor: not-allowed; "  /></li>
					<li><span>手机号码：</span><input name="mobilePhone" id="mobilePhone" value="${vo.mobilePhone}" type="text" class="form-control input-primary input-sm w260" disabled="disabled" style="cursor: not-allowed; "  /></li>
					<li><span>添加时间：</span><input name="regTime" id="regTime" value="<fmt:formatDate value="${vo.regTime}" />" type="text" class="form-control input-primary input-sm w260" disabled="disabled" style="cursor: not-allowed; " /></li>
					<li><span>添加ip：</span><input name="regIp" id="regIp" value="${vo.regIp}" type="text" class="form-control input-primary input-sm w260" disabled="disabled" style="cursor: not-allowed; "  /></li>
					<li><span>最后登录时间：</span><input name="lastLoginTime" id="lastLoginTime" value="<fmt:formatDate value="${vo.lastLoginTime}" />" type="text" class="form-control input-primary input-sm w260"  disabled="disabled" style="cursor: not-allowed; " /></li>
					<li><span>最后错误登录时间：</span><input name="lastLoginErrTime" id="lastLoginErrTime" value="<fmt:formatDate value="${vo.lastLoginErrTime}" />" type="text" class="form-control input-primary input-sm w260" disabled="disabled" style="cursor: not-allowed; " /></li>
					<li><span>最后登录ip：</span><input name="lastLoginIp" id="lastLoginIp" value="${vo.lastLoginIp}" type="text" class="form-control input-primary input-sm w260" disabled="disabled" style="cursor: not-allowed; "  /></li>
					<li><span>身份证号：</span><input name="idNumber" id="idNumber" value="${vo.idNumber}" type="text" class="form-control input-primary input-sm w260" disabled="disabled" style="cursor: not-allowed; "  /></li>
					<li><span>登录累计错误次数：</span><input name="loginErrTimes" id="loginErrTimes" value="${vo.loginErrTimes}" type="text" class="form-control input-primary input-sm w260" disabled="disabled" style="cursor: not-allowed; "  /></li>
					<%-- <li><label>用户类型：</label>
						<select name="userType" id="userType" class="form-control input-primary" disabled="disabled" style="cursor: not-allowed; ">
							<option value="1" <c:if test="${vo.userType==1 }">selected="selected"</c:if>>超级管理员</option>
							<option value="2" <c:if test="${vo.userType==2 }">selected="selected"</c:if>>管理员</option>
							<option value="3" <c:if test="${vo.userType==3 }">selected="selected"</c:if>>发布方</option>
							<option value="4" <c:if test="${vo.userType==4 }">selected="selected"</c:if>>普通会员</option>
						</select>
					</li> --%>
					<li><span>状态</span>
						<div class="fl mr6">
							<input type="radio" id="status" name="status" value="1" <c:if test="${vo.status==1 }" >checked="checked"</c:if> disabled="disabled" style="cursor: not-allowed">
							<label for="status">启用</label>
						</div>
						<div class="fl mr6">
							<input type="radio" id="status1" name="status" value="2" <c:if test="${vo.status==2 }" >checked="checked"</c:if> disabled="disabled" style="cursor: not-allowed">
							<label for="status1">锁定</label>
						</div>
						<div class="clear"></div>
					</li>
	    			<li>
	    				<span>&nbsp;</span>
	    				<input name="" type="button" class="btn btn-warning" value="返回列表" onclick="goBackList();"/>
	    			</li>
	    		</ul>
    		</form>
	    </div>
	</div>
</body>
</html>