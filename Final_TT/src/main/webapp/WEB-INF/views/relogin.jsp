<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Travel Talk</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<style type="text/css">
	.bg-image {
	width: 100%;
	height: 100%;
	content: "";
	background-image:url('resources/images/no1.jpg')
	background-size: cover;
	background-repeat: no-repeat;
	position: absolute;
	top: 0;
	left: 0;
	z-index: -99;
}

</style>

</head>
<body>
<script type="text/javascript">
		setTimeout(go_url, 5000);
		function go_url() {
			$("#but").trigger('click');
		}
	</script>
	<div class="theme-layout">
		<div class="container-fluid pdng0">
			<div class="row">
				<div class="col-lg-12">
					<div class="error-page">
						<div class="bg-image"></div>
						<div class="error-meta">
							<span
								style="margin-top:20%;display: inline-block; font-size: 17px; text-align: center; width: 100%; text-transform: capitalize;">
									5초뒤 로그인 페이지로 이동합니다.
								</span> <button id="but" onclick="location.href='signin.do'"
								style="margin-left:43%;background: #088dcd; border-radius: 3px; color: #fff; display: inline-block; margin-top: 30px; padding: 6px 30px; text-decoration: none; text-align: center;">
									로그인 페이지 이동
								</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>