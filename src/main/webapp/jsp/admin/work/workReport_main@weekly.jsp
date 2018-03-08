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
var toInfoUrl = '${path}/admin/work/workReport/view.do';

	//添加
	function toAdd(){
		$app.dialog(toAddUrl+"?sysModule=weekly",function(){
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
		var queryParams = $("#searchForm").serializeObject();
		queryParams.limit=params.limit;
		queryParams.offset=params.offset;
		return queryParams;
	}
	//查询列表
    function refTable(){
    	$('#mainTable').bootstrapTable('refresh');
    }
    
    function editById(id){
    	
		$app.dialog(toEditUrl+'?id='+id+"&sysAction=edit&sysModule=weekly",function(){
			refTable();
		},{width:"900px",height:"600px"});
	}

	

	//根据id查看
	function viewById(id){
		$lxr.modal({url:toInfoUrl+'?id='+id+"&sysType=info"});
	}
	
    //操作工具栏
    function operatorFormatter(value, row, index) {
    	var operator='<div class="btn-group">';
    	<shiro:hasPermission name="admin/work/workReport/examine?sysModule=weekly">
    	if(row.report_state!=2)
        	operator+=$app.btn('auth','审核','toExamine(\''+row.id+'\')');
    </shiro:hasPermission>
    	
	    	<shiro:hasPermission name="admin/work/workReport/update?sysModule=weekly&sysAction=edit">
	    		operator+=$app.btn('edit','编辑','editById(\''+row.id+'\')');
		    </shiro:hasPermission>
		    <shiro:hasPermission name="admin/work/workReport/delete?sysModule=weekly">
				operator+=$app.btn('delete','删除','toRemove(\''+row.id+'\')');
	    	</shiro:hasPermission>
	    	/* <shiro:hasPermission name="personnel/organize/place:delete">
				operator+='<button class="btn btn-danger btn-round btn-xs" onclick="deleteById(\''+row.id+'\')"><i class="glyphicon glyphicon-trash"></i>删除</button>';
			</shiro:hasPermission> */
		return operator+'</div>';
	}
    
   
    
 
    
</script>
<script type="text/javascript">
function toExamine(id){
	$app.dialog("${path}/admin/work/workReport/toexamine.do?sysModule=weekly&id="+id,function(){
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
</head>
<body class="mlr15">

    
    <div class="rightinfo explain_col">
		<div>
    		<form id="searchForm" name="searchForm"  method="post">
    			
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
			data-url="${path}/admin/work/workReport/view.do?type=2" data-pagination="ture" 
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
