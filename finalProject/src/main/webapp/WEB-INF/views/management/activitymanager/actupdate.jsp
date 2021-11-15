<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>activity manager update</title>
<!-- include libraries(jQuery, bootstrap)  현재 기존 부트스트랩5.0이랑 충돌남 해결해야할것-->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<!-- alert창 -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>

<div align="left">
	<form id="upload_file_frm">
		<input type="hidden" name="sellSeq" value="${act.sellSeq }">
		<h5>기본정보</h5>
		<hr width="80%">
		<table class="table table-bordered" style="width: 80%" id="writeTable1">
		
		<tr>			<!-- 사업자명, 등록번호, id = value값 넣어야함 -->
			<th>회사/사업자명</th>
			<td><input type="text" name="businessName" value="${act.businessName }"></td>
			<th>사업자 등록번호</th>
			<td><input type="text" name="businessNumber" value="${act.businessNumber }"></td>
		</tr>

		<tr>
			<th>판매자 ID</th>
			<td><input type="text" name="hostId" value="${act.hostId }" readonly></td>
			<th>사업자 연락처</th>
			<td><input type="text" name="businessPhoneNum" maxlength="12" value="${act.businessPhoneNum }"></td>
		</tr>
		
		<tr>
			<th>카테고리</th>
				<td>
				<select class="form-select" aria-label="Default select example" name="category" id="_category" style="font-size: 13px;">
				  <option selected>선택</option>
				  <option value="activity">액티비티</option>
				  <option value="ticket">티켓</option>
				  <option value="experience">체험</option>
				</select>
			</td>
			<th style="padding-left: 10px;">사업체주소</th>
			<td>
				<input type="text" style="width: 350px;" name="address" id="searchAddress" value="${act.address }" 
						data-rules="required" data-error="에러: 주소를 입력해 주세요.">
				<input type="button" class="btn btn-primary" onclick="openDaumPostcode()" value="주소검색">
			</td>
		</tr>
		
		<tr>
			<th>호스트소개</th>
			<td colspan="4">
				<textarea rows="1" cols="18" name="hostintro" class="form-control" style="width: 770px; height: 100px;" placeholder="호스트를 소개해 보세요">${act.hostintro }</textarea>
			</td>
		<tr>
		</table>
		
		<br>
		
		<h5>상품정보</h5>
		<hr width="80%">
		<table class="table table-bordered" style="width: 80%" id="writeTable2">
		<tr>
			<th style="width: 150px;">판매 상품 제목</th>
			<td colspan="3">
				<input type="text" name="title" id="title" style="width: 600px;" value="${act.title }">
			</td>
		</tr>
		
		<tr>
			<th>최대인원</th>
				<td>
				<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="maxPeople" id="_maxPeople" style="font-size: 13px;">
				  <option selected>인원선택</option>
					<% for(int i =0; i<50; i++){ %>
					  <option value="<%=i+1%>"><%=i+1 %></option>
					<%
					}
					%>
				</select>
			</td>
			<th>포함사항</th>
			<td>	
				<input type="text" name="included" style="width: 300px;" value="${act.included }">
			</td>
		</tr>
		
		<tr>
			<th>소요시간</th>
			<td>	
				<input type="text" name="timetake" style="width: 100px;" value="${act.timetake }">시간
			</td>
			<th>바우처여부</th>
				<td>
				<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="ticket" id="_ticket" style="font-size: 13px;">
				  <option selected>선택</option>
				  <option value="tickets">모바일 또는 출력된 바우처</option>
				  <option value="eticket">모바일 바우처</option>
				  <option value="pticket">출력된 바우처</option>
				</select>
			</td>
		
		<tr>
			<th>이미지등록</th>
			<td colspan="3">
				<div align="left" style="float: left;">
					<div style="font-size: 13px; color: blue;">※ (필수) 이미지 5개 업로드 해주세요</div>
					<input type="file" name="fileload" multiple="multiple" class="form-control" style="width: 400px;" onchange="fileCheck()">
				</div>
				<div align="right" style="float: right; margin-right: 50px;">
					<div style="font-size: 13px; color: red;"><b>현재 업로드 된 사진 수 : <span id="countPics">${countPics}</span>장</b></div>
					<input type="button" class="btn btn-outline-danger" value="기존사진 전체삭제" id="deletepics">
				</div>
			</td>
		</tr>
	
		<tr>
			<th>상품설명</th>
			<td colspan="3">
				<textarea id="summernote1" name="goodsExplain">${act.goodsExplain }</textarea>
			</td>
		</tr>
		<tr>
			<th>이용안내</th>
			<td colspan="3">
				<textarea id="summernote2" name="useInfo">${act.useInfo }</textarea>
			</td>
		</tr>
		
		</table>
	</form>
</div>

<div>
	<table style="width: 80%">
		<tr>
			<td>
				<button class="btn btn-primary" type="button" onclick="history.go(-1);" >이전</button>&nbsp;&nbsp;
				<button class="btn btn-primary" type="button" id="sendBtn">수정완료</button>
			</td>
		</tr>
	</table>
</div> 

<!-- 다음주소가져오기 -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
function openDaumPostcode() {
    new daum.Postcode({
           oncomplete: function (data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
               document.getElementById('searchAddress').value = data.address;
               document.getElementById('searchAddress').focus();
           }
     }).open();
}
</script>

 <!-- 썸머노트 -->
