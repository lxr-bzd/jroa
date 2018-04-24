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
var toAddUrl = '${path}/data/finance/emp/toedit.do';
var deleteUrl = '${path}/data/finance/emp/delete.do';
var toEditUrl = '${path}/data/finance/emp/toedit.do';
var toInfoUrl = '${path}/data/finance/emp/view.do';
	
	
	
  
	
	//设置查询参数
	function getParam(params) {
		$app.form.preSubmit("#searchForm");
		var queryParams = $("#searchForm").serializeObject();
		
		return queryParams;
	}
	
	
	function initModel(arr){
		
		var depts={};
		var emps = {};
		for (var i = 0; i < arr.length; i++) {
			var uid =  arr[i].uid;
			if(!emps[uid])emps[uid] = {uid:arr[i].uid,empName:arr[i].empName,deptName:arr[i].deptName,deptid:arr[i].deptid}
			switch (arr[i].type) {
			//请假
			case 1:
				emps[uid].qjtime = arr[i].time;
				break;
			//加班
			case 2:
				emps[uid].jbtime = arr[i].time;
				break;
			//未打卡
			case 5:
				emps[uid].wdktime = arr[i].time;
				break;
			default:
				break;
			}
			
			
		}
		
		 var emparr = {};
		
		for ( var i in emps) {
			if(!emparr[emps[i].deptid])emparr[emps[i].deptid] = [];
			emparr[emps[i].deptid].push(emps[i]);
			depts[emps[i].deptid] = emps[i].deptName;
		} 
		
		
		return {depts:depts,emps:emparr};
		
	}
	
	//查询列表
    function refTable(){
    	$app.request("${path}/data/finance/attend/view.do",function(data){
    		if(data.status!=0)return;
    		var mo = initModel(data.data);
		
		$("#tab_group").html(template("tabTmp",mo));
		
		},{param:getParam()});
    }
    
	
	$(function(){
		refTable();
	})

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
				&nbsp;&nbsp;&nbsp;
				<span>时间：</span>
				<input placeholder="-请选择-" data-lxr="{type:'time',format:'yyyy-MM'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false})">
	    			<input type="hidden" name="mtime">
				&nbsp;&nbsp;&nbsp;
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="refTable()">
    		</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	   
	  
		</div>
    </div>
    	<table class="table_list" data-toggle="table">
			<thead>
				<tr>
					<th>部门</th>
					<th >姓名</th>
					<th>加班时长（小时）</th>
					<th>请假时长（天）</th>
					<th>漏打卡（次）</th>
				</tr>
			</thead>
			<tbody id="tab_group">
				
			</tbody>
		</table>
		
    
</body>
	<script type="text/html" id="tabTmp">
 {{each depts as val i}}
			<tr>
					<td rowspan="{{emps[i].length+1}}">{{val}}</td>
					<td style="padding: 0;height:0;"></td>
					<td style="padding: 0;height:0;"></td>
					<td style="padding: 0;height:0;"></td>
					<td style="padding: 0;height:0;"></td>
				</tr>
 			{{each emps[i] as emp j}}
					<tr>
							
							<td>{{emp.empName}}</td>
							<td>{{emp.jbtime}}</td>
							<td>{{emp.qjtime}}</td>
							<td>{{emp.wdktime}}</td>
						</tr>
			{{/each}}
	{{/each}}
	
	</script>
	
</html>
