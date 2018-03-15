<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑页面</title>
<script type="text/javascript">
	$(function() {
		
	});
	function toSubmit(){
		//表单验证
		 if(!$("#submit_form").valid())
				return;
	
		//表单提交
		$("#submit_form").ajaxSubmit({
			url:"${path}/sys/auth/user/editSubmit.do",
			data : $("#submit_form").serialize(),
			cache : false,
			dataType : 'JSON',
			type:'post',
			success:function(data){
				if(data.success){
					 $app.alert('编辑成功');
				}else{
					$app.alert("编辑失败");
				}
			}
		});
	}
	
	//返回列表
	function goBackList(){
		var index = parent.layer.getFrameIndex(window.name);
		if(isNaN(index))window.location="${path}/sys/auth/user/toList.do";
		else
		parent.layer.close(index);
		
	}
	
</script>


	<script type="text/javascript">
	$(document).ready(function () {
		 var validateOpts = {
		  rules: {
			  userName: {required: true}
		 ,account:{required: true}
		 ,password:{required: true}
		 
		 
		  }
		/*   ,
		  messages: {
		   name: {
		    required: "hiik"
		   },
		   sort: {
		    required: "请输入密码" 
		   }
		  } */
		 };
		 
		 $("#submit_form").validate(validateOpts);
		});
</script>
</head>
<body>
	<div>
		
		<div class="formbody">
   			<div class="formtitle"><span>基本信息</span></div>
   			<form id="submit_form" method="post">
   				<input type="hidden" name="id" value="${vo.id}"/>
				<ul class="forminfo">
					<li><span>姓名：</span><input name="userName" id="userName" value="${vo.userName}" type="text" class="form-control input-primary input-sm w260" /></li>
					<li><span>账号：</span>
						<input name="account" id="account" value="${vo.account}" type="text" class="form-control input-primary input-sm w260"  />
					</li>
					<li><span>电子邮箱：</span>
						<input name="email" id="email" value="${vo.email}" type="text" class="form-control input-primary input-sm w260"/>
					</li>
					<li><span>手机号码：</span><input name="mobilePhone" id="mobilePhone" value="${vo.mobilePhone}" type="text" class="form-control input-primary input-sm w260" /></li>
					<li><span>身份证号：</span><input name="idNumber" id="idNumber" value="${vo.idNumber}" type="text" class="form-control input-primary input-sm w260" /></li>
				<%-- 	<li><label>用户类型：</label>
						<select name="userType" id="userType" class="form-control input-primary" style="width:350px">
							<option value="1" <c:if test="${vo.userType==1 }">selected="selected"</c:if>>超级管理员</option>
							<option value="2" <c:if test="${vo.userType==2 }">selected="selected"</c:if>>管理员</option>
							<option value="3" <c:if test="${vo.userType==3 }">selected="selected"</c:if>>发布方</option>
							<option value="4" <c:if test="${vo.userType==4 }">selected="selected"</c:if>>普通会员</option>
						</select>
					</li> --%>
					<li><span>状态</span>
						<div class="fl mr6">
							<input type="radio" id="status" name="status" value="0" <c:if test="${vo.status==0 }">checked="checked"</c:if>>
							<label for="status">启用</label>
						</div>
						<div class="fl mr6">
							<input type="radio" id="status1" name="status" value="1" <c:if test="${vo.status==1 }">checked="checked"</c:if> >
							<label for="status1">锁定</label>
						</div>
						<div class="clear"></div>
					</li>
	    			<li><span>&nbsp;</span><input name="" type="button" class="btn btn-primary" value="确认保存" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="" type="button" class="btn btn-warning" value="返回列表" onclick="goBackList();"/></li>
	    		</ul>
    		</form>
	    </div>
	</div>
</body>
</html>