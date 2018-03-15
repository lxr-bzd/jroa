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
var toAddUrl = '${path}/project/project/prjLog/toedit.do';
var deleteUrl = '${path}/project/project/prjLog/delete.do';
var toEditUrl = '${path}/project/project/prjLog/toedit.do';
var toInfoUrl = '${path}/project/project/prjLog/view.do';

	//添加
	function toAdd(){
		$app.dialog(toAddUrl+'?prjid=${param.prjid}',function(){
			refTable();
		});
	}
	//删除
	//删除
	function toRemove(id){
		
		var ids = id;
		if(!id)ids=getSelectedRowsIds('mainTable');
		
		if(ids)
			$app.confirmDelete(deleteUrl+'?ids='+ids,'删除数据不可恢复，确定要删除吗？'
					,function(){
				refleshData('mainTable');
			});
		else
			$app.alert("请选择一条数据进行操作");
	}
	
	 function editById(id){
			$app.dialog(toEditUrl+'?id='+id+"&sysAction=edit",function(){
				refTable();
			});
		}
		//根据id查看
	function viewById(id){
			$lxr.modal({url:toInfoUrl+'?id='+id+"&sysType=info"});
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
    
    //操作工具栏
    function operatorFormatter(value, row, index) {
    	var operator='<div class="btn-group">';
	    		operator+=$app.btn('edit','编辑','editById(\''+row.id+'\')');
		    
				operator+=$app.btn('delete','删除','toRemove(\''+row.id+'\')');
	    	
		return operator+'</div>';
	}
    
   
    
 
    
</script>

<script type="text/javascript">
$(function(){
	
	$("#mName").html(decodeURIComponent(GetQueryString("prjName")));
	
});

function GetQueryString(name){ 
	var vars = [], hash; 
	var hashes = window.location.href.slice(window.location.href.indexOf('?')+1).split('&'); 
	for(var i = 0; i < hashes.length; i++) { 
	hash = hashes[i].split('='); 
	vars.push(hash[0]); 
	vars[hash[0]] = hash[1]; 
	} 
	return vars[name]; 
	}
</script>
</head>
<body class="mlr15">

    
    <div class="rightinfo explain_col">
		<div>
    		<form id="searchForm" name="searchForm"  method="post">
    			<h2 id="mName"></h2>
    			</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	   
	   <button class="btn btn-info btn-round  btn-sm" onclick="toAdd();" >
					<i class="glyphicon glyphicon-plus"></i> 添加记录
		</button>
		</div>
    </div>
    	<table class="table_list" id="mainTable" data-toggle="table"
			data-url="${path}/project/project/prjLog/view.do?prjid=${param.prjid}" data-pagination="ture" 
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
					<th data-field="empName" >操作人</th>
					<th data-field="info" >记录</th>
					<th data-field="time" data-formatter="$app.tableUi.time" >时间</th>
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
