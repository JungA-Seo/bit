<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 0817 swal -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="sweetalert2.min.css">
<!-- 0819 -->
<link rel="stylesheet" type="text/css" href="./css/login.css">
<!-- 우편번호 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>
<div align ="center" class="centered">
<h2> Join us ! </h2><br><br>
   
<div class="regiForm" id="findidAf">
<form id="frm">
   <table class="table table-borderless">
      <col width="120px"><col width="220px"><col width="180px"> 
      <tr>
         <th>아이디*</th>
         <td>
            <input type="text" id="_id" class="regi" name="id" size="30" placeholder="ID">
            <div id="_rgetid"></div>                           
         </td>
         <td>
            <button type="button" class="loginbtn" id="_btnGetId" title="id체크">확인</button>
         </td>
      </tr>
      <tr>
         <th rowspan="2">비밀번호*</th>
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
         <th>이름*</th>
         <td>
            <input type="text" class="regi" name="name" id="_username" size="30" placeholder="NAME">
         </td>
      </tr>
      <c:if test="${personType == 'business'}">
      <tr>
         <th>사업자명</th>
         <td>
            <input type="text" class="regi" name="businessName" id="businessName" size="30" placeholder="BUSINESS NAME">
         </td>
      </tr>
      <tr>
         <th>사업자등록번호</th> 
         <td>
            <input type="text" class="regi" name="businessNumber" id="businessnumber" size="30" placeholder="BUSINESS NUMBER">
         </td>
      </tr>
      </c:if>
      <tr>
         <th>성별</th>
         <td>
            <select id ="gender" name ="gender"  class="form-select form-select-sm mb-3" aria-label=".form-select-sm example">
               <option selected>SELECT</option>
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
                  <select class="form-select form-select-sm" aria-label=".form-select-sm example" name="year" id="year" ></select>
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
         <th>이메일*</th> 
         <td>
            <input type="text" class="regi" name="email" id="_email" size="30" placeholder="EMAIL">
            <div id="_rgetemail"></div>         
         </td>
         <td>
            <button type="button" class="loginbtn" id="emailbtn" title="이메일체크">확인</button>
         </td>
      </tr>
      <tr>
         <th>주소</th> 
         <td>
            <input type="text" class="regi"  name="address" id="searchAddress" placeholder="ADDRESS"
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
</form><br><br>

<table class="table table-borderless" >
   <tr>
       <th rowspan="4"></th>
       <td>
          <div style="width:500px; height:100px; margin-top: 20px;">
            <input type="checkbox" id="check1" onclick="checkAll()">
            <b> 이용약관(필수), 개인정보 수집 및 이용(필수), 위치정보 이용약관(선택)에 모두 동의합니다.</b>
         </div>
       </td>
    </tr>
 <tr>
    <td>
       <input type="checkbox" id="check2" name="checkAll" style="margin: 10px">Flenda 이용약관 동의<sub style="color:#31B404">(필수)</sub>
      <div style="overflow:auto; width:500px; height:200px; border: 1px solid; border-color: #BDBDBD;" align ="center">
      <h4>Flenda 이용약관</h4>
                     <pre>제 1 조 (목적)

이 약관은 Flenda(이하 ”회사”라 함)이 운영하는 
인터넷사이트(이하 “사이트”라 한다) 및 
모바일 애플리케이션 프로그램을 통해 제공하는 서비스 (이하 서비스라 한다)를 
이용함에 있어 회원의 권리와 의무 및 책임사항을 규정하는 것을 목적으로 한다.


제 2 조 (용어의 정의)

1. "회사"란 Flenda이 재화 또는 용역(이하 "재화등"이라 함)을 
이용자에게 제공하기 위하여 컴퓨터등 정보통신 설비를 이용하여
재화등을 거래할 수 있도록 설정한 법인 또는 가상의 영업장을 말하며,
아울러 인터넷사이트를 운영하는 사업자의 의미로도 사용한다.

2. "사이트"란 회사에 회원으로 등록한 이용자가 
다양한 정보와 서비스를 제공받을 수 있도록 회사가 제작, 운영하는 웹사이트를 의미한다. 
현재 회사가 운영하는 사이트의 접속 주소는 아래와 같다.
- www.flenda.com
- m.flenda.com

