<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
   request.setCharacterEncoding("UTF-8");
%>
<%
   response.setContentType("text/html; charset=UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Travel Talk</title>
<link rel="icon" href="images/fav.png" type="image/png" sizes="16x16">
<link rel="stylesheet" href="css/style.css" />
<script type="text/javascript"
   src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<style type="text/css">
/* 최대 크기 지정 */
.modal {
   max-width: 400px;
   POSITION: RELATIVE;
   margin: 100px;
}

.Modal {
   background: #fff none repeat scroll 0 0;
   border-radius: 3px;
   padding: 10px;
}

.following {
   border: 1px solid #ccc;
   border-radius: 5px;
   POSITION: RELATIVE;
   left: 150px;
   top: -30px;
}
}
</style>
</head>

<body>
   <div class="Modal">
      <section>
         <div class="container">
            <div align="center">
               <h2>
                  <a class="fa far fa-heart">팔로우</a>
               </h2>
            </div>
            <hr>
         </div>
         <div>
            <c:choose>
               <c:when test="${empty follow }">
                  <ul>
                     <li>팔로잉 중인 친구가 없습니다.</li>
                  </ul>
               </c:when>
               <c:otherwise>
                  <ul>
                     <c:forEach items="${follow }" var="follow">
                        <li style="height: 36px;">
                           <h5>
                              <a
                                 href="friendmypage.do?content_users_id=${follow.follow_target }">${follow.follow_target }</a>
                           </h5> <a class="following"
                           href="following_cancel.do?follow_target=${follow.follow_target }">팔로잉
                              취소</a>
                        </li>
                     </c:forEach>
                  </ul>
               </c:otherwise>
            </c:choose>
         </div>
      </section>
   </div>
   <script src="resources/js/script.js"></script>
</body>
</html>