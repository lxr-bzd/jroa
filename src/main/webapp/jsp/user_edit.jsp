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
			url:"${path}/index/user/update.do",
			data : $("#submit_form").serialize(),
			cache : false,
			dataType : 'JSON',
			type:'post',
			success:function(data){
				if(data.status==0){
					$app.alert('编辑成功',function(){  //关闭事件
						window.location="${path}/logout.do";
					});
					
					
				}else{
					$app.alert(data.msg?data.msg:'编辑失败');
				}
			}
		});
	}
	
	//返回列表
	function goBackList(){
		var index = parent.layer.getFrameIndex(window.name);
		if(isNaN(index))window.location="";
		else
		parent.layer.close(index);
		
	}
	
</script>


	<script type="text/javascript">
	$(document).ready(function () {
		 var validateOpts = {
		  rules: {
			  pwd: {required: true}
		 ,newpwd:{required: true}
		 
		 
		  }
		
		 };
		 
		 $("#submit_form").validate(validateOpts);
		});
</script>
</head>
<body>
	<div>
		
		<div class="formbody">
   			<div class="formtitle"><span>修改登录密码</span></div>
   			<form id="submit_form" method="post">
   				
				<ul class="forminfo">
					<li><span>原登录密码：</span>
						<input name="pwd"  value="" type="text" class="form-control input-primary input-sm w260"  />
					</li>
					<li><span>登录密码：</span>
						<input name="newpwd"  value="" type="text" class="form-control input-primary input-sm w260"  />
					</li>
					
	    			<li><span>&nbsp;</span><input name="" type="button" class="btn btn-primary" value="提交" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="" type="button" class="btn btn-warning" value="返回" onclick="goBackList();"/></li>
	    		</ul>
    		</form>
	    </div>
	</div>
</body>
</html>