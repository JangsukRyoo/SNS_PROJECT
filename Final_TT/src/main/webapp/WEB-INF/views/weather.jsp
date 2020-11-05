<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
   request.setCharacterEncoding("UTF-8");
%>
<%
   response.setContentType("text/html; charset=UTF-8");
%>

<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<!DOCTYPE html>
<html>
<head>
<title>Travel Talk</title>
<link rel="stylesheet" href="css/style.css" />
<script type="text/javascript"
   src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script async defer
   src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAq4k5HbUu3jOVMBt2htlDc1h76iIXp_yM&callback=initMap">
</script>
<style type="text/css">
#google-map {
   width: 400px;
   height: 270px;
   margin-top: -270px;
   padding: 0;
   left: 350px;
}

#search-panel {
   position: absolute;
   top: 420px;
   left: 55%;
   z-index: 5;
   background-color: #FFFFFF;
   padding: 5px;
   border: 1px solid black;
   text-align: center;
}

/* 최대 크기 지정 */
.modal {
   max-width: 1000px;
   POSITION: RELATIVE;
   margin: 100px;
}

.Modal {
   background: #fff none repeat scroll 0 0;
   border-radius: 3px;
   padding: 10px;
}
</style>
</head>
<script>
   $
         .getJSON(
               'http://api.openweathermap.org/data/2.5/weather?lat='+${dto.content_place_lat }+'&lon='+${dto.content_place_lon }+'&APPID=e30dd5a14df428e5a92332796c885c6d&units=metric',
               function(data) {
                  var $name = data.name;
                  var $mintemp = data.main.temp_min;
                  var $maxtemp = data.main.temp_max;
                  var $ctemp = data.main.temp;
                  var $now = new Date($.now());
                  var $cDate = $now.getFullYear() + "/"
                        + ($now.getMonth() + 1) + '/' + $now.getDate();
                  var $icon = data.weather[0].icon;
                  var $clouds = data.clouds.all;

                  $('.lowtemp').append($mintemp + '°C');
                  $('.hightemp').append($maxtemp + '°C');
                  $('.temp').append($ctemp + '°C');
                  $('.icon')
                        .append(
                              '<img src="http://openweathermap.org/img/w/' + $icon +'.png" />');
                  $('.dt').prepend($cDate + '일 ' + $name + '의 ');
                  $('.clouds').append($clouds + '%');

                  //<img src="http://openweathermap.org/img/w/.png"
               });
</script>
<script>
   function initMap() {

      /**
       * 맵을 설정한다.
       * 1번째 파라미터 : 구글 맵을 표시할 위치. 여기서는 #google-map
       * 2번째 파라미터 : 맵 옵션.
       *      ㄴ zoom : 맵 확대 정도
       *      ㄴ center : 맵 중심 좌표 설정
       *              ㄴ lat : 위도 (latitude)
       *              ㄴ lng : 경도 (longitude)
       */
      var map = new google.maps.Map(document.getElementById('google-map'), {
         zoom : 12.5,
         center : {
            lat : ${dto.content_place_lat },
            lng : ${dto.content_place_lon }
         }
      });

      /**
       * Google Geocoding. Google Map API에 포함되어 있다.
       */
      var geocoder = new google.maps.Geocoder();

      // submit 버튼 클릭 이벤트 실행
      document.getElementById('submit').addEventListener('click', function() {

         // 여기서 실행
         geocodeAddress(geocoder, map);
      });

      /**
       * geocodeAddress
       * 
       * 입력한 주소로 맵의 좌표를 바꾼다.
       */
      function geocodeAddress(geocoder, resultMap) {

         // 주소 설정
         var address = document.getElementById('address').value;

         /**
          * 입력받은 주소로 좌표에 맵 마커를 찍는다.
          * 1번째 파라미터 : 주소 등 여러가지. 
          *      ㄴ 참고 : https://developers.google.com/maps/documentation/javascript/geocoding#GeocodingRequests
          * 
          * 2번째 파라미터의 함수
          *      ㄴ result : 결과값
          *      ㄴ status : 상태. OK가 나오면 정상.
          */
         geocoder.geocode({
            'address' : address
         }, function(result, status) {

            if (status === 'OK') {
               // 맵의 중심 좌표를 설정한다.
               resultMap.setCenter(result[0].geometry.location);
               // 맵의 확대 정도를 설정한다.
               resultMap.setZoom(18);
               // 맵 마커
               var marker = new google.maps.Marker({
                  map : resultMap,
                  position : result[0].geometry.location
               });

               // 위도
               // 경도
            } else {
               alert('지오코드가 다음의 이유로 성공하지 못했습니다 : ' + status);
            }
         });
      }
   }
