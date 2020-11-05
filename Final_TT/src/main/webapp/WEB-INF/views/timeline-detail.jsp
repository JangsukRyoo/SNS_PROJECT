<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<title>Travel Talk</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="resources/css/main.min.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/color.css">
<link rel="stylesheet" href="resources/css/responsive.css">

<style type="text/css">
/* 최대 크기 지정 */
.modal {
	max-width: 1100px;
	position: relative;
	max-height: 800px;
	margin-top: 50px;
}

.Modal {
	background: #fff none repeat scroll 0 0;
	border-radius: 3px;
	padding: 10px;
}

.friend-info {
	display: inline-block;
	position: relative;
	width: 50%;
	float: left;
	padding: 10px;
	border: 1px solid #9e9e9eba;
	margin-top: 1%;
	margin-bottom: 1%;
	border-radius: 1%;
}

.coment-area {
	display: inline-block;
	margin-top: 1%;
	margin-bottom: 1%;
	width: 50%;
	float: left;
	padding-left: 2%;
}

#substance {
	position: relative;
	height: 50px;
	width: 98%;
	background: #eeeeee;
}

.prev, .next {
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

.next {
	right: 10px;
	border-radius: 3px 0 0 3px;
}

.prev:hover, .next:hover {
	background-color: rgba(0, 0, 0, 0.8);
}

.dot {
	height: 10px;
	width: 10px;
	margin: 0 2px;
	background-color: #bbb;
	border-radius: 50%;
	display: inline-block;
	transition: background-color 0.6s ease;
}

video {
	width: 100%;
	height: 100%;
}
</style>

<script type="text/javascript">
	$(function() {
		$(".bkmark")
				.on(
						"click",
						function() {
							var classname = $(this).children('i').attr('class');
							var bkmark = $(this).children('i');
							var content = $(this).children('input').eq(0).attr(
									'value');
							var index = $(this).children('input').eq(1).attr(
									'value');
							if (classname == 'fa fa-bookmark') {
								$.ajax({
									type : "POST",
									url : "savedeleteajax.do",
									data : content,
									contentType : "application/json",
									dataType : 'json',
									success : function(msg) {
										bkmark
												.attr('class',
														'fa fa-bookmark-o');
										$('.bookmark').eq(index).children('i')
												.attr('class',
														'fa fa-bookmark-o');
									},
									error : function() {
										alert('에러');
									}
								});
							} else if (classname == 'fa fa-bookmark-o') {
								$
										.ajax({
											type : "POST",
											url : "save.do",
											data : content,
											contentType : "application/json",
											dataType : 'json',
											success : function(msg) {
												bkmark.attr('class',
														'fa fa-bookmark');
												$('.bookmark')
														.eq(index)
														.children('i')
														.attr('class',
																'fa fa-bookmark');
											},
											error : function() {
												alert('에러');
											}
										});
							}
						});
	});
</script>

<script type="text/javascript">
	$(function() {

		$(document).on("click", ".close-modal", function() {
			location.reload();
		});

		$(".like_modal")
				.click(
						function() {
							var className = $(this).children('i').attr('class');
							content_no = $(this).children('input').eq(0).attr(
									'value');
							user_id = $(this).children('input').eq(1).attr(
									'value');
							var index = $(this).children('input').eq(2).attr(
									'value');
							var button = $(this).children('input').eq(3).attr(
									'value');
							var LikeVal = {
								"content" : content_no,
								"users" : user_id
							}

							var children = $(this).children('ins');
							var like = $(".like").eq(index).children('i');
							if (className == 'fa fa-heart-o') {
								$(this).children('i').attr('class',
										'fa fa-heart');
								$(".like").eq(index).children('i').attr(
										'class', 'fa fa-heart');
								$.ajax({
									type : "POST",
									url : "like.do",
									data : JSON.stringify(LikeVal),
									contentType : "application/json",
									dataType : 'json',
									success : function(msg) {
										children.html(msg.count);
										if (button == 'like') {
											like.attr('class', 'fa fa-heart');
											$(".like").eq(index)
													.children('ins').html(
															msg.count);
										} else {
											$(".likes").eq(index).children('i')
													.attr('class',
															'fa fa-heart');
											$(".likes").eq(index).children(
													'ins').html(
													msg.count + 'likes');
										};
									},
									error : function() {
										alert('에러');
									}
								});
							} else {
								$(this).children('i').attr('class',
										'fa fa-heart-o');
								$(".like").children('i').attr('class',
										'fa fa-heart-o');
								$.ajax({
									type : "POST",
									url : "dislike.do",
									data : JSON.stringify(LikeVal),
									contentType : "application/json",
									dataType : 'json',
									success : function(msg) {
										children.html(msg.count);
										if (button == 'like') {
											$(".like").eq(index).children('i')
													.attr('class',
															'fa fa-heart-o');
											$(".like").eq(index)
													.children('ins').html(
															msg.count);
										} else {
											$(".likes").eq(index).children('i')
													.attr('class',
															'fa fa-heart-o');
											$(".likes").eq(index).children(
													'ins').html(
													msg.count + 'likes');
										};
									},
									error : function() {
										alert('에러');
									}
								});
							}

						});
		$("#cmbutton")
				.click(
						function() {
							var contentno = $(this).parents().children('input')
									.eq(0).attr('value');
							var userid = $(this).parents().children('input')
									.eq(1).attr('value');
							var substance = $(this).parents().children(
									'textarea').val();
							var index = $(this).parents().children('input').eq(
									2).attr('value');
							var button = $(this).parents().children('input')
									.eq(4).attr('value');
							var commentVal = {
								"substance" : substance,
								"contentno" : contentno,
								"userid" : userid
							};
							var cometarea = $("#we-comet-detail");
							var ins = $("#comment-detail").children('ins');
							if (substance != "") {
								$
										.ajax({
											type : "POST",
											url : "detailComment.do",
											data : JSON.stringify(commentVal),
											contentType : "application/json",
											dataType : 'json',
											success : function(msg) {
												var str = '<li><div class="comet-avatar"><img src="resources/images/profile/'+msg.rdto.re_userprofile+'" alt="" style="width:60px;height:60px"></div>'
														+ '<div class="we-comment" style="border: 1px solid #ede9e9; display: table-cell; margin-left: 20px; padding: 10px; vertical-align: top; position: relative; width: 65%;">'
														+ '<div class="comment-head"><h5><a>'
														+ msg.rdto.userid
														+ '</a>'
														+ '</div><p style="word-break:break-all;">'
														+ msg.rdto.substance
														+ '</p>';

												str += '<span><input type="hidden" value = "'+msg.rdto.re_no+'" /><input type="hidden" value="${dto.content_no}" /><input type="hidden" value="'+ index +'" /><input type="hidden" value="${button2}" /><button type="button" class="deleteButton"  style="width=10%;margin-left:90%;"><i class="fa fa-trash"></i></button></span></div>'
												str += '</div></li>'
												cometarea.append(str);

												$('#substance').val('');
												if (button == 'comment') {
													$(".ccount")
															.eq(index)
															.html(
																	msg.rdto.count);
												} else {
													$(".coments")
															.eq(index)
															.html(
																	'<i class="fa fa-comment-o"></i>'
																			+ msg.rdto.count
																			+ 'comments');
												};
												ins.html(msg.rdto.count);

											},
											error : function(request, status,
													error) {
												alert("code:" + request.status
														+ "\n" + "message:"
														+ request.responseText
														+ "\n" + "error:"
														+ error);
											}
										});
							} else {
								alert("댓글을 입력하세요");
							}
							$("#substance").focus();
						});

		$("#substance")
				.on(
						"keydown",
						function(event) {
							if (event.keyCode == 13) {
								var contentno = $(this).parents().children(
										'input').eq(0).attr('value');
								var userid = $(this).parents()
										.children('input').eq(1).attr('value');
								var substance = $(this).parents().children(
										'textarea').val();
								var index = $(this).parents().children('input')
										.eq(2).attr('value');
								var button = $(this).parents()
										.children('input').eq(4).attr('value');
								var commentVal = {
									"substance" : substance,
									"contentno" : contentno,
									"userid" : userid
								};

								var ins = $("#comment-detail").children('ins');
								if (substance != "") {
									$
											.ajax({
												type : "POST",
												url : "detailComment.do",
												data : JSON
														.stringify(commentVal),
												contentType : "application/json",
												dataType : 'json',
												success : function(msg) {
													var str = '<li><div class="comet-avatar"><img src="resources/images/profile/'+msg.rdto.re_userprofile+'" alt="" style="width:40px;height:40px"></div>'
															+ '<div class="we-comment" style="border: 1px solid #ede9e9; display: table-cell; margin-left: 20px; padding: 10px; vertical-align: top; position: relative; width: 65%;">'
															+ '<div class="comment-head"><h5><a href="time-line.html" title="">'
															+ msg.rdto.userid
															+ '</a>'
															+ '</div><p style="word-break:break-all;">'
															+ msg.rdto.substance
															+ '</p>';

													str += '<span><input type="hidden" value = "'+msg.rdto.re_no+'" /><input type="hidden" value="${dto.content_no}" /><input type="hidden" value="'+ index +'" /><input type="hidden" value="${button2}" /><button type="button" class="deleteButton" style="width:10%;margin-left:90%;"><i class="fa fa-trash"></i></button></span></div>'
													str += '</div></li>'

													$("#we-comet-detail")
															.append(str);

													$('#substance').val('');
													if (button == 'comment') {
														$(".ccount")
																.eq(index)
																.html(
																		msg.rdto.count);
													} else {
														$(".coments")
																.eq(index)
																.html(
																		'<i class="fa fa-comment-o"></i>'
																				+ msg.rdto.count
																				+ 'comments');
													};
													ins.html(msg.rdto.count);

												},
												error : function(request,
														status, error) {
													alert("code:"
															+ request.status
															+ "\n"
															+ "message:"
															+ request.responseText
															+ "\n" + "error:"
															+ error);
												}
											});
								} else {
									alert("댓글을 입력하세요");
								}
							}
						});
		$("#closemd").on('click', function() {
			location.reload(true);
		});
	});
</script>

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
	<div class="Modal">
		<div class="user-post">
			<div class="friend-info">
				<figure>
					<a href="friendmypage.do?content_users_id=${dto.content_users_id }"> <img src="resources/images/profile/${userprofile }" alt="" style="width: 40px; height: 40px; border: 1px solid #f3f3f3;">
					</a>
				</figure>
				<div class="friend-name">
					<ins>
						<a href="friendmypage.do?content_users_id=${dto.content_users_id }" title="">${dto.content_users_id }</a>
					</ins>
					<span><a href="weather.do?content_no=${dto.content_no }&content_place_name=${dto.content_place_name }" rel="modal:open" class="showmore underline">${dto.content_place_name }</a></span>
				</div>
				<div class="post-meta">
					<div class="imageslider">
						<input type="hidden" value="${fn:length(imageList) }" />
						<c:forEach items="${imageList }" var="imageList" varStatus="i">
							<c:choose>
								<c:when test="${i.first }">
									<div id="img-bg" class="img-fade" style="display: block">
										<div id="cover">
											<div id="centered">
												<c:choose>
													<c:when
														test="${fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'mp4' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'avi' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'MP4' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'AVI' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'wmv' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'WMV' }">
														<video controls class="post-img" src="resources/images/content/${imageList }"></video>
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
									<div id="img-bg" class="img-fade " style="display: none">
										<div id="cover">
											<div id="centered">
												<c:choose>
													<c:when
														test="${fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'mp4' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'avi' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'MP4' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'AVI' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'wmv' or fn:substring(imageList,fn:length(imageList)-3,fn:length(imageList)) eq 'WMV' }">
														<video controls class="post-img" src="resources/images/content/${imageList }"></video>
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
						<c:if test="${fn:length(imageList) != 1 }">
							<a class="prev">&#10094;</a>
							<a class="next">&#10095;</a>
						</c:if>
						<script type="text/javascript">
							$(function() {
								var size = $(".imageslider").children('input')
										.attr('value');
								var i = 0;
								$(".dot").eq(i).attr("style",
										"background-color:#717171")
								$(".prev")
										.on(
												'click',
												function() {
													$(".img-fade").eq(i).attr(
															"style",
															"display:none");
													$(".dot")
															.eq(i)
															.attr("style",
																	"background-color:#bbb");
													i = i - 1;
													if (i < 0) {
														i = size - 1;
													}
													$(".img-fade").eq(i).attr(
															"style",
															"display:block");
													$(".dot")
															.eq(i)
															.attr("style",
																	"background-color:#717171");

												});

								$(".next")
										.on(
												'click',
												function() {
													$(".img-fade").eq(i).attr(
															"style",
															"display:none");
													$(".dot")
															.eq(i)
															.attr("style",
																	"background-color:#bbb");
													i = i + 1;
													if (i > size - 1) {
														i = 0;
													}
													$(".img-fade").eq(i).attr(
															"style",
															"display:block");
													$(".dot")
															.eq(i)
															.attr("style",
																	"background-color:#717171");
												});
							});
						</script>
					</div>
					<div class="we-video-info">
						<ul>
							<li><span class="like_modal" data-toggle="tooltip" title="like"> <input type="hidden" name="contentNo" value="${dto.content_no }"> <input type="hidden" name="userID" value="<%=user_id%>" /> <input type="hidden" name="index" value="${index }"> <input type="hidden" name="button1" value="${button1 }" /> <input type="hidden" name="button2" value="${button2 }" /> <c:choose>
										<c:when test="${like.like_liked eq 'like' }">
											<i class="fa fa-heart" style="color: red;"></i>
										</c:when>
										<c:otherwise>
											<i class="fa fa-heart-o" style="color: red;"></i>
										</c:otherwise>
									</c:choose> <ins class="like_count">${dto.content_like_count }</ins>
							</span></li>
							<li><span id="comment-detail" class="comment" data-toggle="tooltip" title="Comments"> <i class="fa fa-comments-o"></i> <ins>${dto.content_comment_count }</ins>
							</span></li>

							<c:if test="${fn:length(imageList) != 1 }">
								<li style="text-align: center; margin-left: 26%;"><c:forEach begin="0" end="${fn:length(imageList)-1 }">
										<span class="dot"></span>
									</c:forEach></li>
							</c:if>

							<li style="position: absolute; right: 0;"><span class="bkmark"> <input type="hidden" value="${dto.content_no }" /> <input type="hidden" name="index" value="${index }"> <c:choose>
										<c:when test="${fn:contains(clist, dto.content_no) }">
											<i class="fa fa-bookmark"></i>
										</c:when>
										<c:otherwise>
											<i class="fa fa-bookmark-o"></i>
										</c:otherwise>
									</c:choose>
							</span></li>
						</ul>
					</div>
					<div class="description">

						<p>${dto.content_substance }</p>
						<a href="#" title="" style="color: #37948c"> ${dto.content_hashtag }</a>
					</div>
				</div>
			</div>
			<div class="coment-area">
				<div style="overflow-y: scroll; height: 610px !important; border: 1px solid #9e9e9eba; border-radius: 1%; padding: 4%;">
					<ul class="we-comet" id="we-comet-detail">
						<c:forEach items="${list }" var="reList">
							<li>
								<div class="comet-avatar">
									<img src="resources/images/profile/${reList.re_userprofile }" alt="" style="width: 40px; height: 40px; border: 1px solid #f3f3f3; position: relative; margin-left: -25%;">
								</div>
								<div class="we-comment" style="border: 1px solid #ede9e9; display: table-cell; margin-left: 20px; padding: 10px; vertical-align: top; position: relative; width: 65%; border-radius: 1%;">
									<div class="coment-head">
										<h5>
											<a href="time-line.html" title="">${reList.userid }</a>
										</h5>
									</div>
									<p style="word-break: break-all;">${reList.substance }</p>
									<c:choose>
										<c:when test="${useridss eq reList.userid }">
											<span> <input type="hidden" value="${reList.re_no }" /> <input type="hidden" value="${dto.content_no}" /> <input type="hidden" value="${index }"> <input type="hidden" value="${button2 }" />
												<button type="button" class="deleteButton" style="width: 10%; margin-left: 90%;">
													<i class="fa fa-trash"></i>
												</button>
											</span>
										</c:when>
									</c:choose>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div style="position: relative; margin-left: -6%; margin-top: 3%;">
					<ul style="list-style: none;">
						<li class="post-comment">
							<div class="comet-avatar">
								<img src="resources/images/profile/${user_profile }" alt="" style="width: 40px; height: 40px; border: 1px solid #f3f3f3;">
							</div>
							<div class="post-comt-box">
								<input type="hidden" name="re_content_no" value=${dto.content_no } /> <input type="hidden" name="re_users_id" value="<%=user_id%>" /> <input type="hidden" name="index" value="${index }"> <input type="hidden" name="button1" value="${button1 }" /> <input type="hidden" name="button2" value="${button2 }" />
								<textarea placeholder="Post your comment" name="re_substance" id="substance"></textarea>
								<button id="cmbutton" style="position: absolute; right: 8%;">
									<i id="send" class="fa fa-send"></i>
								</button>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<script src="resources/js/script.js"></script>
	<script type="text/javascript">
		$(function() {
			var ins = $("#comment-detail").children('ins');

			$(".we-comet")
					.on(
							'click',
							'.deleteButton',
							function() {
								var reno = $(this).parents().children('input')
										.eq(0).attr('value');
								var content_no = $(this).parents().children(
										'input').eq(1).attr('value');
								var index = $(this).parents().children('input')
										.eq(2).attr('value');
								var deVal = {
									"re_no" : reno,
									"contentno" : content_no
								};
								var button = $(this).parents()
										.children('input').eq(3).attr('value');
								var li = $(this).parents('li');
								var ccount = $(".ccount").eq(index);
								var coments = $(".coments").eq(index);
								$
										.ajax({
											type : "POST",
											url : "deleteComment.do",
											data : JSON.stringify(deVal),
											contentType : "application/json",
											dataType : 'json',
											success : function(msg) {
												li.remove();
												ins.html(msg.count);
												if (button == 'comment') {
													ccount.html(msg.count);
												} else {
													coments
															.html('<i class="fa fa-comment-o"></i>'
																	+ msg.count
																	+ 'comments');
												};
											},
											error : function() {
												alert('실패');
											}
										});

							});

		});
	</script>

</body>
</html>