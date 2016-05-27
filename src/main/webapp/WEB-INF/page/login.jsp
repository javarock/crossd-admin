<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jfz/static/common/jsp/common.jsp" %> 
    
<!DOCTYpE html>

<html lang="en">
	
	<head>
		<meta charset="utf-8">
		<title>请登录</title>
		<link rel="stylesheet" href="${staticPath }adminLogin/css/adminLogin.css"/>
	</head>
	
	<body>
		<form method="post" action="${path}login" id='adminLoginForm'>
			<div class="top_div" >
				<div style="padding:90px;">
					<img style="clear: both;display: block; margin:auto;" src="">
				</div>
			</div>
			<div style="background: rgb(255, 255, 255); margin: -100px auto auto; 
				border: 1px solid rgb(231, 231, 231); border-image: none; 
				width: 400px; height: 200px; text-align: center;">
				<div style="width: 165px; height: 96px; position: absolute;">
					<div class="tou"></div>
					<div class="initial_left_hand" id="left_hand"></div>
					<div class="initial_right_hand" id="right_hand"></div>
				</div>
				<p style="padding: 30px 0px 10px; position: relative;">
					<span class="u_logo"></span> 
					<input class="ipt" type="text" placeholder="请输入用户名" value="" name="fdName" id="fdName" >
				</p>
				<p style="position: relative;">
					<span class="p_logo"></span> 
					<input class="ipt" id="fdPassword" type="password" placeholder="请输入密码" value="" name="fdPassword">
				</p>
				<div style="height: 50px; line-height: 50px; margin-top: 30px; 
					border-top-color: rgb(231, 231, 231); border-top-width: 1px; border-top-style: solid;">
					<p style="margin: 0px 35px 20px 45px;">
						<span style="float: left;color: red;" id="loginTip">${sessionScope.loginError }</span>
						<span style="float: right;">
							<input type="button" id="adminLogin" style="background: rgb(0, 142, 173); padding: 7px 10px; 
								border-radius: 4px; border: 1px solid rgb(26, 117, 152); 
								border-image: none; color: rgb(255, 255, 255); font-weight: bold;cursor:pointer;"
								value="登录">	
								
						</span>
					</p>
				</div>
			</div>
			<div style="text-align: center;"></div>
		</form>
		<script type="text/javascript" src="${staticPath }common/js/jquery-1.11.0.min.js"></script>
		
		<script type="text/javascript" src="${staticPath }jqueryvalidation/jquery.form.js"></script>
		
		<script type="text/javascript">
		
			document.onkeydown=function() {
				if (event.keyCode==13) {
					adminLogin();
				}
			}
		
			$(function(){
				//得到焦点
				$("#fdPassword").focus(function(){
					$("#left_hand").animate({
						left: "150",
						top: " -38"
					},{step: function(){
						if(parseInt($("#left_hand").css("left"))>140){
							$("#left_hand").attr("class","left_hand");
						}
					}}, 2000);
					$("#right_hand").animate({
						right: "-64",
						top: "-38px"
					},{step: function(){
						if(parseInt($("#right_hand").css("right"))> -70){
							$("#right_hand").attr("class","right_hand");
						}
					}}, 2000);
				});
				//失去焦点
				$("#fdPassword").blur(function(){
					$("#left_hand").attr("class","initial_left_hand");
					$("#left_hand").attr("style","left:100px;top:-12px;");
					$("#right_hand").attr("class","initial_right_hand");
					$("#right_hand").attr("style","right:-112px;top:-12px");
				});
				
				$("#adminLogin").click(function() {
					adminLogin();
				});
			});
			
			//登录
			/*过期方法*/
			function adminLogin2() {
				var loginTip = $("#loginTip");
				loginTip.hide();
				loginTip.text("");
				var fdName = $.trim($("#fdName").val());
				var fdPassword = $.trim($("#fdPassword").val());
				if(fdName == "" || fdPassword == "") {
					loginTip.text("用户名和密码不能为空");
					loginTip.show();
					return;
				} else {
					$("#adminLogin").attr("disabled",true);
					$.ajax({
						async:false,
						type:"post",
						url:"${path}admin/login",
						dataType:"json",
						data:{"fdName":fdName,"fdPassword":fdPassword},
						success:function(msg) {
							if(msg["success"]) {
								if(msg["loginSuccess"]) {
									window.location.href="${path}index";
								} else {
									loginTip.text("登录失败，用户名或密码错误！");
									loginTip.show();
									$("#adminLogin").removeAttr("disabled");
								}
							} else {
								loginTip.text("登录失败，服务器异常，请稍后重试！");
								loginTip.show();
								$("#adminLogin").removeAttr("disabled");
							}
						},
						error:function() {
							loginTip.text("登录失败，服务器异常，请稍后重试！");
							loginTip.show();
							$("#adminLogin").removeAttr("disabled");
						}
					});
				}
			}
			
			//登录
			function adminLogin() {
				var loginTip = $("#loginTip");
				loginTip.hide();
				loginTip.text("");
				var fdName = $.trim($("#fdName").val());
				var fdPassword = $.trim($("#fdPassword").val());
				if(fdName == "" || fdPassword == "") {
					loginTip.text("用户名和密码不能为空");
					loginTip.show();
				} else {
					$("#adminLogin").attr("disabled",true);
					$("#adminLoginForm").submit();
				}
			}
			
		</script>
		
	
	</body>
</html>