<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	var placeSearch, autocomplete;
	function initAutocomplete() {
		autocomplete = new google.maps.places.Autocomplete((document
				.getElementById('autocomplete')), {
			types : [ 'geocode' ]
		});
		autocomplete.addListener('place_changed', fillInAddress);
	}
	function fillInAddress() {
		var place = autocomplete.getPlace();
		document.getElementById("lat").value = place.geometry.location.lat();
		document.getElementById("lng").value = place.geometry.location.lng();
	}
</script>

<style type="text/css">

/* 최대 크기 지정 */
.modal {
	max-width: 700px;
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
	font-size: 15px;
}

td {
	font-size: 15px;
}
</style>
</head>

<body>
<%@ page import="com.tt.sns.model.dto.UsersDto"%>

	<%
		UsersDto dto = null;
	dto = (UsersDto) session.getAttribute("login");
	String user_id = null;
	user_id = dto.getUsers_id();
	%>
	<div class="Modal">
		<section>
			<div class="container">
				<div align="center">
					<h2>
						<a class="fa fa-plus">게시물 수정</a>
					</h2>
				</div>
				<hr>

				<div>
					<form:form action="editupload.do" method="post"
						enctype="multipart/form-data" modelAttribute="contentdto">
						<input type="hidden" name="content_users_id" value=<%=user_id %> />
						<input	type="hidden" name="content_no" value="${dto.content_no }" >
						<input type="hidden" name="content_place_lat" class="field" id="lat"
									/ value="위도"> <input type="hidden" name="content_place_lon"
									class="field" id="lng" value="경도" />
						<table border="1">
							<tr>
								<th>문구 입력</th>
								<td><textarea rows="5" cols="5" name="content_substance">${dto.content_substance }</textarea></td>
							</tr>
							<tr>
                       			<th>해시태그</th>
                       			<td><textarea rows="1" cols="5" name="content_hashtag" placeholder="#해시태그">${dto.content_hashtag }</textarea></td>
                     		</tr>
							<tr>
								<th>위치 추가</th>
								<td>
									
									<div id="locationField">
										<input id="autocomplete" name="content_place_name"
											placeholder="${dto.content_place_name }" type="text"> 
									</div> 
									
								</td>
							</tr>
							<tr>
								<th>사진</th>
								<td><input multiple="multiple" type="file" name="mpfile" />
								</td>

							</tr>
							<tr>
								<td colspan="2" align="right"><input type="submit" value="완료"> <input type="button" value="취소"
									onclick="location.reload(true)'"></td>
							</tr>

						</table>

					</form:form>
				</div>
			</div>
		</section>
	</div>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAq4k5HbUu3jOVMBt2htlDc1h76iIXp_yM&libraries=places&callback=initAutocomplete"
		async defer></script>
	<script src="resources/js/script.js"></script>

</body>
</html>