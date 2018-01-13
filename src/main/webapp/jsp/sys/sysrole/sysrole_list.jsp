<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>	
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询列表</title>
<script>
	//添加
	function toAdd(){
		$app.dialog('${path}/sysRoleController/toAdd.do',function(){
    		refMainTable();
		});
	}
	//删除
	function toRemove(){
		var ids=getSelectedRowsIds('SysRoleList');
		if(ids){
			$app.confirm("删除数据不可恢复，确定要删除吗？",function(){
				 $.post('${path}/sysRoleController/deleteById.do?ids='+ids,function(data){
						var json=data;
					    if(json.success){
					    	 $app.alert("删除成功，角色被用户绑定的，将不删除",function(){  //关闭事件
								   refleshData('SysRoleList');
			 					});
					    }else
					    	 $app.alert("删除失败");
					    	
					   
					 },"json");
				
			});
			
			
		}else{
			//提示信息
 		   $app.alert("请选择一条数据进行操作");
		}
	}
	
	//编辑
    function toEdit(){
    	var selected=getSelectedRowsArr('SysRoleList');
    	if(selected.length>0&&selected.length<2){

        	$app.dialog('${path}/sysRoleController/editById.do?id='+selected,function(){
        		refMainTable();
    		});
    	}else
    		//提示信息
    		   $app.alert("请选择一条数据进行操作");
    		
	}
	
    //查看
    function toInfo(){
    	var selected=getSelectedRowsArr('SysRoleList');
    	if(selected.length>0&&selected.length<2){
    		
    		$app.dialog('${path}/sysRoleController/findById.do?id='+selected,function(){
        		refMainTable();
    		});
    	}else{
    		$app.alert('请选择一条数据进行操作');
    	}
	}
	
	//设置查询参数
	function postQueryParams(params) {
		var queryParams = $("#searchForm").serializeObject();
		queryParams.limit=params.limit;
		queryParams.offset=params.offset;
		return queryParams;
	}
	
    
    function editById(id){
    	
    	$app.dialog('${path}/sysRoleController/editById.do?id='+id,function(){
    		refMainTable();
		});
	}

	//根据id删除
	function deleteById(id){
		$app.confirm("删除数据不可恢复，确定要删除吗？",function(){
			 $.post('${path}/sysRoleController/deleteById.do?ids='+id,function(data){
				   var json = data;
				   if(json.success){
					   
					   $app.alert("删除成功，角色被用户绑定的，将不删除",function(){  //关闭事件
						   refleshData('SysRoleList');
	 					});
					 
				   }else{
					   $app.alert("删除失败");
					   
				   }
			},"json");
			
		});
		
		
	}

	//根据id查看
	function viewById(id){
		$app.dialog('${path}/sysRoleController/findById.do?id='+id,function(){
    		refMainTable();
		});
	}
	
    //操作工具栏
    function operatorFormatter(value, row, index) {
    	var operator="";
    <shiro:hasPermission name="SysRole:auth">
    	operator+='<button class="btn btn-info btn-round btn-xs" onclick="toAuth(\''+row.id+'\');"><i class="glyphicon glyphicon-pencil"></i> 授权</button>&nbsp;&nbsp;';
    	
	</shiro:hasPermission>
    	
	    	<shiro:hasPermission name="SysRole:edit">
	    		operator+='<button class="btn btn-warning btn-round btn-xs" onclick="editById(\''+row.id+'\');"><i class="glyphicon glyphicon-pencil"></i> 修改</button>&nbsp;&nbsp;';
		    </shiro:hasPermission>
		    <shiro:hasPermission name="SysRole:info">
    			operator+='<button class="btn btn-success btn-round btn-xs" onclick="viewById(\''+row.id+'\')"><i class="glyphicon glyphicon-list-alt"></i> 详情</button>&nbsp;&nbsp;';
	    	</shiro:hasPermission>
	    	<shiro:hasPermission name="SysRole:remove">
				operator+='<button class="btn btn-danger btn-round btn-xs" onclick="deleteById(\''+row.id+'\')"><i class="glyphicon glyphicon-trash"></i> 删除</button>';
    		</shiro:hasPermission>
		return operator;
	}
     
    //角色状态格式化
    function statusFormatter(value,row,index){
    	if(value=='1'){
    		return '<span class="label label-success label-lg">启用</span>'
    	}else if(value=='2'){
    		return '<span class="label label-danger arrowed">禁用</span>';
    	}else{
    		return "";
    	}
    }
    
    //角色类型格式化
    function roleTypeFormatter(value ,row,index){
    	if(value=='1'){
    		return '超级管理员';
    	}else if(value=='2'){
    		return '管理员';
    	}else if(value=='3'){
    		return '发布方';
    	}else if(value=='4'){
    		return '普通会员';
    	}
    }

    //授权
    function toAuth(id){
    	
    	var selected=[id];
    	
    	if(selected.length>0&&selected.length<2){
    	/* 	var dialog = art.dialog.open("${path}/sysResourceController/toSelectTree.do?roleId="+selected,{
    	  		  id:"selectResourceDialog",
    	  		  title:"选择资源",
    	  		  width :'360px',
    	  		  height:'400px',
    	  		  lock:true,
    	  		  init: function (){
    		  		$(this.iframe).attr("scrolling","no");//去掉滚动条
    		  	  },
    	  		  close:function(){
    	  		  }
    	  	});
    		 */
    		$app.dialog("${path}/sysResourceController/toSelectTree.do?roleId="+selected,function(){
        		
    		});
    	}else{
    		//提示信息
    		 $app.alert("请选择一条数据进行操作");
    	
    	}
    } 
    
    
    function refMainTable(){
    	
    	$('#SysRoleList').bootstrapTable('refresh');
    }
    

