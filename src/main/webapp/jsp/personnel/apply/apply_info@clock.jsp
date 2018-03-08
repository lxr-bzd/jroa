<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑页面</title>
<script type="text/javascript">

var depts = [];


var backurl = "${path}/personnel/apply/apply.do";


	function toSubmit(){
		//表单验证
		
	var result = perSubmit();
		
		if(result){
			$app.alert(result);
		}
		
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
	
	function perSubmit(){
		
			//格式化
		$app.form.preSubmit("#submit_form");
			
		}
	
	
	//返回列表
	function goBackList(){
		try {
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		} catch (e) {
			console.log(e);
			if(isNaN(index))window.location=backurl;
		}

	}
	
	function isedit(){
		return $("#submit_form ").attr("data-isadd")?false:true;
		
	}
	
	$(document).ready(function () {
		/*   var index = parent.layer.getFrameIndex(window.name);
		parent.layer.iframeAuto(index);   */
		
		$app.form.format($('#submit_form'))
		initExa();
		
	});
	
	function initExa(){
		var exas = '${exasJson}';
		if(!exas)return;
		exas = $.parseJSON( exas );
		
		for (var i = 0; i < exas.length; i++) {
			$("#exa_group tbody").append('<tr><td>'+exas[i].exaName+'</td><td>'+$app.tableUi.time(exas[i].exatime)+'</td><td>'+exas[i].info+'</td></tr>')
		}
		
	}
	
</script>
	
</head>
<body>
	<div>
		
		<div class="formbody">

		
   			<form id="submit_form"  method="post" data-action="${path}/personnel/apply/apply/update.do">
   				<input name="id" value="${vo.id }" type="hidden" class="form-control input-primary w260" />
   				<ul class="forminfo">
   				
   			
					
					<li><label>时间：</label><input readonly="readonly" data-lxr="{type:'time',format:'yyyy-MM-dd hh:mm:ss'}"
					 data-format="{type:'time',val:'${vo.starttime }',format:'yyyy-MM-dd hh:mm:ss'}"  placeholder="开始时间" style="display: inline" type="text" class="lxr-format form-control input-primary w260" >
    				<input name="starttime" type="hidden">
    				</li>
    				
    				
					
					
					<li><label>原因：</label><textarea readonly="readonly" class="form-control input-primary w260">${vo.info }</textarea>
					</li>
					
					<li><label>审核状态：</label><input type="text" readonly="readonly"  data-format="{type:'enum',val:'${vo.state }',enum:{'1':'未审核','2':'通过','3':'审核中','4':'未通过'}}" class="lxr-format form-control input-primary w260" >
					</li>
					
	    		</ul>
			 <div class="panel panel-info">
			<div class="panel-heading">
			<h3 class="panel-title">审核记录</h3>
			</div>
			<div class="panel-body">
				<table class="table table-bordered"  id= "exa_group">
					<thead>
						<tr>
							<th>审核人</th>
							<th>审核时间</th>
							<th>审核意见</th>
						</tr>
					</thead>
					<tbody>
						
						
					</tbody>
				</table>
			</div>
			</div>
	    		
    			<div class="btnWrap">
    				<input name="" type="button" class="btn btn-warning" value="返回" onclick="goBackList();"/>
				</div>
    		</form>
	
	    </div>
	</div>
</body>


</html>
