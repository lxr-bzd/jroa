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

	
	$(function(){
		refTable();
		
	});
	
  
	
	//设置查询参数
	function getParam(params) {
		var queryParams = $("#searchForm").serializeObject();
		
		return queryParams;
	}
	
	//查询列表
    function refTable(){
    	$app.request("${path}/data/finance/project/view.do",function(data){
    		if(data.status!=0)return;
    		var model = parseResult(data.data);
    		
		$("#tab_group").html(template("tabTmp",{data:model}));
		},{param:getParam()});
    }
    
	
	function getState(){
		var state = [];
		state.push( {name:'策划中',val:1});
		state.push( {name:'开发中',val:2});
		state.push( {name:'测试中',val:3});
		state.push( {name:'已完成',val:4});
		state.push( {name:'维护中',val:5});
		state.push( {name:'待续费',val:6});
		state.push( {name:'已过期',val:7});
		state.push( {name:'已失效',val:8});
		state.push( {name:'暂停中',val:9});
		return state;
	}
	
	
	function parseResult(data){
		
		var models = {};
		for (var i = 0; i < data.length; i++) {
			var mo = models[data[i].managerid+""];
			if(!mo){
				mo = {managerid:data[i].managerid,prog:{}};
				models[data[i].managerid+""] = mo;
			}
			mo.name = data[i].name;
			mo.prog[data[i].progressid] = data[i].num;
			
		}
		
		
		return models;
		
	}
	
	
    
</script>
</head>
<body class="mlr15">
    <div class="rightinfo explain_col">
		<div>
    		<form id="searchForm" name="searchForm"  method="post">
				<span>时间：</span>
				<input placeholder="开始" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
    			<input type="hidden" name="regStart">--
				<input placeholder="结束" data-lxr="{type:'time',format:'yyyy-MM-dd'}" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({isShowClear:false})">
				<input type="hidden" name="regEnd">
				&nbsp;&nbsp;&nbsp;
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="queryList()">
    		</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	   
		</div>
    </div>
    	<table class="table_list" data-toggle="table">
			<thead>
				<tr>
					<th>项目经理</th>
					<th>策划中</th>
					<th>开发中</th>
					<th>测试中</th>
					<th>已完成</th>
					<th>维护中</th>
					<th>待续费</th>
					<th>已过期</th>
					<th>已失效</th>
					<th>暂停中</th>
				</tr>
			</thead>
			<tbody id="tab_group">
				
			</tbody>
		</table>
		
    
</body>

	<script type="text/html" id="tabTmp">
 {{each data as val i}}
    
				<tr>
					<td>{{val.name}}</td>
					
					<td>{{val.prog['1']}}</td>
					<td>{{val.prog['2']}}</td>
					<td>{{val.prog['3']}}</td>
					<td>{{val.prog['4']}}</td>
					<td>{{val.prog['5']}}</td>
					<td>{{val.prog['6']}}</td>
					<td>{{val.prog['7']}}</td>
					<td>{{val.prog['8']}}</td>
					<td>{{val.prog['9']}}</td>
				</tr>
	{{/each}}
	
	</script>
</html>
