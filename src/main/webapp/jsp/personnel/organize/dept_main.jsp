<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<%@ include file="/common/global.jsp"%>	
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询列表</title>
<script>

var toAddUrl = '${path}/personnel/organize/dept/toedit.do';
var deleteUrl = '${path}/personnel/organize/dept/delete.do';
var toEditUrl = '${path}/personnel/organize/dept/toedit.do';
var toInfoUrl = '${path}/personnel/organize/dept/view.do';

	//添加
	function toAdd(pid){
		
		$app.dialog(toAddUrl+(pid?("?pid="+pid):""),function(){
			refMain();
		},{width:"460px",height:"280px"});
		
	}
	//删除
	function toRemove(id){
		var ids;
		if(!id)
		ids=getSelectedTr();
		else ids = [id];
	
		if(ids){
			
			$app.confirmDelete(deleteUrl+'?ids='+ids.join(","),'删除数据不可恢复，确定要删除吗？'
					,function(){
				refMain();
			});
			
			
		}else{
			$app.alert("请选择一条数据进行操作");
		}
	}
	

	
	//设置查询参数
	function postQueryParams(params) {
		var queryParams = $("#searchForm").serializeObject();
		queryParams.limit=params.limit;
		queryParams.offset=params.offset;
		return queryParams;
	}
	//查询列表
    function refMain(){
    	window.location.reload();
    }
    
    function editById(id){
    	$app.dialog(toEditUrl+'?id='+id+"&action=edit",function(){
    		refMain();
		},{width:"460px",height:"280px"});
		
	}


	//根据id查看
	function viewById(id){
		$lxr.modal({url:toInfoUrl+'?id='+id});
	}
	

   //状态转化
    function formatState(value){
    	if(value==1){
    		return "有效";
    	}else{
    		return "无效";
    	}
    }
   
   
   
   
    function getSelectedTr(){
    	
    	var ids = [];
    	
    	$("#main_tbody input[name=btSelectItem]").each(function(i,ele){
    	      if($(ele).prop("checked"))
    	    	  ids.push($(ele).attr("data-id"));
    	    	  
    	    	  
    	      });
    	return ids;
    }
  
</script>




</head>
<body>




    
    <div class="rightinfo">
		<div>
    		<form id="searchForm" name="searchForm"  method="post">
    		</form>
    	</div>
	  
		
		<div id="toolbar" class="btn-group" style="margin:15px auto">
	   
	   <shiro:hasPermission name="personnel/organize/dept/save">
	   		 <button class="btn btn-info btn-round  btn-sm" onclick="toAdd();" >
					<i class="glyphicon glyphicon-plus"></i> 新增部门
			</button>

		</shiro:hasPermission>
	   
	   		
		</div>
    
    	<table id ="mtable"  data-toggle="table" class="table_list" >
			<thead>
				<tr>
					<th data-field="" data-checkbox="true"></th>
					<th data-field="id">id</th>
					<th >部门层级</th>
					<th >部门人数</th>
					<th >状态</th>
					
					<th >操作</th>
				</tr>
			</thead>
			<tbody id="main_tbody">
			
			</tbody>
		</table>
		  <!--<label class="select_all"><input id="checkall" type="checkbox" name="checkall" onclick="  $('#SysUserList thead input[name=btSelectAll]').click()" class="J_checkall">全选/取消</label>-->

    </div>
      
</body>

<script type="text/javascript">
function queryChild(ids,cid){
	var v = findByid(cid).childs;
	for (var i = 0; i < v.length; i++) {
		ids.push(v[i].id);
		queryChild(ids,v[i].id);
	}
	
}


</script>

<script type="text/javascript">

var model;

var vmodel = [];

$(function(){
	
	init();
	$("#mtable").find('thead input[name=btSelectAll]')
	.unbind('click')
	.click(
			function(){
				var c = this.checked;
			
				$("#main_tbody input[name=btSelectItem]").prop("checked",c);//attr("checked", c);
				
			});
	
	$("#checkall").click(
			function(){
				var c = this.checked;
			
				$("#main_tbody input[name=btSelectItem]").prop("checked",c);//attr("checked", c);
				
			});
})


function init(){
	
	
	$.ajax({url:"${path}/personnel/organize/dept/view.do"
	,success:function(data){
		
		initVmodel(data.data);
		
		for (var i = 0; i < model.length; i++) {
			model[i].createTime_v = Formatter.date(model[i].createTime);
			model[i].modifyTime_v = Formatter.date(model[i].modifyTime);
			model[i].knowledgeTypeState_v = formatState(model[i].knowledgeTypeState);
			
		}
		
		
		
		paintRoot();

	}
	
	});
	
	
}

