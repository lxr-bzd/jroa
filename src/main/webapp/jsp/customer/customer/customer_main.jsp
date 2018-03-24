<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>	
<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${path}/js/tableExport.min.js"></script>
<script type="text/javascript" src="${path}/js/jquery.base64.js"></script>
<script src="https://cdn.bootcss.com/xlsx/0.12.2/xlsx.full.min.js"></script>
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
		},{width:"700px",height:"700px"});
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
		},{width:"700px",height:"700px"});
	}

	

	//根据id查看
	function viewById(id){
		$lxr.modal({url:toInfoUrl+'?id='+id+"&type=info"});
	}
	
    //操作工具栏
    function operatorFormatter(value, row, index) {
    	var operator='<div class="btn-group">';
		    
    	operator+=$app.btn('auth','回访','tovisit(\''+row.id+'\',\''+row.name+'\')');
	    	
	    	operator+= $app.btn('edit','编辑','editById(\''+row.id+'\')');
		  
		   
		    operator+= $app.btn('delete','删除','toRemove(\''+row.id+'\')');
	    	
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
<script type="text/javascript">

function onExcell(){
	 if($("#mainTable").bootstrapTable('getSelections').length<1){
		 $app.alert("请选中要导出的数据");
		 return;
	 }
		
	
var unselect = getUnSelectRows();
	$('#mainTable').tableExport({type:'excel',ignoreColumn: [0,1,10],ignoreRow:unselect
		, separator:';', escape:'false'
			,bootstrap: true
	,fileName: '通讯录表格-'+new Date().format("yyyy-MM-dd")});
	
}

function getUnSelectRows(){
	var tb= $("#mainTable");
	var conunt = tb.bootstrapTable('getOptions').totalRows;
	var rowSelected = tb.bootstrapTable('getSelections');
	var all = tb.bootstrapTable('getData');
	var ret = [];
	for (var i = 0; i < all.length; i++) {
		
		var selected = false;
		
		for (var j = 0; j < rowSelected.length; j++) 
			if(all[i].id==rowSelected[j].id){
				selected=true;
				break;
			}
		
		
		if(!selected)ret.push(i+1);
		
	}
	
	return ret;
	
}




</script>

  <script type="text/javascript">
  
  function inExcell(input){
	 parseXlsx(input,function(sheet){
		 
		 var row = 0;
		 for (var i = 0; i < 200; i++) {
			 var v = sheet["A"+(i+2)];
			 if(typeof(v)   !=   "object"){
				 row = i;
				 break;
			 }
				 
		}
		 var cuss = sheet2Cus(sheet,row);
		 
		 var content = template("cusTmp",{data:cuss});
		 $lxr.dialog(function(body){
			
		},function(body){
			
			 xlsSubmit(cuss);
			},{content:content,title:"确认导入"});
		 
		 
	 });
		
  }
  
  
  
  function xlsSubmit(cuss){
	  
	  $app.loading(function(onfinsh){
			$app.request("${path}/customer/customer/customer/save.do",function(data){
				onfinsh();
				if(data.status==0)
					$app.alert('导入成功',function(){  //关闭事件
						refTable();
					});
				
				else $app.alert(data.msg?data.msg:'导入失败');
			},{param:{customersJson:JSON.stringify(cuss)}});
		
			});
	  
	  
  }
  
  
  
  function sheet2Cus(sheet,row){
	  if(row<1)return [];
	  var cuss = [];
	  for (var i = 2; i < row+2; i++) {
		var cus = {};
			cus.name = sheet["A"+i].v;
			cus.typeid = 1;//sheet["B"+i].v;
			cus.contacts = sheet["C"+i]?sheet["C"+i].v:"";
			cus.phone = sheet["D"+i]?sheet["D"+i].v:"";
			cus.follow = 1;//sheet["E"+i];
			cus.source = sheet["F"+i]?sheet["F"+i].v:"";
			cus.industry = sheet["G"+i]?sheet["G"+i].v:"";
			cus.scale = sheet["H"+i]?sheet["H"+i].v:"";
			cus.addr = sheet["I"+i]?sheet["I"+i].v:"";
			cus.state = 0;
			cuss.push(cus);
	}
	  
	  return cuss;
	  
	  
  }
  
  
  
            /*
            FileReader共有4种读取方法：
            1.readAsArrayBuffer(file)：将文件读取为ArrayBuffer。
            2.readAsBinaryString(file)：将文件读取为二进制字符串
            3.readAsDataURL(file)：将文件读取为Data URL
            4.readAsText(file, [encoding])：将文件读取为文本，encoding缺省值为'UTF-8'
                         */
            function parseXlsx(obj,call) {//导入
            	
            	var wb;//读取完成的数据
            	var rABS = false; //是否将文件读取为二进制字符串
            	
            	var ret;
            	
                if(!obj.files) {
                    return;
                }
                var f = obj.files[0];
                var reader = new FileReader();
                reader.onload = function(e) {
                    var data = e.target.result;
                    if(rABS) {
                        wb = XLSX.read(btoa(fixdata(data)), {//手动转化
                            type: 'base64'
                        });
                    } else {
                        wb = XLSX.read(data, {
                            type: 'binary'
                        });
                    }
                    //wb.SheetNames[0]是获取Sheets中第一个Sheet的名字
                    //wb.Sheets[Sheet名]获取第一个Sheet的数据
                    if(call)
                    	var d = wb.SheetNames[0];
                    call(wb.Sheets[wb.SheetNames[0]] );
                };
                if(rABS) {
                    reader.readAsArrayBuffer(f);
                } else {
                    reader.readAsBinaryString(f);
                }
                
                
            }

            function fixdata(data) { //文件流转BinaryString
                var o = "",
                    l = 0,
                    w = 10240;
                for(; l < data.byteLength / w; ++l) o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w, l * w + w)));
                o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w)));
                return o;
            }
        </script>
 
