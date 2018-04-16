<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>	
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询列表</title>
<script>
var toAddUrl = '${path}/personnel/apply/apply/toedit.do?sysModule=leave';
var deleteUrl = '${path}/personnel/apply/apply/delete.do';
var toEditUrl = '${path}/personnel/apply/apply/toedit.do';
var toInfoUrl = '${path}/personnel/apply/apply/toinfo.do?sysModule=leave';
var updateUrl = '${path}/personnel/apply/apply/update.do';

	//添加
	function toAdd(){
		$app.dialog(toAddUrl,function(){
			refleshData('mainTable');
		},{width:"620px",height:"520px"});
		//window.location=toAddUrl;
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
    	$app.dialog(toEditUrl+'?sysModule=leave&id='+id+"&action=edit",function(){
			refleshData('mainTable');
		},{width:"620px",height:"520px"});
	}
   
    
    
</script>
<script type="text/javascript">


function goCancel(id){
	$app.prompt("取消原因",function(content){
		$app.request(updateUrl+"?state=3&id="+id,function(data){
			refleshData('mainTable');
			if(data.status==0)
				$app.alert("取消成功");
			else $app.alert("取消失败");
			
		});
		
	},2);
	
}



//操作工具栏
function operatorFormatter(value, row, index) {
	var operator='<div class="btn-group">';
	switch (row.state) {
	case 1:
		operator+= $app.btn({type:'btn-warning',img:'glyphicon-remove'},'取消','toRemove(\''+row.id+'\')');
		operator+= $app.btn('edit','编辑','editById(\''+row.id+'\')');
	break;
	case 2:
	break;
	case 3:
	break;
	case 4:
		
	break;
	}
	
	operator+= $app.btn('info','查看','toInfo(\''+row.id+'\')');
	
	return operator+'</div>';
}
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


function leave_typeFormatter(val,row,index){
	
	var enu = {'1':'事假','2':'病假','3':'婚假','4':'丧假','5':'年假'};
	return enu[val+""];
	
}


</script>
</head>
<body class="mlr15">

    
    
	    <div id="toolbar" class="btn-group">
	   
	   <button class="btn btn-info btn-round  btn-sm" onclick="toAdd();" >
					 请假申请
		</button>
		</div>
    
    	<table class="table_list" id="mainTable" data-toggle="table"
			data-url="${path}/personnel/apply/apply/view.do?applytype=1" data-pagination="ture" 
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
					<th data-field="deptName" >部门</th>
					<th data-field="uname" >姓名</th>
					<th data-field="leave_type" data-formatter="leave_typeFormatter" >请假类型</th>
					<th data-field="info" >请假内容</th>
					<th data-field="starttime"  data-formatter="$app.tableUi.time">开始时间</th>
					<th data-field="endtime" data-formatter="$app.tableUi.time">结束时间</th>
					
					<th data-field="state"  data-formatter="stateFormatter">状态</th>
					<th data-field="operator" data-formatter="operatorFormatter">操作</th>
				</tr>
			</thead>
		</table>
	   <!-- <div class="select_btn">
	   	<label class="select_all">
	   		<input type="checkbox" name="checkall" onclick="$('#mainTable thead input[name=btSelectAll]').click()"> 全选/取消
	   	</label>
	   	<button class="btn btn-danger btn-round btn-xs" onclick="toRemove()"><i class="glyphicon glyphicon-trash"></i> 批量删除</button>
	   </div> -->
    
</body>
</html>
