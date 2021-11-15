<%@page import="com.flenda.www.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="fileStr" value="${login.newFilename }" />
<c:set var="length"  value="${fn:length(fileStr)}"/>
<c:set var="filename"  value="${fn:substring(fileStr, length-3, length)}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 0817 swal -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- 0819 -->
<link rel="stylesheet" type="text/css" href="./css/login.css">
<!-- 우편번호 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

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

<!-- <div class="userinfo" >    -->
<div align="center" class="updateAll">
<div class="updateForm" >
<form id="frm">
   <table class="table table-borderless" style="margin-left:30px; margin-top: 20px; ">
      <col width="120px"><col width="220px"><col width="180px"> 
      <tr>
         <th>아이디</th>
         <td>
            <input type="text" id="_id" class="regi" name="id" size="30" value="${mem.id}" disabled>                        
         </td>
      </tr>
      <tr>
         <th rowspan="2">비밀번호</th>
         <td>
            <input type="password" class="regi" name="pwd" id="_pwd" size="30" placeholder="PW (8~16자리)">
         </td>
      </tr>
      <tr>
         <td>
            <input type="password" class="regi" name="pwd2" id="_pwd2"  placeholder="PW CHECK">
            <div id="_pwdcheck"></div>
         </td>
         <td>
            <input type="button" class="loginbtn" id= "pwdcheck" onclick="pwtest()" value="확인" >
         </td>
      </tr>
      <tr>
         <th>이름</th>
         <td>
            <input type="text" class="regi" name="name" id="_username" size="30" value="${mem.name}">
         </td>
      </tr>
      <c:if test="${mem.auth==2}">
      <tr>
         <th>사업자명</th>
         <td>
            <input type="text" class="regi" name="businessName" id="businessName" size="30" value="${mem.businessName }">
         </td>
      </tr>
      <tr>
         <th>사업자등록번호</th> 
         <td>
            <input type="text" class="regi" name="businessNumber" id="businessnumber" size="30" value="${mem.businessNumber }">
         </td>
      </tr>
      </c:if>
      <tr>
         <th>성별</th>
         <td>
            <select id ="gender" name ="gender" class="form-select form-select-sm mb-3" aria-label=".form-select-sm example">
               <option selected value="SELECT">SELECT</option>
               <option value="male">남자</option>
               <option value="female">여자</option>
               <option value="secret">밝히고싶지 않음</option>
            </select>
         </td>
      </tr>
      <tr>
         <th>생년월일</th>
         <td>
            <div style ="display:flex">
               <div style= "width:80px; ">
                  <select class="form-select form-select-sm" aria-label=".form-select-sm example" name="year" id="year"></select>
               </div>년 
               <div style= "width:75px; margin-left:12px;">
                  <select class="form-select form-select-sm" aria-label=".form-select-sm example" name="month" id="month"></select>
               </div>월 
               <div style= "width:75px; margin-left:12px;">
                  <select class="form-select form-select-sm" aria-label=".form-select-sm example" name="day" id="day"></select>
               </div>일
            </div>
         </td>
      </tr>
      <tr>
         <th>이메일</th> 
         <td>
            <input type="text" class="regi" name="email" id="_email" size="30" value="${mem.email }">
            <div id="_rgetemail"></div>         
         </td>
         <td>
            <button type="button" class="loginbtn" id="emailbtn" title="이메일체크">확인</button>
         </td>
      </tr>
      <tr>
         <th>주소</th> 
         <td>
            <input type="text" class="regi"  name="address" id="searchAddress" value="${mem.address}"
               data-rules="required" data-error="에러: 주소를 입력해 주세요.">
            <input type="text" class="regi" name="addressDetail" id="searchAddress2" placeholder="ADDRESS">
         </td>
         <td>
            <input type="button" class="loginbtn" onclick="openDaumPostcode()" value="검색">
         </td>
      </tr>
      <tr>
         <th>프로필 사진</th> 
         <td>
            <div class="mb-3">
            <input type="file" class="form-control" class="regi" name="fileload" id="_filename" size="30">
            </div>
         </td>
      </tr>
   </table>
   <input type="hidden" name="id" class ="_id" value="${mem.id}">
   <input type="hidden" name="auth" value="${mem.auth}">
</form>
</div>

   <div align="left">
   <button type="button" class="updatebtn" id="updatebtn" title="수정">수정</button>
   </div>

   <div class="deleteMember" align ="right">
      <button class="button-48" role="button"  style="margin-right: 20px; margin-top: 40px;" id="deleteBtn"><span class="text" style="color:#606ADC;">회원탈퇴</span></button>
   </div>

</div>




<script type="text/javascript">
<!--비밀번호 일치 확인-->
function pwtest(){
   var p1 = document.getElementById('_pwd').value;
   var p2 = document.getElementById('_pwd2').value;
   
   if(p1 == "" || p2 == ""){
      Swal.fire({
           icon: 'error',
           title: '비밀번호를 입력해주세요!',
         })
      return false;
   }
   
     if(p1.length<8 || p1.length>16){
      $("#_pwdcheck").html("8~16자리 이내로 입력해주세요");
      $("#_pwdcheck").css("color", "#ff0000");
      $("#_pwd").val("");
      $("#_pwd2").val("");
      return false;
     }
      
   if(p1 != p2){
      $("#_pwdcheck").html("비밀번호가 일치하지 않습니다");
      $("#_pwdcheck").css("color", "#ff0000");
      $("#_pwd").val("");
      $("#_pwd2").val("");
      return false;
   } else if(p1=p2 || /^[a-zA-Z0-9]{8,16}$/.test(p1) ) {
      $("#_pwdcheck").html("비밀번호가 일치합니다");
      $("#_pwdcheck").css( "color", "#0000ff");
      $("#_pwd").val( $("#_pwd").val().trim() );
      return true;
   }
}
</script>

