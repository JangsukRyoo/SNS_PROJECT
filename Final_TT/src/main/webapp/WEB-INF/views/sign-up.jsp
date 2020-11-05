<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
   request.setCharacterEncoding("UTF-8");
%>
<%
   response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="" />
<meta name="keywords" content="" />
<title>Travel Talk</title>
<link rel="stylesheet" href="resources/css/main.min.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/color.css">
<link rel="stylesheet" href="resources/css/responsive.css">
<style type="text/css">
.container {
   height: 100%;
}

.container::after {
   width: 100%;
   height: 100%;
   content: "";
   background-color: #a8d6d1e6;
   background-repeat: no-repeat;
   position: absolute;
   top: 0;
   left: 0;
   z-index: -99;
}

.signform {
   background: #fdfdfd none repeat scroll 0 0;
   position: relative;
   top: -50px;
   padding: 25px;
   margin: 0 auto;
   width: 500px;
   border-radius: 10px;
   box-shadow: 0px 0px 3px 3px #f3f3f3;
}

body {
   background-color: #a8d6d1e6;
}

.horizontal {
   width: 100%;
   height: 100px;
}

.vertical {
   width: 100%;
   text-align: center;
}

.logo-section {
   height: 125px;
}

#logo {
   width: 125px;
}
</style>
</head>
<body>
   <div class="container">
      <div class="horizontal"></div>
      <div class="signform">
         <div class="editing-info">
            <div class="vertical">
               <div class="logo-section">
                  <img id="logo" alt="logo" src="resources/images/logo.png">
               </div>
            </div>
            <h5 class="f-title">
               <i class="ti-lock"></i>Sign Up
            </h5>
            <form id="signup" action="signupres.do" method="post" enctype="multipart/form-data" modelAttribute="contentdto">
               <div class="form-group">
                  <input type="text" id="users_id" title="N" required="required" name="users_id" /> <label id="idLabel" class="control-label" for="input">ID</label><i class="mtrl-select"></i>
               </div>
               <div class="form-group">
                  <input type="text" required="required" name="users_nickname" /> <label class="control-label" for="input">NICKNAME</label><i class="mtrl-select"></i>
               </div>
               <div class="form-group">
                  <input type="password" id="users_pw" required="required" name="users_pw" /> <label id="pwRegLabel" class="control-label" for="input">PW</label><i class="mtrl-select"></i>
               </div>
               <div class="form-group">
                  <input type="password" id="pwChk" required="required" onkeyup="javascript:pw_chk();" /> <label id="chkLabel" class="control-label" for="input">Confirm PW</label><i class="mtrl-select"></i>
               </div>
               <div class="form-group">
                  <input type="text" required="required" name="users_name" /> <label class="control-label" for="input">User Name</label><i class="mtrl-select"></i>
               </div>
               <div class="form-group">
                  <input type="tel" id="users_phone" onkeyup="javascript:phone_reg();" onkeydown="javascript:if(event.keyCode==13)sign_up();" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" name="users_phone" required="required" /> <label id="phoneLabel" class="control-label" for="input">010-0000-0000</label><i class="mtrl-select"></i>
               </div>

               <!-- 추가 -->
               <div class="form-group">
                  <input type="file" name="mpfile" /> <label class="control-label" for="input"></label><i class="mtrl-select"></i>
               </div>
               <div class="submit-btns">
                  <button type="button" class="mtr-btn" onclick="sign_up();">
                     <span>Confirm</span>
                  </button>
                  <button type="button" class="mtr-btn" onclick="location.href='signin.do'">
                     <span>Cancel</span>
                  </button>
               </div>
            </form>
         </div>
      </div>
   </div>
   <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
   <script src="resources/js/script.js"></script>
   <script type="text/javascript">
      $(function() {
         $("#users_id").focus();
         $("#users_id").blur(function() {
            fn_idChk();
         });
         $("#users_pw").blur(function() {
            pw_reg();
         });
         $("#pwChk").blur(function() {
            pw_chk();
         });
      });
      function pw_chk() {
         if (($("#pwChk").val() != $("#users_pw").val())
               && $("#pwChk").val() != "") {
            $("#pwChk").focus();
            $("#chkLabel").text("비밀번호가 일치하지 않습니다.");
         } else {
            $("#chkLabel").text("Confirm PW");

         }
      }
      function pw_reg() {
         var pw = $("#users_pw").val();
         //(최소 하나이상 && 문자 && 숫자 && 특수기호) || 6자리 이상
         var reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,}$/;
         if (!reg.test(pw) && pw != "") {
            $("#users_pw").focus();
            $("#pwRegLabel").text("최소 하나 이상의 문자, 숫자, 특수기호로 6자리 이상 입력");
         }
         if (reg.test(pw) || pw == "") {
            $("#pwRegLabel").text("PW");
         }
      }

      function fn_idChk() {
         var users_id = $("#users_id").val();
         var idData = {
            "users_id" : users_id
         };
         $.ajax({
            url : "idChk.do",
            type : "post",
            dataType : "json",
            data : JSON.stringify(idData),
            contentType : "application/json",
            success : function(msg) {
               if (msg.chk) {
                  $("#users_id").attr("title", "Y");
                  $("#idLabel").text("ID");
               } else {
                  $("#users_id").attr("title", "N");
                  $("#users_id").focus();
                  $("#idLabel").text("이미 사용중인 아이디 입니다");
               }
            },
            error : function(request, status, error) {
            }
         });
      }
      function phone_reg() {
         var phone = $("#users_phone").val();
         var phone_regExp = /^\d{3}-\d{3,4}-\d{4}$/;
         var valid= false;
         if (phone_regExp.test(phone)) {
            $.ajax({
               url : "phonechk.do",
               type : "post",
               async: false,
               data : phone,
               dataType : "json",
               contentType : "application/json",
               success : function(msg) {
                  if (msg.chk) {
                     $("#phoneLabel").text("유효한 번호 입니다");
                     valid = true;
                  } else {
                     $("#users_phone").focus();
                     $("#phoneLabel").text("유효하지 않은 번호 입니다");
                     valid = false;
                  }
               },
               error : function() {
               }
            });
            return valid;
         } else {
            $("#phoneLabel").text("유효하지 않은 번호 입니다");
            $("#users_phone").focus();
            return valid;
         }
      }
      function sign_up() {
         if (phone_reg()) {
            $("#signup")[0].submit(function() {
               return true;
            });
         }
      }
   </script>
</body>

</html>