<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
   request.setCharacterEncoding("UTF-8");
%>
<%
   response.setContentType("text/html; charset=UTF-8");
%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<title>Travel Talk</title>
<link rel="stylesheet" href="resources/css/main.css" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
   padding-left: 230px;
   top: -95px;
}

.profile-comfile {
   border: 2px dashed #ccc;
   border-radius: 5px;
   font-size: 9px;
   position: relative;
   top: 65px;
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

.prevs, .nexts {
   cursor: pointer;
   position: absolute;
   top: 45%;
   width: auto;
   padding: 16px;
   margin-top: -22px;
   color: white !important;
   font-weight: bold;
   font-size: 18px;
   transition: 0.6s ease;
   border-radius: 0 3px 3px 0;
}

.nexts {
   right: 1px;
   border-radius: 3px 0 0 3px;
}

.prevs:hover, .nexts:hover {
   background-color: rgba(0, 0, 0, 0.8);
}

.dots {
   height: 10px;
   width: 10px;
   margin: 0 2px;
   background-color: #bbb;
   border-radius: 50%;
   display: inline-block;
   transition: background-color 0.6s ease;
}

#keyword {
   width: 90%;
   line-height: 1.35em;
   -webkit-appearance: none;
   border: 0;
   background: #f4f4f4;
   padding: 0.75em;
   transition: background-color .5s ease-in-out;
}

#search_btn {
   border: medium none;
   color: #fff;
   font-size: 13px;
   font-weight: 600;
   padding: 3px 10px;
   position: absolute;
   width: 10%;
   height: 45px;
   background: #37948c;
}

video {
   width : 100%;
   height : 100%;
}
</style>

</head>
<body>
   <%@include file="./header.jsp"%>
   <script type="text/javascript">
