<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/global.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${path}/css/layout/calendar.css" />
<title>默认显示页</title>

</head>
<body>
    <div class="OneMain cd pd20">
    	<div class="Notice">
    		<div class="header_wrap cd">
    			<h4 class="fl">通知公告</h4>
    		</div>
    		<ul id="notice_guoup" class="Notice-wrap">
    			
    		</ul>
    	</div>
    	<div class="Ranking">
    		<div class="header_wrap cd">
    			<h4 class="fl">销售排行</h4>
    			<div class="layui-form fr">
			     	<select id="sale_select" lay-filter="sale_select">
				    
			      	</select>
    			</div>
    		</div>
    		<div class="Ranking-box" id="sale_group">
    		
    		
    		</div>
    	</div>
    	<div class="calendar-box">
    		<div class="header_wrap cd">
    			<h4 class="fl">日历</h4>
    		</div>
    		<div class="calendar-wrap cd">
    			<div id="calendar"></div>
    		</div>
    	</div>
    </div>
	<div class="listMain pd20">
		<ul class="cd" id="monthStatistics">
			<li class="listInner">
				<div class="list1">
					<p class="listText">本月新增用户</p>
					<div class="listNum"><span class="attr-map listNum" data-map="customerNum">--</span>个</div>
				</div>
			</li>
			<li class="listInner">
				<div class="list2">
					<p class="listText">本月签单数</p>
					<div class="listNum"><span class="attr-map listNum" data-map="projectNum">--</span>单</div>
				</div>
			</li>
			<li class="listInner">
				<div class="list3">
					<p class="listText">本月销售业绩</p>
					<div class="listNum"><span class="attr-map listNum" data-map="collectNum">--</span>万</div>
				</div>
			</li>	
			<li class="listInner">
				<div class="list4">
					<p class="listText">本月请假人数</p>
					<div class="listNum"><span class="attr-map listNum" data-map="leaveNum">--</span>人</div>
				</div>
			</li>
			<li class="listInner">
				<div class="list5">
					<p class="listText">本月生日人数</p>
					<div class="listNum"><span class="attr-map listNum" data-map="birthdayNum">--</span>人</div>
				</div>
			</li>
		</ul>
	</div>
	<div class="ThreeMain cd pd20">
		<div class="results">
			<div class="header_wrap cd">
				<h4 class="fl">销售业绩及单数</h4>
				<div class="layui-form fr">
			     	<select>
				      
			      	</select>
				</div>
			</div>
			<div class="results-wrap">
				<div id="Chart1"></div>
			</div>
		</div>
		<div class="sector">
			<div class="header_wrap cd">
				<h4 class="fl">公司部门（人）</h4>
			</div>
			<div class="sector-wrap">
				<div id="Chart2"></div>
			</div>
		</div>
	</div>
    <script src="${path}/jslib/calendar.js"></script>
    <script src="${path}/jslib/g2.min.js"></script>
    <script src="${path}/jslib/data-set.min.js"></script>
	<script>

		// 关于月份： 在设置时要-1，使用时要+1
		$(function () {

		  $('#calendar').calendar({
		    ifSwitch: true, // 是否切换月份
		    hoverDate: true, // hover是否显示当天信息
		    backToday: true // 是否返回当天
		  });

		});
		
		
		$('.strip').each(function(){
			var _this=$(this),number=_this.attr('data-number'),
				thisW=(number/100000)*100;
				_this.css('width',thisW+"%");
		})
		
		layui.use('form', function(){
  			var form = layui.form;
		})
	</script>
	<script>
		function mountNode1(mountNode,vdata){
			const data = vdata;
			
			const ds = new DataSet();
			const dv = ds.createView().source(data);
			dv.transform({
			    type: 'fold',
			    fields: [ '销售额', '单数' ], // 展开字段集
			    key: 'city', // key字段
			    value: 'temperature', // value字段
			});
			const chart = new G2.Chart({
			    container: mountNode,
			    forceFit: true,
			    height: 300 ,
			    padding: [ 20, 20, 40, 40 ]
			});
			chart.legend({ 
			 	position: 'top', // 设置图例的显示位置
			 	marker: 'circle' ,
			  	itemGap: 20 // 图例项之间的间距
			});
			chart.source(dv, {
			    month: {
			      range: [ 0, 1 ]
			    }
			});
			chart.tooltip({
			    crosshairs: {
			      type: 'line'
			    }
			});
			chart.axis('temperature', {
			  	label: {
				    formatter: val => {
				      return val + '万';
				    }
			  	},
			  	line: {
				    lineWidth: 1, // 设置线的宽度
				    stroke: '#ccc', // 设置线的颜色
			  	}
			});
			chart.line().position('month*temperature').color('city');
			chart.point().position('month*temperature').color('city').size(4).shape('circle').style({
			    stroke: '#fff',
			    lineWidth: 1
			});
		chart.render();
		};
		function mountNode2(mountNode,data){
		
			/* const data = [
			    { year: '美工部', 人数: 12 },
			    { year: '前端部', 人数: 12 },
			    { year: '安卓部', 人数: 40 },
			    { year: '苹果部', 人数: 25 },
			    { year: '后台部门', 人数: 10 },
			    { year: '业务部', 人数: 16 },
			    { year: '财务部', 人数: 5 },
				   { year: '业务3部', 人数: 16 },
			    { year: '435', 人数: 5 },
				   { year: '业435务部', 人数: 16 },
			    { year: '财务345部', 人数: 5 },
				   { year: '业务部', 人数: 16 },
			    { year: '财务435部', 人数: 5 },
		  	]; */
		  	const chart = new G2.Chart({
			    container: mountNode,
			    forceFit: true,
			    height: 300 ,
			    padding: [ 40, 20, 50, 30 ]
		  	});
		  	chart.source(data);
		  	chart.scale('人数', {
		    	tickInterval: 10
		  	});
			chart.axis('y', {
			  	line: {
				    lineWidth: 1, // 设置线的宽度
				    stroke: '#ccc', // 设置线的颜色
			  	}
			});
		  	chart.interval().position('year*人数');
		  	chart.render();
		};
		
		mountNode1('Chart1');
		
	</script>
