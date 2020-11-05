<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<title>Travel Talk</title>
<link rel="icon" href="images/fav.png" type="image/png" sizes="16x16">
<link rel="stylesheet" href="css/style.css" />
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAq4k5HbUu3jOVMBt2htlDc1h76iIXp_yM&callback=initMap">
	
</script>
<style type="text/css">

/* 최대 크기 지정 */
.modal {
	max-width: 500px;
	POSITION: RELATIVE;
	margin: 100px;
}

.Modal {
	background: #fff none repeat scroll 0 0;
	border-radius: 3px;
	padding: 10px;
}

tr {
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size :15px;
}
td{
	font-size: 15px;
}

</style>
</head>

<body>
<%@ page import="com.tt.sns.model.dto.UsersDto" %>

<%
   UsersDto dto = null;
   dto = (UsersDto)session.getAttribute("login");
   String user_id = null;
   user_id = dto.getUsers_id();
%>
	<div class="Modal">
		<section>
			<div class="container">
				<div align="center">
					<h2>
						<a class="fa fa-cog">프로필 편집</a>
					</h2>
				</div>
				<hr>

				<div>
					<form action="profileupdate.do" method="post" enctype="multipart/form-data" >
					<input type="hidden" name="users_id" value="${userinfo.users_id }">
						<table border="1">
							<tr>
								<th>사용자 이름</th>
								<td><input name="users_nickname" value="${userinfo.users_nickname }"></td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td><input type="password" name="users_pw" placeholder="문자,숫자,특수기호 포함 6자리"></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input name="users_phone" value="${userinfo.users_phone }"></td>
							</tr>
							<tr>
								<th>소개 </th>
								<td><textarea rows="3" cols="3" name="user_info">${userinfo.user_info }</textarea> </td> 
							</tr>
							<tr>
								<th>프로필 사진</th>
								<td><input type="file" name="mpfile"  /></td>
							</tr>
							<tr>
								<td colspan="2" align="right"><input type="submit" id="ssubmit"
									value="완료"> <input type="button" value="취소"></td>
							</tr>
						</table>
					</form>
				</div>
			</div>

		</section>
	</div>


	<script src="resources/js/script.js"></script>

</body>
</html>