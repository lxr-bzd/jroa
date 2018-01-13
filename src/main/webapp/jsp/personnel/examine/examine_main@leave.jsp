<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>	
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询列表</title>
<script>
var toAddUrl = '${path}/personnel/examine/examine/toedit.do?sysModule=leave';
var deleteUrl = '${path}/personnel/examine/examine/delete.do';
var toEditUrl = '${path}/personnel/examine/examine/toedit.do';
var toInfoUrl = '${path}/personnel/examine/examine/view.do';
var updateUrl = '${path}/personnel/examine/examine/update.do';

	//添加
	function toAdd(){
		$app.dialog(toAddUrl,function(){
			refleshData('mainTable');
		});
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
		return queryParams;
	}
	
    
    function editById(id){
    	$app.dialog(toEditUrl+'?sysModule=leave&sysAction=edit&id='+id+"",function(){
			refleshData('mainTable');
		});
	}

	

	//根据id查看
	function viewById(id){
		$lxr.modal({url:toInfoUrl+'?id='+id+"&type=info"});
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
		operator+= $app.btn('edit','编辑','editById(\''+row.id+'\')');
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
function stateFormatter(value,row,index){
	switch (value) {
	case 1:
	return '审核中';
	break;
	case 2:
	return '通过';
	break;
	case 3:
	return '已取消';
	break;
	case 4:
	return '未通过';
	break;

	default:
		break;
	}
}


function lengthFormatter(val,row,index){
	
	var d = row.endtime-row.starttime;
	if(isNaN(d))return;
	return ((d/1000/60/60).toFixed(2))+'小时';
	
	
}



</script>
</head>
<body class="mlr15">

	    <div id="toolbar" class="btn-group">
	   
	   
		</div>
   
    	<table class="table_list" id="mainTable" data-toggle="table"
			data-url="${path}/personnel/apply/apply/view.do?applytype=1" data-pagination="ture" 
			data-side-pagination="server" data-cache="false" data-query-params="postQueryParams"
			data-page-list="[15, 30, 50, 100]" data-page-size= "15" data-method="post"
			data-show-refresh="false" data-show-toggle="false"
			data-show-columns="false" data-toolbar="#toolbar"
			data-click-to-select="false" data-single-select="false"
			data-striped="false" data-content-type="application/x-www-form-urlencoded">
			<thead>
				<tr>
					<th data-field="" data-checkbox="true"></th>
					<th data-field="id" >id</th>
					<th data-field="uname" >姓名</th>
					<th data-field="identifier" >工号</th>
					<th data-field="starttime"  data-formatter="$app.tableUi.time">开始时间</th>
					<th data-field="endtime" data-formatter="$app.tableUi.time">结束时间</th>
					<th data-field="length" data-formatter="lengthFormatter">请假时长</th>
					<th data-field="state"  data-formatter="stateFormatter">状态</th>
					<th data-field="operator" data-formatter="operatorFormatter">操作</th>
				</tr>
			</thead>
		</table>
		<div class="select_btn">
	   	<label class="select_all">
	   		<input type="checkbox" name="checkall" onclick="if($('#mainTable thead input[name=btSelectAll]').prop('checked')!=this.checked)$('#mainTable thead input[name=btSelectAll]').click();"> 全选/取消
	   	</label>
	   	<button class="btn btn-danger btn-round btn-xs" onclick="toRemove()"><i class="glyphicon glyphicon-trash"></i> 批量删除</button>
	   </div>
    
</body>
</html>
