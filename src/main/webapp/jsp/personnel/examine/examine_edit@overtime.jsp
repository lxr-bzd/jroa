<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑页面</title>
<script type="text/javascript">

var depts = [];


var backurl = "${path}/personnel/examine/examine.do";


	
	function toSubmit(){
		//表单验证
		
		if(!$("#submit_form").valid())
				return;
		
		
		$app.loading(function(onfinsh){
		//表单提交
		$("#submit_form").ajaxSubmit({
			url:$("#submit_form").attr("data-action"),
			data : $("#submit_form").serialize(),
			cache : false,
			dataType : 'JSON',
			type:'post',
			success:function(data){
				if(data.status==0){
					$app.alert('编辑成功',function(){  //关闭事件
						goBackList();
					});
				
				}else
					$app.alert(data.msg?data.msg:'编辑失败');
				
			}
		});
		
		});
	}
	
	//返回列表
	function goBackList(){
		try {
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		} catch (e) {
			if(isNaN(index))window.location=backurl;
		}
		
	}
	
	function isedit(){
		return $("#submit_form ").attr("data-isadd")?false:true;
	}
	
	
</script>
	<script type="text/javascript">
	$(document).ready(function () {
		initExa();
		
		if(isedit())$app.form.format($('#submit_form'));
		
		 var validateOpts = {
		  rules: {
		name: {required: true}
		
		 
		 
		  }
		/*   ,
		  messages: {
		   name: {
		    required: "hiik"
		   },
		   sort: {
		    required: "请输入密码" 
		   }
		  } */
		 };
		 
		 $("#submit_form").validate(validateOpts);
		});
	
	
	function goExamine(t){
		if(t)$("#submit_form input[name=result]").val(1);
		else $("#submit_form input[name=result]").val(2);
		
		
		toSubmit();
		
		
		
		
	}
	
	function isend(){
		if("1"!=$("#exa_group").attr("data-state"))
			return true;
		
		
		var stime = new Number(eval("(" + $("#submit_form .starttime").attr("data-format") + ")").val);
		var etime = new Number(eval("(" + $("#submit_form .endtime").attr("data-format") + ")").val);
		
		if(getTime2Time(etime,stime)>=2)
			return false;
		return true;
		
	}
	
	function getTime2Time($time1, $time2)
	{
	    var time1 , time2;
	    time1 = $time1/1000;
	    time2 = $time2/1000;
	    var time_ = time1 - time2;
	    return (time_/(3600*24));
	}
	
	
	function initExa(){
		var exas = ${exaJson};
		
		for (var i = 0; i < exas.length; i++) {
			$("#exa_group tbody").append('<tr><td>'+exas[i].exaName+'</td><td>'+$app.tableUi.time(exas[i].exatime)+'</td><td>'+exas[i].info+'</td></tr>')
		}
		
	}
	
	
	
	
	
</script>
</head>
<body>
	<div>
		
		<div class="formbody">

<c:if test="${param.sysAction=='edit'}">

   			<form id="submit_form"  method="post" data-action="${path}/personnel/examine/examine/save.do">
   				<input name="applyid" value="${vo.id }" type="hidden" class="form-control input-primary w260" />
   				<input name="result" value="1" type="hidden"  />
   				<input name="isend" value="true" type="hidden"  />
   				<ul class="forminfo">
					<li><label>姓名：</label><input readonly="readonly" value="${vo.uname }" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>部门：</label><input readonly="readonly" value="${vo.deptName }" type="text" class="form-control input-primary w260" />
					</li>
					<li><label>职位：</label><input readonly="readonly" value="${vo.placeName }" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>开始时间：</label><input  readonly="readonly" data-lxr="{type:'time',format:'yyyy-MM-dd'}" data-format="{type:'time',val:'${vo.starttime }',format:'yyyy-MM-dd'}" value="" placeholder="时间" style="display: inline" type="text" class="starttime lxr-format form-control input-primary  w260" >
					</li>
					<li><label>结束时间：</label><input  readonly="readonly" data-lxr="{type:'time',format:'yyyy-MM-dd'}" data-format="{type:'time',val:'${vo.endtime }',format:'yyyy-MM-dd'}" value="" placeholder="时间" style="display: inline" type="text" class="endtime lxr-format form-control input-primary  w260"  >
					</li>
					
					
					<li><label>加班原由：</label>
					<textarea readonly="readonly" class="form-control input-primary w260" >${vo.info }</textarea>
					</li>
					
					<li><label>审批意见：</label>
					<textarea name='info' class="form-control input-primary w260" ></textarea>
					</li>
				
	    		</ul>
	    		
	    <div class="panel panel-info">
			<div class="panel-heading">
			<h3 class="panel-title">审核记录</h3>
			</div>
			<div class="panel-body">
				<table class="table table-bordered" id= "exa_group" data-state="${vo.state }">
					<thead>
						<tr>
							<th>审核人</th>
							<th>审核时间</th>
							<th>审核意见</th>
						</tr>
					</thead>
					<tbody>
						<!-- <tr>
							<td>Tanmay</td>
							<td>Bangalore</td>
							<td>560001</td>
						</tr> -->
						
					</tbody>
				</table>
			</div>
			</div>
	    		
	    		
	    		
	    		<div class="btnWrap">
    				<input name="" type="button" class="btn btn btn-success" value="同意" onclick="goExamine(true)"/>&nbsp;&nbsp;&nbsp;&nbsp;
    				<input name="" type="button" class="btn btn-warning" value="不同意" onclick="goExamine(false);"/>
    				<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/>
	    		</div>
    		</form>
		
    		
</c:if>
	    </div>
	</div>
</body>


</html>
