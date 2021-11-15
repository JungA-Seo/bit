<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/orderAdmin.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
<div class="btnArea">
	<input type="button" class="twoBtn" id="btn1" value="결제 내역">&nbsp;<input type="button" class="twoBtn" id="btn2" value="환불 관리">
</div>

<script type="text/javascript">
		
	$("#btn1").click(function() {
		location.href="payHistory.do";
	});
	$("#btn2").click(function() {
		location.href="refundHistory.do";
	});

</script>

</body>
</html>