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

	$app.alert("暂不支持！");
				
}

$(function() {
	
		$app.form.format($('#submit_form'));
		
	
});


function goBackList(){
	var index = parent.layer.getFrameIndex(window.name);
	if(isNaN(index))window.location=backurl;
	else
	parent.layer.close(index);
	
}



</script>

</head>
<body>
	<div>
		
		<div class="formbody">

   			
<form id="submit_form" method="post" data-action="${path}/personnel/employee/emp/update.do">
<input type="hidden" name="id" value="${vo.id }">
   				<div class="">
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
											<td><input name="deptName" value="${vo.placeName }" onfocus="selectProduct()" type="text" class="form-control input-primary" />
											</td>
										</tr>
									</table>
								</td>
								<td>
									<table width="100%">
										<tr>
											<th>等级</th>
											<td><input name="deptName" value="${vo.levelName }" onfocus="selectProduct()" type="text" class="form-control input-primary" />
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
											<th>生日</th>
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
											<td><select name="political" class="form-control input-primary w100" >
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
											      <option value="1"<c:if test="${vo.sex==1}">selected = "selected"</c:if> >已婚</option>
											      <option value="2"<c:if test="${vo.sex==2}">selected = "selected"</c:if> >未婚</option>
											      <option value="3"<c:if test="${vo.sex==3}">selected = "selected"</c:if>>离异</option>
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
											<td> <select name="education" class="form-control input-primary w100" > 
											    <option value="4" <c:if test="${vo.education==4}">selected = "selected"</c:if>>大专（高职）</option>
											    <option value="5" <c:if test="${vo.education==5}">selected = "selected"</c:if>>本科</option>
										 	    <option value="6" <c:if test="${vo.education==6}">selected = "selected"</c:if>>研究生</option>
											    <option value="3" <c:if test="${vo.education==3}">selected = "selected"</c:if>>高中（职高、中专）</option>
											    <option value="2" <c:if test="${vo.education==2}">selected = "selected"</c:if>>初中</option>
											    <option value="1" <c:if test="${vo.education==1}">selected = "selected"</c:if>>小学</option>
											    </select></td>
										</tr>
									</table>
								</td>
								<td colspan="1">
									<table width="100%">
										<tr>
											<th>专业</th>
											<td><input name="major" value="${vo.major }"   type="text" class="form-control input-primary" /></td>
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
							<%-- <tr>
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
							</tr> --%>
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
				</div>
				<div class="btnWrap">
					<input name="" type="button" class="btn btn-primary" value="打印" onclick="toSubmit()"/>
				</div>
    		</form>
	
	    </div>
	</div>
</body>



</html>
