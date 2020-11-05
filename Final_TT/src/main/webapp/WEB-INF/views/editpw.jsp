<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
}

.container::after {
	width: 100%;
	height: 100%;
	content: "";
	background-color: #a8d6d1e6;
	background-size: cover;
	background-repeat: no-repeat;
	position: absolute;
	top: 0;
	left: 0;
	z-index: -99;
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
	background-color: #fff !important;
}

.horizontal {
	width: 100%;
	height: 230px;
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
</style>

</head>
<body>
	<div class="container">
		<div class="horizontal"></div>
		<div class="signform">
			<div class="editing-info">
				<div class="vertical">
					<div class="logo-section">
						<img id="logo" alt="logo" src="resources/images/logo.png">
					</div>
				</div>
				<h5 class="f-title">
					<i class="ti-lock"></i>Change Password
				</h5>
				<form action="editpw.do">
					<input type="hidden" name="users_id" value="${users_id}">
					<div class="form-group">
						<input type="password" id="users_pw" name="users_pw" required="required" /> <label id="pwLabel" class="control-label" for="input">PW</label><i class="mtrl-select"></i>
					</div>
					<div class="form-group">
						<input type="password" id="pwChk" required="required" onkeydown="javascript:chk();if(event.keyCode==13)findPw();" /> <label id="chkLabel" class="control-label" for="input">Confirm PW</label><i class="mtrl-select"></i>
					</div>
					<div>
						<p id="alert1" style="color: #077268;"></p>
					</div>
					<div class="submit-btns">
						<button type="submit" class="mtr-btn">
							<span>Confirm</span>
						</button>
						<button type="button" class="mtr-btn" onclick="location.href='signin.do'">
							<span>Cancel</span>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	$(function() {
		$("#users_pw").focus();
		$("#users_pw").blur(function() {
			pwChk();
		});
		$("#pwChk").blur(
				function() {
					if (($("#pwChk").val() != $("#users_pw").val())
							&& $("#pwChk").val() != "") {
						$("#chkLabel").text("비밀번호가 일치하지 않습니다.");
					} else {
						$("#chkLabel").text("Confirm PW");
					}
				});

	});
	function pwChk() {
		var pw = $("#users_pw").val();
		//(최소 하나이상 && 문자 && 숫자 && 특수기호) || 6자리 이상
		var reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,}$/;
		if (!reg.test(pw) && pw != "") {
			$("#users_pw").focus();
			$("#pwLabel").text("최소 하나 이상의 문자, 숫자, 특수기호로 6자리 이상 입력");
		}
		if (reg.test(pw) || pw == "") {
			$("#pwLabel").text("PW");
		}

	}

	function findPw() {
		$("form")[0].submit();
	}
	function chk() {
		if (($("#pwChk").val() != $("#users_pw").val())
				&& $("#pwChk").val() != "") {
			$("#chkLabel").text("비밀번호가 일치하지 않습니다.");
		} else {
			$("#chkLabel").text("Confirm PW");
		}
	}
</script>
</html>