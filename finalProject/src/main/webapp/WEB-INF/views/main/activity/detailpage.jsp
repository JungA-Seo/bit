<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- datepicker => https://flatpickr.js.org/ -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<!-- 언어설정  -->
<script src="https://npmcdn.com/flatpickr/dist/flatpickr.min.js"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>

<link rel="stylesheet" type="text/css" href="./css/main_activity_detail1.css">
<link rel="stylesheet" type="text/css" href="./css/detailpage_review.css">
</head>
<body>
<div class="main">
	<div class="header">
		<div class="headerTop">
			<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
			  <ol class="breadcrumb">
			    <li class="breadcrumb-item"><a href="main.do">Home</a></li>
			    <li class="breadcrumb-item"><a href="main_activity.do">액티비티</a></li>
			    <li class="breadcrumb-item active" aria-current="page">상세페이지</li>
			  </ol>
			</nav>
		</div>
		<div class="headerMid">${ act.title }</div>
		<div class="headerBottom"><font style="color: #606ADC;">★</font><span id="scoreOnHeader"></span><span id="reivewOnHeader"></span></div>
	</div>
	<div class="pictures">
		<c:forEach items="${pics}" var="pic" varStatus="i">
			<c:choose>
				<c:when test="${i.count == 4 || i.count == 5}">
					<div align="left" class="sm-items">
					<img alt="" src="http://localhost:8090/flenda/upload/${pic.newFileName }" width="300px" height="300px">
					</div>
				</c:when>
				<c:otherwise>
					<div class="b-items" align="left">
					<img alt="" src="http://localhost:8090/flenda/upload/${pic.newFileName }" width="800px" height="400px">
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
	<div class="body">
		<div class="body_left">
			<div class="icon_info">
				<div>
					<span><img src="./image/clock.png" width="22px" height="22px">${ act.timetake }시간 소요</span>
					<span><img src="./image/tickets.png" width="25px" height="25px">${ act.ticket }</span>
				</div>
				<div>
					<span><img src="./image/group.png" width="25px" height="25px">최대 ${ act.maxPeople }명</span>
					<span><img src="./image/exclamation.png" width="22px" height="22px">포함 사항:${ act.included }</span>
				</div>
			</div>
			<div class="ticketing">
				<div class="ticketing_sub">티켓 선택</div>
				<div class="ticketing_body">
					<div class="calendar" align="center">
						<input type="text" class="selector" onchange="selectDate(this.value)" placeholder="날짜를 선택하세요." />
						<a class="input-button" title="toggle" data-toggle><i class="icon-calendar"></i></a>
					</div>
					<div class="options">
						<div id="_options"></div>
						<div class="cal" id="calculation">
						</div>
					</div>
					<div id="goToPay" align="right">
					</div>
				</div>
			</div>
			<div class="section-01 scroll">
			<div class="explanation">
				<div class="explan_Sub" align="left"><h4><strong>상품설명</strong></h4></div>
				<div style="text-align: left;">${act.goodsExplain }</div>
			</div>
			</div>
			<hr width="95%" style="margin-left: 15px; background-color: #81BEF7;">
			<div class="section-02 scroll">
			<div class="instruction">
				<div class="instruc_Sub" align="left"><h4><strong>이용안내</strong></h4></div>
				<div style="text-align: left;">${act.useInfo }</div>
			</div>
			</div>
			<hr width="95%" style="margin-left: 15px; background-color: #81BEF7;">
			<div class="section-03 scroll"> 
			<div class="canclerule">
				<div class="canclerule_Sub" align="left"><h4><strong>취소 및 환불규정 </strong></h4></div>
				<div align="left" id="cancle01" style="display:none;">
				<p>가이드투어 취소/환불 안내</p>
				<p>각 상품 별 취소 환불 약관이 별도 기재되어 있을 경우 별도 기재 내용이 해당 규정으로서 선 적용됩니다.</p>
					<a><span class="more">더보기▼</span></a>
				</div>
				<div align="left" id="cancle02">
				<p>여행자는 가이드약관 제16조 제2항에 따라 여행요금 지급이 이루어진 후 투어 개시일 이전에 여행계약을 임의로 해제하는 경우, 해제 통보 시점에 관한 다음 각 호의 기준에 따라 여행요금이 환불됩니다.<br>
					해제 통보 시점은 환불요청서가 Flenda 플랫폼에 접수된 시간 또는 Flenda 플랫폼 내 ‘메시지’ 기능을 통하여 환불요청 내용이 기록된 시간을 기준으로 합니다.<br>
					<br><br>
					[국내여행의 경우]
					- 여행자가 여행 개시일로부터 3일 이전 통보 시: 여행 요금 전액 환불<br>
					- 여행 개시일로부터 2일 이전 통보 시: 여행요금에서 가이드 요금의 10%와 Flenda 수수료 공제 후 환불<br>
					- 여행 개시일로부터 여행 시작 시간 기준 24시간 이전 통보 시: 여행요금에서 가이드 요금의 20%와 Flenda 수수료 공제 후 환불<br>
					- 여행 시작 시간으로부터 24시간 이내 통보 시: 여행요금에서 가이드 요금의 30%와 Flenda 수수료 공제 후 환불<br>
					다만, 위의 규정에도 불구하고 다음의 경우에는 예외로 합니다.<br>
					1) 여행자가 여행요금을 결제(지급)한 때로부터 24시간 이내에 여행계약을 철회(취소)하는 경우와 여행자가 투어 예약 후 가이드가 확정되기 전에 취소하는 경우는 여행요금을 전액 환불합니다.<br> 
					단, 여행자가 여행요금을 결제하였다고 하더라도 해당 시점으로부터 24시간 이내 여행이 시작될 경우 (Instant Booking 예약에 해당하는 경우)는 전액 환불 대상에서 제외합니다.<br>
					2) 상품의 특성에 따라 현지 예약금으로 지불되어야 하는 금액이 있는 경우 해당 예약금의 환불에 대하여는 각 상품의 상세설명보기에서 별도로 고지한 취소환불 약관을 적용합니다.<br>
					<br>
					가이드는 가이드약관 제17조 제1항에 따라 여행요금 지급이 이루어진 후 투어 개시일 이전에 여행계약을 임의로 해제하는 경우, 해제 통보 시점에 관한 다음 각 호의 기준에 따라 가이드가 추가 요금을 부담합니다.<br>
					해제 통보 시점은 환불요청서가 Flenda가 플랫폼에 접수된 시간 또는 Flenda 플랫폼 내 ‘메시지’ 기능을 통하여 환불요청 내용이 기록된 시간을 기준으로 합니다.<br>
					<br><br>
					[국내여행의 경우]<br>
					- 여행자가 여행 개시일로부터 3일 이전 통보 시: 여행 요금 전액을 여행자에게 환불. 가이드 부담 없음.<br>
					- 여행 개시일로부터 2일 이전 통보 시: 여행요금에서 가이드 요금의 10%와 Flenda 수수료를 가이드가 부담.<br>
					- 여행 개시일로부터 여행 시작 시간 기준 24시간 이전 통보 시: 여행요금에서 가이드 요금의 20%와 Flenda 수수료를 가이드가 부담.<br>
					- 여행 시작 시간으로부터 24시간 이내 통보 시: 여행요금에서 가이드 요금의 30%와 Flenda 수수료를 가이드가 부담.<br>
					다만, 위의 규정에도 불구하고 다음의 경우에는 예외로 합니다.<br>
					1) 여행자가 여행요금을 결제(지급)한 때로부터 24시간 이내에 여행계약을 철회(취소)하는 경우와 여행자가 투어 예약 후 가이드가 확정되기 전에 취소하는 경우는 여행요금을 전액 환불합니다.<br>
					단, 여행자가 여행요금을 결제하였다고 하더라도 해당 시점으로부터 24시간 이내 여행이 시작될 경우 (Instant Booking 예약에 해당하는 경우)는 전액 환불 대상에서 제외합니다.<br>
					2) 상품의 특성에 따라 현지 예약금으로 지불되어야 하는 금액이 있는 경우 해당 예약금의 환불에 대하여는 각 상품의 상세설명보기에서 별도로 고지한 취소환불 약관을 적용합니다.<br> 
					</p>
				
					<span class="more2">접기▲</span>
				</div>
				
			</div>
			</div>
			<hr width="95%" style="margin-left: 15px; background-color: #81BEF7;">
			<div class="master">
				<div class="master_header" align="left">
					<span><img src="http://localhost:8090/flenda/upload/${hostImg }" alt="이미지" width="40px" height="40px"></span><!-- 프로필사진추가 -->
					<span style="text-align: left;">${act.businessName}</span>
				</div>
				<div class="master_body">${act.hostintro }</div>
			</div>
			<hr width="95%" style="margin-left: 15px; background-color: #81BEF7;">
			<div class="section-04 scroll"> 
			<div class="review" id="_review">
			</div>
			</div>
			<div class="moreBtn">
				<div class="d-grid gap-2">
				  <button class="btn btn-primary" id="_moreBtn" type="button">더보기</button>
				</div>
			</div>
		</div>
		<div class="body_right"><!-- https://kimyang-sun.tistory.com/entry/%EC%8A%A4%ED%81%AC%EB%A1%A4%EC%97%90-%EB%94%B0%EB%9D%BC-%EB%A9%94%EB%89%B4-%ED%91%9C%EC%8B%9C%EC%8B%9C%ED%82%A4%EA%B8%B0-%ED%8E%98%EC%9D%B4%EC%A7%80-%EC%9D%B8%EB%94%94%EC%BC%80%EC%9D%B4%ED%84%B0-%EC%8A%A4%ED%81%AC%EB%A1%A4 -->
			<div class="flotingbenu">
				<table>
					<tr>
						<td align="left"><span id="opprice"><b>&nbsp;KRW ${minprice }</b></span>&nbsp;원 부터</td>
					</tr>
					<tr>
						<td>
						<button type="button" class="btn btn-primary" id="ticketBtn">티켓 선택</button>
						</td>
					</tr>
					<tr>
						<td align="center">
						<button type="button" class="btn btn-light" id="wishlist" onclick="heartclick(this.value)" value="off"><img src="./image/heart.png" alt="off" id="emptyheart">&nbsp;위시리스트담기</button>
						</td>
					</tr>
				</table>		
				<hr width="100%" style="background-color: #aaaaaa;">
				<div class="quickmenu">	
					<ul> 
						<li class="m"><a href="#section-01" class="menu-01"><span>상품설명</span></a></li> 
						<li class="m"><a href="#section-02" class="menu-02"><span>이용안내</span></a></li> 
						<li class="m"><a href="#section-03" class="menu-03"><span>환불규정</span></a></li>
						<li class="m"><a href="#section-04" class="menu-04"><span>후기</span></a></li> 
					</ul> 
				</div>
			</div>
		</div>
	</div><br>
	<div class="footer"><!-- 추천액티비티 -->
		<div class="instruc_Sub" align="left"><h4><strong>추천 액티비티</strong></h4></div>
		<div class="footer_content">
		</div>
	</div>
