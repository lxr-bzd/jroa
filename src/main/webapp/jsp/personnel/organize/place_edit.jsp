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


	
	function toSubmit(){
		//影藏域填充
		
		var deptid = $app.form.multipleSelectVal("#submit_form .lxr_multipleSelect");
				if(!deptid)deptid="";
				$("#submit_form input[name=deptid]").val(deptid);
		
	
		
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
						$app.alert(data.msg?data.msg:'编辑失败');
					
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
	
	function isedit(){
		return $("#submit_form ").attr("data-isadd")?false:true;
		
	}
	
</script>
	<script type="text/javascript">
	
	
	var deptModel;
	var depts;
	
	$(function() {
		
		$app.request("${path}/personnel/organize/dept/view.do",function(data){
			depts = data.data;
			if(isedit()){
				var cid = $("#submit_form input[name=id]").val();
				for(var i=0;i<depts.length;i++){
					if(depts[i].id==cid)
						depts.splice(i,1);
				}
				deptSelect.init = getVals($("#submit_form input[name=deptid]").val());
			}
			deptModel = $lxr.tree(depts,{pidname:"parentid"});
			
			$app.form("#submit_form");
		});
	});
	
	function findByPid(pid){
		for (var i = 0; i < depts.length; i++) {
			if(depts[i].id == pid)
				return depts[i].childs;
		}
	}
	
	
	var deptSelect = {
			 name:"name"
			,val:"id"
			,getRoot:function(render){
				render(deptModel);
			}
			,onSelect:function(pid,render){
				render(findByPid(pid));
				//if(pid)renderPlace($app.form.multipleSelectVal("#submit_form .lxr_multipleSelect"));
			}
	};	
	
	function getVals(val){
		var vals = [];
		var dept;
		for (var i = 0; i < depts.length; i++) {
			if(depts[i].id == val){ 
			dept = depts[i];
				break;
			}	
		}
		
		while(true){
			if(!dept)break;
			vals.push(dept.id);
			dept = findPBydept(dept);
		}
		var ret = [];
		for (var i =  vals.length-1; i > -1; i--) {
			ret.push(vals[i]);	
		}
		
		console.log(ret);
		return ret;
	}
	
	function findPBydept(dept){
		for (var i = 0; i < depts.length; i++) {
			if(depts[i].id == dept.parentid)
				return depts[i];
		}
	}
	
	$(document).ready(function () {
		 var validateOpts = {
				 ignore : []
		 ,rules: {
		deptid: {required: true}
		 ,name:{required: true}
		  }
		/*,
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
		
   			
   			<form id="submit_form" data-isadd="true" method="post" data-action="${path}/personnel/organize/place/save.do">
   				<input type="hidden" name="id" value="">
					
				<ul class="forminfo">
					<li>
					<label>所属部门：</label>
					<div class="lxr_multipleSelect"  data-name="deptid" data-model="deptSelect"> </div>
					<input name="deptid" type="hidden" value="">
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
	    		</ul>
	    		<div class="btnWrap">
					<input name="" type="button" class="btn btn-primary" value="确认" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/>
	    		</div>
    		</form>
    		
</c:if>

<c:if test="${param.action=='edit'}">


   			<form id="submit_form"  method="post" data-action="${path}/personnel/organize/place/update.do">
   				<input type="hidden" name="id" value="${vo.id}">
					
				<ul class="forminfo">
				<li>
					<label>所属部门：</label>
					<div class="lxr_multipleSelect"  data-name="deptid" data-model="deptSelect"> </div>
					<input name="deptid" type="hidden" value="${vo.deptid }">
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
	    		</ul>
	    		<div class="btnWrap">
    				<input name="" type="button" class="btn btn-primary" value="确认" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;
    				<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/>
	    		</div>
    		</form>
		
    		
</c:if>
	    </div>
	</div>
</body>


</html>