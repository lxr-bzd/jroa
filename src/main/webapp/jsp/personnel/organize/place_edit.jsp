<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑页面</title>
<script type="text/javascript">

var depts = [];


var backurl = "${path}/personnel/organize/place.do";


function isEdit(){
	
	return $("#submit_form").attr("data-isedit")
}

	$(function() {
		if(isEdit())return;
		
			
			$app.request("${path}/personnel/organize/dept/view.do"
	    		,function(data){
				if(data.status==0){
					depts = data.data;
					
				}
				selectT(null);
				
			});
			
		
	});
	
	function toSubmit(){
		//影藏域填充
		if(!isEdit()){
		var p = getSelectval();
		
		if(p)$("#submit_form input[name=deptid]").val(p.v);
		}
	
		
		//表单验证
		
		if(!$("#submit_form").valid())
				return;
		
		
		
		$app.loading(function(onfinsh){
			
			$("#submit_form").ajaxSubmit({
				url:$("#submit_form").attr("data-action"),
				data : $("#submit_form").serialize(),
				cache : false,
				dataType : 'JSON',
				type:'post',
				success:function(data){
					onfinsh();
					
					if(data.status==0){
						$app.alert('成功',function(){  //关闭事件
							goBackList();
						});
						
					}else
						$app.alert('编辑失败');
					
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
			console.log(e);
			if(isNaN(index))window.location=backurl;
		}

	}
	
</script>
	<script type="text/javascript">
	$(document).ready(function () {
		 var validateOpts = {
				 ignore : []
		 ,rules: {
		deptid: {required: true}
		 ,name:{required: true}
		 
		 
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

<c:if test="${empty param.action}">
		
   			
   			<form id="submit_form"  method="post" data-action="${path}/personnel/organize/place/save.do">
   				<input type="hidden" name="id" value="">
					
				<ul class="forminfo">
					<li><label>所属部门：</label>
					<div id = "col_group" class="btn-group">
					    
					</div>
					<input type="hidden" name="deptid"/>
						
					
					</li>
					<li><label>职位名称：</label><input name="name"  value="" type="text" class="form-control input-primary w260" /></li>
					
					
					<li class="layui-form">
					    <label>状态：</label>
					    <div class="layui-input-block w160">
					      <input type="radio" name="state" value="0" title="启用" checked >
					      <input type="radio" name="state" value="1" title="禁用">
					    </div>
					</li>
					
				
				<li><label>岗位职责：</label><textarea name="info"  class="form-control input-primary w260" ></textarea></li>
					
					
	    			<li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" value="确认" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/></li>
	    		</ul>
    		</form>
    		
</c:if>

<c:if test="${param.action=='edit'}">


   			<form id="submit_form" data-isedit="true" method="post" data-action="${path}/personnel/organize/place/update.do">
   				<input type="hidden" name="id" value="${vo.id}">
					
				<ul class="forminfo">
					<li><label>所属部门：</label>
					    ${vo.deptName}
					</li>
					<li><label>职位名称：</label><input name="name"  value="${vo.name}" type="text" class="form-control input-primary w260" /></li>
					
					
					
				<li class="layui-form">
					<label>状态：</label>
					<div class="layui-input-block w160">
						<input type="radio"  name="state" value="0" title="启用" <c:if test="${vo.state==0}">checked="checked"</c:if>>
						<input type="radio"  name="state" value="1" title="禁用" <c:if test="${vo.state==1}">checked="checked"</c:if>>
					</div>
				</li>
					
				<li><label>岗位职责：</label><textarea name="info"  class="form-control input-primary w260" >${vo.info}</textarea></li>
					
	    			<li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" value="确认" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/></li>
	    		</ul>
    		</form>
		
    		
</c:if>
	    </div>
	</div>
</body>


<script type="text/javascript">

var typeurl = "${path}/parking/canton/list.do";


function init() {
	
	 
	
}


function getSelectvalArr(){
	var sel = $("#col_group>select");
	

	var ret = [];
	
	sel.each(function(i,e){
		var v = $(e).val();
		if(v||v===0)
		ret.push({v:v,cantype:$(e).attr("data-cantype")});
		
	});
	
	return ret;
	
}

function getSelectval(){
	
	
	var arr = getSelectvalArr();
	
	if(!arr||arr.length<1)
		return;
	
	return arr[arr.length-1];
	
}










function selectT(pid){
	
				 result = getByPid(pid);
				 if(!(result instanceof Array)||result.length<1)
					 return;
				 var html = template("t_select",{cantype:result[0].cantype,pid:pid,data:result});
				 
				 $("#col_group").append(html);
				 
	 
}


 function getByPid(pid){
	 
	 var ret = [];
	 for (var i = 0; i < depts.length; i++) {
		if(depts[i].parentid == pid)
			ret.push(depts[i]);
	}
	 
	 return ret;
	 
 }



function  onSelect(select){
	
	
	$(select).nextAll().remove();
	
	var v = $(select).val();
	if(!v&&v!==0)return;
	
	selectT(v);
	
	
}




</script>

<script type="text/html" id="t_select">
<select data-pid="{{pid}}" data-cantype="{{cantype}}" class="form-control"  style="display: inline;width:110px;" onchange="onSelect(this)">
<option value="">--请选择--</option>
{{each data as d i}}
<option value="{{d.id}}">{{d.name}}</option>
{{/each}}
</select>

</script>
</html>