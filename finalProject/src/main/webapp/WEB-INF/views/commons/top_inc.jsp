<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><!-- utf-8설정 -->
<fmt:requestEncoding value="utf-8" /> <!-- 시간형, encoding format 설정할 때 많이 쓰임 -->

<link rel="stylesheet" href="./css/top_inc.css">

<style>
#dropdownMenuButton1{
	margin-right: 10px;
	border-radius: 50px;
}
#dropdownMenuButton1:hover{
	background-color: white;
	opacity: 0.6;
	transition: 0.3s;
}
.dropdown-item img{
	margin-right: 10px;
}
.mypage_icons{
	width: 300px;
}
.container-fluid .btn{
	border-color: white;
}
</style>

<div id="menubar" >
<div style="width: 100%; height: 53px; margin-top:10px; display: flex;">
	<div style="width: 100%;display: flex;" id="menu1">
		<div id="_title_image" style="margin-left: 20px;">
			<img alt="" src="./image/logotest2.png" style="height: 53px" onclick="location.href='main.do'">
		</div>
		<div style="width: 63%;" > <!-- 상단바  -->
			<!-- <form class="container-fluid justify-content-start"> -->
				<a href="main.do" title="Home"><button class="button-48" role="button" type="button"><span class="text">Home</span></button></a>
				<a href="bbslist.do" title="커뮤니티"><button class="button-48" role="button" type="button"><span class="text">커뮤니티</span></button></a>
				<a href="tmsearch.do" title="테마여행">
					<button class="button-48" role="button" type="button"><span class="text">테마여행</span></button></a>
				<a href="main_activity.do" title="액티비티">
					<button class="button-48" role="button" type="button"><span class="text">액티비티</span></button>
				</a>
			<c:if test="${login.auth == 2}">	<!— 판매자권한  —>
				<a href="management.do" title="판매자페이지"><button class="button-48" role="button" type="button"><span class="text">판매자페이지</span></button></a>
			</c:if>
			<c:if test="${login.auth == 1}"> 	<!— 관리자권한  —>
				<a href="management.do" title="관리자페이지">
					<button class="button-48" role="button" type="button"><span class="text">관리자페이지</span></button>
				</a>
			</c:if>
			<!--  </form> -->
		</div>
	</div>
	<div class="mypage_icons" id="menu2">
		<c:set var="fileStr" value="${login.newFilename }" />
		<c:set var="length"  value="${fn:length(fileStr)}"/>
		<c:set var="filename"  value="${fn:substring(fileStr, length-3, length)}"/>
		<c:if test="${empty login.id}">	<!-- 로그아웃한 경우 -->
			<ul style="display: flex; list-style: none;">
				<li style="margin-right: 10px;"><a href="login.do" title="로그인"><button type="button" class="button-48" role="button"><span class="text" style="color: #606ADC; font-weight: bold;">로그인</span></button></a></li>
				<li><a href="#" title="회원가입"><button type="button" class="button-48" role="button" data-bs-toggle="modal" data-bs-target="#exampleModal"><span class="text">회원가입</span></button></a></li>
			</ul>
		</c:if>
		<c:if test="${not empty login.id}">	<!-- 로그인한 경우 -->
			<c:if test="${filename != 'tmp' && not empty login.newFilename }">
			<img src="http://localhost:8090/flenda/upload/${login.newFilename }" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" width="50px" height="50px" style="border-radius: 30px;">
			<span><strong>${login.name }</strong></span>
			</c:if>
			<c:if test="${filename == 'tmp' || empty login.newFilename}">
			<img src="./image/noProfile.png" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" width="50px" height="50px">
			<span><strong>${login.name }</strong></span>
			</c:if>
			<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" style="padding: 10px;">
				<li>&nbsp;&nbsp;<img src="./image/dollar.png" width="25px" height="25px"><strong> 포인트  ${login.point }</strong></li>
				<li><hr class="dropdown-divider"></li>
				<li><a class="dropdown-item" href="mybbslist.do"><img src="./image/mypage_write.png" width="15px" height="15px">내가 쓴 글</a></li>
				<li><a class="dropdown-item" href="wishlist.do"><img src="./image/mypage_wish.png" width="15px" height="15px">위시리스트</a></li>
				<li><a class="dropdown-item" href="buyhistory.do"><img src="./image/mypage_buy.png" width="15px" height="15px">구매 내역</a></li>
				<li><a class="dropdown-item" href="check.do"><img src="./image/mypage_personal.png" width="15px" height="15px">개인 정보</a></li>
				<li><hr class="dropdown-divider"></li>
				<li style="text-align: center;"><a class="dropdown-item" href="logout.do">로그아웃</a></li>
			</ul>
		</c:if>
	</div>
</div>
</div>

 <!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
       <h3 class="modal-title" id="exampleModalLabel" style="text-align:center; color: #692498;" align="center"> WILL YOU JOIN US?</h3>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="regi.do">
           <div class="totalBox" style="display: flex; vertical-align: middle;" >
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="box1" >
                  <button type="button"  class="btn btn-link" style= "border:none"><img alt="" src="image/individual.png"  border="0" id="individual" style="width:300px; height:300px; text-align: center; border:none;"></button>
               </div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <div class="box2" >
                  <button type="button"  class="btn btn-link" style= "border:none"><img alt="" src="image/business.png"  border="0" id="business" style="width:300px; height:300px; text-align: center; border:none;"></button>
              </div>
           </div>
           <div class="modal-footer"></div>
           </form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
$('#individual').click(function(){
	location.href ="regi.do?param=individual"; 
});

$('#business').click(function(){
	location.href ="regi.do?param=business";
});
</script>