$(function(){
   var p = $("<p>").css("color","#37948c").css("text-align","center").css("font-size","large").text("게시글을 모두 확인하셨습니다.");
   $(".loadMore").append(p);
   var origin = $("#main").height();
   var current;
   if(origin > 3000){
      $("#main").height(3000);
   }else{
      $("#main").height('100%');
   }
   $(window).scroll(function(){
      if($(".fa-camera-retro").hasClass("active")||$(".fa-search").hasClass("active")){
         scroll_top = $(window).scrollTop();
         current = $("#main").height();
         console.log(current - scroll_top);
         if(current < origin){
            if(current - scroll_top <= 856){
               $("#main").height($("#main").height()+500);
            }
         }
      }
         
   });
   
});
</script>
   
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
      
    //게시물 삭제할꺼니?

      function boarddelete(content_no){
            swal({
                title: "정말로 삭제하시겠습니까?",
                text: "*삭제 시 복구 불가*",
                icon: "warning",
                buttons: true,
                dangerMode: true,
              })
              .then((willDelete) => {
                if (willDelete) {
                  swal("삭제 완료", {
                    icon: "success",
                    
                  }).then((result) =>{
                     location.href="delete.do?content_no="+content_no;
                  });
                } else {
                  swal("삭제 처리 취소");
                }
              });
            
         }
   </script>
   
   <script type="text/javascript">
                                          $(function() {
                                             var contentsize = $(".imageslide").eq(0).children('input').eq(2).attr('value');
                                             
                                             var imageindex = new Array();
                                             
                                             if(contentsize != 1) {
                                             for(var j = 0; j <= contentsize-1; j++) {
                                                imageindex[j] = 0;
                                             };
                                             } else {
                                                imageindex[0] = 0;
                                             };
                                             
                                             
                                             $(".prevs").on('click', function() {
                                                var idx = $(this).siblings('.imageslide').children('input').eq(1).attr('value');
                                                var imagesize = $(".imageslide").eq(idx).children('input').eq(0).attr('value');
                                                var i = imageindex[idx];
                                                $(".imageslide").eq(idx).children('.fade-img').eq(i).attr('style','display:none');
                                                $(".we-video-info").eq(idx).children().children('li').eq(4).children('.dots').eq(i).attr('style', 'background-color:#bbb');
                                                i = i-1;
                                                if(i < 0) {
                                                   i = imagesize-1;
                                                }
                                                imageindex[idx] = i;
                                                $(".imageslide").eq(idx).children('.fade-img').eq(i).attr('style','display:block');
                                                var dots = $(".we-video-info").eq(idx).children().children('li').eq(4).children('.dots').eq(i);
                                                dots.attr('style', 'background-color:#717171');
                                             });
                                             
                                             $(".nexts").on('click', function() {
                                                var idx = $(this).siblings('.imageslide').children('input').eq(1).attr('value');
                                                var imagesize = $(".imageslide").eq(idx).children('input').eq(0).attr('value');
                                                var i = imageindex[idx];
                                                $(".imageslide").eq(idx).children('.fade-img').eq(i).attr('style','display:none');
                                                $(".we-video-info").eq(idx).children().children('li').eq(4).children('.dots').eq(i).attr('style', 'background-color:#bbb');
                                                i = i+1;
                                                if(i > imagesize-1) {
                                                   i = 0;
                                                }
                                                imageindex[idx] = i;
                                                $(".imageslide").eq(idx).children('.fade-img').eq(i).attr('style','display:block');
                                                var dots = $(".we-video-info").eq(idx).children().children('li').eq(4).children('.dots').eq(i);
                                                dots.attr('style','background-color:#717171');
                                             });

                                          });
                                          
                                          
                                       </script>
   <script type="text/javascript">
      $(document).on('click','.bookmark',function() {
         var content = $(this).parents().children('input').attr('value');
         var itag = $(this).children('i');
         if($(this).children('i').attr('class') == 'fa fa-bookmark-o') {
            $.ajax({
               type:"POST",
               url:"save.do",
               data: content,
               contentType:"application/json",
               dataType:'json',
               success:function(msg){
                        itag.attr('class','fa fa-bookmark')
                     },
               error:function(){
                        alert('에러');
               }
            });
         } else {
            $.ajax({
               type:"POST",
               url:"savedeleteajax.do",
               data: content,
               contentType:"application/json",
               dataType:'json',
               success:function(msg){
                        itag.attr('class','fa fa-bookmark-o')
                     },
               error:function(){
                        alert('에러');
               }
            });
         }
      });
   </script>
   <script type="text/javascript">

   $(function() {
         $(".like").click(function() {
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
                     children.html(msg.count);
                     
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
                     children.html(msg.count);
                  },
                  error:function(){
                     alert('에러');
                  }
               });
            }
            
         });
         
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
         
         $(".homecmbutton").click(function() {
            var contentno = $(this).parents().children('input').eq(0).attr('value');
            var userid = $(this).parents().children('input').eq(1).attr('value');
            var substance = $(this).parents().children('textarea').val();
            
            var commentVal = {
                  "substance":substance,
                  "contentno":contentno,
                  "userid":userid
            };
            
            var index  = $(".homecmbutton").index(this);
            var ins = $(".ccount").eq(index);
            var textarea = $(".ctext").eq(index);
            if(substance != ""){
            $.ajax({
               type:"POST",
               url:"comment.do",
               data:JSON.stringify(commentVal),
               contentType:"application/json",
               success:function(msg){
                  ins.html(msg.count);
                  $("")
                  textarea.val('');
                  location.href();
               },
               error:function(request,status,error){
                    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                   }
            });
            } else {
               alert("댓글을 입력하세요");
            }
            location.reload();
         });
         $(".ctext").on("keydown", function(event) {
            if(event.keyCode == 13) {
               var contentno = $(this).parents().children('input').eq(0).attr('value');
               var userid = $(this).parents().children('input').eq(1).attr('value');
               var substance = $(this).parents().children('textarea').val();
               
               var commentVal = {
                     "substance":substance,
                     "contentno":contentno,
                     "userid":userid
               };
               
               var index  = $(".homecmbutton").index(this);
               var ins = $(".ccount").eq(index);
               var textarea = $(".ctext").eq(index);
               if(substance != ""){
               $.ajax({
                  type:"POST",
                  url:"comment.do",
                  data:JSON.stringify(commentVal),
                  contentType:"application/json",
                  success:function(msg){
                     ins.html(msg.count);
                     $("")
                     textarea.val('');
                     location.href();
                  },
                  error:function(request,status,error){
                       alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                      }
               });
               } else {
                  alert("댓글을 입력하세요");
               }
               location.reload();
            };
         });
         
         $("nav>a").click(function() {
            location.reload(true);
         });
         
         
      });
   
   
   </script>


   <!-- Wrapper-->
   <div id="wrapper">
      <!-- Nav -->
      <nav id="nav">
         <a href="#work" class="fa fa-camera-retro" style="color: #050e42" id="button_timeline"><span>timeline</span></a> <a href="#contact" class="fa fa-search" style="color: #050e42"><span>search</span></a> <a href="#home" class="fa fa-home" style="color: #050e42" id="button_home"><span>my</span></a>
      </nav>

      <!-- Main -->
      <div id="main">
         <!-- timeline -->
         <article id="work" class="panel">
            <section>
               <div class="loadMore">
                  <c:choose>
                     <c:when test="${empty contentList }">
                        <tr>
                           <td colspan="4" align="center">게시글 없음</td>
                        </tr>
                     </c:when>
                     <c:otherwise>
                        <c:forEach items="${contentList  }" var="dto" varStatus="status">
                           <div class="central-meta item">
                              <div class="user-post">
                                 <div class="friend-info">
                                    <figure>
                                       <a href="friendmypage.do?content_users_id=${dto.content_users_id }"> <img src="resources/images/profile/${profilelist[status.index] }" alt="" style="width: 60px; height: 60px; border: 0.5px solid #04453fbd;">
                                       </a>
                                    </figure>
                                    <div class="friend-name">
                                       <ins>
                                          <a href="friendmypage.do?content_users_id=${dto.content_users_id }">${dto.content_users_id }</a>
                                       </ins>
                                       <ul>
                                          <li><a href="weather.do?content_no=${dto.content_no }&content_place_name=${dto.content_place_name }" rel="modal:open" class="showmore underline" onclick="modalopen(${dto.content_no});">${dto.content_place_name } </a></li>
                                       </ul>
                                    </div>
                                    <div class="post-meta">
                                       <div class="imageslide">
                                          <input type="hidden" value="${fn:length(imageList[status.index]) }" /> <input type="hidden" value="${status.index }" /> <input type="hidden" value="${fn:length(contentList) }" />
                                          <c:forEach items="${imageList[status.index] }" var="imageList" varStatus="i">
                                             <c:choose>
                                                <c:when test="${i.first }">
                                                   <div id="img-bg" class="fade-img" style="display: block">
                                                      <div id="cover">
                                                         <div id="centered">
                                                            <c:choose>
                                                               <c:when test="${fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'mp4' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'avi' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'MP4' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'AVI' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'wmv' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'WMV' }">
                                                                  <video controls class="post-img" src="resources/images/content/${imageList }" onload="javascript:imgInfo(this);" ></video>
                                                               </c:when>
                                                               <c:otherwise>
                                                                  <img class="post-img" src="resources/images/content/${imageList }" alt="" onload="javascript:imgInfo(this);">
                                                               </c:otherwise>
                                                            </c:choose>
                                                         </div>
                                                      </div>
                                                   </div>
                                                </c:when>
                                                <c:otherwise>
                                                   <div id="img-bg" class="fade-img" style="display: none">
                                                      <div id="cover">
                                                         <div id="centered">
                                                            <c:choose>
                                                               <c:when test="${fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'mp4' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'avi' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'MP4' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'AVI' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'wmv' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'WMV' }">
                                                                  <video controls class="post-img" src="resources/images/content/${imageList }" onload="javascript:imgInfo(this);" ></video>
                                                               </c:when>
                                                               <c:otherwise>
                                                                  <img class="post-img" src="resources/images/content/${imageList }" alt="" onload="javascript:imgInfo(this);">
                                                               </c:otherwise>
                                                            </c:choose>
                                                         </div>
                                                      </div>
                                                   </div>
                                                </c:otherwise>
                                             </c:choose>
                                          </c:forEach>
                                       </div>
                                       <c:if test="${fn:length(imageList[status.index]) != 1 }">
                                          <a class="prevs">&#10094;</a>
                                          <a class="nexts">&#10095;</a>
                                       </c:if>

                                       <div class="we-video-info">
                                          <ul>
                                             <li><span class="like" data-toggle="tooltip" title="like"> <input type="hidden" name="contentNo" value="${dto.content_no }"> <input type="hidden" name="userID" value="<%=user_id%>" /> <c:choose>
                                                      <c:when test="${likeDto_home[status.index].like_liked eq 'like' }">
                                                         <i class="fa fa-heart" style="color: red;"></i>
                                                      </c:when>
                                                      <c:otherwise>
                                                         <i class="fa fa-heart-o" style="color: red;"></i>
                                                      </c:otherwise>
                                                   </c:choose> <ins class="like_count">${dto.content_like_count }</ins>
                                             </span></li>
                                             <li><span class="comment" data-toggle="tooltip" title="Comments"> <i class="fa fa-comments-o"></i> <ins class="ccount">${dto.content_comment_count }</ins>
                                             </span></li>
                                             <li><span class="fa fa-paper-plane" onclick="location.href='dm.do?dmreceive=${dto.content_users_id }'"  style="top: 30%; position: absolute;"></span></li>
                                             <li><input type="hidden" value="${dto.content_no }"> <span class="bookmark" style="top: 30%; position: absolute; font-size: 25px; padding-left: 630px;"> <c:choose>
                                                      <c:when test="${fn:contains(clist, dto.content_no) }">
                                                         <i class="fa fa-bookmark"></i>
                                                      </c:when>
                                                      <c:otherwise>
                                                         <i class="fa fa-bookmark-o"></i>
                                                      </c:otherwise>
                                                   </c:choose>
                                             </span></li>
                                             <li style="margin-left: 28%;"><c:if test="${fn:length(imageList[status.index]) != 1 }">
                                                   <c:forEach begin="0" end="${fn:length(imageList[status.index])-1 }" varStatus="k">
                                                      <c:choose>
                                                         <c:when test="${k.first}">
                                                            <span class="dots" style="background-color: #717171"></span>
                                                         </c:when>
                                                         <c:otherwise>
                                                            <span class="dots"></span>
                                                         </c:otherwise>
                                                      </c:choose>
                                                   </c:forEach>
                                                </c:if></li>
                                          </ul>
                                       </div>
                                       <div class="description">
                                          <p>${dto.content_substance }</p>
                                       </div>
                                       <div class="description">
                                          <c:forEach items="${hashlist[status.index] }" var="hashlist" varStatus="i">
                                             <span class="hashtags" style="color: #37948c">#<a class="hashkeyword" href="#">${hashlist }</a></span>
                                          </c:forEach>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="coment-area">
                                    <ul class="we-comet">
                                       <c:forEach items="${commentlist[status.index] }" var='commentlist' begin="0" end="1">
                                          <li>
                                             <div class="comet-avatar">
                                                <img src="resources/images/profile/${commentlist.re_userprofile }" alt="" style="width: 40px; height: 40px; border: 1px solid #06696082;">
                                             </div>
                                             <div class="we-comment" style="display: table-cell;">
                                                <div class="coment-head">
                                                   <h5>
                                                      <a href="time-line.html" title="">${commentlist.userid }</a>
                                                   </h5>
                                                   <p style="word-break: break-all; position: relative; height: 0px;">${commentlist.substance }</p>
                                                </div>
                                             </div>
                                          </li>
                                       </c:forEach>

                                       <li class="post-comment">
                                          <div class="comet-avatar">
                                             <img src="resources/images/profile/${user_profile}" alt="" style="width: 40px; height: 40px; border: 1px solid #06696082; position: relative; margin-top: 10%;">
                                          </div>
                                          <div class="post-comt-box">
                                             <input type="hidden" name="contentno" value=${dto.content_no } /> <input type="hidden" name="userid" value="<%=user_id%>" />
                                             <textarea placeholder="Post your comment" name="substance" class="ctext"></textarea>
                                             <button class="homecmbutton">
                                                <i id="send" class="fa fa-send"></i>
                                             </button>
                                          </div>
                                       </li>
                                       <li><a href="timelinedetail.do?content_no=${dto.content_no}&index=${status.index}&button1=like&button2=comment" rel="modal:open" title="" class="showmore underline">게시물 및 댓글 더보기</a></li>
                                    </ul>
                                    <!-- centerl meta -->
                                 </div>
                              </div>
                           </div>
                        </c:forEach>
                     </c:otherwise>
                  </c:choose>
               </div>
            </section>
         </article>

         <script type="text/javascript">
         $(document).on("click",".hashkeyword",function() {
             var keyword = $(this).text();
               location.href="hashtagsearch.do?keyword="+keyword;
            });
         function autoKeyword(){
           var keyword = $("#keyword").val().trim();
           var $div = $("#auto");
           if(keyword!="" && keyword!="#"){
           $.ajax({
              url : "autocomplete.do",
              cache : false,
              type : "post",
              data : keyword,
              dataType : "json",
              contentType : "application/json",
              success: function(msg){
                       var div = $("<div>").attr("id","auto").css("display","block").css("position","sticky");
                       var ul = $("<ul>");
                       for(var item in msg){
                          if(keyword.indexOf("#")> -1){
                             //해시태그 검색일 때
                             var a = $("<a>").attr("href","hashtagsearch.do?keyword="+msg[item]).text(msg[item]);
                             var li = $("<li>").text("#").css("list-style","none");
                             li.append(a);
                          }else{
                             //아이디 검색일 때
                             var a = $("<a>").attr("href","friendmypage.do?content_users_id="+msg[item]).text(msg[item]);
                             var li = $("<li>").css("list-style","none");
                             li.append(a);
                          }
                          
                          ul.append(li);
                       }
                       div.append(ul);
                       $div.replaceWith(div);
              },
              error:function(){}
           });
           }else{
              $div.css("display","none");
           }
        };
        function search(){
           var keyword = $("#keyword").val();
           if(keyword.indexOf("#")>-1){
              keyword = keyword.replace(/#/gi,"");
              location.href="hashtagsearch.do?keyword="+keyword;
           }else{
              location.href="search.do?keyword="+keyword;
           }
        }
         </script>
         <article id="contact" class="panel">
            <div class="theme-layout">
               <div class="container">
                  <div class="row" id="page-contents">
                     <div class=" col-lg-12">
                        <div class="blog-sec">
                           <div id="searchbar" class="post-filter-sec">
                              <input type="text" id="keyword" onkeyup="javascript:autoKeyword();" onkeydown="javascript:if(event.keyCode==13)search();" autocomplete="off" placeholder="#은 태그 검색">
                              <button id="search_btn" onclick="search();">
                                 <i class="ti-search"></i>
                              </button>
                              <div id="auto" style="display: none"></div>
                           </div>
                           <div class="row masonry" id="search">
                              <c:choose>
                                 <c:when test="${empty allList }">
                                    <p>게시글이 없습니다</p>
                                 </c:when>
                                 <c:otherwise>
                                    <c:forEach items="${allList }" var="dto" varStatus="status">
                                       <div class="col-lg-4 col-sm-6">
                                          <div class="g-post-classic">
                                             <c:forEach items="${imagesearchList[status.index] }" var="imagesearchList" begin="0" end="0">
                                                <figure>
                                                   <div id="img-bg">
                                                      <div id="cover">
                                                         <div id="centered">
                                                            <c:choose>
                                                               <c:when test="${fn:substring(imagesearchList,fn:length(imagesearchList)-3,fn:length(imagesearchList)) eq 'mp4' or fn:substring(imagesearchList,fn:length(imagesearchList)-3,fn:length(imagesearchList)) eq 'avi' or fn:substring(imagesearchList,fn:length(imagesearchList)-3,fn:length(imagesearchList)) eq 'MP4' or fn:substring(imagesearchList,fn:length(imagesearchList)-3,fn:length(imagesearchList)) eq 'AVI' or fn:substring(imagesearchList,fn:length(imagesearchList)-3,fn:length(imagesearchList)) eq 'wmv' or fn:substring(imagesearchList,fn:length(imagesearchList)-3,fn:length(imagesearchList)) eq 'WMV' }">
                                                                  <video controls class="post-img" src="resources/images/content/${imagesearchList }" ></video>
                                                               </c:when>
                                                               <c:otherwise>
                                                                  <img class="post-img" src="resources/images/content/${imagesearchList }" alt="" onload="javascript:imgInfo(this);">
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
                                                      <a style="text-transform:none;" title="" href="timelinedetail.do?content_no=${dto.content_no}&index=${status.index}&button1=likes&button2=comments" rel="modal:open">${dto.content_users_id }</a>
                                                   </h4>
                                                   <p>${dto.content_substance }</p>

                                                   <p style="color: #37948c">
                                                      TAG :
                                                      <c:forEach items="${hashlist_search[status.index] }" var="hashlist">
                                                         <span style="color: #37948c">#<a href="#" class="hashkeyword">${hashlist }</a></span>
                                                      </c:forEach>
                                                   </p>

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

         <!-- home -->
         <article id="home" class="panel">
            <div class="theme-layout">
               <div class="container">
                  <h6>
                     <a class="fa fa-user" style="color: #355396">profile</a>
                  </h6>
                  <div class="row" id="page-contents">
                     <div class=" col-lg-12">
                        <div class="blog-sec">
                           <div class="post-filter-sec2">
                              <img class="profile" style="border: 1px solid #9e9e9e6e;" src="resources/images/profile/${userinfo.users_profile }">
                              <div class="userid">
                                 <h2><%=user_id%></h2>
                              </div>
                              <div class="follow">
                                 <a class="profile-comfile" href="profilecomfile.do" rel="modal:open" class="showmore underline">프로필 편집</a>
                                 <h6>
                                    <a class="fa fa-heart-o " href="follower.do?follow_target=<%=user_id%>" rel="modal:open" class="showmore underline">&nbsp; 팔로워</a>
                                 </h6>
                                 <h6>
                                    <a class="fa far fa-heart" href="follow.do?follow_id=<%=user_id%>" rel="modal:open" class="showmore underline">&nbsp; 팔로잉</a>
                                 </h6>
                                 <h6>
                                    <a class="fa fa-plus" href="insertfeed.do" rel="modal:open" class="showmore underline">&nbsp; 게시물추가</a>
                                 </h6>
                              </div>
                              <div class="myinfo">
                                 <textarea rows="3" cols="3" readonly="readonly" style="width: 90%; height: 150%; left: -30px; top: 20%; position: relative;">${userinfo.user_info }</textarea>
                              </div>
                              <hr>
                           </div>
                           <h6>
                              <a class="fa fa-picture-o" style="color: #355396">photo</a>
                           </h6>
                           <div class="row masonry">
                              <c:choose>
                                 <c:when test="${empty mylist2 }">
                                    <tr>
                                       <td colspan="4" align="center"></td>
                                    </tr>
                                 </c:when>
                                 <c:otherwise>
                                    <c:set var="count" value="0" />
                                    <c:forEach items="${mylist2  }" var="dto" varStatus="status">
                                       <div class="col-lg-4 col-sm-6">
                                          <div class="g-post-classic">
                                             <c:forEach items="${imagemyList[status.index] }" var="imagemyList" begin="0" end="0">
                                                <figure>
                                                   <div id="img-bg">
                                                      <div id="cover">
                                                         <div id="centered">
                                                         <c:choose>
                                                               <c:when test="${fn:substring(imagemyList,fn:length(imagemyList)-3,fn:length(imagemyList)) eq 'mp4' or fn:substring(imagemyList,fn:length(imagemyList)-3,fn:length(imagemyList)) eq 'avi' or fn:substring(imagemyList,fn:length(imagemyList)-3,fn:length(imagemyList)) eq 'MP4' or fn:substring(imagemyList,fn:length(imagemyList)-3,fn:length(imagemyList)) eq 'AVI' or fn:substring(imagemyList,fn:length(imagemyList)-3,fn:length(imagemyList)) eq 'wmv' or fn:substring(imagemyList,fn:length(imagemyList)-3,fn:length(imagemyList)) eq 'WMV' }">
                                                                  <video controls class="post-img" src="resources/images/content/${imagemyList }" ></video>
                                                               </c:when>
                                                               <c:otherwise>
                                                                  <img class="myimg post-img" alt="" onload="imgInfo(this);" src="resources/images/content/${imagemyList }">
                                                               </c:otherwise>
                                                            </c:choose>
                                                         </div>
                                                      </div>
                                                   </div>
                                                </figure>
                                             </c:forEach>
                                             <div class="g-post-meta" style="margin-top: 30%;">
                                                <div class="post-title">
                                                   <a id="place_name" href="weather.do?content_no=${dto.content_no }&content_place_name=${dto.content_place_name }" rel="modal:open" title="" class="showmore underline">${dto.content_place_name }</a>
                                                   <p class="content_substance">
                                                      <a href="timelinedetail.do?content_no=${dto.content_no}&index=${status.index}&button1=likes&button2=comments" rel="modal:open" title="" class="showmore underline"> ${dto.content_substance }</a>
                                                   </p>
                                                   <c:forEach items="${hashlist_my[status.index] }" var="hashlist">
                                                      <span style="color: #37948c">#<a href="#" class="hashkeyword">${hashlist }</a></span>
                                                   </c:forEach>
                                                   <p class="p-date">
                                                      <span class="sub"></span>
                                                   </p>
                                                </div>
                                                <div class="g-post-ranking">
                                                   <a title="" href="#" class="likes"> <input type="hidden" name="contentNo" value="${dto.content_no }"> <input type="hidden" name="userID" value="<%=user_id%>" /> <c:choose>
                                                         <c:when test="${likeDto[status.index].like_liked eq 'like' }">
                                                            <i class="fa fa-heart"></i>
                                                         </c:when>
                                                         <c:otherwise>
                                                            <i class="fa fa-heart-o"></i>
                                                         </c:otherwise>
                                                      </c:choose> <ins style="text-decoration: none;">${dto.content_like_count } likes</ins>
                                                   </a> <a title="" href="timelinedetail.do?content_no=${dto.content_no}&index=${status.index}&button1=likes&button2=comments" rel="modal:open" class="coments"> <i class="fa fa-comment-o"></i>${dto.content_comment_count } comments
                                                   </a> <a class="feed_edit" href="editfeed.do?content_no=${dto.content_no }" rel="modal:open" class="showmore underline"> 수정</a> 
                                                   <a class="feed_delete"><input type="button" value="삭제" onclick="boarddelete(${dto.content_no});"></a>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
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