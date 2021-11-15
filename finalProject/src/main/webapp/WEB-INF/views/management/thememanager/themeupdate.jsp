<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Theme manager Update</title>

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
<input type="hidden" name="sellSeq" value="${tm.sellSeq }">
<h5>기본정보</h5>
<hr width="80%">
<table class="table table-bordered" style="width: 80%" id="writeTable1">


<tr>			<!-- 사업자명, 등록번호, id = value값 넣어야함 -->
	<th>사업자명</th>
	<td><input type="text" name="businessName"  value="${tm.businessName }" ></td>
	<th>사업자 등록번호</th>
	<td><input type="text" name="businessNumber" value="${tm.businessNumber }"></td>
</tr>

<tr>
	<th>판매자 ID</th>
	<td><input type="text" name="hostId" value="${tm.hostId }"></td>	<!-- valueid = loginid로 바꾸기 --> 
	<th>사업자 연락처</th>
	<td><input type="text" name="hostNumber" id="hostNumber" maxlength="13" value="${tm.hostNumber }"></td>
</tr>

<tr>
	<th>카테고리</th>
		<td>
		<select class="form-select" aria-label="Default select example" name="category" id="category">
		  <option selected>선택</option>
		  <option value="시내투어">시내투어</option>
		  <option value="버스투어">버스투어</option>
		  <option value="자연투어">자연투어</option>
		  <option value="이색투어">이색투어</option>
		  <option value="나홀로투어">나홀로투어</option>
		</select>
	</td>
	<th style="padding-left: 10px;">사업체주소</th>
	<td>
		<input type="text" style="width: 350px;" name="hostAddress" id="searchAddress"  value="${tm.hostAddress }"
				data-rules="required" data-error="에러: 주소를 입력해 주세요.">
		<input type="button" class="btn btn-outline-primary" onclick="openDaumPostcode()" value="주소검색">
	</td>
</tr>

<tr>
	<th>호스트소개</th>
	<td colspan="4">
		<textarea rows="1" cols="18" name="hostIntro" style="width: 750px;" placeholder="호스트를 소개해 보세요">${tm.hostIntro }</textarea>
	</td>
<tr>
</table>

<br>

<h5>상품정보</h5>
<hr width="80%">
<table class="table table-bordered" style="width: 80%" id="writeTable2">
<colgroup>
<col width="150px"><col width="100px"><col width="100px"><col width="400px">
</colgroup>
<tr>
	<th>판매 상품 제목</th>
	<td colspan="3">
		<input type="text" name="title" id="title" value="${tm.title }">
	</td>
</tr>

<tr>
	<th>투어최대인원</th>
		<td>
		<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="minPeople" id="minPeople">
		  <option selected>인원선택</option>
			<% for(int i =0; i<50; i++){ %>
			  <option><%=i+1%></option>
			<%
			}
			%>
		</select>
	</td>
	<th>이동수단</th>
	<td>	
		<input type="text" name="transpor" value="${tm.transpor }" >
	</td>
</tr>

<tr>
	<th>소요시간</th>
	<td>	
		<input type="text" name="timetake" value="${tm.timetake }">시간
	</td>
	<th>무료취소기간</th>
		<td>
		<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="cancleperiod" id="cancleperiod">
		  <option selected>기간선택</option>
			<% for(int i =0; i<30; i++){ %>
			  <option value="<%=i+1%>일"><%=i+1 %>일</option>
			<%
			}
			%>
		</select>
	</td>
<tr>
	<th>포함사항</th>
	<td>	
		<input type="text" name="included" value="${tm.included }" >
	</td>
	<th>불포함사항</th>
	<td>	
		<input type="text" name="unincluded" value="${tm.unincluded }" >
	</td>
</tr>

<tr>
	<th>게재도시</th>
	<td>	
		<select class="form-select" aria-label="Default select example" name="city" id="city">
		  <option selected>도시선택</option>
		  <option value="서울">서울</option>
		  <option value="부산">부산</option>
		  <option value="제주도">제주도</option>
		  <option value="가평">가평</option>
		  <option value="강릉">강릉</option>
		  <option value="속초">속초</option>
		  <option value="여수">여수</option>
		  <option value="포항">포항</option>
		</select>
	</td>
	<th>만나는 장소</th>
	<td colspan="3">
		<input type="button" class="btn btn-outline-primary" onclick="openDaumPostcode2()" value="주소검색">
		<input type="text"  name="meetplace" id="searchAddress2" value="${tm.meetplace }"  
				data-rules="required" data-error="에러: 주소를 입력해 주세요." style="width: 300px;">
	</td>
</tr>

<tr>
	<th>이미지등록</th>
		<td colspan="3">
			<div align="left" style="float: left;">
				<div style="font-size: 13px; color: blue;">※ 최대 이미지 5개 업로드가능</div>
				<input type="file" name="fileload" multiple="multiple" class="form-control" >
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
		<textarea id="summernote1" name="goodsExplain">${tm.goodsExplain }</textarea>
	</td>
</tr>

<tr>
	<th>코스소개</th>
	<td colspan="3">
		<textarea id="summernote2" name="courseIntro">${tm.courseIntro }</textarea>
	</td>
</tr>

<tr>
	<th>이용안내</th>
	<td colspan="3">
		<textarea id="summernote3" name="useInfo">${tm.useInfo }</textarea>
	</td>
</tr>