</head>
<body class="mlr15">

    
    <div class="rightinfo explain_col" >
		<div>
    		<form id="searchForm"  method="post">
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
		<button class="btn btn-success btn-round btn-sm" onclick="onExcell()">
						<i class="glyphicon glyphicon-folder-open"></i> 导出
		</button>
		
		<button class="btn btn-success btn-round btn-sm" onclick="$('#inexcell').click();">
						<i class="glyphicon glyphicon-folder-open"></i>  导入
		</button>
		<input type="file" style="display: none;" id="inexcell" onchange="inExcell(this)" />
		<button class="btn btn-success btn-round btn-sm" onclick=" ">
				<a href="${path }/file/template.xls" download="客户模板导入模板.xls">下载导入模板</a>
		</button>
		</div>
		
    </div>
    	<table class="table_list" id="mainTable" data-toggle="table"
			data-url="${path}/customer/customer/customer/view.do?state=0&ismy=true" data-pagination="ture" 
			data-side-pagination="server" data-cache="false" data-query-params="postQueryParams"
			data-page-list="[10, 20, 35, 50]" data-page-size= "10" data-method="post"
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
<script type="text/html" id="cusTmp">
<table class="table table-bordered">
	<thead>
		<tr>
			<th>名称</th>
			<th>客户类型</th>
			<th>联系人</th>

			<th>联系电话</th>
			<th>跟进状态</th>
			<th>客户来源</th>

			<th>所属行业</th>
			<th>人员规模</th>
			<th>地址</th>
		</tr>
	</thead>
	<tbody>

  {{each data as val i}}
		<tr>
			<td>{{val.name}}</td>
			<td>{{val.typeid}}</td>
			<td>{{val.contacts}}</td>
			<td>{{val.phone}}</td>
			<td>{{val.follow}}</td>
			<td>{{val.source}}</td>
			<td>{{val.industry}}</td>
			<td>{{val.scale}}</td>
			<td>{{val.addr}}</td>
		</tr>
 {{/each}}
		
	</tbody>
</table>

</script>
</html>
