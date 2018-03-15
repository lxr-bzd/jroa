﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>	
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询列表</title>
<script type="text/javascript" src="${path}/js/tableExport.min.js"></script>
<script type="text/javascript" src="${path}/js/jquery.base64.js"></script>
<script>
var toAddUrl = '${path}/personnel/employee/emp/toedit.do';
var deleteUrl = '${path}/personnel/employee/emp/delete.do';
var toEditUrl = '${path}/personnel/employee/emp/toedit.do';
var toInfoUrl = '${path}/personnel/employee/emp/view.do';

	//添加
	function toAdd(){
		
		window.location=toAddUrl;
	}
	//删除
	function toRemove(id){
		
		var ids = id;
		if(!id)ids=getSelectedRowsIds('mainTable');
		
		if(ids){
			
			$app.confirmDelete(deleteUrl+'?ids='+ids,'删除数据不可恢复，确定要删除吗？'
					,function(){
				refleshData('mainTable');
			});
			
			
			
		}else{
			$app.alert("请选择一条数据进行操作");
		}
	}
	
	//编辑
    function toEdit(){
    	var selected=getSelectedRowsArr('mainTable');
    	if(selected.length>0&&selected.length<2){
    		window.location=toEditUrl+'?id='+selected+"&action=edit";
    	}else{
    		//提示信息
    		$app.alert('请选择一条数据进行操作');
    		
    	}
	}
	
    //查看
    function toInfo(){
    	var selected=getSelectedRowsArr('mainTable');
    	if(selected.length>0&&selected.length<2){
    		
    		$lxr.modal({url:toInfoUrl+'?id='+selected});
    		
    	}else{
    		$app.alert('请选择一条数据进行操作');
    	}
	}
	
	//设置查询参数
	function postQueryParams(params) {
		var queryParams = $("#searchForm").serializeObject();
		queryParams.limit=params.limit;
		queryParams.offset=params.offset;
		var id =  $app.form.multipleSelectVal("#searchForm .lxr_multipleSelect");
		if(id||id==0)queryParams.deptStr=deptUnder(id).join(",");
		queryParams.state=0;
		return $lxr.trimObject(queryParams);
	}
	//查询列表
    function queryList(){
    	$('#mainTable').bootstrapTable('refresh');
    }
    
    function editById(id){
		window.location=toEditUrl+'?id='+id+"&action=edit";
	}

	

	//根据id查看
	function viewById(id){
		$lxr.modal({url:toInfoUrl+'?id='+id+"&type=info"});
	}
	
    
    function onExcell(){
    	 if($("#mainTable").bootstrapTable('getSelections').length<1){
    		 $app.alert("请选中要导出的数据");
    		 return;
    	 }
    		
    	
    var unselect = getUnSelectRows();
    	$('#mainTable').tableExport({type:'excel',ignoreColumn: [1],ignoreRow:unselect
    		, separator:';', escape:'false'
    			,bootstrap: true
    	,fileName: '通讯录表格-'+new Date().format("yyyy-MM-dd")});
    	
    }
    
    function getUnSelectRows(){
    	var tb= $("#mainTable");
    	var conunt = tb.bootstrapTable('getOptions').totalRows;
    	var rowSelected = tb.bootstrapTable('getSelections');
    	var all = tb.bootstrapTable('getData');
    	var ret = [];
    	for (var i = 0; i < all.length; i++) {
			
    		var selected = false;
    		
    		for (var j = 0; j < rowSelected.length; j++) 
				if(all[i].id==rowSelected[j].id){
					selected=true;
					break;
				}
			
    		
    		if(!selected)ret.push(i+1);
    		
		}
    	
    	return ret;
    	
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
<body class="mlr15">

    
    <div class="rightinfo explain_col">
		<div>
    		<form id="searchForm" name="searchForm"  method="post">
    		<span>所属部门：</span>
    			<div style="display: inline;" class="lxr_multipleSelect" data-name="deptid" data-model="deptSelect"> </div>
					<input name="deptid" type="hidden">
					
				<!--span>职位：</span>
				<select name = "placeid" class="form-control lxr_select"  style="display: inline;width:110px;" onchange="">
					<option value="">--请选择--</option>
				</select-->
				
    			<span>关键词：</span>
    			<input name="kw" value="" placeholder="姓名"  class="form-control input-sm w200" type="text" style="display: inline;" >
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="queryList()">
    		</form>
    	</div>
    	
	    <div id="toolbar" class="btn-group">
	    <button class="btn btn-success btn-round btn-sm" onclick="onExcell()">
						<i class="glyphicon glyphicon-folder-open"></i>  &nbsp;导出excell
				</button>
	   
		</div>
    </div>
    	<table class="table_list" id="mainTable" data-toggle="table"
			data-url="${path}/personnel/employee/emp/view.do" data-pagination="ture" 
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
					<th data-field="id" >id</th>
					<th data-field="name" >姓名</th>
					<th data-field="deptName" >部门</th>
					<th data-field="placeName" >职位</th>
					<th data-field="phone" >手机号</th>
				</tr>
			</thead>
		</table>
		
		
    
</body>
</html>
