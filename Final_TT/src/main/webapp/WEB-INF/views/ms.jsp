<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
<link rel="stylesheet" href="resources/css/main.css" />
<script src="http://localhost:82/socket.io/socket.io.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script defer src="http://localhost:3333/socket.io/socket.io.js"></script>
<script defer src="script.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">
#receiver_dm {
	text-transform: none;
}

.btn-div {
	position: absolute;
	width: 70px;
	bottom: 57px;
	left: 60px;
	top: 60px;
	height: 25px;
	font-size: 13px;
	box-shadow: 2px 2px 3px 0px;
	bottom: 57px;
	left: 60px;
	top: 60px;
	height: 25px;
	font-size: 13px;
	left: 60px;
	top: 60px;
	height: 25px;
	font-size: 13px;
}

.chat-ul-div {
	float: left;
	overflow-y: scroll;
	height: 450px;
	top: 20px;
	position: relative;
	border-radius: 10px 0 0 10px;
	background: #f9fbff3b;
	top: 20px;
}

.chatViewBtn {
	width: 100%;
	height: 100%;
	background-color: #37948c !important;
	color: #f2f2f2 !important;
}

button>i {
	position: absolute;
	left: 7px;
	top: 10px;
}

.chatlist {
	height: 485px;
	overflow: scroll;
}

.createChatBtn {
	background-color: #37948c;
	color: white;
	width: 100px;
	top: 30px;
	left: -40px;
	position: relative;
	height: 30px;
	border-radius: 5px;
	font-size: 13px;
}

.createChatBtn-div {
	position: relative;
	display: inline-block;
	float: right;
	right: 40px;
	bottom: 5px;
	border-radius: 5px;
}

#msgbox_open ul {
	
}

.Allopen_chat_list {
	background: white;
	color: #0e5f57;
	font-weight: bold;
	font-size: 20px;
	width: 300px;
	border-radius: 10px 10px 0 0;
	top: 100px;
	position: relative;
	text-align: center;
}
</style>
<script type="text/javascript">
	$(window).bind("beforeunload", function(e) {
		var live = $("#livehidden").attr('value');
		$.ajax({
			type : "POST",
			url : "livestop.do",
			data : live,
			contentType : "application/json",
			dataType : 'json',

		});
	});
</script>