</div>
<script type="text/javascript">
flatpickr.localize(flatpickr.l10ns.ko);
$(".selector").flatpickr({ 
	dateFormat: "Y년 m월 d일",
	minDate:"today",
	inline: true,
	local: 'ko'
});
let len = 0;
let sellseq = 0;
function selectDate(selecter) {
	let sellSeq = ${act.sellSeq};
	$.ajax({
		url:"detailOptions.do",
		data: {date:selecter, seq:sellSeq},
		success:function(list){
			$('#_options').empty();
			$('#calculation').empty();
			$('#goToPay').empty();
			len = list.length;
			
			$.each(list, function(index, option) {
			sellseq = option.sellSeq;
			   let str = '<div class="option">' +
							'<div class="option_info">' +
								'<div id="opContent' + index + '"><strong>' + option.opcontent + '</strong></div>' +
								'<div id="opDate' + index + '" style="font-size: 15px;">유효기간 : ' + YYYYMMDD(option.startDate) + '~' + YYYYMMDD(option.endDate) + '</div>' +
								'<div id="opTime' + index + '" style="font-size: 15px;">사용시간 : ' + HHMM(option.startDate) + '~' + HHMM(option.endDate) + '</div>' +
						  	'</div>' +
						 	'<div class="option_price"><span id="opPrice' + index + '" style="font-size: 20px; font-weight: bold;">' + option.opPrice + '</span>원/인당</div>' +
						 	'<div class="option_amount">' +
						 		'<span style="padding-right: 10px;"><img onclick="minusBtn(' + index + ')" id="_minusBtn' + index + '" src="./image/minus_off.png" width="40px" height="40px"></span>' +
						 		'<span id="itemCount' + index + '" style="padding-right: 10px;">0</span>' +
						 		'<span><img onclick="plusBtn(' + index + ')" src="./image/plus.png" width="40px" height="40px"></span>' +
						 	'</div>' +
						 '</div>';
						  					  
				$('#_options').append(str);
			});
			
			let total = '<hr width="95%" style="margin-left: 15px;">' +
						'<div class="totalCal" align="right" ><strong>총 여행 금액<span id="_totalCal">0원</span></strong></div>';

			$('#calculation').append(total);
			
			let payBtn = '<div style="color: red; margin-top: 20px; margin-right: 20px; font-size: 20px; font-weight: bold;" id="goBackToCal"></div><button class="btn btn-primary btn-lg" onclick="payBtn()" style="margin: 20px;">결제하기</button>';
			$('#goToPay').append(payBtn);
		},
		error:function(){
			alert('error');
		}
	});
}
let totalPrice = 0;
let totalCount = 0;
function plusBtn(index) {
	let preCount = $('#itemCount'+index).html();
	totalCount += 1;
	$("#itemCount"+index).text(parseInt(preCount)+1);
	if(preCount>=0){
		$('#_minusBtn'+index).attr("src","./image/minus.png");
	}
	
	
	$('#_totalCal').html('');
	let money = $('#opPrice'+index).html();
	totalPrice += parseInt(money);
	$('#_totalCal').html(totalPrice+'원');
}
function minusBtn(index) {
	let preCount = $('#itemCount'+index).html();
	$("#itemCount"+index).text(parseInt(preCount)-1);
	totalCount -= 1;
	if(preCount <= 1){
		$('#_minusBtn'+index).attr("src","./image/minus_off.png");
		$("#itemCount"+index).text(0);
	}
	
	
	let money = $('#opPrice'+index).html();
	totalPrice -= money;
	if(totalCount <0){
		totalCount = 0;
	}
	
	if(totalPrice < 0){
		totalPrice = 0;
	}
	$('#_totalCal').html(totalPrice+'원');
}
function payBtn() {
	let id = '${login.id}';
	let arr = new Array();
	if(totalPrice == 0 || totalCount == 0){
		$('#goBackToCal').text('상품을 선택해주세요');
		return
	}
	if(id == ''){
		alert('로그인 해주세요');
		location.href="login.do";
		return;
	}
	
	for (i = 0; i <= len-1; i++) {
		if($('#itemCount'+i).html() > 0){
		 let seq = $("#opSeq"+i).val();
		 let content = $("#opContent"+i).html();
		 let dateRange = $("#opDate"+i).html();
		 let timeRange = $("#opTime"+i).html();
		 let count = $('#itemCount'+i).html();
		 let price = $('#opPrice'+i).html();
		
		 let str = 	'<div style="display:flex; justify-content: space-between;">'	+
						'<div style="margin-left: 20px;">' + content + '</div>' +
			 			'<div style="margin-right: 15px; margin-bottom: 8px; font-size: 16px;">' + dateRange + '</div>' +
			 		'</div>' +
		 			'<div style="display:flex; justify-content: space-between;">' +
		 				'<div style="margin-left: 20px;">' + count + ' X ' + price + '원</div>' +
		 				'<div style="margin-right: 30px; font-weight: bold;">' + (count*price) + '원</div>' +
		 			'</div>';
		 arr.push(str);
		}
	}
	let date = $('.selector').val();
	location.href = "pay.do?seq=" + sellseq + "&date=" + date + "&items=" + arr + "&totalPrice=" + totalPrice + "&totalCount=" + totalCount;
	
}
let paging = 2;
$('#_moreBtn').click(function() {
	paging += 3;
	ajax();
});

