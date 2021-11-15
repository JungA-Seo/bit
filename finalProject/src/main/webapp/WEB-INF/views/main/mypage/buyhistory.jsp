<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>buyhistory</title>

<!-- bar-rating -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<link rel="stylesheet" href="./css/fontawesome-stars.css">
<script type="text/javascript" src="./resources/ratingstar/jquery.barrating.min.js"></script>

<!-- pagination -->
<script type="text/javascript" src="./resources/pagination/jquery.twbsPagination.min.js"></script>

<link rel="stylesheet" type="text/css" href="./css/mypage_buyhistory.css">

</head>
<body>

<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
	  <ol class="breadcrumb">
	    <li class="breadcrumb-item active" aria-current="page">마이페이지</li>
	    <li class="breadcrumb-item active" aria-current="page">구매내역</li>
	  </ol>
</nav>
<div class="buytop">
	<div><h3>구매내역</h3></div>
</div>
<hr>
<!-- ajax 시작 -->
<div class="buyhistory"></div> 



     
<!-- 후기작성모달 -->

<div class="modal fade" id="reviewModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">후기 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <form id="reviewfrm">    <!--  나중에 db에 값 넣기 --> 
      
       <div id="hiddenSeq">
		  <input type="hidden" name="id" id="id" value="${login.id}">
		  <input type="hidden" name="userImg" value="${login.newFilename }">
      </div>
		
		<div class="modal-body" align="left">
      	후기점수 <br>
      	<select id="star" name="star">		<!-- 기본 별 값 : 1 --> 
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
		</select>
        <div class="mb-3">
            <label for="message-text" class="col-form-label" id="reContent">후기내용</label>
            <textarea class="form-control" id="message-text" name="content"></textarea>
        </div>
        
         <div class="mb-3">
            <label for="message-text" class="col-form-label">후기이미지</label>
            <br>
            <input type="file" name="fileload">
			
        </div>
      </div>
      </form>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="reviewBtn">작성</button>
      </div>
    </div>
  </div>
</div>



<!-- 모달창으로 환불정책 열림 -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <p class="modal-title" id="staticBackdropLabel">취소 및 환불정책</p>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       
 <p>- 취소요청 접수기준은 당사의 운영시간 내 ‘환불요청서’가 접수된 시간 또는 flenda 플랫폼 내의 ‘1:1 문의하기’에 기록된 시간 혹은 ‘취소요청’이 접수된 시간을 기준으로 합니다.
- 예약 확정 후 파트너가 일정을 변경하여 드릴 수 없어서 발생하는 예약 취소에 관하여는 본 취소환불 정책에 따른 수수료가 부과됩니다.
- 여행 일정 변경과 관련한 사항은 파트너에게 직접 문의하여야 합니다. 변경요청하시는 내용에 따라서 요금이 추가되거나 일정 변경이 불가할 수 있습니다.
- 여행자가 여행 확정 후 24시간 이내에 예약 취소를 요청하더라도, 여행일이 24시간 이내인 경우 전액환불 대상에서 제외됩니다.
- 각 상품의 설명 내용에서 취소환불 정책이 별도 규정 있을 경우, 각 상품의 별도 기재 내용이 본 취소환불 정책보다 우선 적용됩니다.
가이드투어 취소/환불 안내
파트너약관 제16조 제2항과 같이 여행요금 지급이 이루어진 후 투어 개시일 이전에 여행계약을 임의로 해제되는 경우, 해제 통보 시점에 관한 다음 각 호의 기준에 따라 여행요금이 환불됩니다.

