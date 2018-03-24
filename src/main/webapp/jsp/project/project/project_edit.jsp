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


var backurl = "${path}/project/project/project.do";


	
	function toSubmit(){
		updateMebs();
		$app.form.preSubmit("#submit_form");
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
				
				else $app.alert(data.msg?data.msg:'编辑失败');
				
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
	
	function isedit(){
		return $("#submit_form ").attr("data-isadd")?false:true;
	}
	
</script>
	<script type="text/javascript">
	$(document).ready(function () {
		if(isedit())$app.form.format($('#submit_form'));
		if(isedit()){
			initProducts();
			initMebs();
		}
		 
		 $("#submit_form").validate({
			 ignore: [],
			  rules: {
					name: {required: true}
		 			,customrid:{required: true}
		 			,product:{required: true}
					,managerid:{required: true}
					,receivable:{required: true,number:true}
					,received:{required: true,number:true}
					,uncollected:{required: true,number:true}
					,salesmanid:{required: true}
					,signtime:{required: true}
					,renew:{number:true}
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
	
	
	function initProducts(){
		var ps =  $.parseJSON($("#submit_form .products_group").attr("data-val"));
		renderProducts(ps);
	}
	
	function initMebs(){
		
		var ps =  $.parseJSON($("#member_group").attr("data-val"));

		if(!(ps instanceof Array))return;
		
		for (var i = 0; i < ps.length; i++) {
			ps[i].index=i;
			$('#member_group>tbody').append(template("mebTmp",ps[i]));
		}
		
		
		
		
	}
	
	
	function onSelectCus(){
		var content = $("#cusHtml").html();
		$lxr.dialog(function(body){
			  body.find('#cusTable').bootstrapTable();
			  $app.form("#cusSearchForm");
		}
		,function(body){
			var rows = getSelectedRows("cusTable");
			if(!rows){
				$app.alert("未选择一条数据");
				return false;
			}
			
			var data = rows[0];
			
		$("#submit_form input[name=customrName]").val(data.name);
		$("#submit_form input[name=customrid]").val(data.id);
	$("#cusInfo_group").html("联系人："+data.contacts+","+"联系人电话："+data.phone+"");
		},{content:content,title:"选择客户"});
		
	}
	
	
	function onSelectProduct(){
		var content = $("#productHtml").html();
		$lxr.dialog(function(body){
			  body.find('#productTable').bootstrapTable();
			 
		}
		,function(body){
			var rows = getSelectedRows("productTable");
			if(!rows){
				$app.alert("未选择一条数据");
				return false;
			}
			renderProducts(rows);
			//var data = rows[0];
		//$("#submit_form input[name=productName]").val(data.name);
		//$("#submit_form input[name=productid]").val(data.id);
			
		},{content:content,title:"选择产品"});
	}
	
	
	
	function onSelectMeb(){
		
		onSelectMan(function(data){
			var rolename = data.placeName;
			
			if(!rolename){
				$app.alert("角色名不能为空");
				return false;
			}			
			
			var index = parseInt($('#member_group>tbody>tr:last').attr('data-index'))+1;
			if(isNaN(index))index = 0;
			
			var model = {index:index,empid:data.id,empName:data.name,role:rolename};
			
			
			$('#member_group>tbody').append(template("mebTmp",model));
				
			});
		
		
	}
	
	

	function updateMebs(){
		$('#member_group>tbody>tr').each(function(i,e){
			$(e).find(".role").attr("name","mebs["+i+"][role]")
			$(e).find(".empid").attr("name","mebs["+i+"][empid]")
		});
		
	}
	
	
	function onSelectEmp(name,vname){
		onSelectMan(function(data){
			
		$("#submit_form input[name="+name+"]").val(data.name);
		$("#submit_form input[name="+vname+"]").val(data.id);
			
		});
		
	}
	

	function onSelectMan(fun){
		var content = $("#manHtml").html();
		$lxr.dialog(function(body){
			  body.find('#manTable').bootstrapTable();
			  $app.form("#manSearchForm");
		}
		,function(body){
			var rows = getSelectedRows("manTable");
			if(!rows){
				$app.alert("未选择一条数据");
				return false;
			}
			
			var data = rows[0];
			
			
			fun(data);
		},{content:content,title:"选择"});
		
	}
	
	function renderProducts(ps){
		
		var eps = [];
		
		$("#submit_form .products_group>h3").each(function(i,e){
			if($(e).find(">input").val()==ps.id)
				eps.push(ps.id);
			
		});
		
		var newps = [];
		
		for (var i = 0; i < ps.length; i++) {
			var isexit = false;
			for (var j = 0; j < eps.length; j++) {
				if(eps[i]==ps[i].id){isexit=true;break;}
			}
			if(!isexit)newps.push(ps[i]);
			
			
		}
		
				
		var html = "";
		
		for (var i = 0; i < newps.length; i++) {
			
			html+=' <h3 style="display:inline;"><input name="productids" type="hidden" value="'+newps[i].id+'">'
			+'<span class="label label-default">'+newps[i].name+' <span class="glyphicon glyphicon-remove" onclick="$(this).parent().remove();"></span>'
			+'</span></h2>';
		}
		$("#submit_form .products_group").append(html);
		//$("#submit_form .products_group").data("products",ps);
		
	}
	
	
	
	
	
	
	$(function(){
		$app.form("#submit_form");
		
		
	});
	
	
</script>
</head>
<body>
	<div>
		
		<div class="formbody">

<c:if test="${empty param.sysAction}">
		
   			
   			<form id="submit_form" data-isadd="true" method="post" data-action="${path}/project/project/project/save.do">
   				<ul class="forminfo">
					<li><label>项目名称：</label><input name="name" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>客户：</label>
							<div class="input-group">
		            			<input name="customrName" readonly="readonly"   type="text" class="form-control input-primary w260" />
		            			
		           				<span class="input-group-btn">
									<button class="btn btn-default" type="button" onclick="onSelectCus()">选择</button>
								</span>
		        			</div>
								<input name="customrid"  type="hidden" />
					</li>
					<li ><label></label>
					<div id="cusInfo_group">
					</div>
							
					</li>
					
					
					<li><label>产品：</label>
					<div class="products_group" style="display:inline;"></div>
					<input type="button" class="btn btn-primary" value="选择产品" onclick="onSelectProduct()" />
				<%-- 
							<div class="input-group w260">
		            			<input name="productName" readonly="readonly" value="${vo.productName }"  type="text" class="form-control input-primary " />
		           				<span class="input-group-btn">
									<button class="btn btn-default" type="button" onclick="onSelectProduct()">选择</button>
								</span>
		        			</div>
								<input name="productid" value="${vo.productid }" type="hidden" /> --%>
					</li>
					
					<li><label>项目经理：</label>
							<div class="input-group">
		            			<input name="managerName"  type="text" readonly="readonly" class=" form-control input-primary w260" />
		            			
		           				<span class="input-group-btn">
									<button class="btn btn-default" type="button" onclick="onSelectEmp('managerName','managerid')">选择</button>
								</span>
		        			</div>
								<input name="managerid"  type="hidden" />
					
					</li>
				<!-- <li><label>项目成员：</label><textarea name="member" rows="" cols="" class="form-control input-primary  w260"></textarea>
					</li> -->
				<li><label>项目成员：</label>
				<div class="table-responsive">
						  <table id="member_group" class="table table-bordered" >
						  
						    <thead>
						      <tr>
						        <th>项目角色</th>
						        <th>成员</th>
						        <th>操作</th>
						        </tr>
						    </thead>
						    <tbody>
						      
						    </tbody>
						    <tfoot>
						    	<tr>
						   		 <td colspan="3" ><a href="javascript:onSelectMeb()">添加</a></td>
						   		 <tr>
						    </tfoot>
						  </table>
				</div>	
								
				
				</li>
					
					<li><label>应收帐款：</label><input name="receivable"  type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>实收帐款：</label><input name="received"  type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>尾款：</label><input name="uncollected"  type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>业务员：</label>
					<div class="input-group">
		            			<input name="salesmanName" readonly="readonly" type="text" class="form-control input-primary w260" />
		            			
		           				<span class="input-group-btn">
									<button class="btn btn-default" onclick="onSelectEmp('salesmanName','salesmanid')" type="button">选择</button>
								</span>
		        			</div><input name="salesmanid"  type="hidden" />
					
					</li>
					
					<li><label>签单时间：</label><input data-lxr="{type:'time',format:'yyyy-MM-dd hh:mm:ss'}"  value="" placeholder="时间" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary  w260" onfocus="WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'})" >
    				<input name="signtime" type="hidden" >
    				</li>
					
					
				<li><label>项目状态：</label>
					<input type="radio"  name="pro_state" value="1" checked="checked">正常
					<input type="radio"  name="pro_state" value="2"  >紧急
				</li>
					
				<li><label>项目进度：</label>
					<select name="progressid" data-model='{url:"${path}/project/setting/progress/view.do?limit=-1&offset=0",val:"id",name:"name",root:"rows"}' class="lxr-select form-control  w200" style="display: inline;" ></select>
    			
				</li>
				<li><label>续费金额：</label><input name="renew"  type="text" class="form-control input-primary w260" />
					</li>
				<li><label>续费时间：</label><input data-lxr="{type:'time',format:'yyyy-MM-dd'}"  value="" placeholder="时间" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary  w260" onfocus="WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'})" >
    				<input name="renewtime" type="hidden" >
    			</li>
				<li><label>续费内容：</label>
					<textarea name="renew_content" rows="" cols=""class="form-control input-primary  w260"></textarea>
				</li>
				
				<li><label>其他：</label>
					<textarea name="remark" rows="" cols=""class="form-control input-primary  w260"></textarea>
				</li>
				
				</ul>
	    		<div class="btnWrap">
					<input name="" type="button" class="btn btn-primary" value="确认保存" onclick="toSubmit()">&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();">
	    		</div>
    		</form>
    		
</c:if>

<c:if test="${param.sysAction=='edit'}">


   			<form id="submit_form"  method="post" data-action="${path}/project/project/project/update.do">
   				<input name="id" value="${vo.id }" type="hidden"  />
   				<ul class="forminfo">
					<li><label>项目名称：</label><input name="name" value="${vo.name }" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>客户：</label>
							<div class="input-group">
		            			<input name="customrName" readonly="readonly" value="${vo.customrName }"  type="text" class="form-control input-primary w260 " />
		           				<span class="input-group-btn">
									<button class="btn btn-default" type="button" onclick="onSelectCus()">选择</button>
								</span>
		        			</div>
								<input name="customrid" value="${vo.customrid }" type="hidden" />
					</li>
					
					<li><label>产品：</label><div class="products_group" data-val='${productsJson }' style="display:inline;"></div>
					
					<input name="" type="button" class="btn btn-primary" value="选择产品" onclick="onSelectProduct()" />
					</li>
					
					<%-- <li><label>产品：</label>
							<div class="input-group w260">
		            			<input name="productName" readonly="readonly" value="${vo.productName }"  type="text" class="form-control input-primary " />
		           				<span class="input-group-btn">
									<button class="btn btn-default" type="button" onclick="onSelectProduct()">选择</button>
								</span>
		        			</div>
								<input name="productid" value="${vo.productid }" type="hidden" />
					</li> --%>
					
					
					<li><label>项目经理：</label>
							<div class="input-group">
		            			<input name="managerName" value="${vo.managerName }" type="text" readonly="readonly" class=" form-control input-primary w260 " />
		            			
		           				<span class="input-group-btn">
									<button class="btn btn-default" type="button" onclick="onSelectEmp('managerName','managerid')">选择</button>
								</span>
		        			</div>
								<input name="managerid" value="${vo.managerid }" type="hidden" />
					
					</li>
					<%-- 
					<li><label>项目成员：</label><textarea name="member" rows="" cols="" class="form-control input-primary  w260">${vo.member }</textarea>
					</li> --%>
					
					<li><label>项目成员：</label>
				<div class="table-responsive">
						  <table id="member_group" data-val='${mebsJson }' class="table table-bordered" >
						  
						    <thead>
						      <tr>
						        <th>项目角色</th>
						        <th>成员</th>
						        <th>操作</th>
						        </tr>
						    </thead>
						    <tbody>
						      
						    </tbody>
						    <tfoot>
						    	<tr>
						   		 <td colspan="3" ><a href="javascript:onSelectMeb()">添加</a></td>
						   		 <tr>
						    </tfoot>
						  </table>
				</div>	
								
				
				</li>
					
					<li><label>应收帐款：</label><input name="receivable" value="${vo.receivable }" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>实收帐款：</label><input readonly="readonly" value="${vo.received }" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>尾款：</label><input readonly="readonly" value="${vo.receivable-vo.received }" type="text" class="form-control input-primary w260" />
					<input name="uncollected"  value="${vo.uncollected }" type="hidden"  />
					</li>
					
					<li><label>业务员：</label>
					<div class="input-group">
		            			<input name="salesmanName" value="${vo.salesmanName }" readonly="readonly" type="text" class="form-control input-primary w260" />
		            			
		           				<span class="input-group-btn">
									<button class="btn btn-default"  onclick="onSelectEmp('salesmanName','salesmanid')" type="button">选择</button>
								</span>
		        			</div><input name="salesmanid" value="${vo.salesmanid }" type="hidden" />
					
					</li>
					
					<li><label>签单时间：</label><input data-lxr="{type:'time',format:'yyyy-MM-dd'}" data-format="{type:'time',val:'${vo.signtime }',format:'yyyy-MM-dd'}" value="" placeholder="时间" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary  w260" onfocus="WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'})" >
    				<input name="signtime" value="${vo.signtime }" type="hidden" >
    				</li>
					
					
				<li><label>项目状态：</label>
					<input type="radio"  name="pro_state" value="1" <c:if test="${vo.pro_state==1}">checked="checked"</c:if>>正常
					<input type="radio"  name="pro_state" value="2" <c:if test="${vo.pro_state==2}">checked="checked"</c:if> >紧急
				</li>
					
				<li><label>项目进度：</label>
					<select name="progressid" data-model='{initVal:"${vo.progressid }",url:"${path}/project/setting/progress/view.do?limit=-1&offset=0",val:"id",name:"name",root:"rows"}' class="lxr-select form-control  w200" style="display: inline;" ></select>
    			</li>
				<li><label>续费金额：</label><input name="renew" value="${vo.renew}" type="text" class="form-control input-primary w260" />
					</li>
				<li><label>续费时间：</label><input data-lxr="{type:'time',format:'yyyy-MM-dd'}" data-format="{type:'time',val:'${vo.renewtime }',format:'yyyy-MM-dd'}" value="" placeholder="时间" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary  w260" onfocus="WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'})" >
    				<input name="renewtime" value="${vo.renewtime }" type="hidden" >
    			</li>
				<li><label>续费内容：</label>
					<textarea name="renew_content" rows="" cols=""class="form-control input-primary  w260">${vo.renew_content}</textarea>
				</li>
				
				<li><label>其他：</label>
					<textarea name="remark" rows="" cols="" class="form-control input-primary  w260">${vo.remark }</textarea>
				</li>
					
					
	    		</ul>
	    		
	    		<div class="btnWrap">
					<input name="" type="button" class="btn btn-primary" value="确认保存" onclick="toSubmit()">&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();">
	    		</div>
    		</form>
		
    		
</c:if>
	    </div>
	</div>
	
	
	
	
</body>
<script type="text/html" id="manHtml">
<div class="rightinfo explain_col" style="text-align: left;">
    		<form id="manSearchForm"   method="post">
			<span>所属部门：</span>
    			<div style="display: inline;" class="lxr_multipleSelect" data-name="deptid" data-model="deptSelect"> </div>
				
    			<span>名称：</span>
    			<input name="kw" value="" placeholder="名称"  class="form-control input-sm w200" type="text" style="display: inline;" >
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="refTable('#manTable')">
    		</form>
    	</div>

<table class="table_list" id="manTable" data-toggle="table"
			data-url="${path}/personnel/employee/emp/view.do" data-pagination="ture" 
			data-side-pagination="server" data-cache="false" data-query-params="postQueryParams"
			data-page-list="[10, 20, 35, 50]" data-page-size= "10" data-method="post"
			data-show-refresh="false" data-show-toggle="false"
			data-show-columns="false" data-toolbar="#toolbar"
			data-click-to-select="false" data-single-select="true"
			data-striped="false" data-content-type="application/x-www-form-urlencoded"
			>
			<thead>
				<tr>
				<th data-field="" data-checkbox="true"></th>
					<th data-field="id" >id</th>
					<th data-field="name" >姓名</th>
					<th data-field="deptName" >部门</th>
					<th data-field="placeName" >职位</th>
					
					<th data-field="phone" >手机号</th>
					
					<th data-field="sex" data-formatter="$app.tableUi.sex" >性别</th>
					<th data-field="state" data-formatter="$app.tableUi.state" >状态</th>
				</tr>
			</thead>
		</table>

</script>


<script type="text/html" id="cusHtml">
<div class="rightinfo explain_col" style="text-align: left;">
<form id="cusSearchForm" method="post">
    			<span>所属部门：</span>
    			<div style="display: inline;" class="lxr_multipleSelect" data-name="deptid" data-model="deptSelect"> </div>
				
    			<span>关键词：</span><input name="kw" value="" placeholder="业务员/客户"  class="form-control input-sm w200" type="text" style="display: inline;" >
				
				
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="refTable('#cusTable')">
    		</form>
</div>
<table class="table_list" id="cusTable" data-toggle="table"
			data-url="${path}/customer/customer/customer/view.do?state=0" data-pagination="ture" 
			data-side-pagination="server" data-cache="false" data-query-params="cusQueryParams"
			data-page-list="[10, 20, 35, 50]" data-page-size= "10" data-method="post"
			data-show-refresh="false" data-show-toggle="false"
			data-show-columns="false" data-toolbar="#toolbar"
			data-click-to-select="false" data-single-select="true"
			data-striped="false" data-content-type="application/x-www-form-urlencoded"
			>
			<thead>
				<tr>
				
					<th data-field="" data-checkbox="true"></th>
					<th data-field="id" >ID</th>
					<th data-field="name" >名称</th>
					<th data-field="typeName">客户类型</th>
					<th data-field="contacts" >联系人</th>
					<th data-field="empName" >业务员</th>
					<th data-field="deptName" >部门</th>
					<th data-field="state"  data-formatter="$app.tableUi.state">状态</th>
				</tr>
			</thead>
		</table>
</script>


<script type="text/html" id="productHtml">
<table class="table_list" id="productTable" data-toggle="table"
			data-url="${path}/customer/customer/product/view.do" data-pagination="ture" 
			data-side-pagination="server" data-cache="false" data-query-params=""
			data-page-list="[10, 20, 35, 50]" data-page-size= "10" data-method="post"
			data-show-refresh="false" data-show-toggle="false"
			data-show-columns="false" data-toolbar="#toolbar"
			data-click-to-select="false" data-single-select="false"
			data-striped="false" data-content-type="application/x-www-form-urlencoded"
			>
			<thead>
				<tr>
					<th data-field="" data-checkbox="true"></th>
					<th data-field="id" >ID</th>
					<th data-field="name" >产品名称</th>
					<th data-field="info"  >产品介绍</th>
					<th data-field="createtime"  >录入时间</th>
				</tr>
			</thead>
		</table>
</script>

<script type="text/html" id="mebHtml">
<table class="table_list" id="productTable" data-toggle="table"
			data-url="${path}/customer/customer/product/view.do" data-pagination="ture" 
			data-side-pagination="server" data-cache="false" data-query-params=""
			data-page-list="[10, 20, 35, 50]" data-page-size= "10" data-method="post"
			data-show-refresh="false" data-show-toggle="false"
			data-show-columns="false" data-toolbar="#toolbar"
			data-click-to-select="false" data-single-select="false"
			data-striped="false" data-content-type="application/x-www-form-urlencoded"
			>
			<thead>
				<tr>
					<th data-field="" data-checkbox="true"></th>
					<th data-field="id" >ID</th>
					<th data-field="name" >产品名称</th>
					<th data-field="info"  >产品介绍</th>
					<th data-field="createtime"  >录入时间</th>
				</tr>
			</thead>
		</table>
</script>

<script type="text/html" id="mebTmp">
<tr data-index="{{index}}">
<input class="role" name="mebs[{{index}}][role]" value="{{role}}"  type="hidden" />
<td>{{role}}</td>
<input class="empid" name="mebs[{{index}}][empid]" value="{{empid}}" type="hidden" />
<td>{{empName}}</td>
<td><a onclick="$(this).parent().parent().remove();">移除</a></td>
</tr>

</script>
<script type="text/javascript">
//设置查询参数
function postQueryParams(params) {
	
	
	// $app.form.preSubmit("#searchForm");
	var queryParams = $("#manSearchForm").serializeObject();
	
	var id =  $app.form.multipleSelectVal("#manSearchForm .lxr_multipleSelect");
	if(id||id==0)queryParams.deptStr=deptUnder(id).join(",");
	queryParams.limit=params.limit;
	queryParams.offset=params.offset;
	//	queryParams.deptid = $app.form.multipleSelectVal("#searchForm .lxr_multipleSelect");
	return $lxr.trimObject(queryParams); 
}
function cusQueryParams(params){
	$app.form.preSubmit("#cusSearchForm");
	var queryParams = $("#cusSearchForm").serializeObject();
	var id =  $app.form.multipleSelectVal("#cusSearchForm .lxr_multipleSelect");
	if(id||id==0)queryParams.deptStr=deptUnder(id).join(",");
	queryParams.limit=params.limit;
	queryParams.offset=params.offset;
	return $lxr.trimObject(queryParams);
}

function refTable(tb){
	
	$(tb).bootstrapTable('refresh');
}




</script>
<script type="text/javascript">

 
var deptModel;
var depts;

$(function() {
	
	$app.request("${path}/personnel/organize/dept/view.do",function(data){
		deptModel = $lxr.tree(data.data,{pidname:"parentid"});
		depts = data.data;
		$app.form("#searchForm");
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
			//if(pid)renderPlace($app.form.multipleSelectVal("#searchForm .lxr_multipleSelect"));
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
		
		 $("#searchForm select[name=placeid]").replaceWith(html);
	});
	
}

function deptUnder(id){
	var ids = [id];
	var dept;
	for (var i = 0; i < depts.length; i++) {
		if(depts[i].id == id){
			dept = depts[i];
			break;
		}
	}
	if(dept.childs.length>0)
		ids.push(getChilds(dept.childs));
	
	return ids;
}

function getChilds(ds){
	var ids = [];
	for (var i = 0; i < ds.length; i++) {
		ids.push(ds[i].id);
		if(ds[i].childs.length>0)
			ids.push(getChilds(ds[i].childs));
	}
	return ids;
	
}

</script>

</html>
