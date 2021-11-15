<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
@import url(//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css);
.profile{
	width: 100%;
	height: 300px;
	padding-top: 50px;
	background-color: #EFF5FB;
	font-family: 'Spoqa Han Sans Neo', 'sans-serif';
	text-align: center;
}
.userImg{
 	margin-left: 48px;
 	width:90px;
 	height:90px;
 	overflow: hidden;
 	display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50px;
}
.userImg img{
	width:90px;
 	height:90px;
}
.userName{
	margin: 20px;
	font-weight: bold;
	font-size: 25px;
}
.points{
	font-size: 18px;
}
</style>

<c:set var="fileStr" value="${login.newFilename }" />
<c:set var="length"  value="${fn:length(fileStr)}"/>
<c:set var="filename"  value="${fn:substring(fileStr, length-3, length)}"/>
    
<div class="menu_table">
	<div class="shadow mb-5 mt-3 bg-body rounded">
	<div class="profile">
		<c:if test="${filename != 'tmp' && not empty login.newFilename }">
		<div class="userImg"><img src="http://localhost:8090/flenda/upload/${login.newFilename }"></div>
		</c:if>
		<c:if test="${filename == 'tmp' || empty login.newFilename}">
		<div class="userImg"><img src="./image/noProfile.png" width="170px" height="170px"></div>
		</c:if>
		<div class="userName">${login.name }</div>
		<div class="points">내 포인트<br>${login.point }</div>
	</div>
	<ul class="nav flex-column m-3">
		<li class="nav-item">
			<a class="nav-link" href="mybbslist.do" style="color: #606ADC;">내가 쓴 글</a>
			<hr style="color: #D8D8D8">
		</li>
		<li class="nav-item">
			<a class="nav-link" href="wishlist.do" style="color: #606ADC;">위시리스트</a>
			<hr style="color: #D8D8D8">
		</li>
		<li class="nav-item">
			<a class="nav-link" href="buyhistory.do?id=${login.id}" style="color: #606ADC;">구매 내역</a>
			<hr style="color: #D8D8D8">
		</li>
		<li class="nav-item mb-3">
			<a class="nav-link" href="check.do" style="color: #606ADC;">개인 정보</a>
		</li>
	</ul>
	</div>
</div>

