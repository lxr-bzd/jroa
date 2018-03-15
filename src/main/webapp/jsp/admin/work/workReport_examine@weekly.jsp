<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/global.jsp"%>
<title>编辑页面</title>
<script type="text/javascript">

var depts = [];


var backurl = "${path}/admin/work/workReport.do";


	$(function() {
		
		
	
	});
	function toSubmit(){
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
				
				else $app.alert(data.msg?data.msg:'编辑失败')
				
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
	$(document).ready(function () {
		 var validateOpts = {
		  rules: {
		name: {required: true}
		
		 
		 
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
	
		
		<div class="formbody">



   			<form id="submit_form"  method="post" data-action="${path}/admin/work/workReport/examine.do">
   				<input name="reportid" value="${vo.id }" type="hidden"  />
   				<ul class="forminfo">
					<li><label>本周工作总结：</label>
					<textarea readonly="readonly"  rows="" cols="" class="form-control input-primary" style="display:inline-block;width:800px;height:100px;">${vo.content }</textarea>
					
					</li>
					
					<li><label>下周工作计划：</label>
					<textarea readonly="readonly"  name="" rows="" cols="" class="form-control input-primary" style="display:inline-block;width:800px;height: 200px;">${vo.study }</textarea>
					</li>
					
					
				<li><label>审批意见：</label>
					<textarea name="content" rows="" cols="" class="form-control input-primary" style="display:inline-block;width:800px;"></textarea>
					</li>
					
					
				</ul>
   				
	    		<div class="btnWrap">
					<input type="button" class="btn btn-primary" value="确认" onclick="toSubmit()">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="btn btn-warning" value="取消" onclick="goBackList();">
					
	    		</div>
    		</form>
    		
	    </div>
</body>


</html>
