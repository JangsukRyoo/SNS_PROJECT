<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#message {
   list-style-type: none;
}

#message li {
   display: flex;
}

.conversation-head {
   width: 100%;
   height: 60px;
   background: #F9FBFF;
   border-radius: 10px 10px 0 0;
}

.conversation-head span {
   letter-spacing: 2px;
   top: 3px;
   position: relative;
}

#chatBox {
   background: #f9fbffba;
   top: -16px;
   position: relative;
}

#message li {
   background: #79C7C5;
   border-radius: 10px;
   margin-bottom: 5px;
   margin-right: 10px;
}

::-webkit-scrollbar {
   display: none;
}

.bottom-bar {
   width: 100%;
   height: 55px;
   top: 10px;
   background: #F9FBFF;
   border-radius: 0 0 10px 10px;
   position: relative;
}

#chatoption ul {
   position: relative;
   top: 100px;
   background: #5f9ea05c;
   width: 300px;
   overflow-y: scroll;
   height: 200px;
   border-radius: 0 0 10px 10px;
}

.Allopen_chat_list {
   background: white;
   color: #777777;
   width: 300px;
   border-radius: 10px 10px 0 0;
   top: 100px;
   position: relative;
   text-align: center;
}

#m {
   width: 410px;
   border-radius: 10px;
   padding: 8px;
   top: 6px;
   position: relative;
   left: 7px;
}

#openexit {
   background: #37948c !important;
   width: 115px;
   top: 20px;
   border-radius: 10px;
   position: relative;
   left: 190px;
}
</style>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.3.0/socket.io.js"></script>
<script>
   $(() => {
      $(".openchatnames").on("click",function() {
        var roomname = $(this).children('input').eq(0).attr('value');
        var user_id = $(this).children('input').eq(1).attr('value');
        
        var insertVal = {
              "openname":roomname,
              "userid":user_id
        }
        
        $.ajax({
              type:"POST",
              url:"openchatinsert.do",
              data:JSON.stringify(insertVal),
              contentType:"application/json",
              dataType:'json',
              success:function(msg){
              location.reload();               
              },
              error:function(){
                 alert('에러');
              }
           });
      });
      
      $(".openchats").on("click", function() {
         var roomname = $(this).children('input').eq(0).attr('value');
         var user_id = $(this).children('input').eq(1).attr('value');
         
      var socket = io("localhost:3000/open");
      var people = "";
      socket.emit("joinRoom", {room: roomname, name:user_id, people:people });
      
      $("#mFrom").submit(() => {
         socket.emit("chat", {room: roomname, name: user_id, msg: $("#m").val(), people:people});
         $("#m").val("");
         return false;
      });
      
      socket.on("welcome", (data) => {
         $("#message").append($("<li style='text-transform:none; margin-left:20%; margin-right:20%; font-size: 12px; font-weight:bold; color:azure;background:turquoise;padding-left:13%;position:relative;'>").text(data.name + data.msg));
         $("#now").text("");
           $("#now").text(data.count);
           people += user_id + ",";
           var chatLog = $('#message');
           chatLog.scrollTop(chatLog[0].scrollHeight - chatLog[0].clientHeight);
      });
      
      socket.on("broadcast", (data) => {
           if (data.name == user_id) {
               $("#message").append($("<li style='text-transform:none;margin-left:299px;'>").text(data.msg));
           }
           else {
              var str = '';
              str += '<li style="text-transform:none; margin-right:299px;background-color:#79c7c55e;"><div style="font-weight:bold; color:black;font-size:13px;">'
              +data.name + ':' + '</div><span>' + data.msg + '</span></li>';
               $("#message").append(str);
           }
           var chatLog = $('#message');
           chatLog.scrollTop(chatLog[0].scrollHeight - chatLog[0].clientHeight);
       });
      
      socket.on("bye", (data) => {
          $("#message").append($("<li>").text(data.name + data.msg));
          var chatLog = $('#message');
          chatLog.scrollTop(chatLog[0].scrollHeight - chatLog[0].clientHeight);
       });
      
      $("#leaveBtn").click(() => {
          socket.emit("leaveRoom", {room: roomname, name: user_id, people:people});
          window.location.href="http://localhost:8787";
          
      });
      });
      });
   
   $("#create").on("click",function() {
      var openname = $("#openname").val();
      var openpw = $("#openpw").val();
      var openlimt = $("#openlimit").val();
      
      var openchatVal = {
         "name":openname,
         "pw" : openpw,
         "limit":openlimit
      }
      
      $.ajax({
            type:"POST",
            url:"openchat.do",
            data:JSON.stringify(openchatVal),
            contentType:"application/json",
            dataType:'json',
            success:function(msg){
                           
            },
            error:function(){
               alert('에러');
            }
         });
   });
   
</script>
</head>
<body>
   <div class="conversation-head" id="ocname" style="display: none;"></div>
   <!--  <ul> </ul> -->
   <div id="chatoption" style="display: none;">
      <div class="Allopen_chat_list">채팅방 만들기</div>
      <ul style="height: 100px; list-style: none;">
         <li style="padding-top: 10px; color: #000000d4; font-weight: bold;">&nbsp;
            채팅방 이름 : <input
            style="top: 8px; position: relative; border-radius: 10px;"
            id="openname" name="openname" type="text">
         </li>
         <li><button id="create"
               style="position: relative; left: 215px; top: -20px; background: #37948c !important; border-radius: 10px; font-weight: bold; color: white;">생성</button></li>
      </ul>
   </div>
   <div id="chatBox" style="display: none">
      <div class="dm_dm"
         style="overflow-y: scroll; -ms-overflow-style: none;">
         <ul id="message"
            style="height: 350px;margin-bottom: unset;list-style: none;margin-top: 10px;overflow-y: scroll;-ms-overflow-style: none;">

         </ul>
      </div>
      <div class="bottom-bar">
         <form id="mFrom">
            <input id="m" autocomplete="off" />
            <button
               style="background: #3b505b; border-radius: 8px; padding: 6px; position: relative; top: 5px; left: 10px;">전송</button>
         </form>
         <div id="openexit">
            <button id="leaveBtn" style="color: white;">채팅방 나가기</button>
         </div>
      </div>
   </div>
</body>
</html>