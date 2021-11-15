<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
/* request.setCharacterEncoding("utf-8"); */
%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><!-- utf-8설정 -->
<fmt:requestEncoding value="utf-8" />	<!-- 시간형, encoding format 설정할 때 많이 쓰임 -->
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<tiles:insertAttribute name="header" />	<!-- head에 link파일 들어감 -->
</head>
<body>

<tiles:insertAttribute name="top_inc" />
<c:if test="${top_menu == 'yes'}">
<tiles:insertAttribute name="top_menu" />
</c:if>

<div id="body_wrap" style="width: 1600px;">
	<div id="middle_wrap">
		<c:if test="${side_menu == 'menu'}">
			<div id="sidebar_wrap" style="width:200px;">
				<tiles:insertAttribute name="left_menu" />
			</div>
			<div id="content_wrap" style="width:1300px;">
				<tiles:insertAttribute name="main" />
			</div>
		</c:if>
		<c:if test="${empty side_menu}">
			<div id="content_wrap" style="width:100%;">
				<tiles:insertAttribute name="main" />
			</div>
		</c:if>
	</div>
</div>

<div id="footer_wrap">
	<tiles:insertAttribute name="bottom_inc" />
</div>	
</body>
</html>