</head>
<body>
	<%@include file="./header.jsp"%>
	<%@ page import="com.tt.sns.model.dto.OpenchatDto"%>



	<!-- Wrapper-->
	<div id="wrapper">

		<!-- Nav -->
		<nav id="nav">
			<a href="#work" class="fa fa-envelope"><span>Message</span></a> <a href="#contact" class="fa fa-comment"><span>Chat</span></a> <a href="#home" class="fa fa-video-camera" style="color: #05534c" id="button_home"><span>Live</span></a>
		</nav>
	
		<!-- Main -->
		<div id="main" style="background: linear-gradient(to bottom left, #79C7C5 40%, #F9FBFF 100%);">

			<!-- 디엠 -->
			<article id="work" class="panel">
				<section>
					<div class="loadMore">
						<div class="central-meta item" style="background: none; border: none; padding: 0; padding-left: 50px;">
							<div class="col-lg-6">
								<div class="central-meta" style="background: none; border: none; padding: 0; margin-bottom: 15px; margin-top: -50px;">
									<div class="messages">
										<h5 class="f-title" style="top: 100px; left: 30px;">
											<i class="ti-bell"></i>All Messages <span class="more-options"><i class="fa fa-ellipsis-h"></i></span>
										</h5>
										<div class="message-box">
											<div class="chat-ul-div">
												<ul class="peoples dmchat" style="top: 60px; padding: 10px;">
													<c:choose>
														<c:when test="${empty dmlist }">
															<li>
																<div class="people-name">
																	<span>채팅 목록이 없습니다.</span>
																</div>
															</li>
														</c:when>
														<c:otherwise>
															<c:forEach items="${dmlist }" var="dmlist" varStatus="status">
																<li>
																	<figure>
																		<img style="width: 40px !important; height: 40px !important; max-width: none;" src="resources/images/profile/${dmprofilelist[status.index] }" alt="">
																		<span class="status f-online"></span>
																	</figure>
																	<div class="people-name">
																		<span style="text-transform: none; margin-left: 10px;">${dmlist.dm_receiver }</span> <input type="hidden" value="${dmlist.dm_receiver }"> <input type="hidden" value="<%=user_id%>"> <input type="hidden" value="${dmlist.dm_no }"> <input type="hidden" value="${dmprofilelist[status.index] }">
																	</div>
																</li>
															</c:forEach>
														</c:otherwise>
													</c:choose>
												</ul>
											</div>
											<div id="msgbox_dm" class="peoples-mesg-box" style="padding: unset;">
												<%@include file="./dm.jsp"%>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</article>
			<script type="text/javascript">
				$(document)
						.on(
								"click",
								".dmchat>li",
								function() {
									var dmBox = $("#dmBox");
									dmBox.css("display", "");
									var sender = $(this).children('div')
											.children('input').eq(0).attr(
													'value');
									var receiver = $(this).children('div')
											.children('input').eq(1).attr(
													'value');
									var roomname = $(this).children('div')
											.children('input').eq(2).attr(
													'value');
									var dmVal = {
										"dm_no" : roomname,
										"dm_user_id" : sender,
										"dm_receiver" : receiver
									};
									var imgdm = $(this).children('div')
											.children('input').eq(3).attr(
													'value');

									$
											.ajax({
												type : "POST",
												url : "dmsubstance.do",
												data : JSON.stringify(dmVal),
												contentType : "application/json",
												success : function(msg) {
													var str = '';
													var str2 = '';
													var list = msg.list;
													$
															.each(
																	list,
																	function(i) {
																		if (list[i].dm_writer != sender) {
																			str += '<li style="text-tranfrom:none;margin-left:299px;">'
																					+ '<span>'
																					+ list[i].dm_substance
																					+ '</span></li>';
																		} else {
																			str += '<li  style="text-transform:none;margin-right:299px; background-color: #79c7c55e;"><div style="font-weight: bold;color: black;font-size: 13px;">'
																					+ list[i].dm_writer
																					+ ' :'
																					+ '</div><span>'
																					+ list[i].dm_substance
																					+ '</span></li>';
																		}
																	});
													str2 += '<input type="hidden" value="'+roomname+'"/>';
													$("#dm").children('li')
															.remove();
													$("#dm").append(str);
													$("#dmexit").children(
															'input').remove();
													$("#dmexit").append(str2);
													$("#receiver_dm").text('');
													$("#receiver_dm").text(
															sender);
													$("#avatar_dm").remove(
															'img');
													var imgstr = '<img src="resources/images/profile/'+ imgdm +'" >'
													$("#avatar_dm").append(
															imgstr);
													//채팅방 시작하자마자 최하단으로 scroll
													var chatLog = $('#dm');
													chatLog
															.scrollTop(chatLog[0].scrollHeight
																	- chatLog[0].clientHeight);
												},
												error : function() {
													alert("에러");
												}
											});

								});
				$(document)
						.on(
								"click",
								".openchat>li",
								function() {

									var chatBox = $("#chatBox");
									var ocname = $("#ocname");
									var chatoption = $("#chatoption");
									$("#mgbox").css("display", "");
									chatBox.css("display", "");
									ocname.css("display", "");
									chatoption.css("display", "none");
									$("#openchatlist").hide();

									var openname = $(this).children('div')
											.children('input').eq(0).attr(
													'value');
									var userid = $(this).children('div')
											.children('input').eq(1).attr(
													'value');
									var str = "";
									$
											.ajax({
												type : "POST",
												url : "openchatsubstane.do",
												data : openname,
												contentType : "application/json",
												dataType : 'json',
												success : function(msg) {
													var str3 = '<input type="hidden" value="'+openname+'"/><input type="hidden" value="'+userid+'"/>';
													$("#openexit").children(
															'input').remove();
													$("#openexit").append(str3);
													$("#ocname").children(
															'span').remove();
													var str2 = '<span style="text-transform:none;">'
															+ openname
															+ '</span>';
													$("#ocname").append(str2);
													var list = msg.list;
													$
															.each(
																	list,
																	function(i) {
																		if (list[i].chat_writer == userid) {
																			str += '<li style="text-transform:none;margin-left:299px;">'
																					+ '<span>'
																					+ list[i].chat_substance
																					+ '</span></li>'
																		} else if (list[i].chat_writer == '.') {
																			str += '<li style="text-transform:none;margin-left: 20%;margin-right: 20%;font-size: 12px;font-weight: bold;color: azure;background: turquoise; padding-left: 13%;position: relative;">'
																					+ list[i].chat_substance
																					+ '</li>';
																		} else {
																			str += '<li style="text-transform:none;margin-right:299px; background-color: #79c7c55e; "><div style="font-weight: bold;color: black;font-size: 13px;">'
																					+ list[i].chat_writer
																					+ ' :'
																					+ '</div><span>'
																					+ list[i].chat_substance
																					+ '</span></li>'
																		}
																	});
													$("#message")
															.children('li')
															.remove();
													$("#message").append(str);
													//채팅방 시작하자마자 최하단으로 scroll
													var chatLog = $('#message');
													chatLog
															.scrollTop(chatLog[0].scrollHeight
																	- chatLog[0].clientHeight);
												},
												error : function() {
													alert('에러');
												}
											});
								});

				$(document).on(
						"click",
						"#leaveBtn",
						function() {
							var openname = $(this).parents('div').children(
									'input').eq(0).attr('value');

							$.ajax({
								type : "POST",
								url : "openchatexit.do",
								data : openname,
								contentType : "application/json",
								dataType : 'json',
								success : function(msg) {
									location.reload();
								},
								error : function() {
									alert('에러');
								}
							});
						});

				$(document).on(
						"click",
						"#dmleaveBtn",
						function() {
							var roomname = $(this).parents('div').children(
									'input').eq(0).attr('value');
							$.ajax({
								type : "POST",
								url : "dmexit.do",
								data : roomname,
								contentType : "application/json",
								dataType : 'json',
								success : function(msg) {
									location.reload();
								},
								error : function() {
									alert('에러');
								}
							});

						});
				function fn_chatList() {
					$("#openchatlist").css("display", "");

				}
			</script>
			<!-- 채팅 -->
			<article id="contact" class="panel">
				<section>
					<div class="loadMore">
						<div class="central-meta item" style="background: none; border: none; padding: 0; padding-left: 50px;">
							<div class="col-lg-6">
								<div class="central-meta" style="background: none; border: none; padding: 0; margin-bottom: 15px; margin-top: -50px;">

									<div class="messages">
										<h5 class="f-title" style="top: 100px; left: 30px;">
											<i class="ti-bell"></i>MY chatList <span class="more-options"><i class="fa fa-ellipsis-h"></i></span>
										</h5>
										<div class="createChatBtn-div">
											<button class="createChatBtn">채팅방 만들기</button>
										</div>
										<div class="message-box">
											<div class="chat-ul-div">
												<ul class="peoples openchat" style="top: 80px; padding: 10px;">
													<c:choose>
														<c:when test="${empty myopenchatlist }">
															<li>채팅 목록이 없습니다.</li>
														</c:when>
														<c:otherwise>
															<c:forEach items="${myopenchatlist }" var="myopenchatlist">
																<li style="text-transform: none;">
																	<div class="openchats">
																		<input type="hidden" value="${myopenchatlist.openname }" /> <input type="hidden" value="<%=user_id%>" /> <span>${myopenchatlist.openname }</span>
																	</div>
																</li>
															</c:forEach>
														</c:otherwise>
													</c:choose>
												</ul>
												<div class="btn-div">
													<button class="chatViewBtn" onclick="fn_chatList();">오픈채팅</button>
												</div>

											</div>
											<div id="msgbox_open" class="peoples-mesg-box" style="padding: unset;">
												<div id="openchatlist" style="display: none;">
													<div class="Allopen_chat_list">모든 오픈채팅 리스트</div>
													<ul style="list-style: none; position: relative; top: 100px; background: #5f9ea05c; width: 300px; overflow-y: scroll; height: 200px; border-radius: 0 0 10px 10px; font-size: 20px; color: #353232; padding-left: 40px;">
														<c:choose>
															<c:when test="${empty openchatlist }">
																<li>채팅방이 없습니다.
															</c:when>
															<c:otherwise>

																<c:forEach items="${openchatlist }" var="openchatlist">
																	<li style="text-transfrom: none;" class="openchatnames">${openchatlist.openname }<input type="hidden" value="${openchatlist.openname }" /> <input type="hidden" value="<%=user_id%>" />
																	</li>
																</c:forEach>
															</c:otherwise>
														</c:choose>
													</ul>
												</div>
												<%@include file="./openchat.jsp"%>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</article>

			<script type="text/javascript">
				$(".createChatBtn-div").on("click", function() {
					$(".conversation-head").css("display", "none");
					$(".message-text-container").css("display", "none");
					$("#chatoption").show();
					$("#ocname").hide();
					$("#chatBox").hide();
					$("#openchatlist").hide();

				});

				$(".btn-div").on("click", function() {
					$("#openchatlist").show();
					$(".conversation-head").hide();
					$("#chatBox").hide();
					$("#chatoption").hide();
				})

				$("#create").on("click", function() {
					var openname = $("#openname").val();
					var openchatVal = {
						"openname" : openname,
						"openpw" : '0',
						"openlimit" : '0'
					}

					$.ajax({
						type : "POST",
						url : "openchat.do",
						data : JSON.stringify(openchatVal),
						contentType : "application/json",
						dataType : 'json',
						success : function(msg) {
							var res = msg.res;
							if (res == 'false') {
								swal("채팅방 이름이 중복됩니다.");
							} else {
								location.reload();
							}
						},
						error : function() {
							alert('에러');
						}
					});
				});
			</script>


			<!-- 라이브방송 -->
			<article id="home" class="panel">
				<section>
					<input type="hidden" id="livehidden" value="<%=user_id%>">
					<div class="loadMore">
						<div class="central-meta item" style="background: none; border: none; padding: 0; padding-left: 50px;">
							<div class="col-lg-6">
								<div class="central-meta" style="background: none; border: none; padding: 0; margin-bottom: 15px; margin-top: -50px;">

									<div class="messages">
										<h5 class="f-title" style="top: 100px; left: 50px; margin-bottom: unset;">
											<i class="ti-bell"></i>Live list <span class="more-options"><i class="fa fa-ellipsis-h"></i></span>
										</h5>
										<div class="message-box">
											<div class="chat-ul-div" id="peopleslive">
												<ul class="peoples" id="peoples-live" style="top: 100px; left: 10px;">
													<c:choose>
														<c:when test="${empty livelist }">
															<li class="livelists">
																<div id="people-name-live">
																	<span>현재 방송중인 유저가 없습니다.</span>
																</div>
															</li>
														</c:when>
														<c:otherwise>
															<c:forEach items="${livelist }" var="livelist" varStatus="index">
																<li style="display: block; margin-top: unset; margin-bottom: unset;" " class="livelists"><input type="hidden" value="${livelist.live_user_id }" />
																	<figure style="margin-bottom: -10px;">
																		<img src="resources/images/profile/${livelist.live_user_profile }" alt="" style="top: -10px; position: relative;">
																		<span class="status f-online" style="top: 55%;"></span>
																	</figure>
																	<div id="people-name-live" style="margin: -10%; margin-left: 30%;">
																		<span>${livelist.live_user_id}</span>
																	</div></li>
															</c:forEach>
														</c:otherwise>
													</c:choose>
												</ul>
											</div>
											<div class="peoples-mesg-box">
												<div class="conversation-head" style="background: #f9fbff05;">
													<%@include file="./live.jsp"%>
												</div>

											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</article>
		</div>
	</div>
	<!-- Scripts -->
	<script src="resources/js/script.js"></script>
	<script src="resources/js/jquery.min.js"></script>
	<script src="resources/js/breakpoints.min.js"></script>
	<script src="resources/js/main.js"></script>
	<script type="text/javascript">
		$(function() {
			var live = $("#livehidden").attr("value");
			var peoples = $("#peoples-live");
			$(document).on("click","#live",function() {
								$.ajax({
									type : "POST",
									url : "live.do",
									data : live,
									contentType : "application/json",
									dataType : "json",
									success : function(msg) {
										$("#live").css("display","none");
										$("#livestop").css("display","");
										var list = msg.livelist;
										var str = "";

										$.each(list,function(i) {
											+ "<input type='hidden' value='"+list[i].live_user_id+"'/>" //
											+ "<figure style='margin-bottom:-10px;'>" //
											+ "<img src='resources/images/profile/'"+list[i].live_user_profile+"' style='top: -10px; position: relative;'/>" //
											+ "<span class='status f-online' style='top: 55%;'></span>" //
											+ "</figure>" //
											+ "<div id='people-name-live' style='margin: -10%; margin-left:30%;'>" //
											+ "<span>" + live[i].live_user_id + "</span></div></li>";
										});
										$(".livelists").remove();
										$("#peoples-live").append(str);
									},
									error : function() {
										alert('에러');
									}
								});
							});
			$("#livestop")
					.on(
							'click',
							function() {
								$
										.ajax({
											type : "POST",
											url : "livestop.do",
											data : live,
											contentType : "application/json",
											dataType : 'json',
											success : function(msg) {
												$("#live").css('display', '');
												$("#livestop").css('display',
														'none');

												var list = msg.livelist;
												var str = '';
												var str2 = '';
												$
														.each(
																list,
																function(i) {
																	str += "<li style='display:block; margin-top:unset; margin-bottom:unset;' class='livelists'>" //
																	+ "<figure style='margin-bottom:-10px;'>" //
																	+ "<img src='resources/images/profile/'"+list[i].live_user_profile+"' style='top:-10px; position:relative;'/>" //
																	+ "<span class='status f-online' style='top:55%;'></span>" //
																	+ "</figure><div id='people-name-live' style='margin:10%; margin-left:30%;'>" //
																	+ "<span>"+live[i].live_user_id+"</span></div></li>";
																});
												$("#peoples-live").children(
														'li').remove();
												$("#peoples-live").append(str);

												if (list.length == 0) {
													str2 += '<li class="livelists"><div id="people-name-live"><span>현재 방송중인 유저가 없습니다.</span></div></li>';
													$(".livelists").remove();
													$("#peoples-live").append(
															str2);
												}
											},
											error : function() {
												alert('에러');
											}
										});
							});

			$(document).on('click', '.livelists', function() {
				roomid = $(this).children('input').attr('value');
				window.open('http://localhost:3333/' + roomid);
			})
		});
	</script>
</body>
</html>