function initVmodel(l){
	model = l;
	vmodel = getByPid();
	for (var i = 0; i < vmodel.length; i++) {
		vmodel[i].level = 0;
		setChild(vmodel[i]);
	}
}


function setChild(p) {
	p.childs = getByPid(p.id);
	if(p.childs instanceof Array)
		for (var i = 0; i < p.childs.length; i++) {
			p.childs[i].level = p.level+1;
			setChild(p.childs[i]);
		}
}

 function getByPid(pid){
	 var l = [];
	 if(!pid||pid===0)pid=null;
		 for (var i = 0; i < model.length; i++) {
			if(model[i].parentid==pid)
				l.push(model[i]);
		}
		 return l;
 }
 
 
 function findByid(id){
	 for (var i = 0; i < model.length; i++) {
			if(model[i].id==id)
				return model[i];
		}
 }


 
 function paintRoot(){
	 
	 
	 $("#main_tbody").empty();
	 for (var i = 0; i < vmodel.length; i++) {
		 vmodel[i].level = 0;
		 vmodel[i].symbol = "";
		 vmodel[i].formatState = $app.tableUi.state;
		 vmodel[i].formatBtn = $app.btn;
		$("#main_tbody").append(template("tem_tr",vmodel[i]));
	}
		
	 
 }
 
 
 
 /* ----------------------------- */
 function printChild(tr){
		
		var v = findByid($(tr).attr("data-id"));
		if(!v)return;
		
		var html = "";
		for (var i = 0; i < v.childs.length; i++) {
			var obj = v.childs[i];
			obj.level = v.level+1;
			obj.symbolClass = "padding-left:"+(obj.level*20)+"px";
				
			obj.symbol = nstr("&nbsp;",obj.level)+"├─";
			if(i==v.childs.length-1)obj.symbol = nstr("&nbsp;",obj.level)+"└─";
				
			obj.formatState = $app.tableUi.state;
			obj.formatBtn = $app.btn;
			html+=template("tem_tr",obj);
		
		}
		$(tr).after(html);
		
		
		
 }
 
 
 
 function nstr(str,n){
	 
	 var s = str;
	 for (var i = 0; i < n; i++) {
		str+=s;
	}
	
	 return str;
	 
 }
 
 

function removeChild(tr) {
	var v = $(tr).attr("data-id");
	var ch = $("#main_tbody>tr[data-pid="+v+"]");
	
	ch.each(function(i,e){
		
		removeChild(e);
		
	});
	
	ch.remove();
} 
 
 
 
 var levelClass=["",""]
 


</script>

<script type="text/javascript">

function onclickNode(id,ck){
	
	var b = ck.checked;
	
	var tr = $("#main_tbody>tr[data-id="+id+"]");
	if(b)printChild(tr);
	else removeChild(tr);
	
	var span = $(ck).prev();
	console.log(span+'-'+$(ck))
	span.removeClass();
	if(b)span.addClass("icon icon-jian");
	else span.addClass("icon icon-add");
}

</script>
<style>
.main_tbody tr td{margin-left: 20px;}

</style>
<script type="text/html" id="tem_tr">
<tr data-id="{{id}}" data-pid="{{parentid}}" >
	<td class="bs-checkbox ">
		<input data-id="{{id}}"  name="btSelectItem" type="checkbox" onchage="">
	</td>
	<td>
		{{id}}
		<!--{{if childs.length>0}}
    		<!--<span class="icon icon-add" onclick="$('#trck-{{id}}').click()"></span>-->
			<!--<input id="trck-{{id}}" data-index="0" style="display:none;"  type="checkbox" onchange="onclickNode('{{id}}',this)">-->
		<!--{{/if}}{{id}}-->
	</td> 
	<td style="text-align: left !important;{{symbolClass}}">
		{{if childs.length>0}}
    		<span class="icon icon-add" onclick="$('#trck-{{id}}').click()"></span> 
			<input id="trck-{{id}}" data-index="0" style="display:none;" type="checkbox" onchange="onclickNode('{{id}}',this)">
		{{/if}}		
<span>{{if symbol}}{{#symbol}}{{/if}}{{name}}</span>
	</td>
	<td style="">{{manNum}}</td>
	<td style="">{{formatState(state)}}</td>
	<td style="">
<div class="btn-group">
		
<shiro:hasPermission name="personnel/organize/dept/update">
	    	
		{{#formatBtn({type:' btn-success',img:'glyphicon-plus'},'添加子部门','toAdd(\''+id+'\')')}}
		{{#formatBtn('edit','编辑','editById(\''+id+'\')')}}
		{{#formatBtn('delete','删除','toRemove(\''+id+'\')')}}

</shiro:hasPermission>
		
</div>
	</td>
</tr>
		


</script>
</html>