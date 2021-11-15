<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbsMwrite</title>
<!-- include libraries(jQuery, bootstrap)  현재 기존 부트스트랩5.0이랑 충돌남 해결해야할것-->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<link rel="stylesheet" href="./css/bbs/bbswrite.css">

</head>
<body>

<div align="center">
	<form id="upload_file_frm">	
		<input type="hidden" name="id"  value="${login.id }">
		<input type="hidden" name="profileImg"  value="${login.newFilename }">		
		<h1>새 글 작성</h1>
		<hr width="100%">		
		<table class="table table-bordered" style="width: 80%" id="writeTable">			
			<tr>
				<th style="width: 150px;">제목</th>
				<td colspan="3">
					<input type="text" name="title" id="title" style="width: 100%;">
				</td>
			</tr>
			
			<tr>
				<th>카테고리</th>
					<td>
						<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="category" >
							<option selected>선택</option>
							<option value="여행기">여행기</option>
							<option value="메모">메모</option>
							<option value="잡담">잡담</option>
						</select>
					</td>
				<th>지역선택</th>
					<td>
						<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="area" >
							<option selected>선택</option>
							<option value="서울">서울</option>
							<option value="인천">인천</option>
							<option value="경기도">경기도</option>
							<option value="강원도">강원도</option>
							<option value="충청도">충청도</option>
							<option value="대전">대전</option>
							<option value="전라도">전라도</option>
							<option value="광주">광주</option>
							<option value="경상도">경상도</option>
							<option value="대구">대구</option>
							<option value="울산">울산</option>
							<option value="부산">부산</option>
							<option value="제주도">제주도</option>
						</select>
					</td>
			</tr>
			
			<tr>
				<th>위치</th>
				<td colspan="3">	
					<input type="text" name="address" style="width: 100%;">
				</td>
			</tr>
			
			<tr>
				<th>(대표)이미지첨부</th>
				<td colspan="3">
					<div style="font-size: 13px; color: blue;">※ 게시판 목록에서 보여질 이미지를 넣어주세요</div>
					<input type="file" name="fileload" class="form-control" style="width: 100%;"> <!-- multiple="multiple" -->
				</td>
			</tr>
		
			<tr>
				<th>내용</th>
				<td colspan="3">
					<textarea id="summernote" name="content"></textarea>
				</td>
			</tr>
		</table>
	</form>
</div>

<div align="center">
	<button class="btn btn-primary" type="button" onclick="history.go(-1);" >이전</button>&nbsp;&nbsp;
	<button class="btn btn-primary" type="button" id="sendBtn">작성완료</button>
			
</div> 

<!-- 썸머노트 -->
<script>
$(document).ready(function() {
	
	$('#summernote').summernote({
		placeholder: '내용을 입력해주세요 (최대 1,000자 이내)',
	    minHeight: 600,
	    minWidth: 400,
	    focus: true, 
	    lang : 'ko-KR'
	});
	  
	$("#sendBtn").click(function() {
		let data = $('#upload_file_frm')[0];
		let dataForm = new FormData(data);
		$.ajax({
			url:"bbsMwriteAf.do",
			type:"post",
			data:dataForm,
			enctype: 'multipart/form-data',
			processData:false,
			contentType:false,
			cache:false,				// Session와 같이 저장을 위한 것.	session은 서버에 저장. cookie는 브라우저에 저장. cache는 임시저장개념
			success:function(msg){
					alert('success');
					if(msg == 'success'){
						alert('성공적으로 글 작성 하였습니다');
						location.href = "bbsManager.do";
					}else{
						alert('글 작성을 실패했습니다');
						location.href = "bbsMwrite.do";
					}
				},
				error:function(/* request, status, error */){
					alert('error');
				}
			});
		});
});

</script>

</body>
</html>