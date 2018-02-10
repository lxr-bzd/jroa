<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>	
<head>
<meta http-equiv="Content-Type" content="text/html;  ">
<script type="text/javascript" src="${path}/js/tableExport.min.js"></script>
<script type="text/javascript" src="${path}/js/jquery.base64.js"></script>

<title>查询列表</title>
<script>
	//添加
	function toAdd(){
		$app.dialog('${path}/sysUserController/toAdd.do',function(){
    		queryList();
		});
	}
	//删除
	function toRemove(ids){
		
		if(typeof(ids)=="undefined")
		ids=getSelectedRowsIds('SysUserList');
		
		if(ids){
			
			$app.confirm("删除数据不可恢复，确定要删除吗？",function(){
				 $.post('${path}/sysUserController/deleteById.do?ids='+ids,function(data){
					   var json = data;
					   if(json.success){
						  
						   $app.alert("删除成功",function(){  //关闭事件
							   queryList();
		 					});
						 
					   }else
						   $app.alert(json.msg);
						   
					   
				},"json");
				
			});
			
			
			
		}else
			$app.alert("请选择一条数据进行操作");
			
	}
	
	//编辑
    function toEdit(){
    	var selected=getSelectedRowsArr('SysUserList');
    	if(selected.length>0&&selected.length<2){
    		$app.dialog('${path}/sysUserController/editById.do?id='+selected,function(){
        		queryList();
    		});
    	}else{
    		//提示信息
    		$app.alert("请选择一条数据进行操作");
    	}
	}
	
    //查看
    function toInfo(id){
    	
    	$app.request("${path}/sys/dev/res/info.do?id="+id
    			,function(data){
    		console.log(data);
    		
    				$lxr.infoModal({title:"",items:[
    		    		{name:"姓名",val:data.userName}
    		    		,{name:"账号",val:data.account}
    		    		,{name:"电子邮箱",val:data.email}
    		    		,{name:"手机号码",val:data.mobilePhone}
    		    		,{name:"添加时间",val:data.regTime}
    		    		,{name:"添加ip",val:data.regIp}
    		    		,{name:"最后登录时间",val:data.lastLoginTime}
    		    		,{name:"最后错误登录时间",val:data.lastLoginErrTime}
    		    		
    		    		,{name:"最后登录ip",val:data.lastLoginIp}
    		    		,{name:"身份证号",val:data.idNumber}
    		    		,{name:"登录累计错误次数",val:data.loginErrTimes}
    		    		,{name:"状态",val:data.status,type:"enum",enums:{"1":"启用","2":"锁定"} }
    		    		
    		    		]
    		    	}
    		    		);
    		
    		
    	});
    	
    	
    	
    	
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
    	$('#SysUserList').bootstrapTable('refresh');
    }
    
    function editById(id){
    	$app.dialog('${path}/sysUserController/editById.do?id='+id,function(){
    		queryList();
		});
	}


	
    //操作工具栏
    function operatorFormatter(value, row, index) {
    	var operator="";
    	<shiro:hasPermission name="SysUser:setRole">
		operator+='<button class="btn btn-info btn-round btn-xs" onclick="setUser(\''+row.id+'\');"><i class="glyphicon glyphicon-user"></i> 分配角色</button>&nbsp;&nbsp;';
    </shiro:hasPermission>
	    	<shiro:hasPermission name="SysUser:edit">
	    		operator+='<button class="btn btn-warning btn-round btn-xs" onclick="editById(\''+row.id+'\');"><i class="glyphicon glyphicon-pencil"></i> 修改</button>&nbsp;&nbsp;';
		    </shiro:hasPermission>
		    <shiro:hasPermission name="SysUser:info">
				operator+='<button class="btn btn-success btn-round btn-xs" onclick="toInfo(\''+row.id+'\')"><i class="glyphicon glyphicon-list-alt"></i> 详情</button>&nbsp;&nbsp;';
	    	</shiro:hasPermission>
	    	<shiro:hasPermission name="SysUser:remove">
				operator+='<button class="btn btn-danger btn-round btn-xs" onclick="toRemove(\''+row.id+'\')"><i class="glyphicon glyphicon-trash"></i> 删除</button>';
			</shiro:hasPermission>
		return operator;
	}
    
    //格式化状态
    function statusFormatter(value,row,index){
    	if(value=='1'){
    		return '<span class="label label-success label-lg">启用</span>';
    	}else if(value=='2'){
    		return '<span class="label label-danger arrowed">锁定</span>';
    	}else{
    		return "";
    	}
    }
    
    //格式化用户类型
    function userTypeFormatter(value,row,index){
    	if(value=='1'){
    		return '超级管理员';
    	}else if(value=='2'){
    		return '管理员';
    	}else if(value=='3'){
    		return '发布方';
    	}else if(value=='4'){
    		return '普通会员';
    	}else{
    		return '';
    	}
    }
    
    function setUser(id){
    	var selected=[id];
    	if(selected.length>0&&selected.length<2){
    		var dialog = art.dialog.open("${path}/sysRoleController/toUserRoleTree.do?userId="+selected,{
    	  		  id:"selectResourceDialog",
    	  		  title:"选择人员",
    	  		  width :'300px',
    	  		  height:'380px',
    	  		  lock:true,
    	  		  init: function (){
    		  		$(this.iframe).attr("scrolling","no");//去掉滚动条
    		  	  },
    	  		  close:function(){
    	  			  
    	  		  }
    	  	});
    	}else{
    		//提示信息
    		$app.alert('请选择一条数据进行操作');
    		
    	}
    }
    
    function closeDialog(){
    	art.dialog.list["selectResourceDialog"].close();
    }
    
    
    function onExcell(){
    	$('#SysUserList').tableExport({type:'excel',ignoreColumn: [0,9]
    		, separator:';', escape:'false'
    	,fileName: '账号表-'+new Date().format("yyyy-MM-dd")});
    	
    }
    