[국내여행의 경우]
- 여행자가 여행 개시일로부터 3일 이전 통보 시: 여행 요금 전액 환불
- 여행 개시일로부터 2일 이전 통보 시: 여행요금에서 가이드 요금의 10%와 flenda 수수료 공제 후 환불
- 여행 개시일로부터 여행 시작 시간 기준 24시간 이전 통보 시: 여행요금에서 가이드 요금의 20%와 flenda 수수료 공제 후 환불
- 여행 시작 시간으로부터 24시간 이내 통보 시: 여행요금에서 가이드 요금의 30%와 flenda 수수료 공제 후 환불
다만, 위의 규정에도 불구하고 다음의 경우에는 예외로 합니다.
1) 여행자가 여행요금을 결제(지급)한 때로부터 24시간 이내에 여행계약을 철회(취소)하는 경우와 여행자가 투어 예약 후 가이드가 확정되기 전에 취소하는 경우는 여행요금을 전액 환불합니다.  단, 여행자가 여행요금을 결제하였다고 하더라도 해당 시점으로부터 24시간 이내 여행이 시작될 경우 (Instant Booking 예약에 해당하는 경우)는 전액 환불 대상에서 제외합니다.
2) 상품의 특성에 따라 현지 예약금으로 지불되어야 하는 금액이 있는 경우 해당 예약금의 환불에 대하여는 각 상품의 상세설명보기에서 별도로 고지한 취소환불 약관을 적용합니다.
티켓 취소/환불 안내
아래 내용이 적용되는 대상은 flenda 플랫폼(웹사이트와 어플리케이션 포함)을 통하여 당사가 판매대행 또는 구매 대행하여 여행자에게 배송하는 실물티켓과 여행자로 하여금 출력할 수 있도록 제공한 E-바우처에 한합니다.
[실물티켓]
1. 환불신청가능기간
결제일 이후 7일 이내 환불 신청한 경우에 한하여 환불이 가능합니다.
(티켓 유효기간의 1개월 이전에 환불을 신청한 경우에 한하여 환불이 가능합니다.)
2. 환불진행시 유의사항
여행자가 반품한 실물티켓을 당사가 수령하여 확인한 후 환불 처리됩니다.
실물티켓 구매 시 동봉되었던 티켓 사용 가이드북, 현지 사용 쿠폰 및 사은품도 함께 반품되어야 정상 환불 처리됩니다.
환불요청 접수 후 5일 이내에 당사에 실물티켓이 수령 확인되는 경우에 한해 정상 환불 처리됩니다.
개인 과실로 인하여 실물티켓이 멸실되거나 훼손된 경우에는 환불이 불가하오니, 각별히 유의하여 주시기 바랍니다.
3. 환불수수료
취소수수료(결제금액의 10%) 및 배송비가 환불수수료로 차감됩니다.
티켓제공업체에서 자체 규정하는 별도의 환불규정이 있는 경우 제공업체의 환불규정이 당사의 환불규정에 우선하여 적용됩니다. (상품상세페이지 기재)
[E-바우쳐]
티켓제공업체에서 자체 규정하는 별도의 환불규정에 따라 취소/환불이 진행됩니다. (상품상세페이지 기재)
티켓제공업체의 정책에 따라 환불이 원칙적으로 불가할 수 있으니, 신중히 구매하여 주시기를 당부 드립니다.
특가여행/민박 상품 군 취소/환불 안내
당사 또는 여행자는 여행 출발 전 이 여행계약을 해제할 수 있습니다. 이 경우 발생하는 손해액은 ‘소비자분쟁해결기준’(공정거래위원회 고시)에 따라 배상합니다.
여행자의 여행계약 해제 요청이 있는 경우(여행자의 취소 요청 시)
- 여행출발일 ~30일전까지 취소 통보 시 - 계약금 환급
- 여행출발일 29~20일전까지 취소 통보 시 - 여행요금의 10% 배상
- 여행출발일 19~10일전까지 취소 통보 시 - 여행요금의 15% 배상
- 여행출발일 9~8일전까지 취소 통보 시 - 여행요금의 20% 배상
- 여행출발일 7~1일전까지 취소 통보 시 - 여행요금의 30% 배상
- 여행출발 당일 취소 통보 시 - 여행요금의 50% 배상</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button> 
      </div>
      
    </div>
  </div>
</div> <!--  모달환불정책끝 -->

<br>
<div id="pagingMain" class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content:center;" ></ul>
    </nav>
</div>




