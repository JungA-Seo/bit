<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<div align="center">
	<div class="refundDetail">
		<div align="center" style="width: 100%; height: 30px; border: 1px solid green;">
			<b>환불 처리가 완료된 주문입니다.</b>
		</div>
		<div align="left" style="width: 100%; height: 30px; margin-top: 10px; margin-bottom: 10px;" >
			<b>환불완료 정보</b>
		</div>
		<div>
			<table class="table table-bordered">
				<col width="150px;"><col width="300px;">
				<tr>
					<th>주문번호</th><td>${refundAfter.orderNum}</td>
				</tr>
				<tr>
					<th>주문자명</th><td>${refundAfter.name}</td>
				</tr>
				<tr>
					<th>이메일</th><td>${refundAfter.email}</td>
				</tr>
				<tr>
					<th>결제수단</th><td>${refundAfter.payMethod} , ${refundAfter.cardNum}</td>
				</tr>
				<tr>
					<th>환불된 금액</th><td>${result}원</td>
				</tr>
				<tr>
					<th>환불사유</th><td>${refundAfter.refundReason}</td>
				</tr>	
			</table>
				<input type="button" value="확인" id="check" class="btn btn-primary">
		</div>
	</div>
</div>
<script type="text/javascript">
	$("#check").click(function() {
		location.href="payHistory.do";
	});
</script>	
	
</body>
</html>