</table>

</form>
</div>

<div align="left">
<strong style="font-size: 12pt;">
<img alt="" src="./image/caution.png">취소 및 환불 규정은 가이드 약관에 따라 자동등록됩니다.
</strong>
</div>
<br>

<div>
<table style="width: 80%">
<tr>
	<td>
		<button class="btn btn-primary" type="button" onclick="history.go(-1);" >이전</button>&nbsp;&nbsp;
		<button class="btn btn-primary" type="button" id="sendBtn" onchange="fileCheck()">수정완료</button>
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

function openDaumPostcode2() {
    new daum.Postcode({
           oncomplete: function (data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
               document.getElementById('searchAddress2').value = data.address;
               document.getElementById('searchAddress2').focus();
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
	        minHeight: 100,
	        minWidth: 200,
	        focus: true, 
	        lang : 'ko-KR'
	        
	  });
	  
	  $('#summernote2').summernote({
	    	placeholder: '코스에 대한 소개를 작성해주세요.(최대 1000자 이내)',
	        minHeight: 150,
	        minWidth: 400,
	        focus: true, 
	        lang : 'ko-KR'
	  });
	  
	  $('#summernote3').summernote({
	    	placeholder: '이용가이드에 대한 내용 입력 해 주세요.(최대 1000자 이내)',
	        minHeight: 150,
	        minWidth: 400,
	        focus: true, 
	        lang : 'ko-KR'
	  });
	  
	  $("#sendBtn").click(function() {
			//alert('click');
		  if($('input[name=businessName]').val() == ''){
	            Swal.fire({
	                 icon: 'error',
	                 text: '회사/사업자명 필수정보를 입력하세요',
	               });
	            return
	         }
	         if($('input[name=businessNumber]').val() == ''){
	            Swal.fire({
	                 icon: 'error',
	                 text: '사업자 등록번호 필수정보를 입력하세요',
	               });
	            return
	         }
	         if($('input[name=hostNumber]').val() == ''){
	            Swal.fire({
	                 icon: 'error',
	                 text: '사업자 연락처 필수정보를 입력하세요',
	               });
	            return
	         }
	         if($('input[name=hostIntro]').val() == ''){
		            Swal.fire({
		                 icon: 'error',
		                 text: '호스트소개 필수정보를 입력하세요',
		               });
		            return
		         }
	         if($('#title').val() == ''){
	             Swal.fire({
	                  icon: 'error',
	                  text: '상품제목 필수정보 입력하세요',
	                });
	             return
	          }
	         if($('#minPeople').val() == '인원선택'){
	             Swal.fire({
	                  icon: 'error',
	                  text: '최대인원 필수정보 선택하세요',
	                });
	             return
	          }
	         if($('#transpor').val() == '선택'){
	             Swal.fire({
	                  icon: 'error',
	                  text: '이동수단 필수정보 선택하세요',
	                });
	             return
	          }
	         if($('input[name=timetake]').val() == ''){
		            Swal.fire({
		                 icon: 'error',
		                 text: '소요시간 필수정보를 입력하세요',
		               });
		            return
		         }
	         if($('#cancleperiod').val() == '기간선택'){
		            Swal.fire({
		                 icon: 'error',
		                 text: '무료취소기간 필수정보를 선택하세요',
		               });
		            return
		         }
	         if($('input[name=included]').val() == ''){
		            Swal.fire({
		                 icon: 'error',
		                 text: '포함사항 필수정보를 입력하세요',
		               });
		            return
		         }
	         if($('input[name=unincluded]').val() == ''){
		            Swal.fire({
		                 icon: 'error',
		                 text: '불포함사항 필수정보를 입력하세요',
		               });
		            return
		         }
	         if($('#city').val() == '도시선택'){
	             Swal.fire({
	                  icon: 'error',
	                  text: '게재도시 필수정보 선택하세요',
	                });
	             return
	          }
	         if($('#meetplace').val() == ''){
	             Swal.fire({
	                  icon: 'error',
	                  text: '만나는장소 필수정보 입력하세요',
	                });
	             return
	          }
	         if($('#goodsExplain').val() == ''){
	             Swal.fire({
	                  icon: 'error',
	                  text: '상품설명 필수정보 입력하세요',
	                });
	             return
	          }
	         if($('#courseIntro').val() == ''){
	             Swal.fire({
	                  icon: 'error',
	                  text: '코스소개 필수정보 입력하세요',
	                });
	             return
	          }
	         if($('#useInfo').val() == ''){
	             Swal.fire({
	                  icon: 'error',
	                  text: '이용안내 필수정보 입력하세요',
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
				url:"themeupdateAf.do",
				type:"post",
				data:dataForm,
				enctype: 'multipart/form-data',
				processData:false,
				contentType:false,
				cache:false,				// Session와 같이 저장을 위한 것.	session은 서버에 저장. cookie는 브라우저에 저장. cache는 임시저장개념
				success:function(msg){
					//alert('success');
					if(msg == 'success'){
						alert('성공적으로 판매등록을 수정하였습니다');
						location.href = "thememainList.do";
					}else{
						alert('판매등록수정에 실패하였습니다');
						location.href = "tmwrite.do";
					}
				},
				error:function(){
					alert('error');
				}
			});
		}); 
		
	  $("#deletepics").click(function() {
			let seq = ${tm.sellSeq }; 
			//alert('success');
			
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