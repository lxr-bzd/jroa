<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/global.jsp"%>	
<title>查询列表</title>
<script>
var toAddUrl = '${path}/data/finance/emp/toedit.do';
var deleteUrl = '${path}/data/finance/emp/delete.do';
var toEditUrl = '${path}/data/finance/emp/toedit.do';
var toInfoUrl = '${path}/data/finance/emp/view.do';
	
	
	
  
	
	//设置查询参数
	function getParam(params) {
		var queryParams = $("#searchForm").serializeObject();
		
		return queryParams;
	}
	
	//查询列表
    function refTable(){
		var empid = "${param.empid}";
    	$app.request("${path}/project/project/prjCollect/view.do?sysType=bysalesman&empid="+empid,function(data){
    		if(data.status!=0){
    			$app.alert(data.msg);
    			return;
    		}
    		
		$("#tab_group").html(template("tabTmp",{data:data.data}));
		
		
		},{param:getParam()});
    }
    
	
	$(function(){
		refTable();
	})

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
<body class="mlr15">

    
    <div class="rightinfo explain_col">
		<div>
    		<form id="searchForm" name="searchForm"  method="post">
			
    			<span>所属部门：</span>
    			<div style="display: inline;" class="lxr_multipleSelect" data-name="deptid" data-model="deptSelect"> </div>
				<input name="deptid" type="hidden">
				&nbsp;&nbsp;&nbsp;
				<span>时间：</span>
				<input placeholder="开始" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
    			<input type="hidden" name="regStart">--
				<input placeholder="结束" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
				<input type="hidden" name="regEnd">
				&nbsp;&nbsp;&nbsp;
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="queryList()">
    		</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	   
	  
		</div>
    </div>
    	<table class="table_list" data-toggle="table">
			<thead>
				<tr>
					<th>项目名称</th>
					<th>客户名称</th>
					<th>业务员</th>
					<th>收款时间</th>
					<th>收款金额</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody id="tab_group">
				
			</tbody>
		</table>
		
    
</body>
	<script type="text/html" id="tabTmp">
 {{each data as val i}}
    
			<tr>
					<td>{{val.prjName}}</td>
					<td>{{val.cusName}}</td>
					<td>{{val.empName}}</td>
					<td>{{val.birthdayNum}}</td>
					<td>{{val.money}}</td>
					<td>{{val.remark}}</td>
				</tr>
	{{/each}}
	
	</script>
	
</html>
