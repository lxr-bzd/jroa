<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html style="overflow:hidden">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工作台首页</title>
<link href="<%=request.getContextPath()%>/css/layout/main.css" rel="stylesheet" type="text/css" />
	<script src="${path }/jslib/jquery.min-1.11.js"></script>
	 <script src="${path }/jslib/layer/layer.js"></script>
<script src="${path}/jslib/artDialog/jquery.artDialog.js?skin=blue"></script>   
<script src="${path}/jslib/artDialog/plugins/iframeTools.js"></script>  
<script src="${path}/js/foxtail/artDialogExt.js"></script>
<script type="text/javascript" src="${path}/js/foxtail/app.js"></script>

<script type="text/javascript">
$(function(){	
	 layoutrezise();
     AutoHeight();
	//顶部导航切换
	$(".nav li a").click(function(){
		$(".nav li a.selected").removeClass("selected");
		$(this).addClass("selected");
	});	
	//导航切换
	$(".menuson li").click(function(){
		$(".menuson li.active").removeClass("active");
		$(this).addClass("active");
	});
	$('.title').click(function(){
		var $ul = $(this).next('ul');
		if($ul.is(':visible')){
			$(this).next('ul').hide();
			 $(this).find('.J_switchs').removeClass('on');
		}else{
			$(this).next('ul').show();
			 $(this).find('.J_switchs').addClass('on');
		}
	});
	
	var firstSys= $('#top .nav li').eq(0).find('a').trigger('click');
	
});	
function layoutrezise() {
    var headerH = $("div#top").height();
    var footerH = $("div#footer").height();
    var bodyerH = $(window).height() - headerH - footerH;
    $("div#middle,div#middle-left,div#middle-right,iframe#rightFrame").height(bodyerH);
    $("div#middle-right").width($(window).width() - $("div#middle-left").width());
}
function AutoHeight() {
    $(window).resize(function () {
        layoutrezise();
    })
} 
function changeList(menu){
	var text= $('#top .nav li').find('.selected').attr("id");
	
	 var vname = $("#top #"+menu+">h2").html();
	$("#middle-left>.lefttop").html('<span></span>'+vname); 
	var all=$('.leftmenu dd').hide();
	var currentModule=$('[class^='+menu+'_]').show();
	currentModule.find('.title').trigger('click');
}






function touPwd(){
	$app.dialog("${path}/index/user/toedit.do",function(){
	
	},{width:"600px",height:"500px"});
	
	
}



</script>
</head>
<div>
	<div id="top" class="header">
		<div class="topleft" >
	    	<a href="${path}/workIndex.do" target="rightFrame"><img src="../images/layout/logo.png" title="系统首页" /></a>
	    </div>
    <ul class="nav">
	
    	<c:forEach var="res" items="${resList }" varStatus="status">
    		<c:if test="${res.level==1 }">
    			<li><a href="javascript:void(0)" id="sys_${res.id }" onclick="changeList('sys_${res.id }')" ><img src="../images/layout/${res.resourceIcon}" title="${res.resourceName }" /><h2 >${res.resourceName }</h2></a></li>
    			
    		</c:if>
    	
    	</c:forEach>
    
    </ul>
    <div class="topright">    
	    
		<div class="user">
			<span>您好：${user.userName }</span>
			<a href="#" onclick="javascript:window.location='${path}/logout.do'" target="_parent">安全退出</a>
			<a href="#" onclick="touPwd()" target="_parent">修改密码</a>
		</div>    
    </div>
	<!-- topEnd -->
	</div>
	<div id="middle" style="width: 100%;height: 100%;">
		<div id="middle-left" style="position:fixed;left: 0;top: 80px;bottom: 0;width: 182px;background-color: #EEEEEE;border-right: 1px solid #dbdbdb;float: left;box-sizing: border-box;">
			<!--<div class="lefttop"><span></span>--</div>--> 
    		<dl class="leftmenu">
    		
    			<c:forEach  var="res" items="${resList }" varStatus="status">
    				<c:if test="${res.level==2 }">
    					<dd style="display: none;" class="sys_${res.parentId }_${res.id}">
					    <div class="title">
					    	<!--<span><img src="../images/layout/leftico01.png" /></span>--><span class="J_switchs cu on" title="展开或关闭"></span>${res.resourceName }
	   					</div>
	    				<ul class="menuson" style="display: none">
	    					<c:forEach var="r" items="${resList }">
	    						<c:if test="${r.level==3 && res.id==r.parentId }">
	    							<li><a href="${path}/${r.resourcePath}" target="rightFrame">${r.resourceName }</a><i></i></li>
	    						</c:if>
	    					</c:forEach>
	       				</ul>    
    				</dd>
    				</c:if>
    			</c:forEach>
    		
				</dl>
		</div>
		<div id="middle-right" style="" >
			 <iframe id="rightFrame" name="rightFrame" style="width:100%; border:0;" src="<%=request.getContextPath()%>/workIndex.do"></iframe>
		</div>
		 <div id="clear" style="clear: both;"></div> 
	</div>
	<div id="footer" style="background-color:#eee">
	     <center><a href=""data-con="南昌嘉瑞科技有限公司" /></a></center>
	</div>  
</div>
</body>
</html>