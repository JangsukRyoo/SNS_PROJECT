<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="" />
<meta name="keywords" content="" />
<title>Travel Talk</title>

<link rel="stylesheet" href="resources/css/main.min.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/color.css">
<link rel="stylesheet" href="resources/css/responsive.css">
<style type="text/css">
.container {
	height: 100%;
	left:0;
	position:absolute;
	top:0;
	width:100%;
	z-index:-1;
	background-position:center center;
	background-repeat:no-repeat;
	background-size:cover;
}






.signform {
	background: #fdfdfd none repeat scroll 0 0;
	padding: 25px;
	position: relative;
	margin: auto;
	width: 400px;
	top: -120px;
	width: 500px;
	border-radius: 10px;
	box-shadow: 0px 0px 3px 3px #f3f3f3;
}

body {
	background-color: #a8d6d1e6;
}

.horizontal {
	width: 100%;
	height: 100%;
}

.vertical {
	width: 100%;
	text-align: center;
}

.logo-section {
	height: 125px;
}

#logo {
	width: 125px;
}

.now {
	visibility:visible;
	transition:opacity 1.5s ease-in;
	z-index: 1;
}

.slideimg{
	width:100%;
	height:100%;
	visibility: hidden;
	opacity: 0;
	position: absolute;
	left: 0px;
	top: 0px
}

.pr, .now {
	opacity: 1;
	visibility: visible;
}

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	
setInterval(imageChange, 5000);

var i = [0, 1, 2, 3];


function imageChange() {
	if($("#first").hasClass("now")) {
		$("#first").removeClass("now");
		$("#first").addClass("pr");
		$("#second").addClass("now");
		$("#fourth").removeClass("pr");
	}else if($("#second").hasClass("now")) {
		$("#second").removeClass("now");
		$("#second").addClass("pr");
		$("#third").addClass("now");
		$("#first").removeClass("pr");
	}else if($("#third").hasClass("now")) {
		$("#third").removeClass("now");
		$("#third").addClass("pr");
		$("#fourth").addClass("now");
		$("#second").removeClass("pr");
	}else if($("#fourth").hasClass("now")) {
		$("#fourth").removeClass("now");
		$("#fourth").addClass("pr");
		$("#first").addClass("now");
		$("#third").removeClass("pr");
	}

};
	
	
</script>

</head>
<body>
	<div class="container" >
		<div class="horizontal">
			<img id="first" class="slideimg now" src="resources/images/no1.jpg">
			<img id="second" class="slideimg" src="resources/images/no2.jpg">
			<img id="third" class="slideimg" src="resources/images/no3.jpg">
			<img id="fourth" class="slideimg pr" src="resources/images/no4.jpg">
		</div>
	</div>
		<div class="signform" style="margin-top:15%;">
			<div class="editing-info">
				<div class="vertical">
					<div class="logo-section">
						<img id="logo" alt="logo" src="resources/images/logo.png">
					</div>
				</div>
				<h5 class="f-title">
					<i class="ti-lock"></i>Sign In
				</h5>
				<form>
					<div class="form-group">
						<input type="text" id="users_id" required="required" onkeydown="javascript:if(event.keyCode==13)next();" /> <label class="control-label" for="input">ID</label><i class="mtrl-select"></i>
					</div>
					<div class="form-group">
						<input type="password" id="users_pw" required="required" onkeydown="javascript:if(event.keyCode==13)login();" /> <label class="control-label" for="input">PW</label><i class="mtrl-select"></i>
					</div>
					<div>
						<p id="chk" style="color:#077268;"></p>
					</div>
					<a class="forgot-pwd underline" title="" href="forgot.do">Forgot Password?</a>
					<div class="submit-btns">
						<button type="button" class="mtr-btn" onclick="login();">
							<span>Sign In</span>
						</button>
						<button type="button" class="mtr-btn" onclick="location.href='signup.do'">
							<span>Sign Up</span>
						</button>
					</div>

				</form>
			</div>
		</div>
</body>
<script>
	$(function() {
		$("#users_id").focus();
	});
	function next() {
		$("#users_pw").focus();
	}
	function login() {
		var users_id = $("#users_id").val().trim();
		var users_pw = $("#users_pw").val().trim();
		var loginVal = {
			"users_id" : users_id,
			"users_pw" : users_pw
		}
		if (users_id == null || users_id == "" || users_pw == null
				|| users_pw == "") {
			$("#chk").text("ID 혹은 PW를 확인하세요");
		} else {
			$.ajax({
				type : "post",
				url : "ajaxlogin.do",
				data : JSON.stringify(loginVal),
				contentType : "application/json",
				dataType : "json",
				success : function(msg) {
					if (msg.check == true) {
						location.replace("home.do");
					} else {
						$("#chk").text("ID 혹은 PW가 잘못되었습니다");
					}
				},
				error : function(msg) {
					alert("통신 실패");
				}
			});
		}
	}
</script>

</body>

</html>