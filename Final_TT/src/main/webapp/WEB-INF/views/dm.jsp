<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
   src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.3.0/socket.io.js"></script>
<script>
   $(() => {
      $(".people-name").on("click", function() {
         
         var roomname = $(this).children('input').eq(2).attr('value');
         var user_id = $(this).children('input').eq(1).attr('value');
      var socket = io("localhost:3000/dm");
      var people = "";
      socket.emit("joinRoom", {room: roomname, name:user_id, people:people });
      
      $("#mFrom_dm").submit(() => {
          var dmVal = {
                "dm_no":roomname,
                "dm_user_id":user_id
          }
          $.ajax({
                 type : "POST",
                 url : "newdmstatusupdate.do",
                 data : JSON.stringify(dmVal),
                 contentType : "application/json",
                 dataType : 'json',

              });
          socket.emit("chat", {room: roomname, name: user_id, msg: $("#m_dm").val(), people:people});
          $("#m_dm").val("");
          return false;
       });
      
      
      socket.on("broadcast", (data) => {
           if (data.name == user_id) {
               $("#dm").append($("<li>").text(data.msg).css("margin-left", "299px"));
           }
           else {
              var html= '';
              html += '<li  style="margin-right:299px; background-color: #79c7c55e; "><div style="font-weight: bold;color: black;font-size: 13px;">'
               + data.name
               + ' :'
               + '</div><span>'
               + data.msg
               + '</span></li>';
               
              $("#dm").append(html);
           }
         //채팅 입력하자마자 최하단으로 scroll
             var chatLog = $('#dm');
           chatLog.scrollTop(chatLog[0].scrollHeight - chatLog[0].clientHeight);
       });
      
      socket.on("bye", (data) => {
          $("#dm").append($("<li>").text(data.name + data.msg));
       });
      
      $("#leaveBtn").click(() => {
         people.split(',');
          var idx = people.indexOf(user_id);
          people.splice(idx, 1);
          for (var i in people) {
             people += people[i] + ",";
          }
           socket.emit("leaveRoom", {room: roomname, name: user_id, people:people});
           window.location.href="http://localhost:8787";
           
       });
      
      });
      });
</script>
<style type="text/css">
.top-bar {
   width: 100%;
   height: 60px;
   background: #F9FBFF;
   border-radius: 10px 10px 0 0;
}

.bottom-bar {
   width: 100%;
   height: 55px;
   top: 10px;
   background: #F9FBFF;
   border-radius: 0 0 10px 10px;
   position: relative;
}

.middle {
   background: #f9fbffba;
}

.avatar {
   width: 35px;
   height: 35px;
   border-radius: 50%;
   position: relative;
   top: 10px;
   left: 20px;
}

.name {
   position: relative;
   top: -15px;
   text-transform: uppercase;
   color: #777777;
   font-size: 14px;
   letter-spacing: 2px;
   font-weight: 500;
   left: 60px;
}

#dm li {
   background: #79C7C5;
   border-radius: 10px;
   margin-bottom: 5px;
   margin-right: 10px;
}

#dmexit {
   background: #37948c !important;
   width: 115px;
   top: 20px;
   border-radius: 10px;
   position: relative;
   left: 190px;
}

::-webkit-scrollbar {
   display: none;
}

#m_dm {
   width: 410px;
   border-radius: 10px;
   padding: 8px;
   top: 6px;
   position: relative;
   left: 7px;
}

.avatar img {
   width: 40px !important;
   height: 40px !important;
   max-width: none;
   border-radius: 100%;
}
</style>
</head>
<body>
   <div id="dmBox" style="display: none">
      <div class="top-bar">
         <div class="avatar" id="avatar_dm"></div>
         <div class="name" id="receiver_dm"></div>
      </div>
      <div class="middle">
         <div class="dm_dm">
            <ul id="dm"
               style="height: 350px; margin-bottom: unset; list-style: none; overflow-y: scroll; -ms-overflow-style: none;">
            </ul>
         </div>
         <div class="bottom-bar">
            <form id="mFrom_dm">
               <input id="m_dm" autocomplete="off" />
               <button 
                  style="background:#3b505b; border-radius:8px; padding:6px; position: relative; top: 5px; left: 10px;">전송</button>
            </form>
            <div id="dmexit">
               <button id="dmleaveBtn" style="color: white;">채팅방 나가기</button>
            </div>
         </div>
      </div>
   </div>
</body>
</html>