3. "회원"이라 함은 사이트에 개인정보를 포함한 정보를 제공하여 회원등록을 한 사용자로서, 
회원등록 시 설정한 아이디(ID)로 
사이트에 자유롭게 접속하여 사이트의 정보를 지속적으로 제공받을 수 있거나 
사이트가 제공하는 서비스를 계속적으로 이용할 수 있는 사용자를 말한다.

4. "상품 등"이라 함은 회사가 사이트를 통하여 회원에게 판매하는 상품을 말한다.

5. "아이디(ID)"라 함은 회원의 식별과 서비스 이용을 위하여 
회원이 설정하고 회사가 승인하여 등록된 주소 또는 이메일 주소를 말한다.

6. "비밀번호(Password)"라 함은 회원의 동일성 확인과 비밀보호를 위하여 
회원 스스로가 설정하여 사이트에 등록한 문자와 숫자의 조합을 말한다.

7. "적립금"이라 함은 상품 등을 구매할 때나 사이트가 제공하는 서비스를 이용할 때 
현금처럼 사용할 수 있는 사이트 전용의 사이버 화폐를 말한다.


제 3 조 (이용계약의 종료)

1. 회원은 본 조에서 정한 바에 따라 이용계약을 해지(회원탈퇴를 요청)할 수 있다.

2. 회원의 해지

   가. 회원은 언제든지 회사에 해지의사를 통지함으로써 
   이용계약을 해지(회원탈퇴를 요청)할 수 있으며, 
   회사는 회원탈퇴에 관한 규정에 따라 이를 처리한다.
   나. 본 조항에 따라 해지를 한 회원(탈퇴한 회원)은 
   이 약관이 정하는 회원가입절차와 관련조항에 따라 회원으로 다시 가입할 수 있다.




제 5 조 (회원자격의 제한 또는 정지)

1. 회원이 다음 각 호의 사유에 해당하는 경우, 
회사는 회원자격을 즉시 제한 또는 정지시킬 수 있다.

가. 회원가입신청 또는 변경 시 허위 내용을 등록한 경우
나. 사이트를 이용하여 구입한 상품 등의 대금, 
   기타 사이트 이용에 관련하여 회원이 부담하는 채무를 기일에 이행하지 않는 경우
다. 다른 사람의 사이트 이용을 방해하거나 
   그 정보를 도용하는 등 전자상거래질서를 위협하는 경우
