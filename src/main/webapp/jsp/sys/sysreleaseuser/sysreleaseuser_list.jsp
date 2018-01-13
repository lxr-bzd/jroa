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
		window.location='${path}/sysReleaseUserController/toAdd.do';
	}
	//删除
	function toRemove(){
		var ids=getSelectedRowsIds('SysReleaseUserList');
		if(ids){
			top.showConfirmDiaglog('提示','删除数据不可恢复，确定要删除吗？',function(){  //关闭事件
				refleshData('SysReleaseUserList');
			},function(){  //确认事件
				 $.post('${path}/sysReleaseUserController/deleteById.do?ids='+ids,function(json){
					
				    if(json.success){
				    	$app.alert('删除成功',function(){  //关闭事件
						    refleshData('SysReleaseUserList');
	 					});
					   
				    }else
				    	$app.alert('删除失败');
					 
				    
				 });
			});
		}else{
			$app.alert('请选择一条数据进行操作');
			
		}
	}
	//重置密码
	function toUpdatePWD(){
		var selectRows=getSelectedRows('SysReleaseUserList');
		var selectIds=[];
		var ids=null;
		if(selectRows){
			for(var i=0;i<selectRows.length;i++){
				selectIds.push(selectRows[i].userId);
			}
		}
		if(selectIds.length>0){
			ids=selectIds.join(",");
		}
		if(ids){
			top.showConfirmDiaglog('提示','重置密码将会使密码初始化，确定要重置吗？',function(){  //关闭事件
				refleshData('SysMemberUserList');
			},function(){  //确认事件
				 $.post('${path}/sysReleaseUserController/updatePWD.do?ids='+ids,function(json){
				    if(json.success){
				    	$app.alert('重置成功,新密码：'+data.msg,function(){  //关闭事件
					   		refleshData('SysMemberUserList');
	 					});
					   
				    }else
				    	$app.alert('重置失败');
					   
				    
				 });
			});
		}else{
			$app.alert('请选择一条数据进行操作');
		}
	}
	//编辑
    function toEdit(){
    	var selected=getSelectedRowsArr('SysReleaseUserList');
    	if(selected.length>0&&selected.length<2){
    		window.location='${path}/sysReleaseUserController/editById.do?id='+selected;
    	}else{
    		$app.alert('请选择一条数据进行操作');
    	}
	}
	
    //查看
    function toInfo(){
    	var selected=getSelectedRowsArr('SysReleaseUserList');
    	if(selected.length>0&&selected.length<2){
    		window.location='${path}/sysReleaseUserController/findById.do?id='+selected;
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
	//查询列表
    function queryList(){
    	$('#SysReleaseUserList').bootstrapTable('refresh');
    }
    
    function editById(id){
		window.location='${path}/sysReleaseUserController/editById.do?id='+id;
	}

	//根据id删除
	function deleteById(id){
		top.showConfirmDiaglog('提示','删除数据不可恢复，确定要删除吗？',function(){  //关闭事件
				refleshData('SysReleaseUserList');
			},function(){  //确认事件
				 $.post('${path}/sysReleaseUserController/deleteById.do?ids='+id,function(json){
				   
				   if(json.success){
					   $app.alert('删除成功');
				   }else{
					   $app.alert('删除失败');
					 
				   }
			});
		});
	}

	//根据id查看
	function viewById(id){
			window.location='${path}/sysReleaseUserController/findById.do?id='+id;
	}
	
    //操作工具栏
    function operatorFormatter(value, row, index) {
		var operator="";
	    	<shiro:hasPermission name="SysReleaseUser:edit">
	    		operator+='<button class="btn btn-warning btn-round btn-xs" onclick="editById(\''+row.id+'\');"><i class="glyphicon glyphicon-pencil"></i> 修改</button>&nbsp;&nbsp;';
		    </shiro:hasPermission>
		    <shiro:hasPermission name="SysReleaseUser:info">
    			operator+='<button class="btn btn-success btn-round btn-xs" onclick="viewById(\''+row.id+'\')"><i class="glyphicon glyphicon-list-alt"></i> 详情</button>&nbsp;&nbsp;';
	    	</shiro:hasPermission>
	    	<shiro:hasPermission name="SysReleaseUser:remove">
				operator+='<button class="btn btn-danger btn-round btn-xs" onclick="deleteById(\''+row.id+'\')"><i class="glyphicon glyphicon-trash"></i> 删除</button>';
    		</shiro:hasPermission>
		return operator;
	}
    
    function typeFormatter(value,row,index){
    	if(value==1){
    		return '社会组织'
    	}else if(value==2){
    		return ' 志愿服务组织';
    	}else if(value==3){
    		return '团组织';
    	}else{
    		return '其他'
    	}
    }
    
    function userNameFormatter(value,row,index){
    	if(row&&row.sysUser){
    		return row.sysUser.userName;
    	}
    }
    
    function emailFormatter(value,row,index){
    	if(row&&row.sysUser){
    		return row.sysUser.email;
    	}
    }
    
    
    function accountFormatter(value,row,index){
    	if(row&&row.sysUser){
    		return row.sysUser.account;
    	}
    }
    
    
    function statusFormatter(value,row,index){
    	if(row&&row.sysUser){
    		var val=row.sysUser.status;
    		if(val=='1'){
        		return '<span class="label label-success label-lg">启用</span>';
        	}else if(val=='2'){
        		return '<span class="label label-danger arrowed">锁定</span>';
        	}else{
        		return "";
        	}
    	}
    }
    
</script>
</head>
<body>
	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
  		<li><a href="javascript:" >活动管理</a></li>
    	<li><a href="javascript:">会员管理</a></li>
   		<li><a href="javascript:">发布方列表</a></li>
    </ul>
    </div>
    
    <div class="rightinfo">
		<div class="explain_col">
    		<form id="searchForm" name="searchForm"  method="post">
    			<label>发布方名称：</label><input type="text" name="sysUser.userName" class="txtSearch">&nbsp;
    			<label>登录账号：</label><input type="text" name="sysUser.account" class="txtSearch">&nbsp;
    			<input type="button" class="btn btn-info btn-round" value="查询" onclick="queryList()">&nbsp;&nbsp;
    			<input type="button" class="btn btn-warning btn-round" value="重置" onclick="$('#searchForm')[0].reset();"> 
    		</form>
    	</div>
	    <div id="toolbar" class="btn-group">
			<shiro:hasPermission name="SysReleaseUser:add">
		    	<button class="btn btn-info btn-round" onclick="toAdd();">
					<i class="glyphicon glyphicon-plus"></i> 添加
				</button>
		    </shiro:hasPermission>
	    	<shiro:hasPermission name="SysReleaseUser:edit">
	    		<button class="btn btn-warning btn-round" onclick="toEdit();">
					<i class="glyphicon glyphicon-pencil"></i> 修改
				</button>
	    	</shiro:hasPermission>
			<shiro:hasPermission name="SysReleaseUser:info">
				<button class="btn btn-success btn-round" onclick="toInfo()">
					<i class="glyphicon glyphicon-list-alt"></i> 详情
				</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="SysReleaseUser:remove">
				<button class="btn btn-danger btn-round" onclick="toRemove()">
					<i class="glyphicon glyphicon-trash"></i> 删除
				</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="SysReleaseUser:resetPwd">
				<button class="btn btn-warning btn-round" onclick="toUpdatePWD()">
					<i class="glyphicon glyphicon-pencil"></i> 重置密码
				</button>
			</shiro:hasPermission>
		</div>
    
    	<table id="SysReleaseUserList" data-toggle="table"
			data-url="${path}/sysReleaseUserController/list.do" data-pagination="true"
			data-side-pagination="server" data-cache="false" data-query-params="postQueryParams"
			data-page-list="[15, 30, 50, 100]" data-page-size="15" data-method="post"
			data-show-refresh="true" data-show-toggle="true"
			data-show-columns="true" data-toolbar="#toolbar"
			data-click-to-select="true" data-single-select="false"
			data-striped="true" data-content-type="application/x-www-form-urlencoded">
			<thead>
				<tr>
					<th data-field="" data-checkbox="true"></th>
				    <th data-field="sysUser.userName" data-formatter="userNameFormatter">发布方名称</th>
				    <th data-field="sysUser.account" data-formatter="accountFormatter">登录账号账号</th>
				    <th data-field="sysUser.email" data-formatter="emailFormatter">电子邮件</th>
					<th data-field="orgType" data-formatter="typeFormatter">组织类型</th>
					<th data-field="qq">QQ号码</th>
					<th data-field="contactsUser">联系人</th>
					<th data-field="contactsPhone">联系手机号码</th>
					<th data-field="sysUser.status" data-formatter="statusFormatter" >账户状态</th>
					<th data-field="operator" data-formatter="operatorFormatter">操作</th>
				</tr>
			</thead>
		</table>
    </div>
</body>
</html>