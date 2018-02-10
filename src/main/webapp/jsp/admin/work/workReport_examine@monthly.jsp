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
				
				else $app.alert(data.msg?data.msg:'编辑失败')
				
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
	$(document).ready(function () {
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
</script>
</head>
<body>
	
		
		<div class="formbody">



   			<form id="submit_form"  method="post" data-action="${path}/admin/work/workReport/examine.do">
   				<input name="reportid" value="${vo.id }" type="hidden"  />
   				<ul class="forminfo">
				
   				<li>
   				<table  class="table table-bordered">
					   				<tr>
					   				<td colspan="4">本月工作目标</td>
					   				<td><input name="" type="button" class="btn btn-primary" value="新增" onclick="addItem()"/></td>
					   				</tr>
					   				<tr>
						   				<td>优先顺序</td>
						   				<td>目标</td>
						   				<td>完成期限</td>
						   				<td>是否完成</td>
						   				<td>操作</td>
					   				</tr>
					   				<tbody  id="item_group">
					   				
					   	<c:forEach var="item" items="${vo.details}" varStatus="i">
					   				<tr>
									<td>${item.sort }<input name="details[${i.index }].sort" type="hidden" value="${item.sort }" /></td>
					   				<td><input name="details[${i.index }].content" value="${item.content }" type="text" class="form-control input-primary" /></td>
					   				<td><input name="details[${i.index }].finishdate" value="${item.finishdate }" type="text" class="form-control input-primary" /></td>
					   				<td><input <c:if test="${item.isfinish==2}">checked="checked"</c:if>
					   				 onclick="if(this.checked)$(this).next().val('2'); else $(this).next().val('1');" type="checkbox" class="" />
					   				<input name="details[${i.index }].isfinish" type="hidden" value="${item.isfinish}" />
					   				</td>
					   				<td><a onclick="$(this).parent().parent().remove()">删除</a></td>
					   				</tr>
						</c:forEach>
						</tbody>
   				</table>
   				</li>
	<li>
	<table  class="table table-bordered">
   				<tr>
   				<td colspan="2">月总结</td>
   				</tr>
   				<tr>
	   				<td>未完成目标的原因和障碍</td>
	   				<td><input name="uncomplete" value="${vo.uncomplete}" type="text" class="form-control input-primary" /></td>
   				
   				</tr>
   				<tr>
	   				<td>克服障碍的对策和方法</td>
	   				<td><input name="answer" value="${vo.answer}" type="text" class="form-control input-primary" /></td>
   				
   				</tr>
   				<tr>
	   				<td>本周创新与收获</td>
	   				<td><input name="study" value="${vo.study}" type="text" class="form-control input-primary" /></td>
   				
   				</tr>
   				
   	</table>
			</li>		
					
				<li><label>审批意见：</label>
					<textarea name="content" rows="" cols="" class="form-control input-primary" style="display:inline-block;width:800px;"></textarea>
					</li>
					
					
				</ul>
	    		<div class="btnWrap">
					<input name="" type="button" class="btn btn-primary" value="确认" onclick="toSubmit()">&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="" type="button" class="btn btn-warning" value="取消" onclick="goBackList();">
	    		</div>
    		</form>
    		
	    </div>
</body>


</html>
