<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!--  datepicker 사용  -->
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <link rel="stylesheet" href="./css/orderAdmin.css">
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- pagination --> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>
<style type="text/css">
tr{
	font-size: 15px;s
}
</style>
</head>
<body>

<div class="searchArea">
	<table class="table">
		<col width="200px"><col width="500px">
		<tr>
			<th>기간</th>
			<td>
				<div class="caltext">
					<input type="text" id="datepicker1" name="startdate" style="font-size: 13px">&nbsp;&nbsp; ~ &nbsp;&nbsp;
					<input type="text" id="datepicker2" name="enddate" style="font-size: 13px">
				</div>
				<div class="calbtn">
					<input type="button" class="btnStyle" onclick="check('today')"  id="today" value="오늘">&nbsp;
					<input type="button" class="btnStyle" onclick="check('yester')"  id="yest" value="어제">&nbsp;
					<input type="button" class="btnStyle" onclick="check('week')"  id="week" value="1주일">&nbsp;
					<input id="month" class="btnStyle" onclick="check('month')" type="button" value="1개월">
				</div>
			</td>
		</tr>
		<tr>
			<th>조건검색</th>
			<td>
				<div class="selbox">
					<select class="form-select" aria-label="Default select example" name="choice" id="_choice">
						<option selected>선택</option>
						<option value="name">주문자명</option>
						<option value="ordernum">주문번호</option>
						<option value="orderMethod">주문방법</option>
					</select>
				</div>
				<div class="seltext">
					<input type="text" id="_search" name="search" class="form-control" placeholder="검색" size="20">
				</div>
				<div class="selbtn">
					<button type="button" class="btn btn-primary" id="searchBtn">검색</button>
				</div>
			</td>
		</tr>
	</table>
</div>

<div align="center">
	<div class="orderTable">
		<table class="table table-hover" id="otable">
			<tr id="orderCount" align="left" style="margin-bottom: 2px;"></tr>
		</table>
	</div>
</div>

<!-- 페이징 -->
<br>
<div id="pagingMain" class="container">
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
let day="all";

function check(date){
	ajax($("#_choice").val(), $("#_search").val(),0,$("#datepicker1").val(),$("#datepicker2").val(), date);
} 

$(document).ready(function() {
	ajax($("#_choice").val(),$("#_search").val(),0,$("#datepicker1").val(),$("#datepicker2").val(),day);
});

$("#searchBtn").click(function() {
	ajax($("#_choice").val(),$("#_search").val(),0,$("#datepicker1").val(),$("#datepicker2").val(),day);
});

function ajax(choices, searchs, pageNumbers, startdates, enddates, days){
	$("#otable").empty();
	$("#pagingMain").empty();
	$.ajax({
		url:"payList.do",
		data: { choice:choices, search:searchs, pageNum:pageNumbers, sdate:startdates, edate:enddates, period:days},
		type: "post",
		success:function(data){
			
			totalCount = data.count;
			pageNum = data.param.pageNum + 1;

			let str="";
			str+='<tr>';
			str+='<th>주문일</th><th>주문 번호</th><th>주문자명</th><th>주문 방법</th><th>총 결제액</th><th>환불 신청</th><th>기능</th>';
			str+='</tr>';
			for(i=0; i<data.list.length; i++){
				str+='<tr>';
				str+=	'<td>'+data.list[i].orderDate.substring(0, 11)+'</td>';	
				str+=	'<td>'+data.list[i].orderNum+'</td>';
				str+=	'<td>'+data.list[i].name+'</td>';
				str+=	'<td>'+data.list[i].payMethod+'</td>';
				str+=	'<td>'+data.list[i].paidMoney+'원</td>';
				str+=	'<td><button class="btn btn-outline-secondary" value="'+data.list[i].orderNum+'" onclick="refurn(this.value)">환불</button></td>';
				str+=	'<td><button class="btn btn-outline-secondary" value="'+data.list[i].orderNum+'" onclick="detail(this.value)">상세정보</button></td>';
				str+=	'<td style="border-style:none;">';
				str+=		'<img alt="'+data.list[i].orderNum+'" src="./image/delbefore.png" onmouseover="src=\'./image/delafter.png\'" onmouseout="src=\'./image/delbefore.png\'" onclick="delList(this.alt)">';
				str+=	'</td>';	
				str+='</tr>';
			}
			$("#otable").append(str);
			
			/* 페이징 추가 */
	         let paging = '<nav aria-label="Page navigation">' +
	                       '<ul class="pagination" id="pagination"  style="justify-content:center;"></ul>' +
	                     '</nav>'
	         $('#pagingMain').append(paging);
	                     
	         let totalPages = Math.floor(totalCount / 10);
		         
		         if(totalCount % 10 > 0){
		            totalPages++;
		         }
		         if(totalPages == 0){
			        	totalPages = 1;
			     }
		         $("#pagination").twbsPagination({
		            startPage: pageNum,
		            totalPages: totalPages,
		            visiblePages: 10,
		            initiateStartPageClick:false,
		            first:'<span sris-hidden="true">«</span>',
		            prev:"이전",
		            next:"다음",
		            last:'<span sris-hidden="true">»</span>',
		            onPageClick:function(event, page){
		               ajax($("#_choice").val(),$("#_search").val(),(page-1),$("#datepicker1").val(),$("#datepicker2").val(),day);
		            }
		         });           

		},
		error:function(){
			alert("error");
		}
	});
}
</script>
<script type="text/javascript">
function refurn(seq){
	location.href="refundHistory.do?seq="+seq;
}
function detail(seq){
	location.href="orderDetail.do?seq="+seq;
}
function delList(seq){
	
	$.ajax({
		url:"delOrder.do",
		type: "post",
		data:{orderNum:seq},
		success:function(data){
			location.href="payHistory.do";
		},
		error:function(){
			alert("error");
		}
	});

}


</script>

</body>
</html>