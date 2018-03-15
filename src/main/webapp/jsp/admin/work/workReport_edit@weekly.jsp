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
	function addItem(){
		var l = $("#item_group>tr").length;
		var html = template("tem_item",{sort:l+1});
		$("#item_group").append(html);
		
	}
	
	function itemonchage(inp){
		
		
	}
	
	$(document).ready(function () {
		 var validateOpts = {
		  rules: {
		name: {required: true}
		
		 
		 
		  }
		
		 };
		 
		 $("#submit_form").validate(validateOpts);
		});
</script>
</head>
<body>
	<div>
		
		<div class="formbody">

<c:if test="${empty param.sysAction}">
		
   			
   			<form id="submit_form" data-isadd="true" method="post" data-action="${path}/admin/work/workReport/save.do">
   				<input type="hidden" name="type" value="2">
   				<input type="hidden" name="report_state" value="1">
   				
   				
				   <div class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">本周工作总结</h3>
					</div>
					<div class="panel-body">
					<textarea name="content" rows="" cols="" class="form-control input-primary" style="display:inline-block;width:800px;height:200px;"></textarea>
					</div>
					</div>
					
				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title">下周工作计划</h3>
					</div>
					<div class="panel-body">
						<textarea name="study" rows="" cols="" class="form-control input-primary" style="display:inline-block;width:800px;height: 100px;"></textarea>
					</div>
					</div>
					
					<div class="btnWrap">
					<input name="" type="button" class="btn btn-primary" value="确认" onclick="toSubmit()">&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();">
	    		</div>
    		</form>
    		
</c:if>

<c:if test="${param.sysAction=='edit'}">


   			<form id="submit_form"  method="post" data-action="${path}/admin/work/workReport/update.do">
   				<input type="hidden" name="type" value="2">
   				<input type="hidden" name="id" value="${vo.id }">
   				
   				   <div class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">本周工作总结</h3>
					</div>
					<div class="panel-body">
					<textarea name="content" rows="" cols="" class="form-control input-primary" style="display:inline-block;width:800px;height:200px;">${vo.content }</textarea>
					</div>
					</div>
					
				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title">下周工作计划</h3>
					</div>
					<div class="panel-body">
						<textarea name="study" rows="" cols="" class="form-control input-primary" style="display:inline-block;width:800px;height: 100px;">${vo.study }</textarea>
					</div>
					</div>
   				
				<div class="btnWrap">
					<input name="" type="button" class="btn btn-primary" value="确认" onclick="toSubmit()">&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();">
	    		</div>
    		</form>
		
    		
</c:if>
	    </div>
	</div>
</body>


<script type="text/html" id="tem_item">
<tr>
   				<td>{{sort}}<input name="details[{{sort-1}}].sort" type="hidden" value="{{sort}}" /></td>
   				<td><input name="details[{{sort-1}}].content" value="" type="text" class="form-control input-primary" /></td>
   				<td><input name="details[{{sort-1}}].finishdate" value="" type="text" class="form-control input-primary" /></td>
   				<td><input onclick="if(this.checked)$(this).next().val('2'); else $(this).next().val('1');" type="checkbox" class="input-primary" />
   				<input name="details[{{sort-1}}].isfinish" type="hidden" value="1"  />
   				</td>
   				<td><a onclick="$(this).parent().parent().remove()">删除</a></td>
   				</tr>

</script>

</html>
