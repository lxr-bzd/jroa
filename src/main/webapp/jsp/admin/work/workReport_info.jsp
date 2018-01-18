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


var backurl = "${path}/admin/work/workReport.do";


	$(function() {
		
		
	
	});
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
				if(data.status==0)
					$app.alert('编辑成功',function(){  //关闭事件
						goBackList();
					});
				
				else $app.alert('编辑失败');
				
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
	
</script>
	<script type="text/javascript">
	
	$(function(){
		
		initState();
		
	});
	
	function initState(){
		var val = $("#report_state").attr("data-val");
		if(val==1)$("#report_state").html("未审核");
		else $("#report_state").html("已审核");
		
		
	}
</script>
</head>
<body>
	
		
		<div class="formbody">



   			<form id="submit_form"  method="post" data-action="${path}/admin/work/workReport/examine.do">
   				<input name="reportid" value="${vo.id }" type="hidden"  />
   				<ul class="forminfo">
					<li><label>今日工作：</label><span>${vo.content }</span>
					</li>
					
					<li><label>今日学习：</label><span>${vo.study }</span>
					</li>
					<li><label>状态：</label><span id="report_state" data-val="${vo.report_state }"></span>
					</li>
					
				<c:if test="${vo.report_state==2 }">
				<li><label>审批人：</label><span >${vo.examineName }</span>
				</li>
				<li><label>审批意见：</label><span >${vo.examineInfo }</span>
				</li>
				</c:if>
					
					
	    		</ul>
    		</form>
    		
	    </div>
</body>


</html>
