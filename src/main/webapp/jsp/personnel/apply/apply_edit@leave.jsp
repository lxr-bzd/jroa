<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <%@ include file="/common/global.jsp" %>
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
    if(typeof(data)=="string")
    data = $.parseJSON(data.replace(/<.*?>/ig,""));
    if(data.status==0){
    $app.alert('编辑成功',function(){ //关闭事件
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

    if(isNaN(index))window.location=backurl;
    }

    }

    function isedit(){
    return $("#submit_form ").attr("data-isadd")?false:true;

    }

    </script>
    <script type="text/javascript">
    $(document).ready(function () {


    $("#submit_form").validate({
    rules: {
    name: {required: true}
    ,starttime:{required: true}
    ,endtime:{required: true}
    ,duration:{number:true}
    }
    /* ,
    messages: {
    name: {
    required: "hiik"
    },
    sort: {
    required: "请输入密码"
    }
    } */
    });
    });


    $(function(){
    if(isedit())$app.form.format($('#submit_form'));

    });


    </script>
    </head>
    <body>
    <div>

    <div class="formbody">

    <c:if test="${empty param.action}">

        <!--<div class="formtitle"><span>基本信息</span></div>-->
        <form id="submit_form" data-isadd="true" method="post" data-action="${path}/personnel/apply/apply/save.do" enctype="multipart/form-data">
        <input name="type" value="1" type="hidden">
        <ul class="forminfo">

        <li class="layui-form">
        <label>请假类型：</label>
        <div class="layui-input-block">
        <input type="radio" name="leave_type" value="1" title="事假" checked >
        <input type="radio" name="leave_type" value="2" title="病假" >
        <input type="radio" name="leave_type" value="3" title="婚假" >
        <input type="radio" name="leave_type" value="4" title="丧假" >
        <input type="radio" name="leave_type" value="5" title="年假" >
        </div>
        </li>


        <li><label>开始时间：</label><input data-lxr="{type:'time',format:'yyyy-MM-dd hh:mm:ss'}"
        value="" placeholder="开始时间" style="display: inline" type="text" class="lxr-format wdateExt
        Wdate input-primary w260" onfocus="WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd HH:mm:ss'})" >
        <input name="starttime" type="hidden">
        </li>

        <li><label>结束时间：</label><input data-lxr="{type:'time',format:'yyyy-MM-dd hh:mm:ss'}"
        value="" placeholder="结束时间" style="display: inline" type="text" class="lxr-format wdateExt
        Wdate input-primary w260" onfocus="WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd HH:mm:ss'})" >
        <input name="endtime" type="hidden">
        </li>

        <li><label>请假时长：</label><input name="duration" value="" placeholder="单位（天）" type="text"
        class=" form-control input-primary w260" >
        </li>

        <li><label>请假事由：</label><textarea name="info" class="form-control input-primary
        w260"></textarea>
        </li>

        <li><label>请假凭证：</label>
        <div class="upBox-wrap">
	        	<form id="upBox">
					 <div id="inputBox"><input type="file"  title="请选择图片" id="file" accept="image/png,image/jpg,image/gif,image/JPEG"></div>
				     <div id="imgBox" data-fname="imgFile"></div>
				</form>
			</div>
        </li>
        </ul>
        <div class="btnWrap">
        <input name="" type="button" class="btn btn-primary" id="testListAction" value="确认"
        onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;
        <input name="" type="button" class="btn btn-warning" value="返回" onclick="goBackList();"/>
        </div>
        </form>
    </c:if>

    <c:if test="${param.action=='edit'}">
        <form id="submit_form" method="post" data-action="${path}/personnel/apply/apply/update.do"
        enctype="multipart/form-data">
        <input name="id" value="${vo.id }" type="hidden" />
        <ul class="forminfo">

        <li><label>请假类型：</label><input data-format="{type:'enum',val:'${vo.leave_type }',enum:{'1':'事假','2':'病假','3':'婚假','4':'丧假','5':'年假'}}"  class="lxr-format form-control input-primary w260"  type="text" readonly="readonly">
					
				</li>
					
					
					<li><label>开始时间：</label><input data-lxr="{type:'time',format:'yyyy-MM-dd hh:mm:ss'}"
					 data-format="{type:'time',val:'${vo.starttime }',format:'yyyy-MM-dd hh:mm:ss'}"  placeholder="开始时间" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary w260" onfocus="WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd HH:mm:ss'})" >
    				<input name="starttime" type="hidden">
    				</li>
    				
    				<li><label>结束时间：</label><input data-lxr="{type:'time',format:'yyyy-MM-dd hh:mm:ss'}"
    				data-format="{type:'time',val:'${vo.endtime }',format:'yyyy-MM-dd hh:mm:ss'}" placeholder="结束时间" style="display: inline" type="text" class="lxr-format wdateExt Wdate input-primary w260" onfocus="WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd HH:mm:ss'})" >
    				<input name="endtime" type="hidden">
    				</li>

        <li><label>请假时长：</label><input name="duration" value="${vo.duration }" placeholder="单位（天）"
        type="text" class=" form-control input-primary w260" >
        </li>

        <li><label>请假事由：</label><textarea name="info" class="form-control input-primary w260">${vo.info }</textarea>
        </li>

        <li><label>请假凭证：</label>
        
        	<div class="upBox-wrap" >
	        	<form id="upBox">
					 <div id="inputBox"><input type="file"  title="请选择图片" id="file" accept="image/png,image/jpg,image/gif,image/JPEG"></div>
				     <div id="imgBox" data-fname="imgFile"></div>
				     <div id="initData" style="display: none;">
				     <c:forEach  items="${vo.vouchers }"   var="file"><span>${file}</span></c:forEach>
				     </div>
				</form>
			</div>
        </li>
        

        </ul>
        <div class="btnWrap">
        <input name="" type="button" class="btn btn-primary" value="确认" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;
        <input name="" type="button" class="btn btn-warning" value="返回" onclick="goBackList();"/>
        </div>
        </form>


    </c:if>
    </div>
    </div>
    <script src="/jroa/jslib/uploadImg.js"></script>
    <script>
    
    $(function(){
    	if(isedit()){
    		 var initData = [];
    		$("#initData>span").each(function(i,e){
    			var src = $(e).html();
    			initData.push({form:'<input name="vouchers" value="'+src+'" type="hidden" />',src:src})
    			
    			
    		});
    		console.log(initData);
    	}
    	
    	 
    	 
    	imgUpload({
    		imgBox:'imgBox', //图片容器id
    		inputBox:"inputBox",
    		num:"5",//上传个数
    		init:initData,
    		onOutof:function(){
    			$app.alert("上传文件不能超过5个");
    	
    		}
    		
    	})
    })
    
   
    
    
    
    	
	
		
   
    </script>
    </body>


    </html>
