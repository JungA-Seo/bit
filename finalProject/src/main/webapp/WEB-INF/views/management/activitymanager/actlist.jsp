<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- datepicker 사용 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- pagination -->
<script type="text/javascript" src="./resources/pagination/jquery.twbsPagination.min.js"></script>
</head>
<body>
<!-- 상단 서칭부분 -->
<div align="center" style="margin-top: 40px;">
	<form id="frm" method="get">
		<table>
		<col width="80"><col width="70"><col width="250">
			<tr>
				<th style="font-size: 15px; text-align: center;" >등록일</th>
				<td colspan="3">
					<input type="text" id="datepicker1" name="startdate" style="padding:auto; width: 150px; height: 35px">&nbsp;&nbsp; ~ &nbsp;&nbsp;
					 <input type="text" id="datepicker2" name="enddate" style="padding:auto; width: 150px; height: 35px">
				</td>
			</tr>
			<tr>
				<th style="font-size: 15px;  text-align: center;" >조건검색</th>
				<td style="width: 100px">
					<select class="form-select" aria-label="Default select example" name="choice" id="_choice" style="width: 150px;">
					  <option selected>선택</option>
					  <option value="sellSeq">판매코드</option>
					  <option value="id">판매자ID</option>
					  <option value="title">판매제목</option>
					  <option value="address">주소</option>
					  <option value="bizNum">사업자등록증</option>
					  <option value="bizName">사업자명</option>
					</select>
				</td>
				<td>
					<input type="text" id="_search" name="search" class="form-control" placeholder="검색" size="20">
				</td>
				<td>
					<button type="button" class="btn btn-primary" id="searchBtn">검색</button>
				</td>
			</tr>	
		</table>
	</form>
</div>

<br>

<!-- 상품 하단테이블 -->
<div align="right" style="padding-right: 85px">
	<button type="button" class="btn btn-primary" id="writeBtn" style="width: 100px; height: 40px; margin-right: 120px;">판매등록</button>
</div>

<div align="center" style="margin-top: 5px; margin-bottom: 10px">
	<table class="table table-hover" style="width: 77%" id="actlist">
	</table>
</div>

<div id="pagingMain" class="container">
</div>

<script type="text/javascript">
/* widget calendar */
$("#datepicker1,#datepicker2").datepicker({
     showMonthAfterYear:true,
     showOn:"both",
     buttonImage:"./image/calendar.png",
     buttonImageOnly:true,
     buttonText: "Select date",
     dateFormat:'yy-mm-dd',
     nextText:'다음 달',
     prevText:'이전 달',
     dayNamesMin:['일','월','화','수','목','금','토'],
     monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
});
$(document).ready(function() {
	ajax($("#_choice").val(),$("#_search").val(),0,$("#datepicker1").val(),$("#datepicker2").val());
});
$("#searchBtn").click(function() {
	ajax($("#_choice").val(),$("#_search").val(),0,$("#datepicker1").val(),$("#datepicker2").val());
});