$(document).ready(function() {
	ajax();
});

function ajax() {
	let sellSeq = ${act.sellSeq};
	$.ajax({
		url:"getReviews.do",
		data: { seq:sellSeq, pageNum:paging },
		success:function(data){
			$('#_review').empty();
			if(data.avg != 'NaN'){
				$('#scoreOnHeader').html(data.avg);
			}else{
				$('#scoreOnHeader').html(0);
			}
			$('#reivewOnHeader').html('(후기 '+data.length+'건)');
			let add='<div class="instruc_Sub" align="left"><h4><strong>후기<font style="color: #606ADC;">(' + data.length + ')</font></strong></h4></div>' +
						'<div class="review_scores">' +
							'<div class="score_left">' +
								'<div class="stars">평점</div>';
							if(data.avg != 'NaN'){
				add +=			'<div class="scores">★ '+ data.avg +'</div>';
							}else{
				add +=			'<div class="scores">★ 0</div>';				
							}
				add +=		'</div>' +
							'<div class="score_right">' +
								'<div class="grahpScore">' +
									'<div class="grahpScores" style="color: #606ADC;">★★★★★</div>' +
									'<div class="grahpScores" style="color: #606ADC;">★★★★</div>' +
									'<div class="grahpScores" style="color: #606ADC;">★★★</div>' +
									'<div class="grahpScores" style="color: #606ADC;">★★</div>' +
									'<div class="grahpScores" style="color: #606ADC;">★</div>' +
								'</div>' +
								'<div class="grahpBar">' +
									'<span class="progress">' +
									  '<span class="progress-bar" role="progressbar" style="width: ' + ((data.star5/data.totalStar)*100) + '%;" aria-valuemin="0" aria-valuemax="100">' + data.star5 + '</span>' +
									'</span>' +
									'<span class="progress">' +
									  '<span class="progress-bar" role="progressbar" style="width: ' + ((data.star4/data.totalStar)*100) + '%;" aria-valuemin="0" aria-valuemax="100">' + data.star4 + '</span>' +
									'</span>' +
									'<span class="progress">' +
									  '<span class="progress-bar" role="progressbar" style="width: ' + ((data.star3/data.totalStar)*100) + '%;" aria-valuemin="0" aria-valuemax="100">' + data.star3 + '</span>' +
									'</span>' +
									'<span class="progress">' +
									  '<span class="progress-bar" role="progressbar" style="width: ' + ((data.star2/data.totalStar)*100) + '%;"  aria-valuemin="0" aria-valuemax="100">' + data.star2 + '</span>' +
									'</span>' +
									'<span class="progress">' +
									  '<span class="progress-bar" role="progressbar" style="width: ' + ((data.star1/data.totalStar)*100) + '%;" aria-valuemin="0" aria-valuemax="100">' + data.star1 + '</span>' +
									'</span>' +
								'</div>' +
							'</div>' +
						'</div>';
			$('#_review').append(add);
			
			$.each(data.reviews, function(index, review) {
				
			  let rev =	'<div class="reviewBox">' +
							'<div class="review_profile"><img src="http://localhost:8090/flenda/upload/' + review.userImg + '" alt="이미지" width="60px" height="60px"></div>' +
							'<div class="reviewBody">' +
								'<div class="reviewInfo">' +
									'<div class="review_id">' + review.id + ' | ' + (review.regidate).substring(0, 16) + '</div>' ;
										if(review.rescore == 5){
			   		rev +=				'<div class="review_score">★★★★★ <strong>매우 만족해요</strong></div>' ;
										}else if(review.rescore == 4){
			   		rev +=				'<div class="review_score">★★★★ <strong>만족해요</strong></div>' ;								
										}else if(review.rescore == 3){
	           		rev +=				'<div class="review_score">★★★ <strong>보통이에요</strong></div>' ;							
										}else if(review.rescore == 2){
			  		rev +=				'<div class="review_score">★★ <strong>불만족해요</strong></div>' ;								
										}else if(review.rescore == 1){
			   		rev +=				'<div class="review_score">★ <strong>아주 불만족해요</strong></div>' ;								
										}
			   		rev +=			'</div>' +
								'<div class="reviewContent">' + review.content + '</div>' +
							'</div>' +
							'<div class="reviewImg">' +
								'<img src="http://localhost:8090/flenda/upload/' + review.fileName + '" width="200px" height="400px" style="border-color: white;">' +
							'</div>' +
							'<hr width="95%" style="margin-left: 15px; margin-top: 10px; background-color: #81BEF7;">' +
						'</div>' ;
				
			 $('#_review').append(rev);	
				
			});
			
		},
		error:function(){
			alert('error');
		}
	});
}
/* 추천액티비티 */
$(document).ready(function() {
	$.ajax({
		url:"referenceAct.do",
		data: {location:'${act.address}', seq:${act.sellSeq} },
		success:function(data){
			
			$.each(data.list, function(index, item) {
				let showlist = 	'<a href="main_actdetail.do?seq=' +item.sellSeq + '">' +
								'<div class="card" style="max-width: 20rem; text-align: left; margin: 20px; float: left; width: 330px;">';
						$.each(data.pics, function(index, pic) {
							if(item.sellSeq == pic.sellSeq){
								<!-- 카드 상단에 배치되는 이미지 : card-img-top -->
								showlist +=	'<img class="card-img-top" src="http://localhost:8090/flenda/upload/' + pic.newFileName + '">';		
								return false;
							}
						});	
				
									<!-- 카드본문:card-body -->
						showlist +=	'<div class="card-body">' +
										'<div style="display:flex; justify-content: space-between;">' +
											'<div class="card-loc">' + locations(item.address) + '</div>' +
											'<div class="card-text"><font style="font-size: 15px; color: blue;">★</font>평점&nbsp;' + item.reviewAvg + '&nbsp;<font style="font-size: 13px; color: #5882FA;">(후기 ' + item.reivewNum + '건)</font></div>' +
										'</div>' +
								      	<!-- 카드 제목 :card-title -->
								      	'<h5 class="card-title">' + dots(item.title) + '</h5>' +
								     	 <!-- 카드의 내용 글 :card-text -->
								      	'<div style="display: flex; justify-content: space-between;">' +
									      	'<div style="margin-right: 20px;">' +
									      	'<div class="card-text"><font size="2"><b>종류 </b></font>&nbsp;&nbsp;' + item.category + '</div>' +
									      	'<div class="card-text"><font size="2"><b>소요시간 </b></font>&nbsp;&nbsp;' + item.timetake + '시간</div>' +
									      	'</div>' +
									      	'<div>' +
									      	'<div class="priceRange" id="priceRange' + index + '"></div>' +
									      	'</div>' +
									     '</div>' +
								    '</div>' +
							 	'</div>' +
							 	'</a>';			
								 
				$(".footer_content").append(showlist);
				priceRange(item.sellSeq,index);
			});
			
			/* 위시리스트 체크 */
			$.each(data.wlist, function(index, wish) {
	      		if(wish.id == '${login.id}' && wish.sellseq == ${act.sellSeq}){
	      			$("#emptyheart").attr("src","./image/fullheart.png" );
	      			$("#wishlist").val("on");
	      		}			 
			});
			
		},
		error:function(){
			alert('error');
		}
	});
});
function locations(address) {
	let arr = address.split(' ');
	return arr[0] + ' ' + arr[1];
}
function priceRange(sellSeq,idx){
	let range = '';
	$.ajax({
		url:"getPriceRange.do",
		data:{seq:sellSeq},
		success:function(str){
			$('#priceRange'+idx).html(str+'원/인');
		},
		error:function(){
			alert('error');
		}
	})
}
function YYYYMMDD(dates) {
	let year = dates.substring(0, 4);
	let month = dates.substring(4, 6);
	let day = dates.substring(6, 8);
	
	return month + "월" + day + "일";
}
function HHMM(dates) {
	let hour = dates.substring(9, 11);
	let min = dates.substring(11, 13);
	return hour + ":" + min ;
}
//참고사이트 https://webclub.tistory.com/304
(function (global, $) {   //생성자함수 
	
	let $menu = $('.flotingbenu li.m'),      // $menu = $('menu'); 와 같다  , 플로팅배너에 있는 메뉴들, 함수를 호출하는 것 
		$contents = $('.scroll'), 		//scroll section들 / 누르면 나오는 콘텐츠들 <div>
		$doc = $('html, body'); 

$(function () { // 해당 섹션으로 스크롤 이동 
	$menu.on('click','a', function(e){ 
		let $target = $(this).parent(),  	 //선택한 요소의 부모 요소 <ul> 
			idx = $target.index(), 
			section = $contents.eq(idx),   	 //eq() : 특정 인덱스 번호를 가진 요소를 선택. 
			offsetTop = section.offset().top; 
		$doc.stop() 
			.animate({ 						// 애니메이션 효과로 자연스럽게 이동됨, 0.1초
				scrollTop :offsetTop 		// offset은 대상의 위치값을 나타냄 (고정적)
				}, 100); 
		return false; 
	});
});



// menu class 추가  해당 부분에 내려가면 색상변함
$(window).scroll(function(){ 
	let scltop = $(window).scrollTop(); 		//현재 스크롤의 위치값
	$.each($contents, function(idx, item){ 
		let $target = $contents.eq(idx),   	 //해당콘텐츠의 인덱스번호
		i = $target.index(), 
		targetTop = $target.offset().top; 	//offset().top : 선택한 요소의 y축 좌표 값을 가져오는 것 
		
		if (targetTop <= scltop) { 			// 해당 콘텐츠의 y축 좌표값이 현재 스크롤의 위치값보다 작거나 같을때 
			$menu.removeClass('on');         //removeClass: 선택한 요소의 클래스 값을 제거 
			$menu.eq(idx).addClass('on'); 
		} 
		if (!(200 <= scltop)) { 
			$menu.removeClass('on');
		} 
	}) 
}); 

}(window, window.jQuery));     //(function (global, $) 의 끝


