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


var backurl = "${path}/project/project/prjRes.do";


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
	
	function isedit(){
		return $("#submit_form ").attr("data-isadd")?false:true;
		
	}
</script>
	<script type="text/javascript">
	$(document).ready(function () {
		 if(isedit())
			$app.form.format($('#submit_form'));
		 
		 $("#submit_form").validate({
		  rules: {
		prjid: {required: true}
		
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
	

	
	
	function onSelectPrj(){
		var content = $("#prjTemp").html();
		$lxr.dialog(function(body){
			  body.find('#prjTable').bootstrapTable();
			  $app.form("#prjSearchForm");
		}
		,function(body){
			var rows = getSelectedRows("prjTable");
			if(!rows){
				$app.alert("未选择一条数据");
				return false;
			}
			
			var data = rows[0];
			
		$("#submit_form input[name=prjName]").val(data.name);
		$("#submit_form input[name=cusName]").val(data.customrName);
		$("#submit_form input[name=prjid]").val(data.id);
		},{content:content,title:"选择项目"});
	}
	
	
	function postQueryParams(params) {
		
		
		// $app.form.preSubmit("#searchForm");
		var queryParams = $("#manSearchForm").serializeObject();
		
		queryParams.limit=params.limit;
		queryParams.offset=params.offset;
		//	queryParams.deptid = $app.form.multipleSelectVal("#searchForm .lxr_multipleSelect");
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
</head>
<body>
	<div>
		
		<div class="formbody">

<c:if test="${empty param.sysAction}">
		
   			
   			<form id="submit_form" data-isadd="true" method="post" data-action="${path}/project/project/prjRes/save.do">
   				<ul class="forminfo">
					
					<li><label>项目：</label>
							<div class="input-group">
		            			<input name="prjName" readonly="readonly"   type="text" class="form-control input-primary w260" />
		            			
		           				<span class="input-group-btn">
									<button class="btn btn-default" type="button" onclick="onSelectPrj()">选择</button>
								</span>
		        			</div>
								<input name="prjid"  type="hidden" />
					</li>
					<li><label>客户：</label><input name="cusName" readonly="readonly"   type="text" class="form-control input-primary w260" />
		            			
					</li>
					<li><label>域名：</label><textarea name="domain"  rows="" cols="" class="form-control input-primary w260" ></textarea>
					</li>
					<li><label>ftp：</label><textarea name="ftp"  rows="" cols="" class="form-control input-primary w260" ></textarea>
					</li>
					<li><label>微信：</label><textarea name="wx"  rows="" cols="" class="form-control input-primary w260" ></textarea>
					</li>
					<li><label>支付宝：</label><textarea name="alipay"  rows="" cols="" class="form-control input-primary w260" ></textarea>
					</li>
					<li><label>短信：</label><textarea name="msg"  rows="" cols="" class="form-control input-primary w260" ></textarea>
					</li>
					<li><label>安卓：</label><textarea name="android"  rows="" cols="" class="form-control input-primary w260" ></textarea>
					</li>
					<li><label>ios：</label><textarea name="ios"  rows="" cols="" class="form-control input-primary w260" ></textarea>
					</li>
				
	    		</ul>
    		</form>
    		
</c:if>

<c:if test="${param.sysAction=='edit'}">


   			<form id="submit_form"  method="post" data-action="${path}/project/project/prjRes/update.do">
   				<input name="id" value="${vo.id }" type="hidden"  />
   				<ul class="forminfo">
				<li><label>项目：</label>
							<div class="input-group">
		            			<input name="prjName" readonly="readonly" value="${vo.prjName }"  type="text" class="form-control input-primary w260" />
		            			
		           				<span class="input-group-btn">
									<button class="btn btn-default" type="button" onclick="onSelectPrj()">选择</button>
								</span>
		        			</div>
								<input name="prjid" value="${vo.prjid }" type="hidden" />
					</li>
					<li><label>客户：</label><input name="cusName" value="${vo.cusName }" readonly="readonly"   type="text" class="form-control input-primary w260" />
		            			
					</li>
					<li><label>域名：</label><textarea name="domain"  rows="" cols="" class="form-control input-primary w260" >${vo.domain }</textarea>
					</li>
					<li><label>ftp：</label><textarea name="ftp"  rows="" cols="" class="form-control input-primary w260" >${vo.ftp }</textarea>
					</li>
					<li><label>微信：</label><textarea name="wx"  rows="" cols="" class="form-control input-primary w260" >${vo.wx }</textarea>
					</li>
					<li><label>支付宝：</label><textarea name="alipay"  rows="" cols="" class="form-control input-primary w260" >${vo.alipay }</textarea>
					</li>
					<li><label>短信：</label><textarea name="msg"  rows="" cols="" class="form-control input-primary w260" >${vo.msg }</textarea>
					</li>
					<li><label>安卓：</label><textarea name="android"  rows="" cols="" class="form-control input-primary w260" >${vo.android }</textarea>
					</li>
					<li><label>ios：</label><textarea name="ios"  rows="" cols="" class="form-control input-primary w260" >${vo.ios }</textarea>
					</li>
	    		</ul>
    		</form>
		
    		
</c:if>

<div class="btnWrap">
					<input name="" type="button" class="btn btn-primary" value="保存" onclick="toSubmit()">&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();">
	    		</div>
	    </div>
	</div>
</body>



<script type="text/html" id="prjTemp">

<div class="rightinfo explain_col" >
<form id="cusSearchForm" method="post">
    			<span>关键词：</span><input name="kw" value="" placeholder="项目名称"  class="form-control input-sm w200" type="text" style="display: inline;" >
				<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="refTable('#prjTable')">
    		</form>
</div>

<table class="table_list" id="prjTable" data-toggle="table"
	data-url="${path}/project/project/project/view.do" data-pagination="ture" 
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
			<th data-field="name" >项目名称</th>
			<th data-field="customrName" >客户</th>
			<th data-field="managerName" >项目经理</th>
			<th data-field="signtime" data-formatter="$app.tableUi.date" >签单时间</th>
			<th data-field="salesmanName" >业务员</th>
		</tr>
	</thead>
</table>
</script>


</html>
