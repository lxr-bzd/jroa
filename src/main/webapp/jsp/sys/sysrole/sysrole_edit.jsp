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
		var roleName=$('#roleName').val();
		if(!roleName){
			$app.alert("角色名称不能为空");
			
			return ;
		}
		//表单提交
		$("#submit_form").ajaxSubmit({
			url:"${path}/sys/auth/role/editSubmit.do",
			data : $("#submit_form").serialize(),
			cache : false,
			dataType : 'JSON',
			type:'post',
			success:function(data){
				if(data.success){
					
					$app.alert("编辑成功");
				}else{
					$app.alert("编辑失败");
					
				}
			}
		});
	}
	
	//返回列表
	function goBackList(){
		var index = parent.layer.getFrameIndex(window.name);
		if(isNaN(index))window.location="${path}/sys/auth/role/toList.do";
		else
		parent.layer.close(index);
	}
	
</script>
</head>
<body>
	<div>
		
		<div class="formbody">
   			<div class="formtitle"><span>基本信息</span></div>
   			<form id="submit_form" method="post">
   				<input type="hidden" name="id" value="${vo.id}"/>
				<ul class="forminfo">
					<li><span>角色名称：</span><input name="roleName" id="roleName" value="${vo.roleName}" type="text" class="form-control input-primary input-sm w260" /></li>
					
					<li><span>角色描述：</span>
						<textarea class="form-control input-sm w260" name="roleDesc" id="roleDesc">${vo.roleDesc}</textarea>
					</li>
					<li><span>状态：</span>
						<div class="fl mr6">
							<input type="radio" value="1" name="roleStatus" id="roleStatus" <c:if test="${vo.roleStatus==1 }">checked="checked"</c:if> >
							<label for="roleStatus">启用</label>
						</div>
						<div class="fl mr6">
							<input type="radio" value="2" name="roleStatus" id="roleStatus1" name="roleStatus" <c:if test="${vo.roleStatus==2 }">checked="checked"</c:if> >
							<label for="roleStatus1">禁用</label> 
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