<script type="text/javascript">
$("#deleteBtn").click(function(){
   //let deleteId =  $("#_id").val();
   let checkid = '${mem.id}';
   
   //alert(checkid);
   Swal.fire({
        title: '정말 탈퇴하시겠습니까?',
        text: '확인을 누르시면 탈퇴가 완료됩니다',
        showCancelButton: true,
        confirmButtonText: 'YES',
      }).then((result) => {
         if (result.isConfirmed) {
            $.ajax({
               url:"deleteMember.do",
               data: { id:checkid },
               success:function( result ){
                  alert("success");
                  if(result == 1){
                     Swal.fire('탈퇴가 완료되었습니다', '', 'success').then((result) => {
                            if (result.isConfirmed) {
                               location.href ="logout.do";
                            }
                        });
                  }else{
                     alert('탈퇴 실패');
                  }
               }, error:function(){
                  alert("error");
               }       
            });
         }
      });
            
});

</script>

<script type="text/javascript">
//이메일 중복확인
$("#emailbtn").click(function(){
   if($("#_email").val().trim() == "") {
      Swal.fire({
           icon: 'error',
           title: '이메일을 입력해주세요!',
         })
      $("#_email").focus();
      return
   } 
   // 이메일형식
   if($("#_email").val().includes('@') == false){
      Swal.fire({
           icon: 'error',
          title: '이메일을 형식에 맞게 입력하세요',
         })

      $("#_email").focus();
      return
   }

   $.ajax({
      url:"getEmail.do",
      type:"post",
      data:{ email:$("#_email").val() },
      success:function( msg ){
         if(msg == 'YES'){
            $("#_rgetemail").html("사용할 수 없는 이메일입니다");
            $("#_rgetemail").css("color", "#ff0000");
            $("#_email").val("");
            $("#_rgetemail").val("");
         }else{
            $("#_rgetemail").html("사용 가능한 이메일입니다");
            $("#_rgetemail").css( "color", "#0000ff");
            $("#_useremail").val( $("#_email").val().trim() );
         }
      },
      error:function(){
         alert('error');
      }
   });
});
</script>

<script type="text/javascript">
//수정완료 버튼 
$("#updatebtn").click(function(){
   if($('#gender').val() == 'SELECT'){
        Swal.fire({
             icon: 'error',
             title: '성별 필수정보를 선택하세요',
           });
        return
     }else if($("#_username").val().trim() == ""){
       Swal.fire({
           icon: 'error',
           title: '이름을 입력해주세요!',
         })
      $("#_username").focus();
      return
   }else if($("#_email").val().trim() == ""){
      Swal.fire({
           icon: 'error',
           title: '이메일을 입력해주세요!',
         })
      $("#_email").focus();
      return
   }else if($("#_email").val().includes('@') == false){
      Swal.fire({
           icon: 'error',
          title: '이메일을 형식에 맞게 입력하세요',
         })

      $("#_email").focus();
      return
   }
   
   
   
   let birth = $("#year").val() + $("#month").val() + $("#day").val()
    let data = $('#frm')[0];
    let dataForm = new FormData(data);
    
    dataForm.append("birthday", birth);   
      
   $.ajax({
      url : "updateInfo.do",
      type: "post",
      data: dataForm,
      enctype: 'multipart/form-data',
      processData:false,
      contentType:false,
      cache:false,
      success:function( data ){
         if(data == 'yes'){
            alert('성공적으로 수정하였습니다');
            location.href = "myInfo.do?id=${mem.id}";
         }else{
            alert('개인정보수정에 실패하셨습니다');
            location.href = "myInfo.do";
         }
      }, error:function(){
         alert('error');
      }
      
   });
});

</script>

<script type="text/javascript">
<!-- 생년월일 -->
$(document).ready(function(){
   $('#gender').val('${mem.gender}');
   
   var today = new Date(); 
   var thisYear = today.getFullYear(); 
   
   let mybirthday = '${mem.birthday}';
   let year = mybirthday.substring(0, 4);
   let mon = mybirthday.substring(4, 6);
   let date = mybirthday.substring(6, 8); 
//년도 selectbox만들기 
for(var i = 1900 ; i <= thisYear ; i++) { 
   $('#year').append('<option value="' + i + '">' + i + '</option>'); 
} 
// 월별 selectbox 만들기 
for(var i=1; i <= 12; i++) { 
   var mm = i > 9 ? i : "0"+i ; 
   $('#month').append('<option value="' + mm + '">' + mm + '</option>'); 
} 

// 일별 selectbox 만들기 
for(var i=1; i <= 31; i++) { 
   var dd = i > 9 ? i : "0"+i ; 
   $('#day').append('<option value="' + dd + '">' + dd+ '</option>');
} 
$("#year > option[value="+year+"]").attr("selected", "true"); 
$("#month > option[value="+mon+"]").attr("selected", "true"); 
$("#day > option[value="+date+"]").attr("selected", "true"); 

});
</script>   
   
<!-- 다음 주소 -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
function openDaumPostcode() {
    new daum.Postcode({
           oncomplete: function (data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
               document.getElementById('searchAddress').value = data.address;
               document.getElementById('searchAddress').focus();
           }
     }).open();
}
</script>

</body>
</html>