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
   left: 130px;
}
</style>
</head>

<body>
   <div class="Modal">
      <section>
         <div class="container">
            <div align="center">
               <h2>
                  <a class="fa far fa-heart">팔로워</a>
               </h2>
            </div>
            <hr>
         </div>
         <div>
            <c:choose>
               <c:when test="${empty follower }">
                  <ul>
                     <li>나를 팔로잉 중인 친구가 없습니다.</li>
                  </ul>
               </c:when>
               <c:otherwise>
                  <ul>
                     <c:forEach items="${follower }" var="follower">
                        <li>
                           <h5>
                              <a
                                 href="friendmypage.do?content_users_id=${follower.follow_id }">${follower.follow_id }</a>
                           </h5>
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