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
		queryParams.month = 1;
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
	
    //操作工具栏
    function operatorFormatter(value, row, index) {
    	var operator='<div class="btn-group">';
		    
	    	<shiro:hasPermission name="personnel/organize/place:edit">
	    		operator+='<button class="btn btn-warning btn-round btn-xs" onclick="editById(\''+row.id+'\');"><i class="glyphicon glyphicon-pencil"></i> 编辑</button>&nbsp;&nbsp;';
		    </shiro:hasPermission>
		    <shiro:hasPermission name="personnel/organize/place:delete">
				operator+='<button class="btn btn-danger btn-round btn-xs" onclick="toRemove(\''+row.id+'\')" ><i class="glyphicon glyphicon-trash"></i> 删除</button>';
	    	</shiro:hasPermission>
	    	/* <shiro:hasPermission name="menber:delete">
				operator+='<button class="btn btn-danger btn-round btn-xs" onclick="deleteById(\''+row.id+'\')"><i class="glyphicon glyphicon-trash"></i>删除</button>';
			</shiro:hasPermission> */
		return operator+'</div>';
	}
    
    //格式化状态
    function statusFormatter(value,row,index){
    	if(value=='1'){
    		return '<span class="label label-success label-lg">启用</span>';
    	}else if(value=='2'){
    		return '<span class="label label-danger arrowed">锁定</span>';
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

	function birthdayFormatter(val){
		if(!val)return "";
		return new Date(new Number(val)).format("MM-dd");
		
	}


	function ageFormatter(val){
		if(!val)return "";
		return (new Date().getFullYear())-(new Date(new Number(val)).getFullYear());
		
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
    			<span>关键词：</span>
    			<input name="kw" value="" placeholder="名称"  class="form-control input-sm w200" type="text" style="display: inline;" >
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="queryList()">
    		</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	   
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
					<th data-field="id" >id</th>
					<th data-field="name" >姓名</th>
					<th data-field="deptName" >部门</th>
					<th data-field="placeName" >职位</th>
					<th data-field="phone" >手机号</th>
					<th data-field="birthday" data-formatter="birthdayFormatter" >生日</th>
					<th data-field="sex" data-formatter="$app.tableUi.sex" >性别</th>
				<!-- 	<th data-field="birthday" data-formatter="ageFormatter" >年龄</th> -->
				</tr>
			</thead>
		</table>
		
    
</body>
</html>
