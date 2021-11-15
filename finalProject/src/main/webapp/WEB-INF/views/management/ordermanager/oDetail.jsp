<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="./css/orderAdmin.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>

	<div class="detailBase">
		<div class="orderDetail">
			<div style="height: 30px; margin-bottom: 15px;" align="left">
				<h3>결제 상세보기</h3>
			</div>
			<table class="table">
				<tr">
					<th>상품코드</th><th>상품명</th><th>총 결제액</th><th>수량</th><th>환불신청</th>
				</tr>
				<tr>
					<td>${dto.orderNum}</td><td>${dto.itemName}</td><td>${dto.paidMoney}</td><td>${dto.totalCount}</td><td><input type="button" class="btn btn-outline-secondary" value="환불" onclick="refurn(${dto.orderNum})"></td>
				</tr>
			</table>
		</div>
		<div class="orderMember">
			<div style="height: 30px; margin-bottom: 15px;" align="left">
				<h3>주문자 정보</h3>
			</div>
				<table class="table">
					<col width="150px"><col width="350px"><col width="150px"><col width="350px">
					<tr>
						<th>주문자명/ID</th><td>${dto.name} / ${dto.id}</td><th>주소</th><td>${mDto.address}</td>
					</tr>
					<tr>
						<th>이메일</th><td>${mDto.email}</td><th>입금자명</th><td>${dto.name}</td>
					</tr>
					<tr>
						<th>주문번호</th><td>${dto.orderNum }</td><th>결제수단</th><td>${dto.payMethod }</td>
					</tr>
					<tr>
						<th>주문일자</th><td>${dto.orderDate}</td><th>결제계좌</th><td>${dto.cardName} ${dto.cardNum}</td>
					</tr>
				</table>
				<button id="check" class="btn btn-primary" style="width: 100px; padding-right: 30px;">확인</button>
		</div>
	</div>

<script type="text/javascript">
function refurn(seq){
	location.href="refundHistory.do?seq="+seq;
}

$("#check").click(function() {
	location.href="payHistory.do";
});

</script>

</body>
</html>