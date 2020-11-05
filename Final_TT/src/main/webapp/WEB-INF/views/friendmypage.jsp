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
<link rel="stylesheet" href="resources/css/main.css" />
<style type="text/css">
.profile {
   border-radius: 200px;
   position: relative;
   left: 60px;
   width: 150px;
   height: 145px;
}

.follow {
   position: relative;
   padding-left: 390px;
   top: -150px;
}

.follow_cancel {
   position: relative;
   padding-left: 390px;
   top: -150px;
}

.DM {
   position: relative;
   padding-left: 390px;
   top: -140px;
}

.myinfo {
   position: relative;
   top: -220px;
   height: 50px;
   width: 250px;
   margin-left: 550px;
}

.userid {
   position: relative;
   padding-left: 230px;
   top: -95px;
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
		function imgInfo(img) {
			if (img.naturalWidth > img.naturalHeight) {
				$(img).css("height", "auto").css("min-width", "100%").css(
						"max-width", "100%");
			} else {
				$(img).css("width", "auto").css("min-height", "100%").css(
						"max-height", "100%");
			}
		}
	</script>

	<script type="text/javascript">
	$(function(){
		
	$(".likes").click(function() {
		var className = $(this).children('i').attr('class');
		content_no = $(this).children('input').eq(0).attr('value');
		user_id = $(this).children('input').eq(1).attr('value');
		var LikeVal = {
			"content" : content_no,
			"users" : user_id
		}

		var children = $(this).children('ins');

		if (className == 'fa fa-heart-o') {
			$(this).children('i').attr('class', 'fa fa-heart');
			$.ajax({
				type : "POST",
				url : "like.do",
				data : JSON.stringify(LikeVal),
				contentType : "application/json",
				dataType : 'json',
				success : function(msg) {
					children.html(msg.count + "likes");

				},
				error : function() {
					alert('에러');
				}
			});
		} else {
			$(this).children('i').attr('class', 'fa fa-heart-o');
			$.ajax({
				type : "POST",
				url : "dislike.do",
				data : JSON.stringify(LikeVal),
				contentType : "application/json",
				dataType : 'json',
				success : function(msg) {
					children.html(msg.count + "likes");
				},
				error : function() {
					alert('에러');
				}
			});
		}

	});
	})
	</script>
	<script type="text/javascript">
		function imgInfo(img) {
			if (img.naturalWidth > img.naturalHeight) {
				$(img).css("height", "auto").css("min-width", "100%").css(
						"max-width", "100%");
			} else {
				$(img).css("width", "auto").css("min-height", "100%").css(
						"max-height", "100%");
			}
		}
		
		//팔로우,팔로우취소
		var target = "${userinfo.users_id}";   //접속한 프로필 사람 id
		var list = new Array();
		<c:forEach items="${followlist}" var="item">   
		list.push("${item.follow_target}");			//login한 사람의 팔로우한 (target) 목록
		</c:forEach>

		$(function(){
			
			if(list.indexOf(target)==-1){      //팔로우 목록 중에 접속한 프로필유저가 목록에 없으면  
				$(".follow").show(); 			//팔로우 띄움
				
			}else{
				$(".follow_cancel").show();
			}
		});
	</script>

	<!-- Wrapper-->
	<div id="wrapper">
		<!-- Nav -->
		<nav id="nav">
			<a href="#home" class="fa fa-home" style="color: #4a6194"></a>
		</nav>

		<!-- Main -->
		<div id="main">
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
						 					<img class="profile" alt=""
											src="resources/images/profile/${userinfo.users_profile }">

										<div class="userid">
											<h2>${userinfo.users_id }</h2>
										</div>



										<div class="follow" style="display:none">
											<a
												href="followform.do?follow_id=<%=user_id%>&follow_target=${userinfo.users_id }"
												class="fa far fa-heart">팔로우</a>
										</div>

										<div class="follow_cancel" style="display:none">
											<a
												href="following_cancel.do?follow_target=${userinfo.users_id }"
												class="fa far fa-heart">팔로우 취소</a>
										</div> 

										<div class="DM">
											<h6>
												<a class="fa fa-envelope active"
													onclick="location.href='dm.do?dmreceive=${userinfo.users_id}'">&nbsp; 메시지보내기</a>
											</h6>
										</div>
										<div class="myinfo">
											<textarea style="width: 90%; height: 150%; left: -30px; top: 20%; position: relative;" rows="3" cols="3" readonly="readonly">${userinfo.user_info }</textarea>
										</div>
										<hr>
									</div>

									<h6>
										<a class="fa fa-picture-o" style="color: #355396">photo</a>
									</h6>
									<div class="row masonry">

										<c:choose>
											<c:when test="${empty dto }">
												<tr>
													<td colspan="4" align="center"></td>
												</tr>
											</c:when>
											<c:otherwise>
											<c:set var="count" value="0" />
												<c:forEach items="${dto  }" var="dto" varStatus="status">
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
                                                            						<img class="myimg post-img" onload="imgInfo(this)" src="resources/images/content/${imageList }">
																				</c:otherwise>
																			</c:choose>
                                                         						</div>
                                                      </div>
                                                      </div>
                                                </figure>
                                                </c:forEach>
																<div class="g-post-meta" style="margin-top:30%;">
																	<div class="post-title">

																		<a id="place_name"
																			href="weather.do?content_no=${dto.content_no }"
																			rel="modal:open" title="" class="showmore underline">${dto.content_place_name }</a>

																		<a
																			href="timelinedetail.do?content_no=${dto.content_no }&index=${status.index}&button1=likes&button2=comments"
																			rel="modal:open" title="" class="showmore underline">
																			<p class="content_substance">${dto.content_substance }</p>
																			<p style="color:#37948c">${dto.content_hashtag }</p>
																		</a> 
																		<span class="p-date">
																			<p class="sub"></p>
																		</span>
																	</div>
																	<div class="g-post-ranking">
																		<a title="" href="#" class="likes"> <input type="hidden" name="contentNo" value="${dto.content_no }">
																		<input type="hidden" name="userID" value="<%=user_id%>" />
																		<c:choose>
																				<c:when test="${likeDto[status.index].like_liked eq 'like' }">
																					<i class="fa fa-heart"></i>
																				</c:when>
																				<c:otherwise>
																					<i class="fa fa-heart-o"></i>
																				</c:otherwise>
																			</c:choose> <ins style="text-decoration: none;">${dto.content_like_count } likes</ins>
																		</a> <a title="" href="#" class="coments"> <i class="fa fa-comment-o"></i>${dto.content_comment_count } comments
																		</a>
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
							</div>
						</div>
					</div>
				</div>
			</article>

		</div>


	</div>

	<!-- Scripts -->
	<script src="resources/js/script.js"></script>

	<script src="resources/js/jquery.min.js"></script>
	<script src="resources/js/breakpoints.min.js"></script>
	<script src="resources/js/main.js"></script>
</body>
</html>