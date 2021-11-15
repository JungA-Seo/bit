<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>

<html lang ="ko">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>

<head>
<link rel="stylesheet" type="text/css" href="./css/login.css">

<!-- 0817 swal -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- naver login -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<!-- id쿠키 저장 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
<!-- kakao login -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</head>


<body>
<div  id="_frmForm" style="color: #692498;" class="centered">
    <div class="loginForm">
      <h2>Login</h2>
      <div class="idForm">
        <input type="text" id="id" name="id" class="id" placeholder="ID">
      </div>
         
      <div class="passForm">
        <input type="password" id="pwd" name="pwd" class="pw" placeholder="PW">
      </div>
      <input type="checkbox" id="chk_save_id" >&nbsp;아이디 저장<br>
      <a href ="findId.do" style="text-decoration:none; color:gray;" id ="findId">아이디 /</a>&nbsp;<a href ="findPw.do" style="text-decoration:none; color:gray;" id ="findPw">비밀번호 찾기</a><br><br>
      <button type="button"  id="_btnLogin" class="loginbtn">LOGIN</button>
      <!-- 네이버아이디로로그인 버튼 노출 영역 -->
       <div align ="center" id = "naver_id_login">
         <a id="naverIdLogin_loginButton" href="#"><img src="https://static.nid.naver.com/oauth/big_g.PNG?version=js-2.0.1" height="60"></a>
      </div><br>
        <!-- 카카오 -->
   	  <div align ="center">
         <a id="custom-login-btn" href="https://kauth.kakao.com/oauth/authorize?
                                 client_id=283fba8c8b4d06934c3d02b2f8fc3fd0
                                 &redirect_uri=http://localhost:8090/flenda/loginKakao.do
                                 &response_type=code">
              <img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222"/>
         </a>
      </div><br><br> 
      <div class="bottomText">
       아직 Flenda의 회원이 아니신가요?  <a href ="regi.do" style="text-decoration:none; color:#606ADC; font-weight:bold;" id ="myBtn" data-bs-toggle="modal" data-bs-target="#exampleModal">회원가입</a>
       
     </div>
  </div>
</div>
  
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header" >
        <h3 class="modal-title" id="exampleModalLabel" style="text-align:center; color: #692498;" align="center">WILL YOU JOIN US?</h3>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="regi.do">
           <div class="totalBox" style="display: flex; vertical-align: middle;" >
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="box1" >
                  <button type="button"  class="btn btn-link" style= "border:none"><img alt="" src="image/individual.png"  border="0" id="individual" style="width:300px; height:300px; text-align: center; border:none;"></button>
               </div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <div class="box2" >
                  <button type="button" class="btn btn-link" style= "border:none" ><img alt="" src="image/business.png" border="0" id="business" style="width:300px; height:300px; text-align: center; border:none;"></button>
              </div>
           </div>
           <div class="modal-footer"></div>
           </form>
      </div>
    </div>
  </div>1
</div>

<!--네이버-->
 <script type="text/javascript">
   var naver_id_login = new naver_id_login("0BAfgZNxnePTC9ReDt79", "http://localhost:8090/flenda/main.do");
     var state = naver_id_login.getUniqState();
     naver_id_login.setButton("green", 3,48);
     naver_id_login.setDomain("http://localhost:8090/flenda/login.do");
     naver_id_login.setState(state);
     naver_id_login.init_naver_id_login();
</script>

<script type="text/javascript">
//아이디 찾기
$("#findId").click(function(){
   location.href ="findId.do";
});

//아이디 저장
let user_id = $.cookie("user_id");
if(user_id != null){
   $("#id").val( user_id );
   $("#chk_save_id").attr("checked", "checked");   
}

$("#chk_save_id").click(function(){

   if( $("#chk_save_id").is(":checked") ){   
      if( $("#id").val().trim() == ""){
         Swal.fire({
              icon: 'error',
              title: '아이디를 입력해주세요!',
            });
         $("#chk_save_id").prop("checked", false);
      }
      else{
         $.cookie("user_id", $("#id").val(), { expires:356, path:'/' });
      }
   }
   else{
      // alert("쿠키 삭제");
      $.removeCookie("user_id", {path:'/'});
   }   
});

$("#_btnRegi").click(function () {
   location.href = "regi.do";
});

$("#_btnLogin").click(function () {
   
   
   if($("#id").val().trim() == ""){
      Swal.fire({
           icon: 'error',
           title: '아이디를 입력해주세요!',
         })
      $("#id").focus();
      return
      
   }else if($("#pwd").val() == ""){
      Swal.fire({
           icon: 'error',
           title: '비밀번호를 입력해주세요!',
         })
      $("#pwd").focus();
      return
   }

$("#_frmForm").click(function() {
   $.ajax({
      url: "loginAf.do",
      data: { id:$("#id").val(), 
            pwd:$("#pwd").val()
           },
      success:function(mem){
         if(mem != ""){
            
            alert(mem.name + "님 환영합니다");
            location.href="main.do";
         }else{
         
            Swal.fire(
                  { icon: 'error', title: '아이디와 비밀번호를 다시 확인해주세요!'}
                  ).then((mem) => {
                            if (mem.isConfirmed) {
                                location.href = location.href;   
                           }
                   });
            
         } 
      },
      error:function(){
         alert('error');
      }   
   });
});   

});

$('#individual').click(function(){
   location.href ="regi.do?param=individual"; 
});

$('#business').click(function(){
   location.href ="regi.do?param=business";
});
</script>

</body>
</html>