<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
.login{
    background: #fdfdfd none repeat scroll 0 0;
    border: 1px solid #ede9e9;
    border-radius: 3px;
    display: inline-block;
    width: 100%;
    margin-bottom: 20px;
    padding: 25px;
}
</style>
</head>
<body>

	<div class="login">
		<div class="editing-info">
			<h5 class="f-title">
				<i class="ti-lock"></i>Change Password
			</h5>

			<form method="post">
				<div class="form-group">
					<input type="password" id="input" required="required" /> <label
						class="control-label" for="input">New password</label><i
						class="mtrl-select"></i>
				</div>
				<div class="form-group">
					<input type="password" required="required" /> <label
						class="control-label" for="input">Confirm password</label><i
						class="mtrl-select"></i>
				</div>
				<div class="form-group">
					<input type="password" required="required" /> <label
						class="control-label" for="input">Current password</label><i
						class="mtrl-select"></i>
				</div>
				<a class="forgot-pwd underline" title="" href="#">Forgot
					Password?</a>
				<div class="submit-btns">
					<button type="button" class="mtr-btn">
						<span>Cancel</span>
					</button>
					<button type="button" class="mtr-btn">
						<span>Update</span>
					</button>
				</div>
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="resources/js/script.js"></script>

</body>

</html>