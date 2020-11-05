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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="" />
<meta name="keywords" content="" />
<title>Travel Talk</title>
<script type="text/javascript"
   src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="resources/css/main.min.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/color.css">
<link rel="stylesheet" href="resources/css/responsive.css">
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

</head>
<body>
   <%@ page import="com.tt.sns.model.dto.UsersDto"%>

   <%
      UsersDto dto = null;
   dto = (UsersDto) session.getAttribute("login");
   String user_id = null;
   user_id = dto.getUsers_id();
   String user_profile = null;
   user_profile = dto.getUsers_profile();
   %>

   <header>
      <div class="topbar stick">
         <div class="logo">
            <a title="" href="home.do"><img src="resources/images/logo.png"
               alt=""></a>
         </div>

         <div class="top-area">
            <ul class="setting-area">
               <li class="bell" id="bells">
               <input type="hidden" name=user_id   value="<%=user_id %>" />
               <a href="#" title="Notification" data-ripple=""> <i class="fa fa-user"></i>
               </a>
                  <div class="dropdowns">
                     <ul class="drops-menu">
                     </ul>
                  </div></li>
               <li><a href="#" title="Messages"
                  onclick="location.href='ms.do'" data-ripple=""><i
                     class="ti-comment"></i></a></li>
            </ul>
            <div class="user-img" id="profile">
               <img src="resources/images/profile/${user_profile }" alt="" style="width:60px;height:60px">
               <div class="user-setting">
                  <a href="savepage.do" ><i class="fa fa-bookmark-o" ></i>저장됨</a>
                  <a href="logout.do" title="" id="logout"><i class="ti-power-off" ></i>log out</a>
               </div>
            </div>
         </div>
      </div>
      <script type="text/javascript">
      $(function() {
         $('#bells').on('click', function() {
            var userid = $(this).children('input').attr('value');
            $(".drops-menu").children('li').remove();
            
            $.ajax({
               type:"POST",
               url:"friend.do",
               data: userid,
               contentType:"application/json",
               dataType:'json',
               success:function(msg){
                  var id = msg.rList;
                  var profile = msg.imgList;
                  var str = "";
                  if(id != "") {
                     $.each(id, function(i) {
                        str += '<li style="display:flex; border-bottom:1px solid lightgray;"><input type="hidden" value="'+id[i]+'" /><img class="friendprofile" src="resources/images/profile/'+ profile[i]  +'" style="cursor:pointer;width:50px;height:50px;border-radius:50%;" ><p class="friendid" style="cursor:pointer;width:auto;margin-bottom:0px;margin-top:13px;margin-left:25px;font-size:20px">' + id[i] + '</p><a class="recommendfollow" style="cursor:pointer;width:auto;margin-left:auto;border-bottom:none;margin-top:5px;margin-right:auto">팔로잉</a></li>';
                     });
                  } else {
                     str = '<li><p>추천친구가 없습니다.</p></li>';
                  }
                  
                  $(".drops-menu").append(str);
                  
               },
               error:function(){
                  alert('에러');
               }
            });
         });
         
         $('.drops-menu').on('click', '.recommendfollow', function() {
            var target = $(this).parents().children('input').attr('value');
            
            $.ajax({
               type:"POST",
               url:"recommendfollow.do",
               data: target,
               contentType:"application/json",
               dataType:'json',
               success:function(msg){
                  $(this).parents('li').remove();
               },
               error:function(){
                  alert('에러');
               }
            });
         });
         
         $('.drops-menu').on('click', '.friendid', function(e) {
            e.stopPropagation();
            var id = $(this).text();
            
            location.href = 'friendmypage.do?content_users_id=' + id;
         });
         
         $('.drops-menu').on('click', '.friendprofile', function(e) {
            e.stopPropagation();
            var id = $(this).siblings('.friendid').text();
            
            location.href = 'friendmypage.do?content_users_id=' + id;
         });
      
      });
      </script>

      <!-- topbar -->

      <script src="resources/js/script.js"></script>
   </header>
</body>
</html>