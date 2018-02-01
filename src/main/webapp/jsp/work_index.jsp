<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/global.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="jslib/calendar/simple-calendar.css" />
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
			     	<select>
				        <option value="0">2017年10月</option>
				        <option value="1">2017年11月</option>
				        <option value="2">2017年12月</option>
				        <option value="2">2018年01月</option>
			      	</select>
    			</div>
    		</div>
    		<div class="Ranking-box">
    			<div class="Ranking-wrap">
	    			<div class="Ranking-name">01.宋科
	    				<span class="Ranking-icon"><img src="images/layout/rank_01.png" alt="" /></span>
	    			</div>
	    			<div class="Ranking-rank">
	    				<div class="Ranking-inner">
	    					<div class="Ranking-strip">
	    						<span class="strip" data-number="15000"></span>
	    					</div>
	    					<span class="Ranking-number">1.5万</span>
	    				</div>
	    			</div>
    			</div>
    			<div class="Ranking-wrap">
	    			<div class="Ranking-name">02.艾鹏鹏
	    				<span class="Ranking-icon"><img src="images/layout/rank_02.png" alt="" /></span>
	    			</div>
	    			<div class="Ranking-rank">
	    				<div class="Ranking-inner">
	    					<div class="Ranking-strip">
	    						<span class="strip" data-number="14000"></span>
	    					</div>
	    					<span class="Ranking-number">1.4万</span>
	    				</div>
	    			</div>
    			</div>
    			<div class="Ranking-wrap">
	    			<div class="Ranking-name">03.李培
	    				<!--<span class="Ranking-icon"><img src="images/layout/rank_02.png" alt="" /></span>-->
	    			</div>
	    			<div class="Ranking-rank">
	    				<div class="Ranking-inner">
	    					<div class="Ranking-strip">
	    						<span class="strip" data-number="13000"></span>
	    					</div>
	    					<span class="Ranking-number">1.3万</span>
	    				</div>
	    			</div>
    			</div>
    			<div class="Ranking-wrap">
	    			<div class="Ranking-name">04.傅黎明
	    				<!--<span class="Ranking-icon"><img src="images/layout/rank_02.png" alt="" /></span>-->
	    			</div>
	    			<div class="Ranking-rank">
	    				<div class="Ranking-inner">
	    					<div class="Ranking-strip">
	    						<span class="strip" data-number="12000"></span>
	    					</div>
	    					<span class="Ranking-number">1.2万</span>
	    				</div>
	    			</div>
    			</div>
    			<div class="Ranking-wrap">
	    			<div class="Ranking-name">05.涂国庆
	    				<!--<span class="Ranking-icon"><img src="images/layout/rank_02.png" alt="" /></span>-->
	    			</div>
	    			<div class="Ranking-rank">
	    				<div class="Ranking-inner">
	    					<div class="Ranking-strip">
	    						<span class="strip" data-number="11000"></span>
	    					</div>
	    					<span class="Ranking-number">1.1万</span>
	    				</div>
	    			</div>
    			</div>
    			<div class="Ranking-wrap">
	    			<div class="Ranking-name">04.刘丽
	    				<!--<span class="Ranking-icon"><img src="images/layout/rank_02.png" alt="" /></span>-->
	    			</div>
	    			<div class="Ranking-rank">
	    				<div class="Ranking-inner">
	    					<div class="Ranking-strip">
	    						<span class="strip" data-number="10000"></span>
	    					</div>
	    					<span class="Ranking-number">1.0万</span>
	    				</div>
	    			</div>
    			</div>
    		</div>
    	</div>
    	<div class="calendar">
    		<div class="header_wrap cd">
    			<h4 class="fl">日历</h4>
    		</div>
    		<div class="calendar-wrap cd">
    			<div id='container'></div>
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
				        <option value="0">2017年10月</option>
				        <option value="1">2017年11月</option>
				        <option value="2">2017年12月</option>
				        <option value="2">2018年01月</option>
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
    <script src="jslib/calendar/simple-calendar.js"></script>
    <script src="jslib/g2.min.js"></script>
    <script src="jslib/data-set.min.js"></script>
	<script>
		
		
		$('.strip').each(function(){
			var _this=$(this),number=_this.attr('data-number'),
				thisW=(number/100000)*100;
				_this.css('width',thisW+"%");
		})
		
		layui.use('form', function(){
  			var form = layui.form;
		})
		var myCalendar = new SimpleCalendar('#container');  //calendar日历插件
		var options = {
			 	width: '100%',
			  	height: 'auto',
			  	language: 'CH', //语言
			  	showLunarCalendar: true, //阴历
			  	showHoliday: true, //休假
			  	showFestival: true, //节日
			  	showLunarFestival: true, //农历节日
			 	showSolarTerm: true, //节气
			 	showMark: true, //标记
			  	timeRange: {
					startYear: 1900, //从那年开始
					endYear: 2049  //到那年结束
			  	},
			 	mark: {
//					'2016-5-5': '上学'
			  	},
			  	theme: {
					changeAble: false,
				weeks: {
				  	backgroundColor: '#FBEC9C',
				 	fontColor: '#4A4A4A',
				  	fontSize: '20px',
				},
				days: {
				  	backgroundColor: '#ffffff',
				  	fontColor: '#565555',
				 	 fontSize: '24px'
				},
					todaycolor: 'orange',
					activeSelectColor: 'orange',
			  	}
			}
	</script>
	<script>
		function mountNode1(mountNode){
			const data = [
			    { month: '1', 销售额: 2, 单数: 1 },
			    { month: '2', 销售额: 4, 单数: 2 },
			    { month: '3', 销售额: 3.2, 单数: 2 },
			    { month: '4', 销售额: 1.6, 单数: 1 },
			    { month: '5', 销售额: 3.4, 单数: 2 },
			    { month: '6', 销售额: 2.3, 单数: 1 },
			    { month: '7', 销售额: 4, 单数: 2 },
			    { month: '8', 销售额: 6, 单数: 3 },
			    { month: '9', 销售额: 5.4, 单数: 2 },
			    { month: '10', 销售额: 3.6, 单数: 4 },
			    { month: '11', 销售额: 9.1, 单数: 6 },
			    { month: '12', 销售额: 1.5, 单数: 1 },
			    { month: '13', 销售额: 4, 单数: 2 },
			    { month: '14', 销售额: 2.4, 单数: 2 },
			    { month: '15', 销售额: 6, 单数: 4 },
			    { month: '16', 销售额: 4, 单数: 3 },
			    { month: '17', 销售额: 5.3, 单数: 2 },
			    { month: '18', 销售额: 1.3, 单数: 1 },
			    { month: '19', 销售额: 9, 单数: 4 },
			    { month: '20', 销售额: 4, 单数: 1 },
			    { month: '21', 销售额: 6.1, 单数: 4 },
			    { month: '22', 销售额: 6, 单数: 3 },
			    { month: '23', 销售额: 1.8, 单数: 1 },
			    { month: '24', 销售额: 4.7, 单数: 2 },
			    { month: '25', 销售额: 8, 单数: 4 },
			    { month: '26', 销售额: 7.4, 单数: 4 },
			    { month: '27', 销售额: 1.2, 单数: 3 },
			    { month: '28', 销售额: 6, 单数: 2 },
			    { month: '29', 销售额: 3, 单数: 3 },
			    { month: '30', 销售额: 4, 单数: 2 }
			];
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
			console.log(data);
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
			    padding: [ 20, 20, 30, 30 ]
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
	
});



function viewNotice(id){
	$app.dialog("${path}/admin/information/article/toinfo.do?id="+id,null,{width:"800px",height:"500px"});
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
</html>