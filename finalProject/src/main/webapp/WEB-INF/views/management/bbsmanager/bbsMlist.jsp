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
				<th style="font-size: 15px; text-align: center;" >작성일</th>
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
					 	<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="area">지역</option>
						<option value="writer">작성자</option>
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
	<button type="button" class="btn btn-primary rounded" id="writeBtn" style="width: 120px; height: 40px; margin-right: 120px;" title="새 글 작성">새 글 작성</button>
</div>

<div align="center" style="margin-top: 5px; margin-bottom: 10px">
	<table class="table table-hover" style="width: 77%" id="bbslist">
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
	$('#bbslist').empty();
	
	$.ajax({
		url : "bbsMlist.do",
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
			let setting = '<colgroup><col style="width: 40px"><col style="width: 60px"><col style="width: 150px;"><col style="width: 60px;">' +
							'<col style="width: 50px"><col style="width: 40px"><col style="width: 40px"><col style="width: 70px"><col style="width: 80px"></colgroup>' +
						  	'<tr align="center"><th>글번호</th><th>작성자</th><th>제목</th><th>지역</th><th>조회수</th>' +
						 	'<th>댓글</th><th>좋아요</th><th>작성일</th><th>관리</th></tr>';
			
			$('#bbslist').append(setting);	
			
			if(data.list == null && data.list[0].seq == ""){
				let add = '<tr><td colspan="9" style="text-align: center;">작성된 게시글이 없습니다</td></tr>'
				$('#bbslist').append(add);
			}
			
			/* 게시판리스트 추가 */
			if(${login.auth} == 1){
				$.each(data.list, function(index,dto){
					let str = '<tr style="text-align: center;">' +
								'<td>' + dto.seq + '</td>' +
								'<td>' + dto.id + '</td>' +
								'<td><a href="bbsdetail.do?seq=' + dto.seq + '">' + (dto.title).substring(0, 20) + '...</a></td>' +
								'<td>' + dto.area + '</td>' +
								'<td>' + dto.readCount + '</td>'+
								'<td>' + dto.commentCount +'</td>'+
								'<td>' + dto.likeCount +'</td>'+
								'<td>' + (dto.wdate).substring(0, 10) + '</td>'+
								'<td>' +
									'<button type="button" class="btn btn-outline-primary" onclick="bbsupdateBtn(this.value)" style="font-size: 9pt" value="' + dto.seq + '">수정</button>&nbsp;' +
									'<button type="button" class="btn btn-outline-warning" onclick="bbsdeleteBtn(this.value)" style="font-size: 9pt" value="' + dto.seq + '">삭제</button>' +
								'</td>'+
							   '</tr';
					$('#bbslist').append(str);
				});	
			}else{
				$.each(data.list, function(index,dto){
					if('${login.id}' == dto.hostId){
						let str = '<tr style="text-align: center;">' +
									'<td>' + dto.seq + '</td>' +
									'<td>' + dto.id + '</td>' +
									'<td><a href="bbsdetail.do?seq=' + dto.seq + '">' + (dto.title).substring(0, 20) + '...</a></td>' +
									'<td>' + dto.area + '</td>' +
									'<td>' + dto.readCount + '</td>'+
									'<td>' + dto.commentCount +'</td>'+
									'<td>' + dto.likeCount +'</td>'+
									'<td>' + (dto.wdate).substring(0, 10) + '</td>'+
									'<td>' +
										'<button type="button" class="btn btn-outline-primary" onclick="bbsupdateBtn(this.value)" style="font-size: 9pt" value="' + dto.seq + '">수정</button>&nbsp;' +
										'<button type="button" class="btn btn-outline-warning" onclick="bbsdeleteBtn(this.value)" style="font-size: 9pt" value="' + dto.seq + '">삭제</button>' +
									'</td>'+
								   '</tr';
						$('#bbslist').append(str);
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

$("#writeBtn").click(function() {
	location.href = "bbsMwrite.do";
});
function bbsupdateBtn(bbsSeq) {
	location.href='bbsMupdate.do?seq=' + bbsSeq;
}
function bbsdeleteBtn(bbsSeq) {
	$.ajax({
		url:"deleteBbs.do",
		type:"post",
		data:{ seq:bbsSeq },
		success:function(msg){
			if(msg == 'success'){
				alert('성공적으로 삭제하였습니다');
				location.href = "bbsManager.do";
			}else{
				alert('삭제 실패');
				location.href = "bbsManager.do";
			}
		},
		error:function(){
			alert('error');
		}
	});
}
</script>
</body>
</html>