<script type="text/javascript">


$(function() {
	//渲染部门
	$app.request("${path}/personnel/organize/dept/view.do",function(data){
		var depts = data.data;
		var deptModel = $lxr.tree(data.data,{pidname:"parentid"});
		
		var vmodel = [];
		for (var i = 0; i < depts.length; i++) {
			if(!depts[i].childs||depts[i].childs.length<1)
				vmodel.push( { year: depts[i].name, 人数: new Number(depts[i].manNum) });
		}
		
		mountNode2('Chart2',vmodel);
		
	});
	
	//渲染公告
	$app.request("${path}/admin/information/article/view.do?type=1&state=0&limit=10&offset=0",function(data){
		var rows = data.rows;
		
		for (var i = 0; i < rows.length; i++) {
			if(isNaN(rows[i].createtime))continue;
			rows[i].vdate = new Date(new Number(rows[i].createtime)).format("MM.dd");
			if(rows[i].vdate==new Date().format("MM.dd"))rows[i].isnew = true;
		}
		
		$("#notice_guoup").html(template("tem_notice",data));
		
	});
	
	//渲染月统计
	$app.request("${path}/index/statistics.do",function(data){

		
		if(data.status!=0)return;
		$("#monthStatistics .attr-map").each(function(i,e){
			var vname= $(e).attr("data-map");
			if(!vname)return;
			if(vname=='collectNum')
				$(e).html(data.data[vname]/10000);
			else
			$(e).html(data.data[vname]);
			
		});
		
		
		
	});
	
	
	//渲染销售额排行
	layui.use('form', function(){
		  var form = layui.form;
		  form.on('select(sale_select)', function(data){
				onChangeSale(data.value);
				}); 
		});
	
	//销售业绩图表
	
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
			
			 renderView(models,data.data.cyear);
		});

	
	
	
	for (var i = 0; i < 5; i++) {
		var vdate = getMonthFirst(i);
		$("#sale_select").append('<option value="'+vdate.getTime()+'">'+vdate.format("yyyy-MM")+'</option>');
		
	}
	
	onChangeSale($("#sale_select").val());
	
	
	
	
	
	
});

