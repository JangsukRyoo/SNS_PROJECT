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
<meta charset="UTF-8">
<title>Travel Talk</title>
<link rel="stylesheet" href="resources/css/main.css" />
<style type="text/css">
.profile {
   border-radius: 200px;
   position: relative;
   left: 60px;
   width: 150px;
   height: 145px;
}

.myinfo {
   position: relative;
   top: -270px;
   height: 50px;
   width: 250px;
   margin-left: 550px;
}

.follow {
   position: relative;
   margin-left: 400px;
   top: -170px;
}

.userid {
   position: relative;
   padding-left: 250px;
   top: -95px;
}

.profile-comfile {
   border: 2px dashed #ccc;
   border-radius: 5px;
   font-size: 9px;
   position: relative;
   top: 50px;
   margin-left: -80px;
}

.feed_edit {
   border: 2px solid #ccc;
   border-radius: 6px;
   position: relative;
   left: 135px;
   top: 10px;
   background-color: #f3f3f3;
}

.feed_delete {
   border: 2px solid #ccc;
   border-radius: 6px;
   position: relative;
   background-color: #f3f3f3;
   left: 120px;
   top: 10px;
}

.content_substance {
   overflow: hidden;
   white-space: nowrap;
   font-size: 20px;
}

#place_name {
   font-size: 8px;
}

.myimg {
   height: 200px
}

.ctext {
   position: relative;
   height: 50px;
   width: 90%;
   background: #eeeeee;
}

video {
	width : 100%;
	height : 100%;
}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
   <%@include file="./header.jsp"%>
   <script type="text/javascript">
      function imgInfo(img) {
         if (img.naturalWidth > img.naturalHeight) {
            $(img).css("height", "auto").css("min-width", "100%").css(
                  "max-width", "100%");
         } else {
            $(img).css("width", "auto").css("min-height", "100%").css(
                  "max-height", "100%");
         }
         ;
      };
   </script>
   
   <div id="wrapper">
      <!-- Nav -->
      <nav id="nav">
         <a href="#contact" class="fa fa-bookmark" style="color: #050e42"><span>search</span></a>
      </nav>
      <!-- Main -->
      <div id="main">
         <!-- search -->
         <script>
            $(function() {
               $("#keyword").focus();
            });
            function search() {
               $("form")[0].submit();
            }
         </script>
         <article id="contact" class="panel">
            <div class="theme-layout">
               <div class="container">
                  <div class="row" id="page-contents">
                     <div class=" col-lg-12">
                        <div class="blog-sec">
                           <header>
                              <h2>저장 된 모든 게시물</h2>
                              <hr   style="top: 10px;" >
                           </header>
                           
                           <div class="row masonry" id="search">
                              <c:choose>
                                 <c:when test="${empty saveList }">
                                    <p>게시글이 없습니다</p>
                                 </c:when>
                                 <c:otherwise>
                                    <c:forEach items="${saveList }" var="dto" varStatus="status">
                                       <div class="col-lg-4 col-sm-6">
                                          <div class="g-post-classic">
                                          <c:forEach items="${imgList[status.index] }" var="imgList" begin="0" end="0">
                                             <figure>
                                                <div id="img-bg">
                                                   <div id="cover">
                                                      <div id="centered">
                                                         <c:choose>
								<c:when test="${fn:substring(imgList,fn:length(imgList)-3,fn:length(imgList)) eq 'mp4' or fn:substring(imgList,fn:length(imgList)-3,fn:length(imgList)) eq 'avi' or fn:substring(imgList,fn:length(imgList)-3,fn:length(imgList)) eq 'MP4' or fn:substring(imgList,fn:length(imgList)-3,fn:length(imgList)) eq 'AVI' or fn:substring(imgList,fn:length(imgList)-3,fn:length(imgList)) eq 'wmv' or fn:substring(imgList,fn:length(imgList)-3,fn:length(imgList)) eq 'WMV' }">
									<video controls class="post-img" src="resources/images/content/${imgList }" ></video>
								</c:when>
								<c:otherwise>
									<img class="post-img" src="resources/images/content/${imgList }" alt="" onload="javascript:imgInfo(this);">
								</c:otherwise>
							</c:choose>
                                                      </div>
                                                   </div>
                                                </div>
                                             </figure>
                                             </c:forEach>
                                             <div class="g-post-meta" style="margin-top: 30%;">
                                                <div class="post-title">
                                                   <h4>
                                                      <a title="" href="timelinedetail.do?content_no=${dto.save_content_no}&index=${status.index}&button1=likes&button2=comments" rel="modal:open">${dto.save_content_users_id }</a>
                                                   </h4>
                                                   <p>${dto.save_content_substance }</p>

                                                   <span class="p-date">tag : &nbsp; <c:forEach items="${hashList[status.index] }" var="hashlist">
                                                         <span style="color:#37948c">#<a class="hashkeyword" href="#">${hashlist }</a></span>
                                                      </c:forEach>
                                                         <div class="savedelete" style="text-align: -webkit-right;"><a href='savedelete.do?content_no=${dto.save_content_no}'>삭제</a></div>
                                                   </span>
                                                   <script>
                                                   $(document).on("click",".hashkeyword",function() {
                                                       var keyword = $(this).text();
                                                         location.href="hashtagsearch.do?keyword="+keyword;
                                                      });
                                                   </script>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </c:forEach>
                                 </c:otherwise>
                              </c:choose>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </article>
      </div>
   </div>
   <!-- Scripts -->
   <script src="resources/js/script.js"></script>
   <script src="resources/js/breakpoints.min.js"></script>
   <script src="resources/js/main.js"></script>
</body>
</html>