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
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
	
	<div class="refundBase">
		<div style="height: 30px; margin-bottom: 15px" align="left">
			<h2>환불 정보</h2>
		</div>
		<div>
			<table class="table">
				<col width="150px"><col width="350px"><col width="150px"><col width="350px">
				<tr>
					<th>주문번호</th><td>${refundAfter.orderNum}</td><th>주문자명</th><td>${order.name}</td>
				</tr>
				<tr>
					<th>이메일</th><td>${order.email}</td><th>휴대번호</th><td>${order.phone}</td>
				</tr>
				<tr>
					<th>상품구매금액</th><td>${refundAfter.refundPrice}원</td><th>취소 비용</th><td>${refundAfter.balance}원</td>
				</tr>
				<tr>
					<th>총 환불금액</th><td colspan="3">${refundAfter.refundPrice} - ${refundAfter.balance} = ${result}원</td>
				</tr>
				<tr>
					<th>결제수단</th><td colspan="3">${refundAfter.payMethod}  ${refundAfter.cardNum}</td>
				</tr>
				<tr>
					<th>환불사유</th><td colspan="3"><input type="text" id="refundReason" size="100px"></td>
				</tr>
			</table>
			<div class="rfnBtn">
				<input type="button" class="btn btn-outline-secondary" id="rBtn" value="환불 접수">&nbsp;&nbsp;<input type="button" class="btn btn-outline-secondary" id="cBtn" value="접수 취소">
			</div>
		</div>
	</div>
	
<script type="text/javascript">
	$(document).ready(function() {
		$("#rBtn").click(function() {
			let orderSeq = '${refundAfter.orderNum}';
			let msg = $("#refundReason").val();
			location.href="refundSuc.do?orderNum=" + orderSeq + "&refundReason="+msg;
		});
		
		$("#cBtn").click(function() {
			location.href="refundHistory.do";
		})
		
	});

</script>	
	
</body>
</html>