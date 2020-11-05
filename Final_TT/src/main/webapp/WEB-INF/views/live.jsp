<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#video-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, 800px);
	grid-auto-rows: 600px;
}

video {
	width: 100%;
	height: 80%;
	object-fit: cover;
	filter: blur(100px);
	filter: brightness(130%);
}
</style>
<script defer src="https://unpkg.com/peerjs@1.2.0/dist/peerjs.min.js"></script>
<script src="/socket.io/socket.io.js" defer></script>
<script defer src="http://localhost:3333/socket.io/socket.io.js"></script>
<script defer src="script.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var socket = io("http://localhost:3333");
	});
</script>
</head>
<body>

	<div class="conversation-head" style="background: #f9fbff05;">
		<button id="live" onclick="window.open('http://localhost:3333/<%=user_id%>')" style="border: 1px solid #f3f3f3; font-weight: bold;">라이브 시작하기</button>
		<button id="livestop" style="display: none; border: 1px solid #f3f3f3; font-weight: bold;">라이브 종료하기</button>
	</div>
</body>
</html>