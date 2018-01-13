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
		var roleName=$('#roleName').val();
		if(!roleName){
			$app.alert('角色名称不能为空');
			return ;
		}
		//表单提交
		var formData =  $("#add_form").serializeObject() ;
		formData.roleName = "roleName";
		$("#add_form").ajaxSubmit({
			url:"${path}/sysRoleController/add.do",
			data : formData,
			cache : false,
			dataType : 'JSON',
			type:'post',
			success:function(data){
				if(data.success){
					$app.alert('添加成功',function(){  //关闭事件
						goBackList();
					});
			      
				}else{
					$app.alert('添加失败');
					
				}
			}
		});
	}
	
	//返回列表
	function goBackList(){
		var index = parent.layer.getFrameIndex(window.name);
		if(isNaN(index))window.location="${path}/sysRoleController/toList.do";
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
				<ul class="forminfo">
					<li><span>角色名称：</span><input name="roleName" id="roleName" type="text" class="form-control input-primary input-sm w260"/></li>
					<!-- <li><label>角色类型：</label>
						<select name="roleType" id="roleType" class="form-control input-primary" style="width:350px">
							<option value="1">超级管理员</option>
							<option value="2">管理员</option>
							<option value="3" selected="selected">发布方</option>
							<option value="4">普通会员</option>
						</select>
					</li> -->
					
					<li><span>角色描述：</span>
						<textarea  class="form-control input-sm w260" name="roleDesc" id="roleDesc"></textarea>
					</li>
					<li><span>状态：</span>
						<div class="fl mr6">
							<input type="radio" checked="checked" value="1" name="roleStatus" id="roleStatus">
							<label for="roleStatus">启用    </label>
						</div>
						<div class="fl mr6">
							<input type="radio" value="2" name="roleStatus" id="roleStatus1" name="roleStatus">
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