</script>
</head>
<body>
	
    
    <div class="rightinfo">
		<div class="explain_col">
    		<form id="searchForm" name="searchForm"  method="post">
    			<span>角色名称：</span><input type="text" name="roleName" class="form-control input-sm" style="width: 220px;display: inline;">&nbsp;
<!--     			<label>角色类型：</label> -->
<!-- 						<select name="roleType" id="roleType" class="form-control input-primary" style="width:150px"> -->
<!-- 							<option value="1">超级管理员</option> -->
<!-- 							<option value="2">管理员</option> -->
<!-- 							<option value="3" selected="selected">发布方</option> -->
<!-- 							<option value="4">普通会员</option> -->
<!-- 						</select> -->
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="refMainTable()">&nbsp;&nbsp;
    	<!-- 		<input type="button" class="btn btn-warning btn-round" value="重置" onclick="$('#searchForm')[0].reset();"> 
    	 -->	</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	    	<shiro:hasPermission name="SysRole:add">
		    	<button class="btn btn-info btn-round btn-sm" onclick="toAdd();">
					<i class="glyphicon glyphicon-plus"></i> 添加角色
				</button>
		    </shiro:hasPermission>
			<shiro:hasPermission name="SysUser:remove">
				<button class="btn btn-warning btn-round btn-sm" onclick="toRemove()">
					<i class="glyphicon glyphicon-trash"></i> 批量删除
				</button>
			</shiro:hasPermission>
	   
		</div>
    	<table id="SysRoleList"  class="table_list" data-toggle="table"
			data-url="${path}/sysRoleController/list.do" data-pagination="true"
			data-side-pagination="server" data-cache="false" data-query-params="postQueryParams"
			data-page-list="[10, 15, 20, 30, 50,100]" data-method="post"
			data-show-refresh="false" data-show-toggle="false"
			data-show-columns="false" data-toolbar="#toolbar"
			data-click-to-select="false" data-single-select="false"
			data-striped="false" data-content-type="application/x-www-form-urlencoded"
			>
			<thead>
				<tr>
					<th data-field="" data-checkbox="true"></th>
					<th data-field="id">ID</th>
					<th data-field="roleName">角色名称</th>
					<th data-field="roleType" data-formatter="roleTypeFormatter">角色类型</th>
					<th data-field="roleStatus" data-formatter="statusFormatter" >状态</th>
					<th data-field="createTime" data-formatter="dateFormatter" >创建时间</th>
					<th data-field="modifyTime" data-formatter="dateFormatter" >修改时间</th>
					<th data-field="roleDesc">角色描述</th>
					<th data-field="operator" data-formatter="operatorFormatter">操作</th>
				</tr>
			</thead>
		</table>
			<!--<label class="select_all"><input type="checkbox" name="checkall" onclick=" var sl =$('#SysRoleList thead input[name=btSelectAll]');  if(sl.prop('checked')!=this.checked)sl.click();" class="J_checkall">全选/取消</label>-->

    </div>
</body>
</html>