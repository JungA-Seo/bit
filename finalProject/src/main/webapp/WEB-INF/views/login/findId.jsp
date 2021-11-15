<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>

<!-- 0817 swal -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="sweetalert2.min.css">
<!-- 0819 -->
<link rel="stylesheet" type="text/css" href="./css/login.css">

</head>
<body>
<div class ="findcentered">
   <div class="box">
       <form method="post" class="findIdForm" id="findidAf">
         <h3>아이디 찾기</h3><br>
         <h6>회원가입 시 등록했던 이메일 주소로 </h6>
         <h6>아이디 찾기가 가능합니다</h6><br>
         <div class= "idForm" id="findidAf">
            <input type="text" id="email" class ="id" name="email" placeholder="이메일주소를 입력해주세요" >
         </div><br>         
         <button type="button" id="findBtn" class="findbtn" >FIND</button>&nbsp;&nbsp;   
         <button type="button" onclick="history.go(-1);" class="findbtn" >LOGIN</button>   
      </form>
   </div>
</div>


<script>
$(document).ready(function() {
   $("#findBtn").click(function(){
      if($("#email").val().trim()==""){
         Swal.fire({
              icon: 'error',
             title: '이메일을 입력해주세요',
            })
         $("#email").focus();
         return
      }
      if($("#email").val().includes('@') == false){
         Swal.fire({
              icon: 'error',
             title: '이메일을 형식에 맞게 입력하세요',
            })
   
         $("#email").focus();
         return
      }
      
      $.ajax({
         url: "findIdAf.do",
         data: {email : $("#email").val()},
         success:function(result) {
            if(result != ''){
               Swal.fire({
                    icon: 'success',
                    title: '회원님의 아이디는',
                    text: result,
                    footer: '<a href="login.do">로그인하러 가기</a>'
                  })
            }else{
               Swal.fire({
                    icon: 'error',
                    title: '등록되지 않은 정보입니다',
                    text: '이메일을 확인해주세요',
                  })
            }
         },
         error:function(result){
            alert("error");
         }
      })
   });
});
</script>
</head>

</body>
</html>