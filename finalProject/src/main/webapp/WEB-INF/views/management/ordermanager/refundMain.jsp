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
	<col width="100px"><col width="300px">
		<tr height="50px" >
			<th>진행상태</th>
			<td align="left">
				<input type="button" onclick="changeStatus('all')" class="clickBtn btnStyle" value="전체">&nbsp;
				<input type="button" class="clickBtn btnStyle" onclick="changeStatus('refundting')" value="환불 처리 중">&nbsp;
				<input  type="button" class="clickBtn btnStyle" onclick="changeStatus('completerefund')" value="환불 완료">&nbsp;
				<input type="button" class="clickBtn btnStyle" onclick="changeStatus('calcelrefund')" value="환불 취소">
			</td>
		</tr>
		<tr height="50px">
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
		<tr height="50px">
			<th>조건검색</th>
			<td>
				<div class="selbox">
					<select class="form-select" aria-label="Default select example" name="choice" id="_choice">
						<option selected>선택</option>
			 			<!-- <option value="reqDate">취소요청일</option> -->
					 	<option value="itemName">상품명</option>
			 			<option value="orderNum">상품번호</option>
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
	<table id="otable" class="table table-hover">
	</table>
</div>
</div>

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
let processStatus = "all";
let day = "all";
function changeStatus(data){
	processStatus = data;
}
function check(data){
	ajax($("#_choice").val(),$("#_search").val(),0,$("#datepicker1").val(),$("#datepicker2").val(),data,processStatus);
}

$(document).ready(function() {
	ajax($("#_choice").val(),$("#_search").val(),0,$("#datepicker1").val(),$("#datepicker2").val(),'',processStatus);
});

$("#searchBtn").click(function() {
	ajax($("#_choice").val(),$("#_search").val(),0,$("#datepicker1").val(),$("#datepicker2").val(),'',processStatus);
})

</script>
<script type="text/javascript">
	function ajax(choices, searchs, pageNumbers, startdates, enddates, days ,processStatus){
		$("#otable").empty();
		let str ="";
		str += 	'<tr style="text-align: center;">';
		str +=		'<th>주문 번호</th><th>상품명</th><th>취소요청일</th><th>취소완료일</th><th>상품가격</th><th>처리상태</th><th>상태수정</th><th>기능</th>';
		str +=	'</tr>';
		
		$.ajax({
			url:"refundList.do",
			data: { choice:choices, search:searchs, pageNum:pageNumbers, sdate:startdates, edate:enddates, period:days, status:processStatus },
			type: "post",
			success:function(data){
				
				totalCount = data.count;
				pageNum = data.param.pageNum + 1;

				for(i=0; i<data.list.length; i++){
					str+= 	'<tr style="text-align: center;">';
					str+=		'<td>'+data.list[i].orderNum+'</td><td>'+data.list[i].itemName+'</td><td>'+data.list[i].reqDate.substring(0,11)+'</td><td>'+data.list[i].finishDate.substring(0,11)+'</td>';
					str+=		'<td>'+data.list[i].refundPrice+'원'+'</td><td>'+data.list[i].condition+'</td>';
					str+=		'<td>';
				if(data.list[i].condition!="환불완료"){	
					str+=			'<select id="condition" onchange="selData(\''+data.list[i].orderNum+'\',this.value)">';
					str+=				'<option value="환불처리중">환불처리중</option>';
					str+=				'<option value="환불완료">환불완료</option>';
					str+=				'<option value="환불취소">환불취소</option>';
					str+=			'</select>';
				}else{
					str+= '<b>처리 완료</b>';	
				}
					str+=		'</td>';
					str+=		'<td>';
					if(data.list[i].condition!="환불완료"){		
					str+=			'<button class="btn btn-outline-secondary" value="'+ data.list[i].orderNum +'" onclick="status(this.value)">확인</button>&nbsp;&nbsp;';
					}else{
						str+= '&nbsp;&nbsp;&nbsp;<b>완료</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
					}
					str+=			'<input type="button" class="btn btn-outline-secondary" value="상세정보" onclick="detail(\'' + data.list[i].orderNum + '\',\''+data.list[i].condition+'\')">';
					str+=		'</td>';
					str+='<td style="border-style:none;">';
					str+='<img alt="'+data.list[i].orderNum+'" src="./image/delbefore.png" onmouseover="src=\'./image/delafter.png\'" onmouseout="src=\'./image/delbefore.png\'" onclick="delList(this.alt)">';
					str+='</td>';	
					str+=	'</tr>';
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
			               ajax($("#_choice").val(),$("#_search").val(),(page-1),$("#datepicker1").val(),$("#datepicker2").val(),day,processStatus);
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
let sequence;
let conValue;
function selData(seq,val){
	sequence= seq;
	conValue= val;
}

function status(seq){
	let num = seq;
	let val = $("#condition").val();
		if(seq==sequence){
			 num = sequence;
			 val = conValue;
		}

		$.ajax({
			url:"change.do",
			type: "post",
			data:{orderNum:num,condition:val},
			success:function(){
				location.href="refundHistory.do";
			},
			error:function(){
				alert("error");
			}
		});
}
function detail(seq,status){
	location.href="refundDetail.do?orderNum="+seq+"&condition="+status;
}
function delList(seq){
	
	$.ajax({
		url:"delRefund.do",
		type: "post",
		data:{orderNum:seq},
		success:function(data){
			location.href="refundHistory.do";
		},
		error:function(){
			alert("error");
		}
	});

}
</script>
</body>
</html>