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
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
<script type="text/javascript">
function make(){
      if(document.getElementById("content").value=="" || document.getElementById("hashtag").value=="" || document.getElementById("autocomplete").value=="" || document.getElementById("photo").value=="" ){
         swal("오류", "입력이 누락된 값이 있습니다!", "warning");
      }else{
         swal("생성완료", "게시글이 생성되었습니다!", "success")
         .then((value) => {   
          document.sub1.submit();
            });
      }

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
                  <a class="fa fa-plus">게시물 추가</a>
               </h2>
            </div>
            <hr>

            <div>
               <form:form onsubmit="return false" action="upload.do" method="post" name="sub1"
                  enctype="multipart/form-data" modelAttribute="contentdto">
                  <input type="hidden" name="content_place_lat" class="field"
                     id="lat"  value="위도">
                  <input type="hidden" name="content_place_lon" class="field"
                     id="lng" value="경도" />
                  <input type="hidden" name="content_users_id" value="<%=user_id%>" />
                  <table border="1">
                     <tr>
                        <th>문구 입력</th>
                        <td><textarea rows="5" cols="5" name="content_substance"
                              placeholder="사진 내용을 적으세요.." id="content"></textarea></td>
                     </tr>
                     <tr>
                        <th>해시태그</th>
                        <td><textarea rows="1" cols="5" name="content_hashtag"
                              placeholder="#해시태그" id="hashtag"></textarea></td>
                     </tr>
                     <tr>
                        <th>위치 추가</th>
                        <td>
                           <div id="locationField">
                              <input id="autocomplete" name="content_place_name"
                                 placeholder="위치 입력.." type="text">
                           </div>


                        </td>
                     </tr>
                     <tr>
                        <th>사진</th>
                        <td><input multiple="multiple" type="file" name="mpfile"
                           id="photo" /></td>

                     </tr>
                     <tr>
                        <td colspan="2" align="right"><input type="button"
                           value="완료" onclick="make()"> <input type="button"
                           value="취소" onclick="location.href='home.do'"></td>
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