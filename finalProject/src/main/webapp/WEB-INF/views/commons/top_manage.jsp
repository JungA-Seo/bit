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


<div style="width: 100%; height: 53px; margin-top:20px;  margin-bottom: 20px; display: flex;">
	<div style="width: 100%;display: flex;">
		<div id="_title_image" style="margin-left: 20px;">
			<img alt="" src="./image/logotest2.png" style="height: 53px">
		</div>
		<div style="width: 80%;">
			<form class="container-fluid justify-content-start">
				<a href="management.do" title="Home"><button class="button-48" role="button" type="button"><span class="text">Home</span></button></a>
				<c:if test="${login.auth == 1}">
				<a href="memManagement.do" title="회원정보"><button class="button-48" role="button" type="button"><span class="text">회원정보</span></button></a>
				<a href="bbsManager.do" title="커뮤니티"><button class="button-48" role="button" type="button"><span class="text">커뮤니티</span></button></a>
				</c:if>
				<a href="thememainList.do" title="테마여행"><button class="button-48" role="button" type="button"><span class="text">테마여행</span></button></a>
				<a href="activity.do" title="액티비티"><button class="button-48" role="button" type="button"><span class="">액티비티</span></button></a>
				<c:if test="${login.auth == 1}">
				<a href="chat.do" title="문의관리"><button class="button-48" role="button" type="button"><span class="text">문의관리</span></button></a>
				<a href="orderHis.do" title="결제관리"><button class="button-48" role="button" type="button"><span class="text">결제관리</span></button></a>
				<a href="statisic.do" title="통계"><button class="button-48" role="button" type="button"><span class="text">통계</span></button></a>
				</c:if>
			</form>
		</div>
	</div>
	<a href="main.do" title="회원가입"><button type="button" class="btn btn-outline-dark rounded-pill" style="width: 130px; margin-right: 20px; margin-top: 5px;">사용자페이지</button></a>
	<div class="mypage_icons">
		<c:set var="fileStr" value="${login.newFilename }" />
		<c:set var="length"  value="${fn:length(fileStr)}"/>
		<c:set var="filename"  value="${fn:substring(fileStr, length-3, length)}"/>
		<c:if test="${filename != 'tmp'}">
		<img src="http://localhost:8090/flenda/upload/${login.newFilename }" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" width="50px" height="50px" style="border-radius: 30px;">
		<span><strong>${login.name }</strong></span>
		</c:if>
		<c:if test="${filename == 'tmp'}">
		<img src="./image/noProfile.png" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" width="50px" height="50px">
		<span><strong>${login.name }</strong></span>
		</c:if>
		<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" style="padding: 10px;">
			<li>&nbsp;&nbsp;<img src="./image/dollar.png" width="25px" height="25px"><strong> 포인트  ${login.point }</strong></li>
			<li><hr class="dropdown-divider"></li>
			<li><a class="dropdown-item" href="mybbslist.do"><img src="./image/mypage_write.png" width="15px" height="15px">내가 쓴 글</a></li>
			<li><a class="dropdown-item" href="wishlist.do"><img src="./image/mypage_wish.png" width="15px" height="15px">위시리스트</a></li>
			<li><a class="dropdown-item" href="buyhistory.do"><img src="./image/mypage_buy.png" width="15px" height="15px">구매 내역</a></li>
			<li><a class="dropdown-item" href="#"><img src="./image/mypage_personal.png" width="15px" height="15px">개인 정보</a></li>
			<li><hr class="dropdown-divider"></li>
			<li style="text-align: center;"><a class="dropdown-item" href="logout.do">로그아웃</a></li>
		</ul>
	</div>
</div>