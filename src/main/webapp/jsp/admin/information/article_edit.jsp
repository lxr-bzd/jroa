<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/global.jsp"%>
<script type="text/javascript" src="${path}/jslib/kindeditor-4.1.10/kindeditor-all-min.js"></script>
<title>编辑页面</title>
<script type="text/javascript">

var depts = [];


var backurl = "${path}/admin/information/article.do";



	function toSubmit(){
		editor.sync();
		//表单验证
		if(!$("#submit_form").valid())
				return;
				
		$app.loading(function(onfinsh){
		//表单提交
		$("#submit_form").ajaxSubmit({
			url:$("#submit_form").attr("data-action"),
			data : $("#submit_form").serialize(),
			cache : false,
			dataType : 'JSON',
			type:'post',
			success:function(data){
				if(data.status==0)
					$app.alert('编辑成功',function(){  //关闭事件
						goBackList();
					});
				
				else $app.alert('编辑失败');
				
			}
		});
		
		});
	}
	
	//返回列表
	function goBackList(){
		try {
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		} catch (e) {

			if(isNaN(index))window.location=backurl;
		}
		
	}
	
</script>
	<script type="text/javascript">
	var editor;
	
	$(document).ready(function () {
		
		
		 editor = KindEditor.create('#submit_form textarea[name="content"]', {  
		        allowFileManager : true,  
		        uploadJson : '${path}/jslib/kindeditor-4.1.10/jsp/upload_json.jsp',
				fileManagerJson : '${path}/jslib/kindeditor-4.1.10/jsp/file_manager_json.jsp',  
		        resizeType : 0,  
		        width :  '680px',  
		        height : '500px'  
		    }); 
		
		
		 
		 $("#submit_form").validate({
			  rules: {
				  title: {required: true}
		 			,author: {required: true}
					 
					 
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
					 });
		});
	
	 
</script>
</head>
<body>
	<div>
		
		<div class="formbody">

<c:if test="${empty param.sysAction}">
		
   			
   			<form id="submit_form" data-isadd="true" method="post" data-action="${path}/admin/information/article/save.do">
   				<input type="hidden" name="type" value="${param.type }">
   				<ul class="forminfo">
					<li><label>标题：</label><input name="title"  type="text" class="form-control input-primary w260" />
					</li>
					
					
				<li><label>概要：</label><textarea name="summary" rows="" cols="" class="form-control input-primary w260"></textarea>  
				
				<li><label>状态：</label>
					<input type="radio"  name="state" value="0" checked="checked">启用
					<input type="radio"  name="state" value="1"  >禁用
				</li>
					
					<li><label>内容：</label>
					<textarea name="content" rows="" cols="" class="form-control input-primary w260"></textarea>
					
					</li>
					
					
	    			<li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" value="确认保存" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/></li>
	    		</ul>
    		</form>
    		
</c:if>

<c:if test="${param.sysAction=='edit'}">


   			<form id="submit_form"  method="post" data-action="${path}/admin/information/article/update.do">
   				<input name="id" value="${vo.id }" type="hidden"  />
   				
   				<ul class="forminfo">
				<li><label>标题：</label><input name="title"  value="${vo.title }" type="text" class="form-control input-primary w260" />
					</li>
					
					
				<li><label>概要：</label><textarea name="summary" value="" rows="" cols="" class="form-control input-primary w260">${vo.summary }</textarea>  
				
				<li><label>状态：</label>
					<input type="radio"  name="state" value="0" <c:if test="${vo.state==0}">checked="checked"</c:if>>启用
					<input type="radio"  name="state" value="1" <c:if test="${vo.state==1}">checked="checked"</c:if>>禁用
				</li>
					
					<li><label>内容：</label>
					<textarea name="content" rows="" cols="" class="form-control input-primary w260">${vo.content }</textarea>
					
					</li>
					
				
					
					
					
	    			<li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" value="确认保存" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/></li>
	    		</ul>
    		</form>
		
    		
</c:if>
	    </div>
	</div>
</body>



</html>
