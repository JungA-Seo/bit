<%@page import="java.util.List"%>
<%@page import="com.flenda.www.dto.OptionDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>		<!-- 코어태그 --> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	<!-- 코어태그substring --> 


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>theme manager list</title>

<!-- datepicker 사용 -->
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <link rel="stylesheet" href="/resources/demos/style.css">
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- <link rel="stylesheet" href="./css/theme1.css"> -->

<!-- pagination -->
<script type="text/javascript" src="./resources/pagination/jquery.twbsPagination.min.js"></script>
<style type="text/css">
th{
	font-size: 15px;
}
</style>
</head>
<body>

<!-- 상단 서칭부분 -->
<div align="center" style="margin-top: 40px; margin-left: 80px;">
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
				<th style="font-size: 15px;  text-align: center;">조건검색</th>
				<td style="width: 100px">
					<select class="form-select" aria-label="Default select example" name="choice" id="_choice" style="width: 150px;">
					  <option selected>선택</option>
					  <option value="category">투어명</option>
					  <option value="title">제목</option>
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

<br><br>

<!-- 상품 하단테이블 -->


<div align="right" style="padding-right: 85px">
	<button type="button" class="btn btn-primary" id="writeBtn" style="width: 100px; height: 40px; margin-right: 120px;">판매등록</button>
</div>


<!-- ajax 테이블 -->
<div align="center" style="margin-top: 5px; margin-bottom: 10px">
<table class="table table-hover" style="width: 80%" id="tm_List_table">
</table>
</div>

<!-- 페이징 -->
<br>
<div id="pagingMain" class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content:center;" ></ul>
    </nav>
</div>
<br>


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
</script>

<script type="text/javascript">


$(document).ready(function() {
	
	 ajax($("#_choice").val(),$("#_search").val(),0,$("#datepicker1").val(),$("#datepicker2").val());

});	


	//검색버튼 클릭시
	$("#searchBtn").click(function() {
		//alert('click');
		ajax($("#_choice").val(),$("#_search").val(),0,$("#datepicker1").val(),$("#datepicker2").val());
	});


	
	let totalCount = 0;   //글의 총수
	let pageSize = 10;      //페이지의 크기 1 ~ 10   [1]~[10]
	let pageNumber = 1;      //현재페이지
	
function ajax(Tchoice, Tsearch, TpageNumber, Tstartdate, Tenddate){
	//alert("enddate:" + Tenddate);
		
	$('#pagingMain').empty();
	$('#tm_List_table').empty();		// 검색하고나서 새로운 리스트 보여줄때 리스트 초기화
	
	$.ajax({
		url : "tmlist.do",
		type: "post",
		data: { choice:Tchoice, search:Tsearch, pageNumber:TpageNumber, startdate:Tstartdate, enddate:Tenddate },
		success:function( data ){
			//alert('success');
			
			/*검색 고정*/
			$("#_choice").val(data.search.choice);
			$("#_search").val(data.search.search);
			$("#datepicker1").val(data.search.startDate);
		    $("#datepicker2").val(data.search.endDate);
			
			/*페이징 값변경*/
			 totalCount = data.totalCount;
        	 pageNumber = data.search.pageNumber + 1;
        	// alert("totalCount:" + totalCount);
        	// alert("pageNumber:" + pageNumber);
        	 
			/* 게시판 셋팅 */
			let setting = '<colgroup><col style="width: 50px"><col style="width: 100px"><col style="width: 100px;"><col style="width: 250px;">' +
							'<col style="width: 100px"><col style="width: 80px"></colgroup>' +
						  '<tr align="center"><th>번호</th><th>판매코드</th><th>카테고리</th><th>상품타이틀</th><th>등록일</th><th>관리</th></tr>';
			
			$('#tm_List_table').append(setting);	
			
			if(data.themelist == null && data.themelist[0].sellSeq == ""){
				let add = '<tr><td colspan="7" style="text-align: center;">등록된 판매옵션이 없습니다</td></tr>'
				$('#tm_List_table').append(add);	
			}
			
			/* 게시판리스트 추가 */
			if(${login.auth} == 1){
				$.each(data.themelist, function(index,dto){
					let str = '<tr>' +
								'<td style="text-align: center;">' + (index+1) + '</td>' +
								'<td style="text-align: center;">' + dto.sellSeq + '</td>' +
								'<td style="text-align: center;">' + dto.category +'</td>' +
								'<td style="text-align: center;">' + dto.title + '</td>' +
								'<td style="text-align: center;">' + dto.regidate.substring(0, 11) + '</td>'+
								'<td style="text-align: center;">' +
									'<button type="button" class="btn btn-outline-primary" onclick="detailBtn('+ dto.sellSeq +')" style="font-size: 9pt">상세보기</button>' +
								'</td>'+
							   '</tr';
					$('#tm_List_table').append(str);
				});
			}else{
				$.each(data.themelist, function(index,dto){
					if('${login.id}' == dto.hostId){
						let str = '<tr>' +
									'<td style="text-align: center;">' + (index+1) + '</td>' +
									'<td style="text-align: center;">' + dto.sellSeq + '</td>' +
									'<td style="text-align: center;">' + dto.category +'</td>' +
									'<td style="text-align: center;">' + dots(dto.title) + '</td>' +
									'<td style="text-align: center;">' + dto.regidate.substring(0, 11) + '</td>'+
									'<td style="text-align: center;">' +
										'<button type="button" class="btn btn-outline-primary" onclick="detailBtn('+ dto.sellSeq +')" style="font-size: 9pt">상세보기</button>' +
									'</td>'+
								   '</tr';
						$('#tm_List_table').append(str);
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
	
	
	});  //ajax끝 
} //function ajax 끝 	
	
	
$("#writeBtn").click(function() {
	//alert('writeBtn');
	location.href = "tmwrite.do";
});
 
	

function detailBtn(sellSeq){
	location.href = "tmdetail.do?sellSeq=" + sellSeq;
}


//제목글자 길때 …으로 표시

function dots(str){
	let newStr = '';
	if(str.length > 25){
		newStr = str.substring(0, 26);
	}else{
		return str;
	}
	return newStr + '…';
}

</script>


</body>
</html>