라. 사이트를 이용하여 법령, 
   이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우</pre>
         </div>
       </td>
   </tr>
    <tr>
       <td>
          <input type="checkbox" id="check3" name="checkAll" style="margin: 10px">개인정보 수집 및 이용 동의<sub style="color:#31B404">(필수)</sub>
         <div style="overflow:auto; width:500px; height:200px; border: 1px solid; border-color: #BDBDBD;">
         <h4>개인정보 수집 및 이용 동의</h4>
         <pre>
          Flenda(이하 `회사’라 한다)는 이용자의 개인정보를 보호하고 
이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 
다음과 같이 개인정보 처리방침을 수립 및 공개 합니다. 
회사는 `동의’ 버튼을 클릭하면 개인정보 수집 및 이용등 
아래 개인정보 처리방침에 대해 동의한 것으로 봅니다.

제1조 개인 정보 수집 항목

회사가 제공 받는 수집한 최소한의 개인 정보 항목과 목적은 다음과 같으며, 
회사는 고객의 회원가입 시 고객 스스로의 정보 입력 
또는 가상계좌번호, 로그(Log), 쿠키(Cookie) 등 자동으로 생성되는 정보를 
서버(Server)에 저장하는 방법으로 정보를 수집합니다.

① 회원인식 및 예약 : 이름, 전자우편 주소, 비밀번호(이상 선택적 수집 정보), 휴대전화번호
② 예약내역의 확인 및 상담 목적: 휴대전화번호


제2조 개인정보의 수집 및 이용목적

회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.
① 여행 상품 판매 및 중개 서비스의 이행 및 서비스 제공에 따른 요금정산
   - 여행상품 예약, 컨텐츠 제공, 구매 및 요금 결제
② 고객관리- 고객관리 및 이용에 따른 본인확인, 개인식별, 
불량회원의 부정 이용 방지와 비인가, 사용 방지, 가입/탈퇴 의사 확인, 연령확인
                  
         </pre>
         </div>
       </td>
   </tr>
   <tr>
       <td>
          <input type="checkbox" id="check4" name="checkAll" style="margin: 10px">위치정보 이용약관 동의<sub style="color:#585858">(선택)</sub>
         <div style="overflow:auto; width:500px; height:200px; border: 1px solid; border-color: #BDBDBD;">
         <h4>위치정보 이용약관 동의</h4>
         <pre>
            
1조 목적
본 약관은 회원(Flenda 서비스 약관에 동의한 자를 말하며, 이하 “회원”)이 Flenda(이하 “회사”)가 제공하는 서비스(이하 “서비스”)를 이용함에 있어 
회사와 회원의 권리/의무 및 책임사항을 규정함을 목적으로 합니다.

제2조 이용약관의 효력 및 변경
① 본 약관은 서비스를 신청한 고객 또는 개인위치정보주체가 본 약관에 동의하고 
회사가 정한 소정의 절차에 따라 서비스의 이용자로 등록함으로써 효력이 발생합니다.

② 회원이 온라인에서 본 약관의 "동의하기" 버튼을 클릭하였을 경우 
본 약관의 내용을 모두 읽고 이를 충분히 이해하였으며, 그 적용에 동의한 것으로 봅니다.

③ 회사는 위치정보의 보호 및 이용 등에 관한 법률, 콘텐츠산업 진흥법, 전자상거래 등에서의 소비자보호에 관한 법률, 
소비자기본법 약관의 규제에 관한 법률 등 관련법령을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.

④ 회사가 약관을 개정할 경우에는 기존약관과 개정약관 및 개정약관의 적용일자와 개정사유를 명시하여 
현행약관과 함께 그 적용일자 7일 전부터 적용일 이후 상당한 기간 동안 공지 하고, 
개정 내용이 회원에게 불리한 경우에는 그 적용일자 30일 전부터 적용일 이후 
상당한 기간 동안 각각 이를 서비스 홈페이지에 게시하거나 회원에게 전자적 형태(전자우편, SMS 등)로 약관 개정 사실을 발송하여 고지합니다.

⑤ 회사가 전항에 따라 회원에게 통지하면서 공지 
또는 공지 고지일로부터 개정약관 시행일 7일 후까지 거부의사를 표시하지 아니하면 이용약관에 승인한 것으로 봅니다. 
회원이 개정약관에 동의하지 않을 경우 회원은 이용계약을 해지할 수 있습니다.

제3조 관계법령의 적용
본 약관은 신의성실의 원칙에 따라 공정하게 적용하며, 본 약관에 명시되지 아니한 사항에 대하여는 관계법령 또는 상관례에 따릅니다.

제4조 개인위치정보의 이용 또는 제공
① 회사는 서비스 제공을 위하여 회사가 수집한 고객의 위치정보를 이용할 수 있으며, 
회원이 본 약관에 동의하는 경우 위치정보 이용에 동의한 것으로 간주됩니다.

② 회사는 고객이 제공한 개인위치정보를 해당 고객의 동의 없이 서비스 제공 이외의 목적으로 이용하지 않습니다.

③ 회사는 개인위치정보를 회원이 지정하는 제3자에게 제공하는 경우에는 
개인위치정보를 수집한 당해 통신 단말장치로 매회 회원에게 제공받는 자, 제공일시 및 제공목적을 즉시 통보합니다.

단, 아래 각 호의 1에 해당하는 경우에는 회원이 미리 특정하여 지정한 통신 단말장치 또는 전자우편주소로 통보할 수 있습니다.
1. 개인위치정보를 수집한 당해 통신단말장치가 문자, 음성 또는 영상의 수신기능을 갖추지 아니한 경우
2. 개인위치정보 주체가 개인위치정보를 수집한 해당 외의 통신단말장치 또는 전자우편 주소 등으로 통보할 것을 미리 요청한 경우
         </pre>
         </div>
       </td>
   </tr>
   <tr>
      <td colspan="2" style="height: 100px; text-align: center;">
         <button type="button" class="loginbtn" id="_btnRegi" title="회원가입">JOIN</button>                  
      </td>
   </tr>
</table>
</div>
</div>


<!-- 아이디 체크 및 공백방지-->
<script type="text/javascript">
//id체크
$("#_btnGetId").click(function () {
   // 공백입력했을 때 아이디입력요청 
   if($("#_id").val().trim() == "") {
      Swal.fire({
           icon: 'error',
           title: '아이디를 입력해주세요!',
         })
      $("#_id").focus();
      return
   } 
   
   $.ajax({
      url:"getId.do",
      type:"post",
      data:{ id:$("#_id").val() },
      success:function( msg ){
         if(msg == 'YES'){
             $("#_rgetid").html("사용할 수 없는 아이디입니다");
            $("#_rgetid").css("color", "#ff0000");
            $("#_id").val("");
            $("#_userid").val("");
         }else{
   
             $("#_rgetid").html("사용 가능한 아이디입니다");
            $("#_rgetid").css( "color", "#0000ff");
            $("#_userid").val( $("#_id").val().trim() ); 
         }
      },
      error:function(){
         alert('error');
      }
   });
});

//이메일 중복확인
$("#emailbtn").click(function () {
   // 공백입력했을 때 아이디입력요청 
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

$("#_btnRegi").click(function () {
   // 회원가입
   
    if($("#_id").val().trim() == ""){
       Swal.fire({
         icon: 'error',
         title: '아이디를 입력해주세요!',
            })
      $("#_id").focus();
      return
   }
   else if($("#_pwd").val().trim() == ""){
      Swal.fire({
           icon: 'error',
           title: '비밀번호를 입력해주세요!',
         })
      $("#_pwd").focus();
      return
   }
   else if($("#_username").val().trim() == ""){
      Swal.fire({
           icon: 'error',
           title: '이름을 입력해주세요!',
         })
      $("#_username").focus();
      return
   }
   
   else if($("#_email").val().trim() == ""){
      Swal.fire({
           icon: 'error',
           title: '이메일을 입력해주세요!',
         })
      $("#_email").focus();
      return
   } 
   
   else if(!$("#check2").is(":checked")){
      Swal.fire({
           icon: 'error',
           title: '필수약관에 동의해주세요!',
         })
      $("#check2").focus();
      return
   }
   else if(!$("#check3").is(":checked")){
      Swal.fire({
           icon: 'error',
           title: '필수약관에 동의해주세요!',
         })
      $("#check3").focus();
      return
   }

   let birth = $("#year").val() + $("#month").val() + $("#day").val()
    let data = $('#frm')[0];
    let dataForm = new FormData(data);
    dataForm.append("birthday", birth);
   
   $.ajax({
      url:"regiAf.do",
      type:"post",
      data:dataForm,
       enctype: 'multipart/form-data',
        processData:false,
        contentType:false,
        cache:false,
        success:function(msg){
            if(msg = 'yes'){
               Swal.fire('가입이 완료되었습니다.<br>로그인을 진행해주세요!', '', 'success').then((result) => {
                    if (result.isConfirmed) {
                       location.href ="login.do";
                    }
                }); 
        	}else{
            Swal.fire({
                 icon: 'error',
                 title: '회원가입 실패!',
               })
            location.href="regi.do";
         }   
      },
      error:function(){
         alert("error");      
      }
   });
});

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

<!-- 생년월일 -->
$(document).ready(function(){
   var now = new Date(); 
   var year = now.getFullYear(); 
   var mon = (now.getMonth() + 1) > 9 ? ''+(now.getMonth() + 1) : '0'+(now.getMonth() + 1);
   var day = (now.getDate()) > 9 ? ''+(now.getDate()) : '0'+(now.getDate()); 
   
//년도 selectbox만들기 
for(var i = 1900 ; i <= year ; i++) { 
   $('#year').append('<option value="' + i + '">' + i + '</option>'); } 

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
$("#day > option[value="+day+"]").attr("selected", "true"); })
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

<!-- 이용약관 동의 -->
<script type="text/javascript">
   function checkAll() {
      if(document.getElementById("check1").checked == true){
         for (i = 0; i < 3; i++) {
            document.getElementsByName("checkAll")[i].checked=true; //**name="checkAll"의 배열형태로 true를 적용
         }
      }else{
         for (i = 0; i < 3; i++) {
            document.getElementsByName("checkAll")[i].checked=false;
         }
      }
   }
</script>
</body>
</html>