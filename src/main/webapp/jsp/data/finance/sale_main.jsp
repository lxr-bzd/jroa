<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/global.jsp"%>	
<title>查询列表</title>

</head>
<body class="mlr15">

    
    <div class="rightinfo explain_col">
		<div>
    		<form id="searchForm" name="searchForm"  method="post">
    			
				<span>时间：</span>
				<input placeholder="年" name="year" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary" onfocus="WdatePicker({dateFmt:'yyyy',minDate:'2006',maxDate:'2099',isShowClear:false})">
    			
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="refTable()">
    		</form>
    	</div>
    </div>
    	<div class="pd10">
    		<div id="Chart1" style="width: 100%;height: 450px;"></div>
    	</div>
    	<table class="table_list" id="mainTable" data-toggle="table">
			<thead>
				<tr>
				
					
					<th data-field="time" >时间</th>
					<th data-field="user" >用户量</th>
					
					<th data-field="order" >订单量</th>
					<th data-field="receivables" >应收款(万元)</th>
					<th data-field="receipts" >实收款(万元)</th>
					<th data-field="" >未收款(万元)</th>
				</tr>
			</thead>
			<tbody id="tab_group">
				
			</tbody>
		</table>
		<div class="fixed-table-pagination">
			<div class="pd10">
				应收合计：<span id = "receivable">-</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				实收合计：<span id = "collect">-</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				未收合计：<span id = "uncollect">-</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		</div>
    <script src="/jroa/jslib/echarts.min.js"></script>
	<script>
			var myChart = echarts.init(document.getElementById('Chart1'));
			option = {
			    tooltip: {
			        trigger: 'axis',
			        axisPointer: {
			            type: 'cross',
			            crossStyle: {
			                color: '#999'
			            }
			        }
			    },
			    toolbox: {
			        feature: {
			            dataView: {show: true, readOnly: false},
			            magicType: {show: true, type: ['line', 'bar']},
			            restore: {show: true},
			            saveAsImage: {show: true}
			        }
			    },
			    legend: {
			        data:['用户量','订单量','实收款']
			    },
			    xAxis: [
			        {
			            type: 'category',
			            name: '日期',
			            data: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			            axisPointer: {
			                type: 'shadow'
			            }
			        }
			    ],
			    yAxis: [
			        {
			            type: 'value',
			            name: '业绩',
			            axisLabel: {
			                formatter: '{value} 万'
			            }
			        }
			    ],
			    series: [
			        {
			            name:'用户量',
			            type:'bar',
			            color: 'blue',
			            data:[]
					},
			        {
			            name:'订单量',
			            type:'bar',
			            color: 'green',
			            data:[]
					},
			        {
			            name:'实收款',
			            type:'bar',
			            color: 'gray',
			            data:[]
			        }
			    ]
			};
		

	</script>
	
	<script type="text/javascript">
	$(function(){
		refTable();
	})
	
	
	
	function getParam(){
		var queryParams = $("#searchForm").serializeObject();
		return queryParams;
	}
	
	
	function refTable(){
		
		$app.request("${path}/data/finance/sale/view.do",function(data){
			var cuss = [];
			if(typeof(data.data.cuss)=="object")cuss = data.data.cuss;
			
			var prjs = [];
			if(typeof(data.data.prjs)=="object")prjs = data.data.prjs;
			
			var keys = {};
			
			for (var i = 0; i < cuss.length; i++) { var mdate = cuss[i].mdate;
			keys[mdate+""] = insert_flg(mdate,"-",4);
					}
			for (var i = 0; i < prjs.length; i++) { var mdate = prjs[i].mdate;
			keys[mdate+""] = insert_flg(mdate,"-",4);
					}
			
			var models = [];
			for ( var i in keys) {
				
				var cus = getCus(cuss,i);
				var prj = getPrj(prjs,i);
				var mo = createModel(cus,prj);
				mo.vmdate = keys[i];
				mo.mdate = i;
				models.push(mo);
			}
			
			renderTable(models);
			 renderView(models,data.data.cyear);
		},{param:getParam()});
		
	}
	
	
	function renderTable(models){
		$("#tab_group").html(template("tabTmp",{data:models}));
		var receivable = 0;
		var collect = 0;
		for (var i = 0; i < models.length; i++) {
			receivable+= (isNaN(models[i].receivable)?0:models[i].receivable);
			collect+= (isNaN(models[i].collect)?0:models[i].collect);
		}
		
		$("#collect").html(collect/10000+"万");
		$("#receivable").html(receivable/10000+"万");
		$("#uncollect").html((receivable-collect)/10000+"万");
	}
	
	
	
	function createModel(emp,prj){
		
		var mo = {};
		if(!emp)emp={cusNum:0}
		
		mo.cusNum = emp.cusNum;
		
		if(!prj)prj = {"receivable":0.00,"collect":0.00};
		
		mo.receivable = prj.receivable;
		mo.collect = prj.collect;
		mo.prjNum =  prj.prjNum
		return mo;
		
	}
	
	function getCus(cuss,key){
		
		for (var i = 0; i < cuss.length; i++) {
			if(cuss[i].mdate==key)return cuss[i];
		}
		
	}
	
	
	function getPrj(cuss,key){
		
		
		for (var i = 0; i < cuss.length; i++) {
			if(cuss[i].mdate==key)return cuss[i];
		}
		
	}
	
	function insert_flg(str,flg,sn){
	  
	     return str.substring(0, sn)+flg+str.substring(sn, str.length);
	}
	
	
	function renderView(models,cyear){
		
		option.series[0].data = [];
		option.series[1].data = [];
		option.series[2].data = [];
		for (var i = 1; i < 13; i++) {
			var key = cyear+(i<9?("0"+i):(i+""));
			var mo = findModel(key,models);
			if(!mo){
				option.series[0].data.push(0);
				option.series[1].data.push(0);
				option.series[2].data.push(0);
			}else{
				option.series[0].data.push(mo.cusNum);
				option.series[1].data.push(mo.prjNum);
				option.series[2].data.push(mo.collect/10000);
			}
		}
		
		myChart.setOption(option);
	}
	
	
	function findModel(key,models){
		for (var i = 0; i < models.length; i++) {
			if(models[i].mdate==key)
				return models[i];
		}
		
	}
	
	
	
	</script>
	
	<script type="text/html" id="tabTmp">
 {{each data as val i}}
    
			<tr>
					<td>{{val.vmdate}}</td>
					<td>{{val.cusNum}}</td>
					<td>{{val.prjNum}}</td>
					<td>{{val.receivable/10000}}</td>
					<td>{{val.collect/10000}}</td>
					
					<td>{{(val.receivable-val.collect)/10000}}</td>
				</tr>
	{{/each}}
	
	</script>
	
	
</body>
</html>
