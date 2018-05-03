<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>	
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询列表</title>
<script>
var toAddUrl = '${path}/personnel/employee/emp/toedit.do';
var deleteUrl = '${path}/personnel/employee/emp/delete.do';
var toEditUrl = '${path}/personnel/employee/emp/toedit.do';
var toInfoUrl = '${path}/personnel/employee/emp/toinfo.do';

	//添加
	function toAdd(){
		$app.dialog(toEditUrl,function(){
			refleshData('mainTable');
		},{width:"900px",height:"700px"});
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
    function toInfo(id){
    	
    	$app.dialog(toInfoUrl+'?id='+id,null,{width:"900px",height:"700px"});
    	
	}
	
	//设置查询参数
	function postQueryParams(params) {
		$app.form.preSubmit("#searchForm");
		var queryParams = $("#searchForm").serializeObject();
		
		var id =  $app.form.multipleSelectVal("#searchForm .lxr_multipleSelect");
		if(id||id==0)queryParams.deptStr=deptUnder(id).join(",");
		queryParams.limit=params.limit;
		queryParams.offset=params.offset;
		queryParams.deptid = $app.form.multipleSelectVal("#searchForm .lxr_multipleSelect");
		queryParams.state = 0;
		return $lxr.trimObject(queryParams);
	}
	//查询列表
    function queryList(){
    	$('#mainTable').bootstrapTable('refresh');
    }
    
    function editById(id){
    	$app.dialog(toEditUrl+'?id='+id+"&action=edit",function(){
    		queryList();
    	},{width:"900px",height:"700px"});
		//window.location=toEditUrl+'?id='+id+"&action=edit";
	}

	
    //操作工具栏
    function operatorFormatter(value, row, index) {
    	var operator='<div class="btn-group">';
		  
	    	operator+= $app.btn('info','查看','toInfo(\''+row.id+'\')');
	    	
			
	    	
	    	operator+= $app.btn('edit','编辑','editById(\''+row.id+'\')');
	    	
			
		    
		    operator+= $app.btn('delete','删除','toRemove(\''+row.id+'\')');
		 
		return operator+'</div>';
	}
    
    //格式化状态
    function stateFormatter(value,row,index){
    	if(value=='0'){
    		return '是';
    	}else if(value=='1'){
    		return '否';
    	}else{
    		return "";
    	}
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
					<span>入职时间：</span>
					<input placeholder="开始" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
    			<input type="hidden" name="regStart">--
				<input placeholder="结束" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
				<input type="hidden" name="regEnd">
    			
    			<span>性别：</span><select name="sex" class="form-control" style="display: inline;width:110px;" onchange="">
    			<option value="">--全部--</option>
    			<option value="1">男</option>
    			<option value="2">女</option>
    			</select>
    			<span>关键词：</span>
    			<input name="kw" value="" placeholder="姓名"  class="form-control input-sm w200" type="text" style="display: inline;" >
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="queryList()">
    		</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	   
	   <button class="btn btn-info btn-round  btn-sm" onclick="toAdd();" >
					<i class="glyphicon glyphicon-plus"></i> 添加
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
					<th data-field="levelName" >等级</th><!-- 
					<th data-field="identifier" >工号</th> -->
					<th data-field="phone" >手机号</th>
					<th data-field="entry_time" data-formatter="$app.tableUi.date">入职日期</th>
					<th data-field="birthday" data-formatter="$app.tableUi.date" >生日</th>
					<th data-field="sex" data-formatter="$app.tableUi.sex" >性别</th>
					<th data-field="state" data-formatter="stateFormatter" >是否在职</th>
					<th data-field="operator"  data-formatter="operatorFormatter">操作</th>
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
