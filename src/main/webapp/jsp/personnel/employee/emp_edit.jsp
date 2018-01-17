<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑页面</title>
<style type="text/css">
.input-group-addon{
border:none;
background-color:#fff;
}
</style>
<script type="text/javascript">

var backurl = "${path}/personnel/employee/emp.do";

	function toSubmit(){
		var result = perSubmit();
		
		if(result){
			$app.alert(result);
		}
		
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
		$app.form.preSubmit("#submit_form");
			
		}
	
	//取消
	function goBackList(){
		var index = parent.layer.getFrameIndex(window.name);
		if(isNaN(index))window.location=backurl;
		else
		parent.layer.close(index);
		
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
			deptModel = $lxr.tree(data.data,{pidname:"parentid"});
			depts = data.data;
			
		});
		if(isedit()){
			$app.form.format($('#submit_form'));
			
			var pselect = $("#submit_form select[name=placeid]");
			renderPlace($("#submit_form input[name=deptid]").val(),pselect.attr("data-val"));
			
			var lselect = $("#submit_form select[name=levelid]");
			renderLevel(lselect.attr("data-val"));
			
		}else {
			renderLevel();
		}
		
	});
	
	
	function getDeptById(id){
		for (var i = 0; i < depts.length; i++) {
			if(depts[i].id == id)
				return depts[i];
		}
	}
	
	
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
			}
	};
	
	
	function renderPlace(did,val){
		$app.request("${path}/personnel/organize/place/view.do?type=bydeptid&deptid="+did,function(data){
			
			var html = '<option value="">--请选择--</option>';
			if(!$lxr.isEmpty(data.data))
		for (var i = 0; i < data.data.length; i++) {
				html+='<option value="'+data.data[i].id+'">'+data.data[i].name+'</option>';
			}
			
			var h =  $("#submit_form select[name=placeid]");
				/* h.change(function(e){
				
					if(e.target.value)
						renderLevel(e.target.value);
				}); */
			h.html(html);
			if(val)h.val(val);
		});
		
	}
	
	function renderLevel(val){
		$app.request("${path}/personnel/organize/level/view.do?type=all",function(data){
			
			var html = '<option value="">--请选择--</option>';
			if(!$lxr.isEmpty(data.data))
		for (var i = 0; i < data.data.length; i++) {
				html+='<option value="'+data.data[i].id+'">'+data.data[i].name+'</option>';
			}
			var sele = $("#submit_form select[name=levelid]");
			sele.html(html);
			if(val)	sele.val(val);
		});
		
	}
	
	
	
	
	
	$(document).ready(function () {
		   
		
		
		 $("#submit_form").validate({
			 ignore : []
		 ,rules: {
						 name: {required: true}
		 				,deptName:{required: true}
		 				,placeid:{required: true}
		 				,levelid:{required: true}
		 				,identifier:{required: true}
		 				,phone:{required: true,isMobile:true}
		 				,entry_time:{required: true}
		 				,birthday:{required: true}
		 				,idcard:{isIdCardNo:true}
		 				,graduation_time:{required: true}
		 				,height:{number:true}
		 				,weight:{number:true}
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
	
	
	function selectProduct(){
		var content = $("#deptHtml").html();
		$lxr.dialog(function(body){
			$app.form("#deptForm");
			 
		}
		,function(body){
			var id =  $app.form.multipleSelectVal("#deptForm .lxr_multipleSelect");
			if(!id&&id!=0)return;
			var dept = getDeptById(id);
			$("#submit_form input[name=deptName]").val(dept.name);
			$("#submit_form input[name=deptid]").val(dept.id);
			
			renderPlace(id);
			
		},{content:content,title:"选择部门"});
		
	}
</script>
</head>
<body>
	<div>
		
		<div class="formbody">

<c:if test="${empty param.action}">
		
   			
   			<form id="submit_form" data-isadd="true" method="post" data-action="${path}/personnel/employee/emp/save.do">
   				<div class="formTable">
					<table class="forminfo layui-table" cellspacing="0" cellpadding="0" border="0" width="100%">
						<tbody>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>部门</th>
											<td><input name="deptName" onfocus="selectProduct()" type="text" class="form-control input-primary" />
											<input name="deptid"  type="hidden" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>职位</th>
											<td><select name="placeid" class="form-control input-primary w100" ></select>
											</td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>等级</th>
											<td><select name="levelid" class="form-control input-primary w100" ></select>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>入职时间</th>
											<td><input data-lxr="{type:'time',format:'yyyy-MM-dd'}"
					 data-format="{type:'time',val:'${vo.entry_time }',format:'yyyy-MM-dd'}" value="" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary w1" onfocus="WdatePicker({isShowClear:false})" >
					 <input type="hidden" name="entry_time">
					 </td>
								</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>姓名</th>
											<td><input name="name" value="${vo.name }" type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>性别</th>
											<td>
												<div class="layui-form mauto">
											      <input type="radio" name="sex" value="1" title="男" checked="checked">
											      <input type="radio" name="sex" value="2" title="女" >
												</div>
											
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>出生日期</th>
											<td><input data-lxr="{type:'time',format:'yyyy-MM-dd'}"
					 style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary w1" onfocus="WdatePicker({isShowClear:false})" >
					<input name="birthday" type="hidden"></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>籍贯</th>
											<td><input name='origin' type="text" class="form-control" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>民族</th>
											<td><input name="national" type="text" class="form-control" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>政治面貌</th>
											<td>
											<select name="political" class="form-control input-primary w100" >
											       <option value="3">群众</option>
											      <option value="1">党员</option>
											      <option value="2">团员</option>
											     
											 </select>
											
											</td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>婚姻状况</th>
											<td>
											
											      <select name="marriage" class="form-control input-primary w100" >
											      <option value="1">已婚</option>
											      <option value="2">未婚</option>
											      <option value="3">离异</option>
											      </select>
											
											</td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>身高</th>
											<td>
											<div class="input-group">
											<input name="height"  type="text" class="form-control" />
											<span class="input-group-addon">CM</span>
											</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>从业年限</th>
											<td><input name="experience" type="text" class="form-control" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>健康状况</th>
											<td><input name="health" type="text" class="form-control" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>体重</th>
											<td><div class="input-group">
											<input name="weight"  type="text" class="form-control" />
											<span class="input-group-addon">KG</span>
											</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>手机号</th>
											<td><input name="phone"   type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>紧急联系人</th>
											<td><input name="urgent_man" type="text" class="form-control" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>紧急联系人电话</th>
											<td><input name="urgent_phone" type="text" class="form-control" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="1">
										<table width="100%">
											<tr>
												<th>工号</th>
												<td><input name="identifier"   type="text" class="form-control input-primary" /></td>
											</tr>
										</table>
									</td>
								
								<td colspan="2">
									<table width="100%">
										<tr>
											<th>身份证号</th>
											<td><input name="idcard"   type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<table width="100%">
										<tr>
											<th>户口所在地</th>
											<td><input name="reg_area"   type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<table width="100%">
										<tr>
											<th>现家庭住址</th>
											<td><input name="live_area"   type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table width="100%">
										<tr>
											<th>毕业学校</th>
											<td><input name="graduation_school"   type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>毕业时间</th>
											<td><input data-lxr="{type:'time',format:'yyyy-MM-dd'}" 
											 style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary w1" onfocus="WdatePicker({isShowClear:false})" >
											 <input type="hidden" name="graduation_time">
											 </td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>学历</th>
											<td><select name="education" class="form-control input-primary w100" > 
											    <option value="4">大专（高职）</option>
											    <option value="5">本科</option>
											    <option value="6">研究生</option>
											    <option value="3">高中（职高、中专）</option>
											    <option value="2">初中</option>
											    <option value="1">小学</option>
											    </select>
											 </td>
										</tr>
									</table>
								</td>
								<td colspan="1">
									<table width="100%">
										<tr>
											<th>专业</th>
											<td><input name="major"   type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td colspan="1">
									<table width="100%">
										<tr>
											<th>已有职称或证书</th>
											<td><input name="certificate"   type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<table width="100%">
										<tr>
											<th>备注</th>
											<td><textarea name="remark"  class="form-control input-primary w1" ></textarea></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
							<td colspan="1">
									<table width="100%">
										<tr>
											<th>账号</th>
											<td><input name="account"   type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td colspan="1">
									<table width="100%">
										<tr>
											<th>密码</th>
											<td><input name="pwd"   type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td colspan="1">
									<table width="100%">
										<tr>
											<th>是否有效</th>
											<td><div class="layui-form mauto">
											      <input type="radio" name="state" value="0" title="启用" checked="checked">
											      <input type="radio" name="state" value="1" title="禁用" >
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<!--<tr>
								<td colspan="3">
									<div class="pd10 Explain">
										<h4>说明(以下内容仔细阅读):</h4>
										<div>1,填报时,请务必保证填写的内容真实.若因填写有误而引起的问题,其后果由填表人负责.</div>
										<div>2,所有与简历相关的证件(身份证,学历证明,专业资格证书)验原件交复印件.</div>
										<div>
											<div class="autograph fr">
												<label>填表人签名:</label><input type="text" class="ml10" />
												<label>时间:</label><input type="text" class="input-primary ml10" onfocus="WdatePicker({isShowClear:false})" >
											</div>
										</div>
									</div>
								</td>
							</tr>-->
						</tbody>
					</table>
					<div class="fr mt20">
						<label>&nbsp;</label><input name="" type="button" class="btn btn-primary" value="确认" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/>
					</div>
				</div>
    		</form>
    		
</c:if>

<c:if test="${param.action=='edit'}">

<form id="submit_form" method="post" data-action="${path}/personnel/employee/emp/update.do">
<input type="hidden" name="id" value="${vo.id }">
   				<div class="formTable">
					<table class="forminfo layui-table" cellspacing="0" cellpadding="0" border="0" width="100%">
						<tbody>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>部门</th>
											<td><input name="deptName" value="${vo.deptName }" onfocus="selectProduct()" type="text" class="form-control input-primary" />
											<input name="deptid" value="${vo.deptid }" type="hidden" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>职位</th>
											<td><select name="placeid" data-val="${vo.placeid }" class="form-control input-primary w100" ></select>
											</td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>等级</th>
											<td><select name="levelid"  data-val="${vo.levelid }"  class="form-control input-primary w100" ></select>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>入职时间</th>
											<td><input data-lxr="{type:'time',format:'yyyy-MM-dd'}"
					 data-format="{type:'time',val:'${vo.entry_time }',format:'yyyy-MM-dd'}" value="" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary w1" onfocus="WdatePicker({isShowClear:false})" >
					 <input type="hidden" name="entry_time">
					 </td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>姓名</th>
											<td><input name="name" value="${vo.name }" type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>性别</th>
											<td>
												<div class="layui-form mauto">
											      <input type="radio" name="sex" value="1" title="男" <c:if test="${vo.sex==1}">checked="checked"</c:if>>
											      <input type="radio" name="sex" value="2" title="女" <c:if test="${vo.sex==2}">checked="checked"</c:if>>
												</div>
												
												
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>出生日期</th>
											<td><input data-lxr="{type:'time',format:'yyyy-MM-dd'}"
					 data-format="{type:'time',val:'${vo.birthday }',format:'yyyy-MM-dd'}"
					 style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary w1" onfocus="WdatePicker({isShowClear:false})" >
					<input name="birthday" type="hidden"></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>籍贯</th>
											<td><input name='origin' value="${vo.origin }" type="text" class="form-control" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>民族</th>
											<td><input name="national" value="${vo.national }" type="text" class="form-control" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>政治面貌</th>
											<td>
											<select name="political" class="form-control input-primary w100" >
											       <option value="3" <c:if test="${vo.political==3}">selected = "selected"</c:if>>群众</option>
											      <option value="1" <c:if test="${vo.political==1}">selected = "selected"</c:if>>党员</option>
											      <option value="2" <c:if test="${vo.political==2}">selected = "selected"</c:if>>团员</option>
											 </select>
											 </td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>婚姻状况</th>
											<td>
											
											         <select name="marriage" class="form-control input-primary w100" >
											      <option value="1"<c:if test="${vo.marriage==1}">selected = "selected"</c:if> >已婚</option>
											      <option value="2"<c:if test="${vo.marriage==2}">selected = "selected"</c:if> >未婚</option>
											      <option value="3"<c:if test="${vo.marriage==3}">selected = "selected"</c:if>>离异</option>
											      </select>
											
											</td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>身高</th>
											<td>
											<div class="input-group">
											<input name="height" value="${vo.height }" type="text" class="form-control" />
											<span class="input-group-addon" >CM</span>
											</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>从业年限</th>
											<td><input name="experience" value="${vo.experience }" type="text" class="form-control" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>健康状况</th>
											<td><input name="health" value="${vo.health }" type="text" class="form-control" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>体重</th>
											<td>
											<div class="input-group">
											<input name="weight" value="${vo.weight }" type="text" class="form-control" />
											<span class="input-group-addon" >KG</span>
											</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>手机号</th>
											<td><input name="phone" value="${vo.phone }"  type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>紧急联系人</th>
											<td><input name="urgent_man" value="${vo.urgent_man }" type="text" class="form-control" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>紧急联系人电话</th>
											<td><input name="urgent_phone" value="${vo.urgent_phone }" type="text" class="form-control" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="1">
										<table width="100%">
											<tr>
												<th>工号</th>
												<td><input name="identifier" value="${vo.identifier }"  type="text" class="form-control input-primary" /></td>
											</tr>
										</table>
									</td>
								
								<td colspan="2">
									<table width="100%">
										<tr>
											<th>身份证号</th>
											<td><input name="idcard" value="${vo.idcard }"  type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<table width="100%">
										<tr>
											<th>户口所在地</th>
											<td><input name="reg_area" value="${vo.reg_area }"  type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<table width="100%">
										<tr>
											<th>现家庭住址</th>
											<td><input name="live_area" value="${vo.live_area }"  type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table width="100%">
										<tr>
											<th>毕业学校</th>
											<td><input name="graduation_school" value="${vo.graduation_school }"  type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>毕业时间</th>
											<td><input data-lxr="{type:'time',format:'yyyy-MM-dd'}"
											data-format="{type:'time',val:'${vo.graduation_time }',format:'yyyy-MM-dd'}" 
											 style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary w1" onfocus="WdatePicker({isShowClear:false})" >
											 <input type="hidden" name="graduation_time">
											 </td> 
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<th>学历</th>
											<td>
											   <select name="education" class="form-control input-primary w100" > 
											    <option value="4" <c:if test="${vo.education==4}">selected = "selected"</c:if>>大专（高职）</option>
											    <option value="5" <c:if test="${vo.education==5}">selected = "selected"</c:if>>本科</option>
										 	    <option value="6" <c:if test="${vo.education==6}">selected = "selected"</c:if>>研究生</option>
											    <option value="3" <c:if test="${vo.education==3}">selected = "selected"</c:if>>高中（职高、中专）</option>
											    <option value="2" <c:if test="${vo.education==2}">selected = "selected"</c:if>>初中</option>
											    <option value="1" <c:if test="${vo.education==1}">selected = "selected"</c:if>>小学</option>
											    </select>
											</td>
										</tr>
									</table>
								</td>
								<td colspan="1">
									<table width="100%">
										<tr>
											<th>专业</th>
											<td><input name="major"  value="${vo.major }" type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td colspan="1">
									<table width="100%">
										<tr>
											<th>已有职称或证书</th>
											<td><input name="certificate" value="${vo.certificate }"  type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<table width="100%">
										<tr>
											<th>备注</th>
											<td><textarea name="remark"  class="form-control input-primary w1" >${vo.remark }</textarea></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
							<td colspan="1">
									<table width="100%">
										<tr>
											<th>账号</th>
											<td><input name="account" value="${vo.account }"  type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td colspan="1">
									<table width="100%">
										<tr>
											<th>密码</th>
											<td><input name="pwd"  value="${vo.pwd }"  type="text" class="form-control input-primary" /></td>
										</tr>
									</table>
								</td>
								<td colspan="1">
									<table width="100%">
										<tr>
											<th>是否有效</th>
											<td><div class="layui-form mauto">
											      <input type="radio" name="state" value="0" title="启用" <c:if test="${vo.state==0}">checked="checked"</c:if>>
											      <input type="radio" name="state" value="1" title="禁用" <c:if test="${vo.state==1}">checked="checked"</c:if>>
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<!--<tr>
								<td colspan="3">
									<div class="pd10 Explain">
										<h4>说明(以下内容仔细阅读):</h4>
										<div>1,填报时,请务必保证填写的内容真实.若因填写有误而引起的问题,其后果由填表人负责.</div>
										<div>2,所有与简历相关的证件(身份证,学历证明,专业资格证书)验原件交复印件.</div>
										<div>
											<div class="autograph fr">
												<label>填表人签名:</label><input type="text" class="ml10" />
												<label>时间:</label><input type="text" class="input-primary ml10" onfocus="WdatePicker({isShowClear:false})" >
											</div>
										</div>
									</div>
								</td>
							</tr>-->
						</tbody>
					</table>
					<div class="fr mt20">
						<label>&nbsp;</label><input name="" type="button" class="btn btn-primary" value="确认" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/>
					</div>
				</div>
    		</form>
		
    		
</c:if>
	    </div>
	</div>
</body>


<script type="text/html" id="deptHtml">
<form id="deptForm">
<div style="display: inline;" class="lxr_multipleSelect" data-name="deptid" data-model="deptSelect"> </div>
					<input name="deptid" type="hidden">
</form>
</script>

</html>