<script type="text/javascript">
let loginid = '${login.id}';
$(document).ready(function() {
	//alert("id:" + loginid);
	
	let totalCount = 0;   //글의 총수
	let pageSize = 10;      //페이지의 크기 1 ~ 10   [1]~[10]
	let pageNumber = 1;      //현재페이지
	
	$.ajax({
		url:"getreviewlist.do",
		data: {id:loginid},
		success:function(map){
			//alert('success');
		
		/*페이징 값변경*/
		totalCount = map.totalCount;

		$.each(map.olist, function(index, or) {	
	
			let card = '<div class="card" id="cardTable1">' +
					   '<h5  class="card-header" align="left">'+or.itemName+'</h5>' +
						'<div class="card-body">' +
						  	'<div class="card-one">' +
						  		'<div class="Pdiv">' +
						  			'<div class="onepage">'+
									 	'<div class="page1'+or.sellSeq+'">' +
											'<span id="page1txt"><b>여행일 :&nbsp;</b>'+or.reservationDate+'</span><br>' +
											'<span id="page1txt"><b>카테고리 :&nbsp;</b>'+or.category+'</span><br>' +
										 	'<span id="page1txt"><b>예약자 :&nbsp;</b>'+or.name+'</span><br>' +
										 	'<span id="page1txt"><b>구매일 :</b>&nbsp;'+or.orderDate.substring(0, 16)+'</span><br>' +
										 	'<span id="page1txt"><b>구매수량 :</b>&nbsp;'+or.totalCount+'개</span><br>' +
										'</div>'+
									'</div>'+
								 '<div class="twopage">'+
									 '<div class="page2'+or.sellSeq+'">';
									
								if(or.payMethod == "samsung"){
								card +='<span id="page2txt"><b>결제방법 :</b>&nbsp;삼성페이</span><br>' ;
								}
								else if(or.payMethod == "card"){
								card +='<span id="page2txt"><b>결제방법 :</b>&nbsp;카드</span><br>' ;
								}
								else if(or.payMethod == "trans"){
								card +='<span id="page2txt"><b>결제방법 :</b>&nbsp;계좌이체</span><br>' ;
								}
								else if(or.payMethod == "vbank"){
								card +='<span id="page2txt"><b>결제방법 :</b>&nbsp;가상계좌</span><br>' ;
								}
								else{
								card +='<span id="page2txt"><b>결제방법 :</b>&nbsp;휴대폰 소액결제</span><br>' ;
								}
							card +=	'<span id="page2txt"><b>결제금액 :&nbsp;</b>'+or.paidMoney+'&nbsp;원</span><br>' +
									'<span id="page2txt"><b>만나는장소 :</b>&nbsp;'+or.meetplace+'</span><br>'+
								 	'<span id="page2txt"><b>주문번호 :</b>&nbsp;'+or.orderNum+'</span><br>'+
									'<span id="page2txt"><b>요청사항 :</b>&nbsp;'+or.userMemo+'</span>' +
									'</div>'+   //page2의 끝
								'</div>'+
								'<div class="reviewtable">' +
				 				'<span id="point"><img alt="" src="./image/pay-point.png" id="poimage"><b id="po">포인트를 모으세요!</b></span>' +
			 					'<br><br>' +
			 					'<span><b>작성시 1,000점</b>&nbsp;&nbsp;' +
			 						'<button type="button" class="btn btn-primary btn-sm" onclick="travelwrite()">여행기작성</button>' +
			 					'</span><br><br>' +
			 					'<span><b>작성시 500점</b>&nbsp;&nbsp;' +
			 						'<button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#reviewModal" onclick="sequnce(' + or.sellSeq + ')">후기작성</button>' +
								'</span>' +
								'</div>' + //reviewtable끝
								
								'<div class="arrowbtn">'+
									'<img src="./image/down-arrow.png" alt="off" id="arrows'+or.sellSeq+'" onclick="arrow(this.alt,'+or.sellSeq+')">' +
								'</div>' +	
							'</div>'+
							
							'<div class="cancleTable">'+
						 	'<div class="canclewrite">' +
						 		'<span><button class="btn btn-primary" value="' + or.orderNum + '" onclick="refund(this.value)">취소 및 환불요청</button></span>' +
							 	'<br>취소 및 환불 약관에 따라서 영업일 기준 3일 이내에 별도의 안내 드립니다.<br>' +
				    			'환불 정책 반드시 확인 해 주세요. (<a href="none" data-bs-toggle="modal" data-bs-target="#staticBackdrop">환불정책확인</a>)' +
						 	'</div>' +
					 	'</div>' +
				 	'</div>' +
				'</div></div>';
				$(".buyhistory").append(card); 	
				$(".page1" + or.sellSeq).show();
				$(".page2" + or.sellSeq).hide();
				
				let str =  '';
							$("#hiddenSeq").append(str); 
		
			});	//orderlist for문 끝
		
		if(map.olist == ''){
			let showlist = '<div class="nobuyList">구매한 상품이 없습니다</div>' +
							'<span><button class="btn btn-outline-primary me-5 rounded-pill" type="button" onclick="moveToAct()">액티비티 둘러보기</button></span>' +
							'<span><button class="btn btn-outline-primary me-5 rounded-pill" type="button" onclick="moveToTheme()">테마여행 둘러보기</button></span>';
			$(".buyhistory").append(showlist);
		}	
			
		
		 /* 페이징 추가 */
        let paging = '<nav aria-label="Page navigation">' +
                      '<ul class="pagination" id="pagination"  style="justify-content:center;"></ul>' +
                    '</nav>'
        $('#pagingMain').append(paging);
        
        let totalPages = Math.floor(totalCount / 3);
       // alert("totalpages" + totalPages);
        
        if(totalCount % 3 > 0){
           totalPages++;
        }
        $("#pagination").twbsPagination({
           startPage: pageNumber,
           totalPages: totalPages,
           visiblePages: 3,
           initiateStartPageClick:false,
           first:'<span sris-hidden="true">«</span>',
           prev:"이전",
           next:"다음",
           last:'<span sris-hidden="true">»</span>',
           onPageClick:function(event, page){
              
           }
        });  
	
		
		}, //success끝
		error:function(){
			alert('error');
		}
		
	});//ajax끝
});


