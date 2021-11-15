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
<!-- 0819 -->
<link rel="stylesheet" type="text/css" href="./css/login.css">

</head>

<body >
<div style="color: #0064CD;">
<div class ="findcentered">
 <div class="box">
 <form method="post" class="findPwForm">
   <h3>비밀번호 찾기</h3><br>
   <div class= "idForm" >
      <input type="text" id="id" class ="id" name="id" placeholder="아이디를 입력해주세요" required>
   </div>
   <div class= "idForm" id="findidAf">
      <input type="text" id="email" class ="id" name="email" placeholder="이메일주소를 입력해주세요" required>
   </div><br>            
      <button type="button" id="findBtn" class="findbtn" >FIND</button>&nbsp;&nbsp;   
         <button type="button" onclick="history.go(-1);" class="findbtn" >LOGIN</button>   
 </form>
 </div>
</div>
</div>

<script>
$(document).ready(function() {
      $("#findBtn").click(function(){
         if($("#id").val().trim()==""){
            Swal.fire({
                 icon: 'error',
                title: '아이디를 입력해주세요',
               })
            $("#id").focus();
            return
         }
         if($("#email").val().trim()==""){
            Swal.fire({
                 icon: 'error',
                title: '이메일을 입력해주세요',
               })
            $("#email").focus();
            return
         }
         $.ajax({
            url : "findPwPost.do",
            type : "POST",
            data : {
               id : $("#id").val(),
               email : $("#email").val()
            },
            success : function(result) {
               if(result == 'success'){
                  Swal.fire({
                       icon: 'success',
                       title: '입력하신 이메일로 임시 비밀번호를 발송했습니다',
                       showConfirmButton: false,
                       timer: 1500
                     })
               }else{
                  Swal.fire({
                       icon: 'error',
                      title: '등록되지 않은 정보입니다',
                      text: '아이디와 이메일을 확인해주세요',
                     })
               }
            },
            error : function(){
               alert("error");
            }
         })
      });
});
</script>


</body>
</html>