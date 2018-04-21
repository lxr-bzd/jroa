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
		initBtn();
		$("#mName").html(decodeURIComponent(GetQueryString("prjName")));
	});
	
  
	
	//设置查询参数
	function getParam(params) {
		var queryParams = $("#searchForm").serializeObject();
		
		return queryParams;
	}
	
	//查询列表
    function refTable(){
    	$app.request("${path}/project/project/prjMeb/view.do",function(data){
    		if(data.status!=0)return;
    		var mo = cModel(data.data);
    		$("#main_table").html(template("tabTmp",mo));
    		initChart(mo);
		},{param:getParam()});
    }
    
	
	function cModel(data){
		var mo = {arr:data.mebs,uid:data.uid,allMoney:0};
		
		for (var i = 0; i < mo.arr.length; i++) {
			
			if(mo.arr[i].starttime)mo.arr[i].starttime = $app.tableUi.date(mo.arr[i].starttime);
			if(mo.arr[i].intime)mo.arr[i].intime = $app.tableUi.time(mo.arr[i].intime);
			mo.arr[i].uMoney = mo.arr[i].empMoney*mo.arr[i].usetime;
			
			if(isNaN(mo.arr[i].uMoney))mo.arr[i].uMoney = 0;
			
			mo.allMoney+=mo.arr[i].uMoney;
			
		}
		
		return mo;
		
	}
	
	
	function initBtn(){
		
		$app.request("${path}/project/project/prjMeb/view.do?type=state&prjid="+getPrjid(),function(data){
    		if(data.status!=0)return;
    		gBtn(data.data);
    	
		});
		
		
		
		
	}
	
	function gBtn(s){

			
			switch (s) {
			case 1:
				$("#btn_group").html('<input type="button" disabled="disabled"  class="btn btn-info btn-round btn-sm"  value="开始" >');
				
				break;
			
			case 2:
				$("#btn_group").html('<input type="button" class="btn btn-info btn-round btn-sm" onclick="doDev(this,true)" value="开始" >');
				
				break;
			case 3:
				$("#btn_group").html('<input type="button" class="btn btn-info btn-round btn-sm" onclick="doDev(this,false)" value="结束" >');
				break;
			

			default:
				$("#btn_group").html('<input type="button" disabled="disabled"  class="btn btn-info btn-round btn-sm"  value="开始" >');
			
				break;
			}
			return;
			
		
		
	}
	
	
	
	function doDev(btn,s){
		var type="start";
		if(!s)type="end";
			
			$app.request("${path}/project/project/prjMeb/doDev.do",function(data){
	    		if(data.status!=0)return;
	    		
	    		gBtn(data.data);
	    		
	    		refTable();
	    		
			
			},{param:{type:type,prjid:getPrjid()}});
		
	}
	
	
	function getPrjid(){
		
		return $("#searchForm input[name=prjid]").val();
		
	}
	
	function setAlltime(){
		$app.prompt("设置预计用时(天)",function(pass){
			if(isNaN(pass)){
				$app.alert("填入数字");
				return true;
				
			}
		$app.request("${path}/project/project/prjMeb/setTime.do",function(data){
			if(data.status==0)
				refTable();
			
			else $app.alert(data.msg?data.msg:'失败');
			
		},{param:{prjid:getPrjid(),alltime:pass}});
			
			
		});
		
	}
	
	
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
<div id="btn_group" style="padding-top: 20px;"><input type="button" disabled="disabled" class="btn btn-info btn-round btn-sm" value="开始" ></div>
    <div class="rightinfo explain_col">
		<div class="project-name">
    		<form id="searchForm" name="searchForm"  method="post">
    		<input type="hidden" name="prjid" value="${param.prjid }">
				<span>项目名称：</span><span id="mName"></span>
				&nbsp;&nbsp;&nbsp;
				
    			
    		</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	   
		</div>
    </div>
    	
    	<table class="project-list" width="100%">
			<thead>
				<tr>
					<th>职位</th>
					<th>姓名</th>
					<th>开始时间</th>
					<th>上次开始时间</th>
					<th>预算用时(天)</th>
					<th>实际用时(天)</th>
					<th>人力成本(元)</th>
				</tr>
			</thead>
			<tbody id="main_table">
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				
				<tr>
					<td>参与人数</td>
					<td colspan="6" style="text-align:left;">张三</td>
				</tr>
				<tr>
					<td>成本合计</td>
					<td colspan="6" >张三</td>
				</tr>
				
			</tbody>
		</table>
		
			<div id="mountNode"></div>
	
		
    
</body>
<script src="${path}/jslib/g2.min.js"></script>
	<script src="${path}/jslib/data-set.min.js"></script>
	<script>
			function initChart(mo){
				var time1 =    { name:'计划用时'};
				var time2 =    { name:'实际用时'};
			
			var fields = [];
				
			for (var i = 0; i < mo.arr.length; i++) {
				fields.push(mo.arr[i].role);
				time1[mo.arr[i].role] = 0;
				time2[mo.arr[i].role] = mo.arr[i].usetime;
			}
				 
				 
					  const ds = new DataSet();
					  const dv = ds.createView().source([time1,]);
					  dv.transform({
					    type: 'fold',
					    fields:fields,
					   // fields: [ 'Jan.','Feb.','Mar.','Apr.','May','Jun.','Jul.','Aug.' ], // 展开字段集
					    key: '月份', // key字段
					    value: '月均降雨量', // value字段
					  });
					  chart.axis('x', {
						  line: {
						    lineWidth: 2, // 设置线的宽度
						    stroke: 'red', // 设置线的颜色
						    lineDash: [ 3, 3 ] // 设置虚线样式
						  }
						});
					  chart.source(dv);
					  chart.interval().position('月份*月均降雨量').color('name').adjust([{
					    type: 'dodge',
					    marginRatio: 1 / 32
					  }]);
					  chart.render();
				
				
			}
		

			  const chart = new G2.Chart({
			    container: 'mountNode',
			    forceFit: true,
			    height: 260
			  });
			 
	</script>

	<script type="text/html" id="tabTmp">
	
	 {{each arr as val i}}  
  
         <tr >
					<td>{{val.role}}</td>
					<td>{{val.empName}}</td>
					<td>{{val.starttime}}</td>
					<td>{{val.intime}}</td>
					<td>{{if !val.alltime&&val.empid==uid}} 
<input type="button" class="btn btn-info btn-round btn-sm" onclick="setAlltime('{{uid}}')" value="设置用时">
{{else}}{{val.alltime}}{{/if}}</td>
					<td>{{val.usetime}}</td>
					<td>{{val.uMoney}}</td>
				</tr> 
	{{/each}}  
				
				<tr>
					<td>参与人数</td>
					<td colspan="6"  style="text-align:left;">{{arr.length}}</td>
				</tr>
				<tr>
					<td>成本合计</td>
					<td colspan="6"  style="text-align:left;">{{allMoney}}</td>
				</tr>
				
	</script>
</html>