function arrow(alt,num) {				//화살표 누르면 펼쳐지기
//	alert(alt);
//	alert(num);
	
	if(alt=='off'){					// 펼칠때
		$(".page2"+num).show('500');
		$('#arrows'+num).attr('src','./image/uparrow.png');
		$('#arrows'+num).attr('alt','on');
		
	}
	else{							// 줄일때
		$(".page2"+num).hide('500');
		$('#arrows'+num).attr('src','./image/down-arrow.png');
		$('#arrows'+num).attr('alt','off');
	}
	
} 

//여행기 버튼 클릭시 
function travelwrite() {
	location.href = "bbswrite.do";
}  

//별점구현
$('#star').barrating({
		theme: 'fontawesome-stars'
});

let orSeq = 0;
function sequnce(sellSeq){
	orSeq = sellSeq;
	
	$.ajax({
		url:"checkReview.do",
		data:{ id:loginid, sellSeq:orSeq},
		success:function(data){
			if(data == 'success'){
				alert('이미 후기작성 하셨습니다.');
				location.href = "buyhistory.do?id=${login.id}";
			}
		},
		error:function(){
			alert('error');
		}
	});
	
}
//리뷰버튼 클릭시
$("#reviewBtn").click(function() {
	
	let star = $("#star").val();  //별점 값 가져오기
	//alert(star);
	let data = $('#reviewfrm')[0];
	let dataForm = new FormData(data);
	
	dataForm.append('rescore', star );	//dataForm에 값 붙여넣기
	dataForm.append('sellSeq', orSeq);
	
	$.ajax({
		url:"addReview.do",
		type:"post",
		data: dataForm,
		enctype: 'multipart/form-data',
		processData:false,
		contentType:false,
		cache:false,				// Session와 같이 저장을 위한 것.	session은 서버에 저장. cookie는 브라우저에 저장. cache는 임시저장개념
		success:function(msg){
			//alert('success');
			if(msg == 'success'){
				alert('후기를 작성해주셔서 감사합니다');
				location.href = "buyhistory.do?id=${login.id}";
			}else{
				alert('후기작성에 실패하셨습니다');
				location.href = "buyhistory.do?id=${login.id}";
			}
		},
		error:function(){
			alert('error');
		}
	}); //ajax끝

});

function moveToAct() {
	location.href="main_activity.do";
}
function moveToTheme() {
	location.href="tmsearch.do";
}
function refund(orderNum) {
	location.href="refundHistory.do?seq="+orderNum;
}
</script>

</body>
</html>