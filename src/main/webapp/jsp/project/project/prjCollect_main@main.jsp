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
var toAddUrl = '${path}/project/project/prjCollect/toedit.do';
var deleteUrl = '${path}/project/project/prjCollect/delete.do';
var toEditUrl = '${path}/project/project/prjCollect/toedit.do';
var toInfoUrl = '${path}/project/project/prjCollect/view.do';

	

	
	function editById(id){
		$app.dialog(toEditUrl+'?id='+id+"&sysAction=edit",function(){
			refTable();
		});
	}
	
	function viewById(id){
		$lxr.modal({url:toInfoUrl+'?id='+id+"&sysType=info"});
	}
	
	
	
  
	
	//设置查询参数
	function postQueryParams(params) {
		$app.form.preSubmit("#searchForm");
		var queryParams = $("#searchForm").serializeObject();
		queryParams.limit=params.limit;
		queryParams.offset=params.offset;
		var ret = $lxr.trimObject(queryParams);
		initCount(ret);
		return ret;
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

    
    function typeFormatter(value, row, index) {
    	var m = {'1':"项目收款",'2':"续费",'3':"其他"}
		return m[value+""];
	}
</script>
<script type="text/javascript">
$(function(){
	initCount();
	var empName = $lxr.getUrlParam("empName");
	if(!empName)return;
	$("#searchForm input[name=empName]").val(decodeURIComponent(empName));
	refTable();
	
});


function initCount(par){
	$app.request("${path}/index/prjMoney.do",function(data){
		if(data.status==0){
			var allCollect  = data.data.allCollect/10000;
			var monthCollect = data.data.monthCollect/10000;
			
			$("#allCollect").html(allCollect+"万");
			$("#monthCollect").html(monthCollect+"万");
			
		}
	},{param:par});
	
}


/* function getDate(str){
	var arr = str.split(/[- : \/]/);
	
	return new Date(arr[0],arr[1]-1,arr[2],arr[3]==undefined?0:arr[3],arr[4]==undefined?0:arr[4],arr[5]==undefined?0:arr[5]);

}
 */
</script>
</head>
<body class="mlr15">

    
    <div class="rightinfo explain_col">
		<div>
    		<form id="searchForm" name="searchForm"  method="post">
    		<span>关键词：</span>
    			<input name="kw" value="" placeholder="关键词"  class="form-control input-sm w200" type="text" style="display: inline;" >
    			&nbsp;&nbsp;
    		<span>业务员：</span>
    			<input name="empName" value="" placeholder="业务员"  class="form-control input-sm w200" type="text" style="display: inline;" >
    			&nbsp;&nbsp;
    			<span>收款时间：</span>
	    			<input placeholder="月份" data-lxr="{type:'time',format:'yyyy-MM'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false})">
	    			<input type="hidden" name="startTime">
					
				    <input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="refTable()">
    			</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	  
		</div>
    </div>
    	
    	<div class="input-collect" style="display: inline;">
    		<div class="input-group">
		       <div class="input-group-addon"><span >总收款</span></div>
		       <span id="allCollect" class="form-control input-primary"></span>
		    </div>
    		<div class="input-group">
		       <div class="input-group-addon"><span>本月收款</span></div>
		       <span id="monthCollect" class="form-control input-primary"></span>
		    </div>
    	</div>
    	
    	<table class="table_list" id="mainTable" data-toggle="table"
			data-url="${path}/project/project/prjCollect/view.do" data-pagination="ture" 
			data-side-pagination="server" data-cache="false" data-query-params="postQueryParams"
			data-page-list="[10, 20, 35, 50]" data-page-size= "20" data-method="post"
			data-show-refresh="false" data-show-toggle="false"
			data-show-columns="false" data-toolbar="#toolbar"
			data-click-to-select="false" data-single-select="false"
			data-striped="false" data-content-type="application/x-www-form-urlencoded"
			>
			<thead>
				<tr>
				
					<th data-field="" data-checkbox="true"></th>
					<th data-field="id" >id</th>
					<th data-field="prjName" >项目名称</th>
					<th data-field="cusName" >客户名称</th>
					<th data-field="empName" >业务员</th>
					<th data-field="money" >收款金额</th>
					<th data-field="time" data-formatter="$app.tableUi.time" >收款时间</th>
					<th data-field="type" data-formatter="typeFormatter" >收款类型</th>
					<th data-field="remark">备注</th>
				</tr>
			</thead>
		</table>
		
    <div class="select_btn">
	<!--    	<label class="select_all">
	   		<input type="checkbox" name="checkall" onclick="if($('#mainTable thead input[name=btSelectAll]').prop('checked')!=this.checked)$('#mainTable thead input[name=btSelectAll]').click();"> 全选/取消
	   	</label>
	   	<button class="btn btn-danger btn-round btn-xs" onclick="toRemove()"><i class="glyphicon glyphicon-trash"></i> 批量删除</button>
	 --></div>
</body>
</html>
