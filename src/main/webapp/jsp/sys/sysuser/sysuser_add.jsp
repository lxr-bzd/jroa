<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增页面</title>
<script type="text/javascript">
	$(function() {

	});
	function toSubmit(){
		//表单验证
		 if(!$("#add_form").valid())
				return;
	
		
		 $app.loading(function(close){
			//表单提交
				$("#add_form").ajaxSubmit({
					url:"${path}/sys/auth/user/add.do",
					data : $("#add_form").serialize(),
					cache : false,
					dataType : 'JSON',
					type:'post',
					success:function(data){
						close();
						if(data.success){
							$app.alert('添加成功',function(){  //关闭事件
								goBackList();
							});
							
						}else{
							$app.alert('添加失败')
							
						}
					}
				});
			 
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
		 
		 $("#add_form").validate(validateOpts);
		});
</script>
</head>
<body>
	<div>
	
		<div class="formbody">
   			<div class="formtitle"><span>基本信息</span></div>
   			<form id="add_form" class="vform" method="post">
				<ul class="forminfo">
					<li><span><strong style="color:red;">*</strong>姓名：</span><input name="userName" id="userName" type="text" class="form-control input-primary input-sm w260" /></li>
					<li><span><strong style="color:red;">*</strong>账号：</span><input name="account" id="account" type="text" class="form-control input-primary input-sm w260"  /></li>
					<li><span>电子邮箱：</span><input name="email" id="email" type="text" class="form-control input-primary input-sm w260" /></li>
					<li><span>手机号码：</span><input name="mobilePhone" id="mobilePhone" type="text" class="form-control input-primary input-sm w260" /></li>
					<li><span><strong style="color:red;">*</strong>密码：</span><input name="password" id="password" type="password" class="form-control input-primary input-sm w260" /></li>
					<li><span>身份证号：</span><input name="idNumber" id="idNumber" type="text" class="form-control input-primary input-sm w260" /></li>
					
					<li><span>状态</span>
						<div class="fl mr6">
							<input type="radio" id="status" name="status" value="0" checked="checked"><label for="status">启用</label>
						</div>
						<div class="fl mr6">
							<input type="radio" id="status1" name="status" value="1"><label for="status1">锁定</label>
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