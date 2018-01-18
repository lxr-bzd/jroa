<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑页面</title>
<script type="text/javascript">



var backurl = "${path}/personnel/organize/level.do";


	function toSubmit(){
		//表单验证
		var result = perSubmit();
		if(result){
				$app.alert(result);
		}
		
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
				if(data.status==0){
					$app.alert('编辑成功',function(){  //关闭事件
						goBackList();
					});
				
				}else
					$app.alert('编辑失败');
				
			}
		});
		
		});
	}
	
	
	
	function perSubmit(){
		/* if(isedit())return;
		
var deptid = $app.form.multipleSelectVal("#submit_form .lxr_multipleSelect");
		
		if(!deptid){
			$app.alert('请选择部门');
			return;
		}
		
		$("#submit_form input[name=deptid]").val(deptid); */
		
	}
	
	
	
	//返回列表
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
	/* var deptModel;
	var depts;
	
	$(function() {
		
		$app.request("${path}/personnel/organize/dept/view.do",function(data){
			deptModel = $lxr.tree(data.data,{pidname:"parentid"});
			depts = data.data;
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
				if(pid)renderPlace($app.form.multipleSelectVal("#submit_form .lxr_multipleSelect"));
			}
	};
	
	
	function renderPlace(did){
		$app.request("${path}/personnel/organize/place/view.do?type=bydeptid&deptid="+did,function(data){
			
			var html = '<select name = "placeid" class="form-control lxr_select"  style="display: inline;width:110px;" onchange=""><option value="">--请选择--</option>';
			if(!$lxr.isEmpty(data.data))
		for (var i = 0; i < data.data.length; i++) {
				html+='<option value="'+data.data[i].id+'">'+data.data[i].name+'</option>';
			}
			html+='</select>';
			
			 $("#submit_form select[name=placeid]").replaceWith(html);
		});
		
	} */
	
	$(document).ready(function () {
		 var validateOpts = {
		  rules: {
		name: {required: true}
	/* 	 ,placeid:{required: true} */
		 ,subs_meal:{required: true,number: true}
		 ,sal_base:{required: true,number: true}
		 ,subs_insurance:{required: true,number: true}
		 ,subs_every:{required: true,number: true}
		 
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
		
   			<!--<div class="formtitle"><span>基本信息</span></div>-->
   			<form id="submit_form" data-isadd="true" method="post" data-action="${path}/personnel/organize/level/save.do">
   				
   				<ul class="forminfo">
					<li><label>级别：</label><input name="name" type="text" type="text" class="form-control input-primary w260" />
					</li>
					
					<!-- <li><label>部门：</label> <div class="lxr_multipleSelect" data-name="deptid" data-model="deptSelect"> </div>
					<input name="deptid" type="hidden">
					</li>
					
					<li><label>职位：</label><select name = "placeid" class="form-control lxr_select"  style="display: inline;width:110px;" onchange=""><option value="">--请选择--</option></select>
					</li> -->
					
					<li><label>餐补：</label><input name="subs_meal"  value="" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>底薪：</label><input name="sal_base"  value="" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>保险补助：</label><input name="subs_insurance"  value="" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>全勤：</label><input name="subs_every"  value="" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>管理津贴：</label><input name="subs_manage"  value="" type="text" class="form-control input-primary w260" />
					</li>
					<li><label>团队津贴：</label><input name="subs_team"  value="" type="text" class="form-control input-primary w260" />
					</li>
					<li><label>工龄工资：</label><input name="subs_age"  value="" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>备注：</label><textarea name="remark"   class="form-control input-primary w260" ></textarea>
					</li>
					
					<li class="layui-form">
					    <label>状态：</label>
					    <div class="layui-input-block w160">
					      <input type="radio" name="state" value="0" title="启用" checked >
					      <input type="radio" name="state" value="1" title="禁用">
					    </div>
					</li>
	    		</ul>
    			<div class="btnWrap">
    				<input name="" type="button" class="btn btn-primary" value="确认" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;
    				<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/>
    			</div>
    		</form>
    		
</c:if>

<c:if test="${param.action=='edit'}">

<!--<div class="formtitle"><span>基本信息</span></div>-->
   			<form id="submit_form"  method="post" data-action="${path}/personnel/organize/level/update.do">
   				<input name="id" value="${vo.id }" type="hidden" class="form-control input-primary w260" />
   				<ul class="forminfo">
					<li><label>级别：</label><input name="name" value="${vo.name }" type="text" class="form-control input-primary w260" />
					</li>
					
					<%-- <li><label>部门：</label> <strong>${vo.deptName }</strong>
					</li>
					
					<li><label>职位：</label> <strong>${vo.placeName }</strong>
					</li> --%>
					
					<li><label>餐补：</label><input name="subs_meal"  value="${vo.subs_meal }" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>底薪：</label><input name="sal_base"  value="${vo.sal_base }" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>保险补助：</label><input name="subs_insurance"  value="${vo.subs_insurance }" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>全勤：</label><input name="subs_every"  value="${vo.subs_every }" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>管理津贴：</label><input name="subs_manage"  value="${vo.subs_manage }" type="text" class="form-control input-primary w260" />
					</li>
					<li><label>团队津贴：</label><input name="subs_team"  value="${vo.subs_team }" type="text" class="form-control input-primary w260" />
					</li>
					<li><label>工龄工资：</label><input name="subs_age"  value="${vo.subs_age }" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>备注：</label><input name="remark"  value="${vo.remark }" type="text" class="form-control input-primary w260" />
					</li>
					
				<li class="layui-form">
					<label>状态：</label>
					<div class="layui-input-block w160">
						<input type="radio"  name="state" value="0" title="启用" <c:if test="${vo.state==0}">checked="checked"</c:if>>
						<input type="radio"  name="state" value="1" title="禁用" <c:if test="${vo.state==1}">checked="checked"</c:if>>
					</div>
				</li>
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