//취소규정 더보기
$(document).ready(function() {

    //기본값 설정
    $("#cancle01").show(); //cancle 규정 첫부분 영역 보이기
    $("#cancle02").hide(); //more...숨기기
    $(".more2").hide();
   

    //더보기클릭시 보이기 및 숨기기
    $("span.more").click(function() {
        //3000 : 3초, 'slow', 'normal', 'fast'
        $("#cancle02").show('300'); //천천히 보이기
        $(".more2").show('300'); //천천히 보이기
        
        $(this).hide('normal');//more버튼 숨기기

    });
    
    $("span.more2").click(function() {

        $("#cancle01").show('300'); //천천히 보이기
        $(".more1").show('300'); //천천히 보이기
        
        $("#cancle02").hide('normal'); 
        $(".more").show('normal');
        
        $(this).hide('normal');

    });

});

//티켓선택 버튼선택시 스크롤 이동
$(document).ready(function(){

	$('#ticketBtn').click(function(){

		let offset = $('.ticketing').offset(); //선택한 태그의 위치를 반환

            //animate()메서드를 이용해서 선택한 태그의 스크롤 위치를 지정해서 0.1초 동안 부드럽게 해당 위치로 이동함 

        $('html').animate({scrollTop : offset.top}, 100);

	});

});

function heartclick(values){
	let seq = ${act.sellSeq};
	let id = '${login.id}';
	if(id == ''){
		alert('로그인 후, 사용가능합니다');
		return
	}
	if(values=="off"){
		$("#emptyheart").attr("src","./image/fullheart.png" );
		$("#wishlist").val("on");
		$.ajax({
			url:"addWish.do",
			data: {id:'${login.id}', sellseq:seq },
			success:function(str){
				if(str == 'success'){
					alert('찜하기 성공!');
				}else{
					alert('찜하기 실패!');
				}
			},
			error:function(){
				alert('error');
			}
		});
	}else{
		$("#emptyheart").attr("src","./image/heart.png" );
		$("#wishlist").val("off");
		$.ajax({
			url:"deleteWish.do",
			data: {id:'${login.id}', sellseq:seq },
			success:function(str){
				if(str == 'success'){
					alert('찜하기해제!');
				}else{
					alert('찜하기해제 실패!');
				}
			},
			error:function(){
				alert('error');
			}
		});
	}
}
function dots(str){
	let newStr = '';
	if(str.length > 15){
		newStr = str.substring(0, 16);
	}else{
		return str;
	}
	return newStr + '...';
}
</script>
</body>
</html>