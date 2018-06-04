<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/global.jsp"%>	
<script type="text/javascript" src="${path}/js/tableExport.min.js"></script>
<script type="text/javascript" src="${path}/js/jquery.base64.js"></script>
<title>查询列表</title>
<script>
var toAddUrl = '${path}/project/project/project/toedit.do';
var deleteUrl = '${path}/project/project/project/delete.do';
var toEditUrl = '${path}/project/project/project/toedit.do';
var toInfoUrl = '${path}/project/project/project/view.do';

	//添加
	function toAdd(){
		$app.dialog(toAddUrl,function(){
			refTable();
		},{width:"800px",height:"800px"});
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
    	var selected =getSelectedRowsArr('mainTable');
    	if(selected.length>0&&selected.length<2){
    		window.location=toEditUrl+'?id='+selected+"&sysAction=edit";
    	}else{
    		//提示信息
    		$app.alert('请选择一条数据进行操作');
    		
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
		queryParams.limit=params.limit;
		queryParams.offset=params.offset;
		return $lxr.trimObject(queryParams);
	}
	//查询列表
    function refTable(){
    	$('#mainTable').bootstrapTable('refresh');
    }
    
    function editById(id){
		$app.dialog(toEditUrl+'?id='+id+"&sysAction=edit",function(){
			refTable();
		},{width:"800px",height:"800px"});
	}

	

	//根据id查看
	function viewById(id){
		$lxr.modal({url:toInfoUrl+'?id='+id+"&sysType=info"});
	}
	
	
	
	
	
    //操作工具栏
    function operatorFormatter(value, row, index) {
    	var operator='<div class="btn-group">';
    	 	<shiro:hasPermission name="project/project/prjLog">
				operator+=$app.btn('auth','跟踪','todetail(\''+row.id+'\',\''+row.name+'\')');;
			</shiro:hasPermission> 
	    	<shiro:hasPermission name="project/project/project/update">
	    		operator+=$app.btn('edit','编辑','editById(\''+row.id+'\')');
		    </shiro:hasPermission>
		    <shiro:hasPermission name="project/project/project/delete">
				operator+=$app.btn('delete','删除','toRemove(\''+row.id+'\')');
	    	</shiro:hasPermission>
	    	<shiro:hasPermission name="project/project/prjCollect">
			operator+=$app.btn({type:'btn-info',img:'glyphicon-usd'},'收款','toPrjCollect(\''+row.id+'\',\''+row.name+'\')');
    		</shiro:hasPermission>
    		
			operator+=$app.btn('auth','测评','todevelop(\''+row.id+'\',\''+row.name+'\',\''+row.managerName+'\')');
	
		return operator+'</div>';
	}
    
   
    
 
    
</script>
<script type="text/javascript">
function todevelop(id,name,managerName){
	window.location.href = "${path}/project/project/prjMeb.do?prjid="+id+"&prjName="+encodeURIComponent(name)+"&managerName="+encodeURIComponent(managerName);
}

function todetail(id,name){
	window.location.href = "${path}/project/project/prjLog.do?prjid="+id+"&prjName="+encodeURIComponent(name);
}

function toPrjCollect(id,name){
	window.location.href = "${path}/project/project/prjCollect.do?prjid="+id+"&prjName="+encodeURIComponent(name);
	
}

function progressFormatter(val){
	
	switch (val) {
	case 1:
		return "策划中";
		break;
case 2:return "开发中";
		
		break;
case 3:return "测试中";
	
	break;
case 4:return "已完成";
	
	break;
case 5:return "待续费";
	
	break;

	default:
		break;
	}
	
}

function docFormatter(val){
	if(val){
		var fname = val;
		var i = val.lastIndexOf("/");
		if(i>=0)fname = val.substring(i,val.length);
		return '<button class="btn btn-round btn-sm">'+
				'<a href="'+val+'"  download="'+fname+'"><span class="glyphicon glyphicon-download-alt"></span></a></button>';
	}
}



$(function(){
	$app.form("#searchForm");
});


function onExcell(){
	 if($("#mainTable").bootstrapTable('getSelections').length<1){
		 $app.alert("请选中要导出的数据");
		 return;
	 }
		
	
var unselect = getUnSelectRows();
	$('#mainTable').tableExport({type:'excel',ignoreColumn: [0,1,11],ignoreRow:unselect
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
</head>
<body class="mlr15">

    
    <div class="rightinfo explain_col">
		<div>
    		<form id="searchForm" name="searchForm"  method="post">
    			<span>项目经理：</span>
    			<input name="managerKw" value="" placeholder="项目经理"  class="form-control input-sm w200" type="text" style="display: inline;" >
    			&nbsp;&nbsp;
    			<span>业务员：</span>
    			<input name="salesmanKw" value="" placeholder="业务员"  class="form-control input-sm w200" type="text" style="display: inline;" >
    			&nbsp;&nbsp;
    			<span>客户名称：</span>
    			<input name="cusKw" value="" placeholder="客户名称"  class="form-control input-sm w200" type="text" style="display: inline;" >
    			&nbsp;&nbsp;
				<div class="senior" style="display: none;">
					<br /><br />
	    			<span>下单时间：</span>
	    			<input placeholder="开始" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
	    			<input type="hidden" name="startTime">-
					<input placeholder="结束" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
					<input type="hidden" name="endTime">
					
					<span>项目状态：</span>
					<select name="progressid" data-model='{url:"${path}/project/setting/progress/view.do?limit=-1&offset=0",val:"id",name:"name",root:"rows"}' class="lxr-select form-control  w200" style="display: inline;" ><option value="">-请选择-</option></select>
	    			
					<span>关键词：</span>
	    			<input name="kw" value="" placeholder="项目名称"  class="form-control input-sm w200" type="text" style="display: inline;" >
	    			<br /><br />
	    			<span>续费时间：</span>
	    			<input placeholder="开始" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
	    			<input type="hidden" name="renewStime">-
					<input placeholder="结束" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
					<input type="hidden" name="renewEtime">
    			</div>
    			<!--<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="refTable()">-->
    			<div class="control-group" style="display: inline-block;">
				    <label class="checkbox_btn"><input type="checkbox"><span>高级搜索</span></label>
				    &nbsp;&nbsp;
				    <input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="refTable()">
				</div>
    		</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	    <button class="btn btn-success btn-round btn-sm" onclick="onExcell()">
						<i class="glyphicon glyphicon-folder-open"></i>  &nbsp;导出excell
				</button>
			<shiro:hasPermission name="project/project/project/save">
				<button class="btn btn-info btn-round  btn-sm" onclick="toAdd();" >
					<i class="glyphicon glyphicon-plus"></i> 添加
				</button>
	    	</shiro:hasPermission>
	   
		</div>
    </div>
    	<table class="table_list" id="mainTable" data-toggle="table"
			data-url="${path}/project/project/project/view.do" data-pagination="ture" 
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
					<th data-field="name" >项目名称</th>
					
					<th data-field="customrName" >客户</th>
					<th data-field="cusPhone" >客户电话</th>
					<th data-field="managerName" >项目经理</th>
					<th data-field="progressName" >项目状态</th>
					<th data-field="signtime" data-formatter="$app.tableUi.date" >签单时间</th>
					<th data-field="salesmanName" >业务员</th>
					<th data-field="ordertime" data-formatter="$app.tableUi.date"  >下单时间</th>
					<th data-field="orderempName">下单人</th>
					<th data-field="doc" data-formatter="docFormatter" >项目功能表</th>
					<th data-field="operator" data-formatter="operatorFormatter">操作</th>
				</tr>
			</thead>
		</table>
		
    <div class="select_btn">
	   	<label class="select_all">
	   		<input type="checkbox" name="checkall" onclick="if($('#mainTable thead input[name=btSelectAll]').prop('checked')!=this.checked)$('#mainTable thead input[name=btSelectAll]').click();"> 全选/取消
	   	</label>
	   	 <shiro:hasPermission name="project/project/project/delete">
	   	<button class="btn btn-danger btn-round btn-xs" onclick="toRemove()"><i class="glyphicon glyphicon-trash"></i> 批量删除</button>
		</shiro:hasPermission>
	</div>
	<script type="text/javascript">
		$('.checkbox_btn').click(function(){
			var _this=$(this),
				$input=_this.children('input'),
				$span=_this.children('span');
			if($input.prop('checked')){
				$('.senior').show();
			}else{
				$('.senior').hide();
			}
		})
	</script>
</body>
</html>