<script>
$(document).ready(function() {
	$('#_category').val('${act.category}');
	$('#_maxPeople').val('${act.maxPeople}');
	$('#_ticket').val('${act.ticket}');
	
	
	setTimeout(function() {
		$('input[name=businessName]').focus();
	});
	
		$('#category').val('${act.category}');
		$('#maxPeople').val('${act.maxPeople}');
		$('#ticket').val('${act.ticket}');
	
	  $('#summernote1').summernote({
	    	placeholder: '상품설명을 최대 1000자 이내로 작성해주세요 (이미지 첨부시 설명생략가능)',
	        minHeight: 150,
	        minWidth: 400,
	        focus: true, 
	        lang : 'ko-KR'
	  });
	  
	  $('#summernote2').summernote({
	    	placeholder: '이용가이드에 대한 내용 입력 해 주세요.(최대 1000자 이내)',
	        minHeight: 150,
	        minWidth: 400,
	        focus: true, 
	        lang : 'ko-KR'
	  });
	  
	  $("#sendBtn").click(function() {
		  if($('input[name=businessName]').val() == ''){
				Swal.fire({
					  icon: 'error',
					  text: '회사/사업자명 필수정보 입력하세요'
					});
				return
			}
			if($('input[name=businessNumber]').val() == ''){
				Swal.fire({
					  icon: 'error',
					  text: '사업자 등록번호 필수정보 입력하세요'
					});
				return
			}
			if($('input[name=businessPhoneNum]').val() == ''){
				Swal.fire({
					  icon: 'error',
					  text: '사업자 연락처 필수정보 입력하세요'
					});
				return
			}
			if($('#_category').val() == '선택'){
				Swal.fire({
					  icon: 'error',
					  text: '카테고리 필수정보 입력하세요'
					});
				return
			}
			if($('input[name=address]').val() == ''){
				Swal.fire({
					  icon: 'error',
					  text: '사업체주소 및 상세주소 필수정보 입력하세요'
					});
				return
			}
			if($('input[name=title]').val() == ''){
				Swal.fire({
					  icon: 'error',
					  text: '판매 상품 제목 필수정보 입력하세요'
					});
				return
			}
			if($('#_maxPeople').val() == '인원선택'){
				Swal.fire({
					  icon: 'error',
					  text: '최대인원 필수정보 선택하세요'
					});
				return
			}
			if($('input[name=timetake]').val() == ''){
				Swal.fire({
					  icon: 'error',
					  text: '소요시간 필수정보 입력하세요'
					});
				return
			}
			if($('#_ticket').val() == '선택'){
				Swal.fire({
					  icon: 'error',
					  text: '바우처여부 필수정보 선택하세요'
					});
				return
			}
			if($('input[name=fileload]').val() == ''){
				Swal.fire({
					  icon: 'error',
					  text: '이미지 5개 업로드하세요'
					});
				return
			}
			if($('#summernote1').val() == ''){
				Swal.fire({
					  icon: 'error',
					  text: '상품설명 필수정보 입력하세요'
					});
				return
			}
			if($('#summernote2').val() == ''){
				Swal.fire({
					  icon: 'error',
					  text: '이용안내 필수정보 입력하세요'
					});
				return
			}
			if(parseInt($("input[type='file']")[0].files.length) != 5){
				Swal.fire({
					  icon: 'error',
					  text: '이미지 5개 업로드 해주세요'
					});
				return
			}  
		  	if(parseInt($('#countPics').html()) == 5 &&  parseInt($("input[type='file']")[0].files.length) == 5){
		  		Swal.fire({
					  icon: 'error',
					  text: '기존 업로드된 이미지 5개 삭제 후, 재업로드 해주세요'
					});
				return
		  	}
		  
		  	let data = $('#upload_file_frm')[0];
		  	let dataForm = new FormData(data);
			$.ajax({
				url:"actupdateAf.do",
				type:"post",
				data:dataForm,
				enctype: 'multipart/form-data',
				processData:false,
				contentType:false,
				cache:false,				// Session와 같이 저장을 위한 것.	session은 서버에 저장. cookie는 브라우저에 저장. cache는 임시저장개념
				success:function(msg){
					alert('success');
					if(msg == 'success'){
						alert('성공적으로 글수정하였습니다');
						location.href = "activity.do";
					}else{
						alert('글수정 실패하셨습니다');
						location.href = "actwrite.do";
					}
				},
				error:function(){
					alert('error');
				}
			});
		}); 
});
$("#deletepics").click(function() {
	let seq = ${act.sellSeq }; 
	alert('success');
	
	$.ajax({
		url:"deletePic.do",
		type:"post",
		data: { sellSeq:seq },
		success:function(map){
			if(map.msg == 'success'){
				$('#countPics').empty();
				$('#countPics').text(map.countPics);
				alert('성공적으로 사진삭제하였습니다');
			}
		},
		error:function(){
			alert('error');
		}
	}); 
});
function fileCheck() {
	let fileslength = $("input[type='file']")[0].files.length;
	if(parseInt(fileslength) == 5){
		Swal.fire({
			  icon: 'success',
			  text: '이미지 5개 업로드 성공!'
			});
	}else{
		Swal.fire({
			  icon: 'error',
			  text: '이미지 5개 업로드 해주세요'
			});
	}
}
</script>
</body>
</html>