</script>
<body>
   <%@ page import="com.tt.sns.model.dto.UsersDto"%>

   <%
      UsersDto dto = null;
   dto = (UsersDto) session.getAttribute("login");
   String user_id = null;
   user_id = dto.getUsers_id();
   %>
   <script type="text/javascript">
      function imgInfo(img) {
         if (img.naturalWidth > img.naturalHeight) {
            $(img).css("height", "auto").css("min-width", "100%").css(
                  "max-width", "100%");
         } else {
            $(img).css("width", "auto").css("min-height", "100%").css(
                  "max-height", "100%");
         };
      };
   </script>

   <script type="text/javascript">
      $(function){
         $(".likes").click(function() {
            var className = $(this).children('i').attr('class');
            content_no = $(this).children('input').eq(0).attr('value');
            user_id = $(this).children('input').eq(1).attr('value');
            var LikeVal = {
                  "content":content_no,
                  "users":user_id
            }

            var children = $(this).children('ins');
            
            if(className == 'fa fa-heart-o') {
               $(this).children('i').attr('class', 'fa fa-heart');
               $.ajax({
                  type:"POST",
                  url:"like.do",
                  data:JSON.stringify(LikeVal),
                  contentType:"application/json",
                  dataType:'json',
                  success:function(msg){
                     children.html(msg.count +"likes");
                     $("#button_home").trigger("click");
                     
                  },
                  error:function(){
                     alert('에러');
                  }
               });
            } else {
               $(this).children('i').attr('class', 'fa fa-heart-o');
               $.ajax({
                  type:"POST",
                  url:"dislike.do",
                  data:JSON.stringify(LikeVal),
                  contentType:"application/json",
                  dataType:'json',
                  success:function(msg){
                     children.html(msg.count + "likes");
                     $("#button_home").trigger("click");
                  },
                  error:function(){
                     alert('에러');
                  }
               });
            }
         });
      };
   </script>
   <div class="Modal">
      <section>
         <div class="container">
            <h2>
               <a class="fa fa-map-o"><sapn>Map</sapn></span></a>
            </h2>

            <div class="central-meta">
               <div>
                  <ul class="nearby-contct">
                     <li>
                        <h2 class="dt">날씨 정보</h2>
                        <div class="temp">현재 온도 :</div>
                        <div class="lowtemp">최저 온도 :</div>
                        <div class="hightemp">최고 온도 :</div>
                        <div class="clouds">구름 :</div>
                        <div class="icon">날씨 아이콘 :</div>
                     </li>
                  </ul>
                  <div id="google-map"></div>
               </div>
            </div>
            <br> <br> <br> <br>

            <h2>
               <a class="fa fa-map-marker "><sapn>Spot</sapn></span></a>
            </h2>


            <div class="row masonry">
               <c:choose>
                  <c:when test="${empty searchcontentList }">
                     <tr>
                        <td colspan="4" align="center"></td>
                     </tr>
                  </c:when>
                  <c:otherwise>
                     <c:set var="count" value="0" />
                     <c:forEach items="${searchcontentList  }" var="dto" 
                        varStatus="status">
                        <tr>
                           <div class="col-lg-4 col-sm-6">
                              <div class="g-post-classic">
                              <c:forEach items="${imageList[status.index] }" var="imageList" begin="0" end="0">
                                 <figure>
                                    <div id="img-bg">
                                       <div id="cover">
                                          <div id="centered">
                                             <c:choose>
								<c:when test="${fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'mp4' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'avi' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'MP4' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'AVI' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'wmv' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'WMV' }">
									<video controls class="post-img" src="resources/images/content/${imageList }" ></video>
								</c:when>
								<c:otherwise>
									<img class="post-img" src="resources/images/content/${imageList }" alt="" onload="javascript:imgInfo(this);">
								</c:otherwise>
							</c:choose>
                                          </div>
                                       </div>
                                    </div>
                                 </figure>
                                 </c:forEach>
                                 <div class="g-post-meta" style="margin-top: 30%">
                                    <div class="post-title">

                                       <a id="place_name"
                                          href="weather.do?content_no=${dto.content_no }"
                                          rel="modal:open" title="" class="showmore underline">${dto.content_place_name }</a>
                                       <a
                                          href="timelinedetail.do?content_no=${dto.content_no }&index=${status.index}&button1=likes&button2=comments"
                                          rel="modal:open" title="" class="showmore underline">
                                          <p>${dto.content_substance }</p>
                                          <p style="color: #37948c">${dto.content_hashtag }</p>
                                       </a> <span class="p-date">
                                          <p class="sub"></p>
                                       </span>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </tr>
                        <script type="text/javascript">
                                          function timeBefore() {
                                             var j_count = '<c:out value="${count}"/>';

                                             //현재시간
                                             var now = new Date();

                                             var test = '${dto.content_date }';
                                             var test2 = test
                                                   .toString();
                                             var writeDay2 = test2
                                                   .replace(
                                                         "KST ",
                                                         "");
                                             var writeDay = new Date(
                                                   writeDay2);
                                             var minus;
                                             var time = '';
                                             if (now
                                                   .getFullYear() > writeDay
                                                   .getFullYear()) {
                                                minus = now
                                                      .getFullYear()
                                                      - writeDay
                                                            .getFullYear();
                                                time += minus
                                                      + "년 ";
                                             }
                                             if (now.getMonth() > writeDay
                                                   .getMonth()) {
                                                minus = now
                                                      .getMonth()
                                                      - writeDay
                                                            .getMonth();
                                                time += minus
                                                      + "달 ";
                                             }
                                             if (now.getDate() > writeDay
                                                   .getDate()) {
                                                minus = now
                                                      .getDate()
                                                      - writeDay
                                                            .getDate();
                                                time += minus
                                                      + "일 ";
                                             }

                                             if (now.getHours() > writeDay
                                                   .getHours()) {
                                                minus = now
                                                      .getHours()
                                                      - writeDay
                                                            .getHours();
                                                time += minus
                                                      + "시간 ";
                                             }

                                             if (now
                                                   .getMinutes() > writeDay
                                                   .getMinutes()) {
                                                minus = now
                                                      .getMinutes()
                                                      - writeDay
                                                            .getMinutes();
                                                time += minus
                                                      + "분 ";
                                             }

                                             if (now
                                                   .getSeconds() > writeDay
                                                   .getSeconds()) {
                                                minus = now
                                                      .getSeconds()
                                                      - writeDay
                                                            .getSeconds();
                                                time += minus
                                                      + "초";
                                             }

                                             time += "전";
                                             document
                                                   .getElementsByClassName("sub")[j_count].innerHTML = time;

                                          }

                                          setInterval(timeBefore,
                                                1000);
                                       </script>
                                       <c:set var="count" value="${count+1 }" />
                                    </c:forEach>
                  </c:otherwise>
               </c:choose>
            </div>
         </div>

      </section>
   </div>

   <script src="resources/js/script.js"></script>
   
   

</body>
</html>