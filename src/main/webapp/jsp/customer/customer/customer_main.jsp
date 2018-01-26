<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>	
<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询列表</title>
<script>
var toAddUrl = '${path}/customer/customer/customer/toedit.do';
var deleteUrl = '${path}/customer/customer/customer/delete.do';
var toEditUrl = '${path}/customer/customer/customer/toedit.do';
var toInfoUrl = '${path}/customer/customer/customer/view.do';

	//添加
	function toAdd(){
		$app.dialog(toAddUrl,function(){
			refTable();
		},{width:"500px",height:"700px"});
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
		var id =  $app.form.multipleSelectVal("#searchForm .lxr_multipleSelect");
		if(id||id==0)queryParams.deptStr=deptUnder(id).join(",");
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
		},{width:"500px",height:"700px"});
	}

	

	//根据id查看
	function viewById(id){
		$lxr.modal({url:toInfoUrl+'?id='+id+"&type=info"});
	}
	
    //操作工具栏
    function operatorFormatter(value, row, index) {
    	var operator='<div class="btn-group">';
		    
    	operator+=$app.btn('auth','回访','tovisit(\''+row.id+'\',\''+row.name+'\')');
	    	<shiro:hasPermission name="personnel/organize/place:edit">
	    	operator+= $app.btn('edit','编辑','editById(\''+row.id+'\')');
		    </shiro:hasPermission>
		    <shiro:hasPermission name="personnel/organize/place:delete">
		    operator+= $app.btn('delete','删除','toRemove(\''+row.id+'\')');
	    	</shiro:hasPermission>
	    
			
			
		return operator+'</div>';
	}
    
   
    
 
    
</script>

<script type="text/javascript">

function tovisit(id,name){
	
	window.location.href = "${path}/customer/customer/visit.do?cusid="+id+"&cusName="+encodeURIComponent(name);
}

 function followFormatter(value, row, index){
	 
	 switch (value) {
	 
	case "1":
		return '初访';
		break;
	case "2":
		return '意向';
		break;
	case "3":
		return '报价';
		break;
	case "4":
		return '<span style="color:red;">成交</span>';
		break;
	case "5":
		return '搁置';
		break;
	default:
		break;
	}
	
	 
 }
 
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

    
    <div class="rightinfo explain_col" >
		<div>
    		<form id="searchForm" name="searchForm"  method="post">
    			<span>所属部门：</span>
    			<div style="display: inline;" class="lxr_multipleSelect" data-name="deptid" data-model="deptSelect"> </div>
				
    			<span>业务员：</span><input name="kw" value="" placeholder="业务员/客户"  class="form-control input-sm w200" type="text" style="display: inline;" >
				<span>录入时间：</span>
    			<input placeholder="开始" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
    			<input type="hidden" name="startTime">--
				<input placeholder="结束" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
				<input type="hidden" name="endTime">
				<span>跟进状态：</span>
				<select name="follow" class="form-control " style="display: inline;width: 100px;">
				<option value="">全部</option>
				<option value="1">初访</option>
				<option value="2">意向</option>
				<option value="3">报价</option>
				<option value="4">成交</option>
				<option value="5">搁置</option>
				</select>
				
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
			data-url="${path}/customer/customer/customer/view.do?state=0&ismy=true" data-pagination="ture" 
			data-side-pagination="server" data-cache="false" data-query-params="postQueryParams"
			data-page-list="[15, 30, 50, 100]" data-page-size= "15" data-method="post"
			data-show-refresh="false" data-show-toggle="false"
			data-show-columns="false" data-toolbar="#toolbar"
			data-click-to-select="false" data-single-select="false"
			data-striped="false" data-content-type="application/x-www-form-urlencoded"
			>
			<thead>
				<tr>
				
					<th data-field="" data-checkbox="true"></th>
					<th data-field="id" >ID</th>
					<th data-field="name" >名称</th>
					<th data-field="typeName">客户类型</th>
					<th data-field="contacts" >联系人</th>
					<th data-field="phone" >联系电话</th>
					<th data-field="follow" data-formatter="followFormatter">跟进状态</th>
					<th data-field="empName" >业务员</th>
					<th data-field="deptName" >部门</th>
					<th data-field="state"  data-formatter="$app.tableUi.state">状态</th>
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
