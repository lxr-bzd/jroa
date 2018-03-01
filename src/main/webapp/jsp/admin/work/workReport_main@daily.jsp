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
var toAddUrl = '${path}/admin/work/workReport/toedit.do';
var deleteUrl = '${path}/admin/work/workReport/delete.do';
var toEditUrl = '${path}/admin/work/workReport/toedit.do';
var toInfoUrl = '${path}/admin/work/workReport/toinfo.do';

	//添加
	function toAdd(){
		$app.dialog(toAddUrl+"?sysModule=daily",function(){
			refTable();
		},{width:"900px",height:"600px"});
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
    function toInfo(){
    	var selected=getSelectedRowsArr('mainTable');
    	if(selected.length>0&&selected.length<2)	
    		$lxr.modal({url:toInfoUrl+'?id='+selected});
    	else
    		$app.alert('请选择一条数据进行操作');
    	
	}
	
	//设置查询参数
	function postQueryParams(params) {
		$app.form.preSubmit("#searchForm");
		var queryParams = $("#searchForm").serializeObject();
		var id =  $app.form.multipleSelectVal("#searchForm .lxr_multipleSelect");
		if(id||id==0)queryParams.deptStr=deptUnder(id).join(",");
		queryParams.limit=params.limit;
		queryParams.offset=params.offset;
		return queryParams;
	}
	//查询列表
    function refTable(){
    	$('#mainTable').bootstrapTable('refresh');
    }
    
    function editById(id){
		$app.dialog(toEditUrl+'?id='+id+"&sysAction=edit&sysModule=daily",function(){
			refTable();
		},{width:"900px",height:"600px"});
	}

	

	//根据id查看
	function viewById(id){
		$app.dialog(toInfoUrl+'?id='+id,function(){
			refTable();
		},{width:"900px",height:"600px"});
		
	}
	
    //操作工具栏
    function operatorFormatter(value, row, index) {
    	var operator='<div class="btn-group">';
    	
    	<shiro:hasPermission name="admin/work/workReport/examine?sysModule=daily">
    	if(row.report_state!=2)operator+=$app.btn({type:"btn-warning",img:"glyphicon-ok"},'审核','toExamine(\''+row.id+'\')');
    	</shiro:hasPermission>
    	
    	operator+=$app.btn('info','详情','viewById(\''+row.id+'\')');
    	
    	if(row.report_state==1){
    	<shiro:hasPermission name="admin/work/workReport/update?sysModule=daily&sysAction=edit">
    		operator+=$app.btn('edit','编辑','editById(\''+row.id+'\')');
	    </shiro:hasPermission>
	    
	    <shiro:hasPermission name="admin/work/workReport/delete?sysModule=daily">
			operator+=$app.btn('delete','删除','toRemove(\''+row.id+'\')');
    	</shiro:hasPermission>
    	}
	    	
	    	
	    	
		return operator+'</div>';
	}
    
   
    
 
    
</script>
<script type="text/javascript">
function toExamine(id){
	$app.dialog("${path}/admin/work/workReport/toexamine.do?sysModule=daily&id="+id,function(){
		refTable();
	},{width:"900px",height:"600px"});

}


function report_stateFormatter(val){
	switch (val) {
	case 1:return "未审核";
		break;
	case 2:return "已审核";
	break;
	
	}
	
}

function examineNameFormatter(val){
	if(!val&&val!=0)
		return "";
	return val;
	
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
				
    			<span>时间：</span>
    			<input placeholder="开始" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
    			<input type="hidden" name="startTime">--
				<input placeholder="结束" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
				<input type="hidden" name="endTime">
    			<span>关键词：</span>
    			<input name="kw" value="" placeholder="关键词"  class="form-control input-sm w200" type="text" style="display: inline;" >
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="refTable()">
    		</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	   
	   <button class="btn btn-info btn-round  btn-sm" onclick="toAdd();" >
					<i class="glyphicon glyphicon-plus"></i> 添加
		</button>
		</div>
    </div>
    	<table class="table_list" id="mainTable" data-toggle="table"
			data-url="${path}/admin/work/workReport/view.do?type=1" data-pagination="ture" 
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
					<!-- <th data-field="sort" data-formatter="Formatter.sort">序号</th> -->
					<th data-field="id" >id</th>
					<th data-field="empName" >员工</th>
					<th data-field="deptName" >部门</th>
					<th data-field="createtime" data-formatter="$app.tableUi.time">提交时间</th>
					<th data-field="examineName" data-formatter="examineNameFormatter">审核人</th>
					<th data-field="report_state" data-formatter="report_stateFormatter" >状态</th>
					<th data-field="operator" data-formatter="operatorFormatter">操作</th>
				</tr>
			</thead>
		</table>
		
   <!--  <div class="select_btn">
	   	<label class="select_all">
	   		<input type="checkbox" name="checkall" onclick="if($('#mainTable thead input[name=btSelectAll]').prop('checked')!=this.checked)$('#mainTable thead input[name=btSelectAll]').click();"> 全选/取消
	   	</label>
	   	<button class="btn btn-danger btn-round btn-xs" onclick="toRemove()"><i class="glyphicon glyphicon-trash"></i> 批量删除</button>
	</div> -->
</body>
</html>
