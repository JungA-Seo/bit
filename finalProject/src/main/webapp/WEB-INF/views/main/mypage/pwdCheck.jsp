<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="./css/login.css">
<!— alert창 —>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>
<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
     <ol class="breadcrumb">
       <li class="breadcrumb-item active" aria-current="page">마이페이지</li>
       <li class="breadcrumb-item active" aria-current="page">개인정보</li>
     </ol>
</nav>
<div class="myinfotop">
   <div><h3>개인정보</h3></div>
</div>
<hr>


<div class ="findcentered">
<h2 style="margin-bottom: 30px;">개인정보 수정</h2>
 <div class="box">
 <form method="post" class ="pwdCheckForm">
   <h5 style="margin-bottom: 50px;">비밀번호를 한번 더 입력해주세요</h5>
   <div class= "checkForm">
      <input type="text" id="id" class ="checkidpw" name="id" value="${login.id}" readonly="readonly">
   </div>
   <div class= "checkForm">
      <input type="password" id="pwd" class ="checkidpw" name="pwd" placeholder="비밀번호를 입력해주세요" required>
   </div>
   <div>
   </div><br>            
      <button type="button" id="checkBtn" class="findbtn" >확인</button>&nbsp;&nbsp;   
         <button type="button" onclick="history.go(-1);" class="findbtn" >뒤로가기</button>   
 </form>
 </div>
</div>

<script type="text/javascript">



$("#checkBtn").click(function(){
   
   if($('#pwd').val() == ''){
       Swal.fire({
            icon: 'error',
            title: '비밀번호를 입력해주세요',
          });
       return 
    }
   
   let checkid = $("#id").val();
   let checkpwd = $("#pwd").val();
   //alert("checkid:"+ checkid + "checkpwd:" +checkpwd);
   
   $.ajax({
      url:"pwdCheck.do",
      data: {id:checkid, pwd:checkpwd},
      success:function( result ){
         //alert("success");
         if(result == 1){
            location.href="myInfo.do?id=${login.id}";
         }else{
             Swal.fire({
                  icon: 'error',
                  title: '비밀번호를 다시 입력해주세요',
                });
         }
      }, error:function(){
         alert("error");
      }
   });


});

</script>

</body>
</html>