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
					<i class="ti-lock"></i>Find Account
				</h5>
				<div>
					<input type="radio" id="id" name="find" checked="checked"> <label for="id">find id</label> &nbsp;&nbsp;<input type="radio" id="pw" name="find"> <label for="pw">find pw</label>
				</div>
				<form id="forgot_id">
					<div class="form-group">
						<input type="text" id="users_name1" required="required" /> <label class="control-label" for="input">NAME</label><i class="mtrl-select"></i>
					</div>
					<div class="form-group">
						<input type="tel" id="users_phone1" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required="required" onkeydown="javascript:if(event.keyCode==13)findId();" /> <label class="control-label" for="input">010-0000-0000</label><i class="mtrl-select"></i>
					</div>
					<div>
						<p id="alert1" style="color: #077268;"></p>
					</div>
					<div class="submit-btns">
						<button type="button" class="mtr-btn" onclick="findId();">
							<span>Find ID</span>
						</button>
						<button type="button" class="mtr-btn" onclick="location.href='signin.do'">
							<span>Cancel</span>
						</button>
					</div>
				</form>
				<form id="forgot_pw">
					<div class="form-group">
						<input type="text" id="users_id" required="required" /> <label class="control-label" for="input">ID</label><i class="mtrl-select"></i>
					</div>
					<div class="form-group">
						<input type="text" id="users_name2" required="required" /> <label class="control-label" for="input">NAME</label><i class="mtrl-select"></i>
					</div>
					<div class="form-group">
						<input type="tel" id="users_phone2" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" name="users_phone" required="required" onkeydown="javascript:if(event.keyCode==13)findPw();" /> <label class="control-label" for="input">010-0000-0000</label><i class="mtrl-select"></i>
					</div>
					<div>
						<p id="alert2" style="color: #077268;"></p>
					</div>
					<div class="submit-btns">
						<button type="button" class="mtr-btn" onclick="findPw();">
							<span>Find PW</span>
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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	$(function() {
		$("#forgot_pw").hide();
		$("#users_name1").focus();

		$("#id").click(function() {
			$("#pw").removeAttr("checked");
			$("#forgot_pw")[0].reset();
			$("#forgot_pw").hide();
			$("#forgot_id").show();
			$("#users_name1").focus();
		});
		$("#pw").click(function() {
			$("#id").removeAttr("checked");
			$("#forgot_id")[0].reset();
			$("#forgot_id").hide();
			$("#forgot_pw").show();
			$("#users_id").focus();
			$("#alert1").text("");
			
		});
	});
	function findId() {
		var users_id = $("#users_id").val();
		var users_name = $("#users_name1").val();
		var users_phone = $("#users_phone1").val();
		var users_info = {
			"users_id" : users_id,
			"users_name" : users_name,
			"users_phone" : users_phone
		};
		$.ajax({
			url : "findaccount.do",
			data : JSON.stringify(users_info),
			contentType : "application/json",
			type : "post",
			dataType : "json",
			success : function(msg) {
				var user = msg.user;
				if (user == null) {
					$("#alert1").text("찾으시는 계정이 없습니다");
				} else {
					//$("#users_name").val(user.users_id).text(user.users_id);
					//$("#users_phone").val("");
					$("#alert1").text("ID: " + user.users_id);
				}
			},
			error : function(msg) {
			}
		});
	}
	function findPw() {
		var users_id = $("#users_id").val();
		var users_name = $("#users_name2").val();
		var users_phone = $("#users_phone2").val();
		var users_info = {
			"users_id" : users_id,
			"users_name" : users_name,
			"users_phone" : users_phone
		};
		$.ajax({
			url : "findaccount.do",
			data : JSON.stringify(users_info),
			contentType : "application/json",
			type : "post",
			dataType : "json",
			success : function(msg) {
				var user = msg.user;
				if (user == null) {
					$("#alert2").text("찾으시는 계정이 없습니다");
				} else {
					location.replace("editpwform.do?users_id="+user.users_id);
				}
			},
			error : function(msg) {
			}
		});
	}
</script>
</html>