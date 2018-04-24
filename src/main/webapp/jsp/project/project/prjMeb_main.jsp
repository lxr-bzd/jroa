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
    <div class="project-box">
    	<div class="project-left">
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
			<div id="mountNode" style="width: 100%;height:400px;margin-top:20px;"></div>
    	</div>
    	<div class="project-right">
    		<div id="mountNode2" style="width: 100%;height:400px;"></div>
    	</div>
    </div>
    	

	
		
    
</body>
<%--<script src="${path}/jslib/g2.min.js"></script>--%>
	<%--<script src="${path}/jslib/data-set.min.js"></script>--%>
	<script src="${path}/jslib/echarts.min.js"></script>
	

	<script>
	var myChart = echarts.init(document.getElementById('mountNode'));
	var app = {};
	option = null;
	var posList = [
		'left', 'right', 'top', 'bottom',
		'inside',
		'insideTop', 'insideLeft', 'insideRight', 'insideBottom',
		'insideTopLeft', 'insideTopRight', 'insideBottomLeft', 'insideBottomRight'
	];

	app.configParameters = {
		rotate: {
			min: -90,
			max: 90
		},
		align: {
			options: {
				left: 'left',
				center: 'center',
				right: 'right'
			}
		},
		verticalAlign: {
			options: {
				top: 'top',
				middle: 'middle',
				bottom: 'bottom'
			}
		},
		position: {
			options: echarts.util.reduce(posList, function (map, pos) {
				map[pos] = pos;
				return map;
			}, {})
		},
		distance: {
			min: 0,
			max: 100
		}
	};

	app.config = {
		rotate: 90,
		align: 'left',
		verticalAlign: 'middle',
		position: 'insideBottom',
		distance: 15
	};
	
function initChart(mo){
	//name:'计划用时'
	var time1 = [];
	//name:'计划用时'
	var time2 = [];
    var fields = [];
for (var i = 0; i < mo.arr.length; i++) {
	fields.push(mo.arr[i].role);
	time1.push(mo.arr[i].alltime);
	time2.push(mo.arr[i].usetime);
}


option = {
		color: ['#003366', '#006699'],  //柱形颜色
		tooltip: {
			trigger: 'axis',
			axisPointer: {
				type: 'shadow'
			}
		},
		legend: {
			data: ['预计用时', '实际用时']  //参数
		},
		toolbox: {
			show: true,
			orient: 'vertical',
			left: 'right',
			top: 'center',
			feature: {
				mark: {show: true},
				dataView: {show: true, readOnly: false},
				restore: {show: true},
				saveAsImage: {show: true}
			}
		},
		calculable: true,
		xAxis: [
			{
				name: '部门',
				type: 'category',
				axisTick: {show: false},
				data: fields  //部门
			}
		],
		yAxis: [
			{
				name: '天数',
				type: 'value'
			}
		],
		series: [
			{
				name: '预计用时',
				type: 'bar',
				barGap: 0,
				data: time1
			},
			{
				name: '实际用时',
				type: 'bar',
				data: time2
			}
		]
	};
	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);


	}

	
	</script>
	<script type="text/javascript">
	var myChart2 = echarts.init(document.getElementById('mountNode2'));
	option2 = null;
	
	option2 = {
		    title : {
		        text: '某站点用户访问来源',
		        subtext: '纯属虚构',
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data: ['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
		    },
		    series : [
		        {
		            name: '访问来源',
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:[
		                {value:335, name:'直接访问'},
		                {value:310, name:'邮件营销'},
		                {value:234, name:'联盟广告'},
		                {value:135, name:'视频广告'},
		                {value:1548, name:'搜索引擎'}
		            ],
		            itemStyle: {
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                }
		            }
		        }
		    ]
		};
	myChart2.setOption(option2);
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