</script>
</head>
<body>

    
    <div class="rightinfo">
		<div class="explain_col">
    		<form id="searchForm" name="searchForm"  method="post">
    			<label>用户名：</label><input type="text" name="userName" class="form-control input-sm w260" style="display: inline;">&nbsp;
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="queryList()">&nbsp;&nbsp;
    		</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	    <button class="btn btn-success btn-round btn-sm" onclick="onExcell()">
						<i class="glyphicon glyphicon-folder-open"></i>  &nbsp;导出excell
				</button>
	    	<shiro:hasPermission name="SysUser:add">
		    	<button class="btn btn-info btn-round btn-sm" onclick="toAdd();">
					<i class="glyphicon glyphicon-plus"></i> 添加账号
				</button>
		    </shiro:hasPermission>
			<shiro:hasPermission name="SysUser:remove">
				<button class="btn  btn-warning btn-round btn-sm " onclick="toRemove()">
					<i class="glyphicon glyphicon-trash"></i> 批量删除
				</button>
			</shiro:hasPermission>
	    	<%-- <shiro:hasPermission name="SysUser:edit">
	    		<button class="btn btn-warning btn-round" onclick="toEdit();">
					<i class="glyphicon glyphicon-pencil"></i> 修改
				</button>
	    	</shiro:hasPermission>
			<shiro:hasPermission name="SysUser:info">
				<button class="btn btn-success btn-round" onclick="toInfo()">
					<i class="glyphicon glyphicon-list-alt"></i>详情
				</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="SysUser:remove">
				<button class="btn btn-danger btn-round" onclick="toRemove()">
					<i class="glyphicon glyphicon-trash"></i>删除
				</button>
			</shiro:hasPermission> 
			<shiro:hasPermission name="SysUser:setRole">
				<button class="btn btn-info btn-round" onclick="setUser();">
					<i class="fa fa-users"></i> 分配角色
				</button>
			</shiro:hasPermission>
			--%>
		</div>
    
    	<table id="SysUserList" class="table_list" data-toggle="table"
			data-url="${path}/sysUserController/list.do" data-pagination="true"
			data-side-pagination="server" data-cache="false" data-query-params="postQueryParams"
			data-page-list="[15, 30, 50, 100]" data-page-size="15" data-method="post"
			data-show-refresh="false" data-show-toggle="false"
			data-show-columns="false" data-toolbar="#toolbar"
			data-click-to-select="false" data-single-select="false"
			data-striped="false" data-content-type="application/x-www-form-urlencoded"
			>
			<thead>
				<tr>
					<th data-field="" data-checkbox="true"></th>
					<th data-field="userName">用户名</th>
					<th data-field="account">账号</th>
					<th data-field="email">电子邮箱</th>
					<th data-field="mobilePhone">手机号码</th>
					<th data-field="regTime" data-formatter="dateFormatter" >添加时间</th>
					<th data-field="idNumber">身份证号</th>
				<!-- 	<th data-field="userType" data-formatter="userTypeFormatter">用户类型</th> -->
					<th data-field="lastLoginTime" data-formatter="dateFormatter" >上次登录时间</th>
					<th data-field="status" data-formatter="statusFormatter">状态</th>
					<th data-field="operator" data-formatter="operatorFormatter">操作</th>
				</tr>
			</thead>
		</table>
			<!--<label class="select_all"><input type="checkbox" name="checkall" onclick=" var sl =$('#SysUserList thead input[name=btSelectAll]');  if(sl.prop('checked')!=this.checked)sl.click();" class="J_checkall">全选/取消</label>-->

    </div>
</body>
</html>