<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/global.jsp"%>
<title>编辑页面</title>
<script type="text/javascript">

var depts = [];


var backurl = "${path}/customer/customer/visit.do";


	function toSubmit(){
		
		$app.form.preSubmit("#submit_form");
		
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
				if(data.status==0)
					$app.alert('编辑成功',function(){  //关闭事件
						goBackList();
					});
				
				else $app.alert(data.msg?data.msg:'编辑失败');
				
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
		if(isedit())
			$app.form.format($('#submit_form'));
		
		
		 var validateOpts = {
		  rules: {
			  info: {required: true}
		
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
</script>
</head>
<body>
	<div>
		
		<div class="formbody">

<c:if test="${empty param.sysAction}">
		
   			
   			<form id="submit_form" data-isadd="true" method="post" data-action="${path}/customer/customer/visit/save.do">
   				<input name="cusid" type="hidden" value="${param.cusid }">
   				<ul class="forminfo">
					
					
					<li><label>回访时间：</label><input data-lxr="{type:'time',format:'yyyy-MM-dd hh:mm:ss'}" value="" placeholder="回访时间" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary w300" onfocus="WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd HH:mm:ss'})" >
    				<input name="time" type="hidden">
    				</li>
    				<li><label>回访内容：</label><textarea name="info"  rows="" cols=""  class="form-control input-primary w300 txt100" style="width:400px;"></textarea>
    				
					</li>
	    		</ul>
	    		<div class="btnWrap">
					<input name="" type="button" class="btn btn-primary" value="确认保存" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/>
	    		</div>
    		</form>
    		
</c:if>

<c:if test="${param.sysAction=='edit'}">


   			<form id="submit_form"  method="post" data-action="${path}/customer/customer/visit/update.do">
   				<input name="id" value="${vo.id }" type="hidden"  />
   				<ul class="forminfo">
					<li><label>回访时间：</label><input data-lxr="{type:'time',format:'yyyy-MM-dd hh:mm:ss'}"  data-format="{type:'time',val:'${vo.time }',format:'yyyy-MM-dd hh:mm:ss'}" value="" placeholder="回访时间" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary w300" onfocus="WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd HH:mm:ss'})" >
    				<input name="time" type="hidden" >
    				</li>
    				<li><label>回访内容：</label><textarea name="info"  rows="" cols=""  class="form-control input-primary w300 txt100" style="width:400px;">${vo.info}</textarea>
    				
					</li>
	    		</ul>
	    		<div class="btnWrap">
					<input name="" type="button" class="btn btn-primary" value="确认保存" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();"/>
	    		</div>
    		</form>
		
    		
</c:if>
	    </div>
	</div>
</body>


</html>