function renderView(models,cyear){
	var ret = [];
	
	for (var i = 1; i < 13; i++) {
		var key = cyear+(i<9?("0"+i):(i+""));
		var mo = findModel(key,models);
		if(!mo){
			ret.push({ month: i, 销售额: 0, 单数: 0 });
		}else{
			ret.push({ month: i, 销售额: mo.collect/10000, 单数: mo.prjNum });
			
		}
	}
	
	mountNode1('Chart1',ret);
	
}

function findModel(key,models){
	for (var i = 0; i < models.length; i++) {
		if(models[i].mdate==key)
			return models[i];
	}
	
}
function insert_flg(str,flg,sn){
	  
    return str.substring(0, sn)+flg+str.substring(sn, str.length);
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


function onChangeSale(val){
	var starttime = val;
	var endtime = getMonthLast(new Date(new Number(starttime))).getTime();
	//渲染x销售月统计
	$app.request("${path}/index/sale.do",function(data){
		if(data.status!=0)return;
		
		$("#sale_group").empty();
		if(!data.data||data.data.length<1){
			$("#sale_group").append('(暂无数据！)');
			return;
			}
		
		for (var i = 0; i < data.data.length; i++) {
			data.data[i].sort = i+1;
			data.data[i].collectNumView = data.data[i].collectNum/10000;
			var html = template("tem_sale",data.data[i]);
			$("#sale_group").append(html);
		}
		refSale();
		
	},{param:{starttime:starttime,endtime:endtime}});
}



function viewNotice(id){
	$app.dialog("${path}/admin/information/article/toinfo.do?id="+id,null,{width:"800px",height:"500px"});
}




function refSale(){
	
	$("#sale_group>.Ranking-wrap .Ranking-strip").each(function(i,e){
		//以30万为基数
		var bl =  $(e).find(".strip").attr("data-number")/300000;
		var width = $(e).width()*bl
		 $(e).find(".strip").css("width",width);
		
	});
	
}


function toPrjCollect(empName){
	
	window.location.href = "/jroa/project/project/prjCollect.do?sysModule=main&empName="+encodeURIComponent(empName);
}


</script>
<script type="text/javascript">

function getMonthFirst(n){ 
	var cdate = new Date();
	var monthStartDate = new Date(cdate.getFullYear() , cdate.getMonth()-n, 1); 
	return monthStartDate; 
	} 


function getMonthLast(cdate)     
{     
    var Nowdate=cdate;     
    var MonthNextFirstDay=new Date(Nowdate.getFullYear(),Nowdate.getMonth()+1,1);     
    var MonthLastDay=new Date(MonthNextFirstDay-86400000);     
    M=Number(MonthLastDay.getMonth())+1;     
    return MonthLastDay;     
}

</script>
</body>
<script type="text/html" id="tem_notice">
{{each rows as item i}}
  <li>
<a href="javascript:viewNotice('{{item.id}}')" class="cd">
	<div class="Notice-text">
		<span class="Notice-date">[{{item.vdate}}]</span>
		{{item.title}}
	
		{{if item.isnew}}<i class="Notice-icon fr">new</i>{{/if}}
	</div>
</a>
</li>
{{/each}}
</script>

<script type="text/html" id="tem_sale">
<div class="Ranking-wrap">
	    			<div class="Ranking-name"><a href="javascript:toPrjCollect('{{empName}}')">{{sort}}.{{empName}}</a>
	    				<!--<span class="Ranking-icon"><img src="images/layout/rank_02.png" alt="" /></span>-->
	    			</div>
	    			<div class="Ranking-rank">
	    				<div class="Ranking-inner">
	    					<div class="Ranking-strip">
	    						<span class="strip" data-number="{{collectNum}}"></span>
	    					</div>
	    					<span class="Ranking-number">{{collectNumView}}万</span>
	    				</div>
	    			</div>
    			</div>
</script>
</html>