let totalCount = 0;   //글의 총수
let pageSize = 10;      //페이지의 크기 1 ~ 10   [1]~[10]
let pageNumber = 1;      //현재페이지
function ajax(choices, searchs, pageNumbers, startdates, enddates) {
	$('#pagingMain').empty();
	$('#actlist').empty();
	
	$.ajax({
		url : "managemnetAct.do",
		type: "post",
		data: { choice:choices, search:searchs, pageNumber:pageNumbers, startdate:startdates, enddate:enddates },
		success:function( data ){
			//alert('success');
			
			/*검색 고정*/
			$("#_choice").val(data.search.choice);
			$("#_search").val(data.search.search);
			$("#datepicker1").val(data.search.startdate);
		    $("#datepicker2").val(data.search.enddate);
			
			/*페이징 값변경*/
			 totalCount = data.totalCount;
        	 pageNumber = data.search.pageNumber + 1;

			/* 게시판 셋팅 */
			let setting = '<colgroup><col style="width: 40px"><col style="width: 40px"><col style="width: 40px;"><col style="width: 150px;">' +
							'<col style="width: 90px"><col style="width: 40px"><col style="width: 40px"><col style="width: 70px"><col style="width: 40px"></colgroup>' +
						  	'<tr align="center"><th>번호</th><th>판매코드</th><th>판매자</th><th>판매제목</th><th>주소</th>' +
						 	'<th>리뷰수</th><th>평점</th><th>등록일</th><th>관리</th></tr>';
			
			$('#actlist').append(setting);	
			
			if(data.list == null && data.list[0].sellSeq == ""){
				let add = '<tr><td colspan="9" style="text-align: center;">등록된 판매정보가 없습니다</td></tr>'
				$('#actlist').append(add);	
			}
			
			/* 게시판리스트 추가 */
			if(${login.auth} == 1){
				$.each(data.list, function(index,dto){
					let str = '<tr style="text-align: center;">' +
								'<td>' + (index+1) + '</td>' +
								'<td>' + dto.sellSeq + '</td>' +
								'<td>' + dto.hostId +'</td>' +
								'<td>' + dto.title + '</td>' +
								'<td>' + dto.address + '</td>'+
								'<td>' + dto.reivewNum +'</td>'+
								'<td>' + dto.reviewAvg +'</td>'+
								'<td>' + (dto.regidate).substring(0, 16) + '</td>'+
								'<td>' +
									'<button type="button" class="btn btn-outline-primary" onclick="moreBtn('+ dto.sellSeq +')" style="width: 78px; height: 30px; font-size: 9pt">상세보기</button>' +
								'</td>'+
							   '</tr';
					$('#actlist').append(str);
				});	
			}else{
				$.each(data.list, function(index,dto){
					if('${login.id}' == dto.hostId){
						let str = '<tr style="text-align: center;">' +
									'<td>' + (index+1) + '</td>' +
									'<td>' + dto.sellSeq + '</td>' +
									'<td>' + dto.hostId +'</td>' +
									'<td>' + dto.title + '</td>' +
									'<td>' + dto.address + '</td>'+
									'<td>' + dto.reivewNum +'</td>'+
									'<td>' + dto.reviewAvg +'</td>'+
									'<td>' + (dto.regidate).substring(0, 16) + '</td>'+
									'<td>' +
										'<button type="button" class="btn btn-outline-primary" onclick="moreBtn('+ dto.sellSeq +')" style="width: 78px; height: 30px; font-size: 9pt">상세보기</button>' +
									'</td>'+
								   '</tr';
						$('#actlist').append(str);
					}
				});	
			}
			 /* 페이징 추가 */
	         let paging = '<nav aria-label="Page navigation">' +
	                       '<ul class="pagination" id="pagination"  style="justify-content:center;"></ul>' +
	                     '</nav>'
	         $('#pagingMain').append(paging);
	         
	         let totalPages = Math.floor(totalCount / 10);
	        // alert("totalpages" + totalPages);
	         
	         if(totalCount % 10 > 0){
	            totalPages++;
	         }
	         $("#pagination").twbsPagination({
	            startPage: pageNumber,
	            totalPages: totalPages,
	            visiblePages: 10,
	            initiateStartPageClick:false,
	            first:'<span sris-hidden="true">«</span>',
	            prev:"이전",
	            next:"다음",
	            last:'<span sris-hidden="true">»</span>',
	            onPageClick:function(event, page){
	               ajax($("#_choice").val(),$("#_search").val(),(page-1),$("#datepicker1").val(),$("#datepicker2").val());
	            }
	         });   

		},
		error:function(){
			alert('error');
		}
	});
}

function moreBtn(seq) {
	location.href = "actdetail.do?seq=" + seq;
}

$("#writeBtn").click(function() {
	location.href = "actwrite.do";
});
</script>
</body>
</html>