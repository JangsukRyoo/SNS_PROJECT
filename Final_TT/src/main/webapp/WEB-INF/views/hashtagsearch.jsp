<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	width:100%;
	height:100%;
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
			};
		};

		function autoKeyword() {
			var keyword = $("#keyword").val().trim();
			var $div = $("#auto");
			if (keyword != "" && keyword != "#") {
				$.ajax({
					url : "autocomplete.do",
					cache : false,
					type : "post",
					data : keyword,
					dataType : "json",
					contentType : "application/json",
					success : function(msg) {
						var div = $("<div>").attr("id", "auto").css("display",
								"block").css("position", "sticky");
						var ul = $("<ul>");
						for ( var item in msg) {
							if (keyword.indexOf("#") > -1) {
								var a = $("<a>")
										.attr(
												"href",
												"hashtagsearch.do?keyword="
														+ msg[item]).text(
												msg[item]);
								var li = $("<li>").text("#").css("list-style",
										"none");
								li.append(a);
							} else {
								var a = $("<a>").attr(
										"href",
										"friendmypage.do?content_users_id="
												+ msg[item]).text(msg[item]);
								var li = $("<li>").css("list-style", "none");
								li.append(a);
							}

							ul.append(li);
						}
						div.append(ul);
						$div.replaceWith(div);
					},
					error : function() {
					}
				});
			} else {
				$div.css("display", "none");
			}
		}
	</script>
	<div id="wrapper">
		<!-- Nav -->
		<nav id="nav">
			<a href="#contact" class="fa fa-search" style="color: #050e42"><span>search</span></a>
		</nav>
		<!-- Main -->
		<div id="main">
			<!-- search -->
			<script>
				$(function() {
					$("#keyword").focus();
				});
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
									<div id="taginfo">
										<h1>${keyword}</h1>
										<p>게시물 수 ${tagcount}</p>
									</div>
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
                                                            						<img class="post-img" onload="imgInfo(this)" src="resources/images/content/${imageList }">
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
																		<a title="" href="timelinedetail.do?content_no=${dto.content_no}&index=${status.index}&button1=likes&button2=comments" rel="modal:open">${dto.content_users_id }</a>
																	</h4>
																	<p>${dto.content_substance }</p>

																	<p style="color: #37948c">
																		TAG : &nbsp;
																		<c:forEach items="${hashlist_search[status.index] }" var="hashlist">
																			<span style="color: #37948c">#<a class="hashkeyword" href="#">${hashlist }</a></span>
																		</c:forEach>
																	</p>
																	<script>
																		$(
																				document)
																				.on(
																						"click",
																						".hashkeyword",
																						function() {
																							var keyword = $(
																									this)
																									.text();
																							location.href = "hashtagsearch.do?keyword="
																									+ keyword;
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