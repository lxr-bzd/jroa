<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <% response.setHeader( "Cache-Control",
    "no-store, no-cache, must-revalidate"); response.setHeader( "Pragma", "no-cache"); response.setDateHeader(
    "Expires", -1); %>
        <html>
            
            <head>
            <meta name="renderer" content="webkit" />
                <meta http-equiv="Content-Type" content="IE=edge; charset=UTF-8">
                <title>嘉瑞云办公管理系统</title>
                <link href="<%=request.getContextPath()%>/css/layout/style.css" rel="stylesheet" type="text/css" />
                <script src="<%=request.getContextPath()%>/jslib/jquery.min-1.11.js"></script>
                <script src="<%=request.getContextPath()%>/js/layout/logincloud.js" type="text/javascript"></script>
                <link rel="stylesheet" href="<%=request.getContextPath()%>/jslib/table/docs/assets/bootstrap/css/bootstrap.min.css">
                <script src="<%=request.getContextPath()%>/jslib/table/docs/assets/bootstrap/js/bootstrap.min.js"> </script>
                <link href="<%=request.getContextPath()%>/jslib/layui/css/layui.css" rel="stylesheet" type="text/css" />
                <script src="<%=request.getContextPath()%>/jslib/layui/layui.js"></script>
                <script type="text/javascript">
                    $(function() {
                        if (window != top) {
                            top.location.href = location.href;
                        }
/*                        $('.loginbox').css({
                            'position': 'absolute',
                            'left': ($(window).width() - 692) / 2
                        });
                        $(window).resize(function() {
                            $('.loginbox').css({
                                'position': 'absolute',
                                'left': ($(window).width() - 692) / 2
                            });
                        });*/
                        var message = $.trim($('#msgShow').text());
                        if (message) {
                            $('#warnInfo').show();
                        }

                    });

                    //刷新验证码
                    function refreshCode() {
                        $("#passkey_img").attr("src", "<%=request.getContextPath()%>/loadPasskey.do?timestamp=" + new Date().getTime());
                    }

//                  function openWarnInfo() {
//                      $('#warnInfo').show();
//                  }

                    function login() {
                        var loginNam = $("#loginName").val();
                        var password = $("#password").val();
                        var passkey = $("#passKey").val();
                        if (!loginNam) {
                           // $("#msgShow").text('');
//                          openWarnInfo();
						layer.msg('请输入登录名', {time: 5000, icon:6});
                            return;
                        }
                        if (!password) {
                            //$("#msgShow").text('请输入登录密码');
							layer.msg('请输入登录密码', {time: 5000, icon:6});
   

                            return;
                        }

                        /* if(!passkey){
 			$("#msgShow").text('请输入验证码');
 			openWarnInfo();
 			return;
 		} */
                        var $btn = $("btnLogin").button('登录中...');
                        $btn.button('reset');
                        $("#userLoginForm").submit();
                    }

                    function enterLogin() {
                        var event = arguments.callee.caller.arguments[0] || window.event; // 修正浏览器兼容 
                        if (event.keyCode == 13) {
                            login();
                        }
                    }
                    layui.use('form', function(){
					  var form = layui.form;
					});
                    
                    

                    $(function(){
                    	$("#password").val("");
                    	
                    })
                    
                    
                    
                </script>
                <style type="text/css">
                    span { display: block; } 
                </style>
            </head>
            
            <body onkeydown="enterLogin();" onload="refreshCode()" class="login-body">
                <div class="loginbody">
                    <form id="userLoginForm" class="userLoginForm" action="<%=request.getContextPath()%>/login.do"
                    method="post">
                        <div class="loginbox login_table">
                        	<div class="loginform">
                        		<div class="loginHead">
                        			<div class="loginIcon fl"><img src="images/layout/logo_icon.png" alt="" /></div>
                        			<div class="loginTxt fl">
                        				<h3>嘉瑞云办公管理系统</h3>
                        				<h5>云办公改变工作效率</h5>
                        			</div>
                        		</div>
                        		<div class="loginWrap">
                        			<div class="loginIpt">
                        			<span style="color: red;">${warn }</span>
	                        			<input type="text" id="loginName" name="loginName" class="text login-user" placeHolder="请输入用户名">
	                        			<input type="password" id="password" name="password" class="text login-pass" placeHolder="请输入登录密码">
                        			</div>
                        			<div class="loginStore layui-form">
									  <div class="layui-form-item">
									      <input type="checkbox" name="rememberMe" title="记住我" lay-skin="primary">
									  </div>
                        			</div>
                                    <input id="btnLogin" type="button" class="" value="登  录" onclick="login();" />
                        		</div>
                        	</div>
                        </div>
                    </form>
                </div>
            </body>
        
        </html>