<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
<div align="center" style="margin-top: 50px; margin-bottom: 20px;">
	<div class="btn-group" role="group" aria-label="Basic outlined example">
	  <button type="button" id="btn1" class="btn btn-outline-primary">매출 통계</button>
	  <button type="button" id="btn2" class="btn btn-outline-primary">접속자 수</button>
	  <button type="button" id="btn3" class="btn btn-outline-primary">신규 가입자 수</button>
	</div>
</div>
<hr>
<script type="text/javascript">
	$("#btn1").click(function() {

		location.href="salesMain.do";
	});
	$("#btn2").click(function() {

		location.href="memberMain.do";
	});
	$("#btn3").click(function() {

		location.href="newMemberMain.do";
	});
</script>



</body>
</html>