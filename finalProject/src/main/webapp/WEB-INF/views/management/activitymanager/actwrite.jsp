<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>theme manager write</title>
<!-- include libraries(jQuery, bootstrap)  현재 기존 부트스트랩5.0이랑 충돌남 해결해야할것-->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<!-- <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<!-- alert창 -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style type="text/css">
th{
	text-align: center;
}
</style>
</head>
<body>

<div align="left">
	<form id="upload_file_frm">
		<input type="hidden" name="latitude" id="latitude" ><!-- latitude(위도) -->
		<input type="hidden" name="longitude" id="longitude"><!-- longitude(경도) -->
		
		<h3><b>기본정보</b></h3>
		<hr width="80%">
		<table class="table table-bordered" style="width: 80%" id="writeTable1">
		
		<tr>			<!-- 사업자명, 등록번호, id = value값 넣어야함 -->
			<th>회사/사업자명 <font color="red" size="4">*</font></th>
			<td><input type="text" name="businessName" value="${login.businessName }"></td>
			<th>사업자 등록번호 <font color="red" size="4">*</font></th>
			<td><input type="text" name="businessNumber" value="${login.businessNumber }"></td>
		</tr>
		
		<tr>
			<th>판매자 ID</th>
			<td><input type="text" name="hostId" value="${login.id }" readonly="readonly"></td>
			<th>사업자 연락처 <font color="red" size="4">*</font></th>
			<td><input type="text" name="businessPhoneNum" maxlength="12"></td>
		</tr>
		
		<tr>
			<th>카테고리 <font color="red" size="4">*</font></th>
				<td colspan="3">
				<select class="form-select" aria-label="Default select example" name="category" id="_category" style="width: 200px; font-size: 13px;">
				  <option selected>선택</option>
				  <option value="activity">액티비티</option>
				  <option value="ticket">티켓</option>
				  <option value="experience">체험</option>
				</select>
			</td>
		</tr>
		<tr>	
			<th style="padding-left: 10px;">사업체주소 <font color="red" size="4">*</font></th>
			<td colspan="3">
				<input type="text" style="width: 350px;" name="address" id="searchAddress" 
						data-rules="required" data-error="에러: 주소를 입력해 주세요.">&nbsp;&nbsp;
				<input type="button" class="btn btn-primary" onclick="openDaumPostcode()" value="주소검색"><br>
				<input type="text" name="detailAddress" id="detailAddress" onchange="checkMap()" placeholder="상세주소"><br>
				<div id="map"></div>
			</td>
		</tr>
		
		<tr>
			<th>호스트소개</th>
			<td colspan="4">
				<textarea rows="1" cols="18" name="hostintro" class="form-control" style="width: 770px; height: 100px;" placeholder="호스트를 소개해 보세요"></textarea>
			</td>
		<tr>
		</table>
		
		<br>
		
		<h3><b>상품정보</b></h3>
		<hr width="80%">
		<table class="table table-bordered" style="width: 80%" id="writeTable2">
		<tr>
			<th style="width: 150px;">판매 상품 제목 <font color="red" size="4">*</font></th>
			<td colspan="3">
				<input type="text" name="title" id="title" style="width: 600px;">
			</td>
		</tr>
		
		<tr>
			<th>최대인원 <font color="red" size="4">*</font></th>
				<td>
				<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="maxPeople" id="_maxPeople" style=" font-size: 13px;">
				  <option selected>인원선택</option>
					<% for(int i =0; i<50; i++){ %>
					  <option><%=i+1 %></option>
					<%
					}
					%>
				</select>
			</td>
			<th>포함사항</th>
			<td>	
				<input type="text" name="included" style="width: 300px;">
			</td>
		</tr>
		
		<tr>
			<th>소요시간 <font color="red" size="4">*</font></th>
			<td>	
				<input type="text" name="timetake" style="width: 100px;">&nbsp;&nbsp;시간
			</td>
			<th>바우처여부 <font color="red" size="4">*</font></th>
				<td>
				<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="ticket" id="_ticket" style=" font-size: 13px;">
				  <option selected>선택</option>
				  <option value="모바일 또는 출력된 바우처">모바일 또는 출력된 바우처</option>
				  <option value="모바일 바우처">모바일 바우처</option>
				  <option value="출력된 바우처">출력된 바우처</option>
				</select>
			</td>
		
		<tr>
			<th>이미지등록 <font color="red" size="4">*</font></th>
			<td colspan="3">
				<div style="font-size: 13px; color: blue;">※ (필수) 이미지 5개 업로드 해주세요</div>
				<input type="file" name="fileload" multiple="multiple" class="form-control" onchange="fileCheck()" style="width: 600px;">
			</td>
		</tr>
	
		<tr>
			<th>상품설명 <font color="red" size="4">*</font></th>
			<td colspan="3">
				<textarea id="summernote1" name="goodsExplain"></textarea>
			</td>
		</tr>
		<tr>
			<th>이용안내 <font color="red" size="4">*</font></th>
			<td colspan="3">
				<textarea id="summernote2" name="useInfo"></textarea>
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
				<button class="btn btn-primary" type="button" id="sendBtn">판매등록</button>
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
               document.getElementById('detailAddress').focus();
           }
     }).open();
}
</script>

 <!-- 썸머노트 -->
<script>
$(document).ready(function() {
	setTimeout(function() {
		$('input[name=businessName]').focus();
	});
	
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

		//체크
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
			if($('input[name=detailAddress]').val() == ''){
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
		  
		  
	  	let data = $('#upload_file_frm')[0];
	  	let dataForm = new FormData(data);
		$.ajax({
			url:"actwriteAf.do",
			type:"post",
			data:dataForm,
			enctype: 'multipart/form-data',
			processData:false,
			contentType:false,
			cache:false,				// Session와 같이 저장을 위한 것.	session은 서버에 저장. cookie는 브라우저에 저장. cache는 임시저장개념
			success:function(msg){
				alert('success');
				if(msg == 'success'){
					alert('성공적으로 글작성하였습니다');
					location.href = "activity.do";
				}else{
					alert('글작성 실패하셨습니다');
					location.href = "actwrite.do";
				}
			},
			error:function(){
				alert('error');
			}
		});
	}); 
});
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=397303b6b1a3824cfbfe07f9d7527206&libraries=services"></script> <!-- 카카오지도 -->
<script type="text/javascript">
function checkMap() {
	let Myaddress = document.getElementById('searchAddress').value;//  주소를 가져온다. by이기동** 
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	    mapOption = {
	        center: new kakao.maps.LatLng(37.5556326132925, 126.992217614712), // 지도의 중심좌표
	        level: 5 // 지도의 확대 레벨
	    };  
	
	mapContainer.style.width = "400px";
	mapContainer.style.height = "400px";
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(Myaddress, function(result, status) {	// 주소를 입력한다. by이기동**
		
		var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
	    imageSize = new kakao.maps.Size(40, 40), // 마커이미지의 크기입니다
	    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	    
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);	// *********검색한 주소의 좌표가져온다
			//alert(result[0].y+" "+result[0].x);
	        document.getElementById("latitude").value = result[0].y;
	        document.getElementById("longitude").value = result[0].x;
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
        	});

	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+ Myaddress +'</div>'
	        });
	        
	        infowindow.open(map, marker);

	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});
}
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