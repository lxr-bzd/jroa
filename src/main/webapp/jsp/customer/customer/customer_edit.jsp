<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>
<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑页面</title>
<script type="text/javascript">

var depts = [];


var backurl = "${path}/customer/customer/customer.do";


	
	function toSubmit(){
		//表单验证
		if(!$("#submit_form").valid())
				return;
				
		$app.loading(function(onfinsh){
		//表单提交
		$("#submit_form").ajaxSubmit({
			url:$("#submit_form").attr("data-action"),
			cache : false,
			dataType : 'JSON',
			type:'post',
			success:function(data){
				onfinsh();
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
		initType();
		
		if(isedit())initProducts();
		
		
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
	
	
	function selectProduct(){
		var content = $("#proHtml").html();
		$lxr.dialog(function(body){
			  body.find('#proTable').bootstrapTable();
		}
		,function(body){
			var rows = getSelectedRows("proTable");
			if(!rows){
				$app.alert("未选择一条数据");
				return false;
			}
			renderProducts(rows);
		},{content:content,title:"选择产品"});
		
	}
	
	
	function renderProducts(ps){
		
		var html = "";
		
		for (var i = 0; i < ps.length; i++) {
			html+=' <h3 style="display:inline;"><span class="label label-default">'+ps[i].name+' <span class="glyphicon glyphicon-remove" onclick="onRemoveProduct(this)"></span>'
			+'<input name="productids" type="hidden" value="'+ps[i].id+'"></span></h2>';
		}
		$("#submit_form .products_group").html(html);
		$("#submit_form .products_group").data("products",ps);
		
	}
	
	function initProducts(){
		var ps =  $.parseJSON($("#submit_form .products_group").attr("data-val"));
		renderProducts(ps);
	}
	
	
	function onRemoveProduct(span){
		$(span).parent().remove();
		
	}
	
	
	
	function initType(){
		$app.request("${path}/customer/customer/cusType/view.do?type=all",function(data){
			
			var array = data.data;
			var html = ' <select name="typeid">';
		      
			for (var i = 0; i < array.length; i++) {
				html+='<option value="'+array[i].id+'" >'+array[i].name+'</option>'
			}
			html+=' </select>'
			$("#submit_form .type_group").html(html);
			var val = $("#submit_form .type_group").attr("data-val");
			
			if(val)$("#submit_form .type_group>select").val(val);
			form.render('select');
		});
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


</script>


<script type="text/javascript">

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

function refTable(tb){
	
	$(tb).bootstrapTable('refresh');
}

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
</head>
<body>
	<div>
		
		<div class="formbody">

<c:if test="${empty param.sysAction}">
		
   			
   			<form id="submit_form" class="layui-form" data-isadd="true" method="post" data-action="${path}/customer/customer/customer/save.do">
   				<ul class="forminfo">
					<li><label>客户名称：</label><input name="name" type="text" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>客户质量：</label>
					<div class="type_group w260 selectBox">
							
					</div>
					</li>
					
					<li><label>联系人：</label><input name="contacts" type="text" type="text" class="form-control input-primary w260" />
					</li>
					<li><label>联系电话：</label><input name="phone" type="text" type="text" class="form-control input-primary w260" />
					</li>
					<li><label>关联产品：</label>
					<div class="products_group" style="display:inline;"></div>
					<input type="button" class="btn btn-primary" value="选择产品" onclick="selectProduct()" />
					</li>
					
					<li><label>跟进状态：</label>
						<div class="w260 selectBox">
						    <select name="follow">
						        <option value="1" >初访</option>
						        <option value="2" >意向</option>
						        <option value="3" >报价</option>
						        <option value="4" >成交</option>
						        <option value="5" >搁置</option>
						    </select>
					   </div>
					</li>
					<li><label>客户来源：</label><input name="source" type="text" class="form-control input-primary w260" />
					<li><label>所属行业：</label><input name="industry" type="text" class="form-control input-primary w260" />
					<li><label>人员规模：</label><input name="scale" type="text" class="form-control input-primary w260" />
					
					
					<li><label>地址：</label><input name="addr" type="text"  class="form-control input-primary w260" />
					</li>
					
					
				<li><label>状态：</label>
					<input type="radio"  name="state" value="0" title="启用" checked="checked">
					<input type="radio"  name="state" value="1" title="禁用"  >
				</li>
				<li><label>业务员：</label>
					<div class="input-group">
		            			<input name="empName" readonly="readonly" type="text" class="form-control input-primary w260" />
		            			
		           				<span class="input-group-btn">
									<button class="btn btn-default" onclick="onSelectEmp('empName','empid')" type="button">选择</button>
								</span>
		        			</div><input name="empid"  type="hidden" />
					
					</li>
				
	    		</ul>
	    		<div class="btnWrap">
					<input name="" type="button" class="btn btn-primary" value="确认保存" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/>
	    		</div>
    		</form>
    		
</c:if>

<c:if test="${param.sysAction=='edit'}">


   			<form id="submit_form" class="layui-form"  method="post" data-action="${path}/customer/customer/customer/update.do">
   				<input name="id" type="hidden" value="${vo.id }">
   				<ul class="forminfo">
					<li><label>客户名称：</label><input name="name" value="${vo.name }" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>客户质量：</label>
					<div class="type_group w260 selectBox" data-val="${vo.typeid }">
							
					</div>
					</li>
					
					<li><label>联系人：</label><input name="contacts" value="${vo.contacts }" type="text" class="form-control input-primary w260" />
					</li>
					<li><label>联系电话：</label><input name="phone" value="${vo.phone }" type="text" class="form-control input-primary w260" />
					</li>
					<li><label>关联产品：</label><div class="products_group" data-val='${productsJson }' style="display:inline;"></div>
					
					<input name="" type="button" class="btn btn-primary" value="选择产品" onclick="selectProduct()" />
					</li>
					
					<li><label>跟进状态：</label>
						<div class="w260 selectBox">
						    <select name="follow">
						        <option value="1" <c:if test="${vo.follow==1}">selected="selected"</c:if>>初访</option>
						        <option value="2" <c:if test="${vo.follow==2}">selected="selected"</c:if>>意向</option>
						        <option value="3" <c:if test="${vo.follow==3}">selected="selected"</c:if>>报价</option>
						        <option value="4" <c:if test="${vo.follow==4}">selected="selected"</c:if>>成交</option>
						        <option value="5" <c:if test="${vo.follow==5}">selected="selected"</c:if>>搁置</option>
						    </select>
					   </div>
					</li>
					<li><label>客户来源：</label><input name="source" value="${vo.source }" type="text" class="form-control input-primary w260" />
					<li><label>所属行业：</label><input name="industry" value="${vo.industry }" type="text" class="form-control input-primary w260" />
					<li><label>人员规模：</label><input name="scale" value="${vo.scale }" type="text" class="form-control input-primary w260" />
					
					
					<li><label>地址：</label><input name="addr" value="${vo.addr }" type="text"  class="form-control input-primary w260" />
					</li>
					
					
				<li><label>状态：</label>
					<input type="radio"  name="state" value="0" title="启用" <c:if test="${vo.state==0}">checked="checked"</c:if>>
					<input type="radio"  name="state" value="1" title="禁用" <c:if test="${vo.state==1}">checked="checked"</c:if>>
				</li>
				
				<li><label>业务员：</label>
					<div class="input-group">
		            			<input name="empName" readonly="readonly" type="text" value="${vo.empName }" class="form-control input-primary w260" />
		            			
		           				<span class="input-group-btn">
									<button class="btn btn-default" onclick="onSelectEmp('empName','empid')" type="button">选择</button>
								</span>
		        			</div><input name="empid"  type="hidden" value="${vo.empid }"/>
					
					</li>
				
	    		</ul>
	    		<div class="btnWrap">
					<input name="" type="button" class="btn btn-primary" value="确认保存" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/>
	    		</div>
    		</form>
</c:if>
	    </div>
	</div>
</body>

<script type="text/html" id="proHtml">

<table class="table_list" id="proTable" data-toggle="table"
			data-url="${path}/customer/customer/product/view.do" data-pagination="ture" 
			data-side-pagination="server" data-cache="false" data-query-params="postQueryParams"
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
				</tr>
			</thead>
		</table>

</script>

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
					
					
					<th data-field="state" data-formatter="$app.tableUi.state" >状态</th>
				</tr>
			</thead>
		</table>

</script>

</html>
