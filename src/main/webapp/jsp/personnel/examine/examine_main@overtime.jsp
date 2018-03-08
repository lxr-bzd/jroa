<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>	
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询列表</title>
<script>
var toAddUrl = '${path}/personnel/examine/examine/toedit.do?sysModule=overtime';
var deleteUrl = '${path}/personnel/examine/examine/delete.do';
var toEditUrl = '${path}/personnel/examine/examine/toedit.do';
var toInfoUrl = '${path}/personnel/apply/apply/toinfo.do?sysModule=overtime';
var updateUrl = '${path}/personnel/examine/examine/update.do';

	//添加
	function toAdd(){
		$app.dialog(toAddUrl,function(){
			refleshData('mainTable');
		});
		
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
	

	
    //查看
    function toInfo(id){
    	$app.dialog(toInfoUrl+"&id="+id,function(){
			refleshData('mainTable');
		},{width:"600px",height:"700px"});
	}
	
	//设置查询参数
	function postQueryParams(params) {
		var queryParams = $("#searchForm").serializeObject();
		queryParams.limit=params.limit;
		queryParams.offset=params.offset;
		return queryParams;
	}
	
	//查询列表
    function queryList(){
    	$('#mainTable').bootstrapTable('refresh');
    }
    
    function editById(id){
    	$app.dialog(toEditUrl+'?sysModule=overtime&sysAction=edit&id='+id+"",function(){
			refleshData('mainTable');
		},{width:"800px",height:"800px"});
	}
   
    
    
</script>
<script type="text/javascript">


function goExamine(id){
	$app.dialog(toAddUrl,function(){
		refleshData('mainTable');
	});
	
}



//操作工具栏
function operatorFormatter(value, row, index) {
	var operator='<div class="btn-group">';
	switch (row.state) {
	case 1:
		operator+= $app.btn({type:'btn-warning',img:'glyphicon-remove'},'审批','editById(\''+row.id+'\')');
		
	break;
	case 2:
	break;
	case 3:
	break;
	case 4:
		operator+= $app.btn('info','查看原因','toInfo(\''+row.id+'\')');
	break;
	}
	
	operator+= $app.btn('info','查看','toInfo(\''+row.id+'\')');
	
	return operator+'</div>';
}
//格式化状态
//格式化状态
function stateFormatter(value,row,index){
	
	var enu = {'1':'未审核','2':'通过','3':'审核中','4':'未通过'};
	return enu[value+""];
}


function lengthFormatter(val,row,index){
	
	var d = row.endtime-row.starttime;
	if(isNaN(d))return;
	return ((d/1000/60/60).toFixed(2))+'小时';
	
	
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
					<span>时间：</span>
					<input placeholder="开始" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
    			<input type="hidden" name="starttime">-
				<input placeholder="结束" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
				<input type="hidden" name="endtime">
    			
    			
    			<span>关键词：</span>
    			<input name="kw" value="" placeholder="姓名"  class="form-control input-sm w200" type="text" style="display: inline;" >
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="queryList()">
    		</form>
    	</div>

	    <div id="toolbar" class="btn-group">
	   
	   
		</div>
   </div>
   
    	<table class="table_list" id="mainTable" data-toggle="table"
			data-url="${path}/personnel/examine/examine/view.do?applytype=2" data-pagination="ture" 
			data-side-pagination="server" data-cache="false" data-query-params="postQueryParams"
			data-page-list="[10, 20, 35, 50]" data-page-size= "10" data-method="post"
			data-show-refresh="false" data-show-toggle="false"
			data-show-columns="false" data-toolbar="#toolbar"
			data-click-to-select="false" data-single-select="false"
			data-striped="false" data-content-type="application/x-www-form-urlencoded">
			<thead>
				<tr>
					<th data-field="" data-checkbox="true"></th>
					<th data-field="id" >id</th>
					<th data-field="uname" >姓名</th>
					<th data-field="starttime"  data-formatter="$app.tableUi.time">开始时间</th>
					<th data-field="endtime" data-formatter="$app.tableUi.time">结束时间</th>
					<th data-field="length" data-formatter="lengthFormatter">时长</th>
					<th data-field="state"  data-formatter="stateFormatter">状态</th>
					<th data-field="operator" data-formatter="operatorFormatter">操作</th>
				</tr>
			</thead>
		</table>
		
    
</body>
</html>
