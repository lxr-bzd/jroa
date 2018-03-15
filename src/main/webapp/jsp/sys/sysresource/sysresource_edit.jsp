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
		var message="";
		var resourceName=$.trim($("#resourceName").val());
		var permissionStr=$.trim($('#permissionStr').val());
		if(!resourceName){
			message="-资源名称不能为空";
		}
		if(!permissionStr){
			message+="<br/>-权限字符串不能为空";
		}
		if(message){
			$app.alert("message");
			
			return ;
		}
		//表单提交
		$("#submit_form").ajaxSubmit({
			url:"${path}/sys/auth/res/editSubmit.do",
			data : $("#submit_form").serialize(),
			cache : false,
			dataType : 'JSON',
			type:'post',
			success:function(data){
				if(data.success){
					 $app.alert('编辑成功',function(){
						 goBackList();
						 
					 });
				}else{
					$app.alert("编辑失败");
				}
			}
		});
	}
	
	//返回列表
	function goBackList(){
		var index = parent.layer.getFrameIndex(window.name);
		if(isNaN(index))window.location="${path}/sys/auth/res/toList.do";
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
					<li><span>上级资源名称：</span>
						<input class="form-control input-sm w260" value="${vo.parentName }" disabled="disabled" style="cursor: not-allowed;" />
					</li>
					<li><span><font color="red" size="3">*</font>资源名称：</span><input name="resourceName" id="resourceName" type="text" class="form-control input-primary input-sm w260" value="${vo.resourceName }"/></li>
					<li><span>资源路径：<c:if test="${vo.level==3}"><font color="red" size="3">*</font></c:if></span>
						<input name="resourcePath" <c:if test="${vo.level==3}">required="true"</c:if> id="resourcePath" type="text" class="form-control input-primary input-sm w260" value="${vo.resourcePath }" />
					</li>
					<li><span>资源图标：</span><input name="resourceIcon" id="resourceIcon" type="text" class="form-control input-primary input-sm w260"  value="${vo.resourceIcon}" /></li>
					<li><span>层级：</span>
						<input name="level" id="level" type="text" class="form-control input-primary input-sm w260" style="cursor: not-allow" disabled="disabled"  value="${vo.level }" />
					</li>
					<li><span><font color="red" size="3">*</font>权限字符串：</span><input name="permissionStr" id="permissionStr" type="text" class="form-control input-primary input-sm w260" value="${vo.permissionStr}" /></li>
					<li><span>排序：</span><input name="orderNum" id="orderNum" value="${vo.orderNum}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="10" type="text" class="form-control input-primary input-sm w260"/></li>
					<li><span>是否启用：</span>
						<div class="fl mr6">
							<input type="radio" id="isEnable" <c:if test="${vo.isEnable==1 }">checked="checked"</c:if> name="isEnable" value="1" >
							<label for="isEnable">启用</label>
						</div>
						<div class="fl mr6">
							<input type="radio" id="isEnable1" <c:if test="${vo.isEnable==2 }">checked="checked"</c:if> name="isEnable" value="2">
							<label for="isEnable1">禁用</label>
						</div>
						<div class="clear"></div>
					</li>
					<li><span>资源描述：</span>
						<textarea class="form-control input-sm w260" name="resourceDesc" id="resourceDesc">${vo.resourceDesc}</textarea>
					</li>	    			
	    			<li><span>&nbsp;</span><input name="" type="button" class="btn btn-primary" value="确认保存" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="" type="button" class="btn btn-warning" value="返回列表" onclick="goBackList();"/></li>
	    		</ul>
    		</form>
	    </div>
	</div>
</body>
</html>