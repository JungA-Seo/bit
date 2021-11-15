<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="./css/main.css">
 <link rel="stylesheet" type="text/css" href="./css/chat/chatUser.css">

<a class="LuChatBtn" href="javascript:void(0);">
</a>

<div class="movebtn">
 	<input class="btn_grp" type="button" onclick="btnclick(1)" value="환불문의">
	<input class="btn_grp" type="button" onclick="btnclick(2)" value="상품문의">
	<input class="btn_grp" type="button" onclick="btnclick(3)" value="투어문의">
	<input class="btn_grp" type="button" onclick="btnclick(4)" value="기타문의">
</div>

<div class="chatWindow">
	<div class="LuChatHeader">Flenda Manager </div>
	<div class="chatWindow__chat"></div>
	<div class="chatInputHolder">
		<input type="text" class="chatWindow__question" name="question" placeholder="질문을 작성하세요..." autocomplete="off">
		<button type="button" class="chatSendBtn">전송</button>
	</div>
</div>

<form action="moveChatRoom.do" method="post" id="moveChatForm">
	<input type="hidden" name="roomName" id="roomId">
</form>


<div class="footer_container">

	<div class="footer_box1" align="center">
		<div class="box1">
			<div class="box1_icons">
				<ul class="icon_down">
					<li style="margin-right: 20px;"><a href="https://ko-kr.facebook.com/"><img src="./image/facebook.png"></a></li>
					<li style="margin-right: 20px;"><a href="https://instagram.com/flenda_official?utm_medium=copy_link"><img src="./image/instagram.png"></a></li>
					<li style="margin-right: 20px;"><a href="https://blog.naver.com/minki145"><img src="./image/naver.png" style="width: 33px; height: 33px;"></a></li>
				</ul>
			</div>
			<div class="box1_text">
				당신이 찾는 모든 여행이 여기에
			</div>
		</div>		
	</div>
	
	<div align="center">
	<div class="footer2">
		<!-- 고객센터 -->
		<div class="footer_box2">
			<div class="box2_textbox">
				<div class="cs_name"><strong>고객센터 운영안내</strong></div>
				<div class="cs_chat">평일(채팅/유선) : 10:00-18:00 (점심:12:00~13:00)</div>
				<div class="cs_email">이메일 : cs@flenda.com</div>
				<div class="cs_text">※주말/공휴일 : 채팅 상담만 가능</div>
				<div class="cs_phone">유선상담 : 010-8523-2063</div>
				<div class="cs_chat_btn" style="margin-top: 10px;">
					<button type="button" class="button-6" role="button">
					1:1 채팅상담</button>
				</div>
			</div>		
		</div>
		
		<div class="footer_box3">
			
			<div style="font-weight: bold;">Flenda Inc.┃ CEO Lee Gidong</div>
			<div>Business Registration Number, 261-81-04385</div>
			<div>Mail-order Distributor Registration Number, 2021-서울마포구-01088</div>
			<div>South Korea Travel Agent Licence : 2021 - 00001111</div>
			<div>&nbsp;</div>
			<div>© 2021 Flenda Inc. All Rights Reserved.</div>
			
		</div>
		
		<!-- 결제수단 -->
		<div class="footer_box4">
			<div class="text4">결제수단</div>
			<div class="cards">
				<div class="card_visa">
					<img src="./image/vs.JPG">
				</div>
				<div class="card_master">
					<img src="./image/ms.JPG">
				</div>
				<div class="card_amex">
					<img src="./image/amex.JPG">
				</div>
				<div class="card_payco">
					<img src="./image/payco.JPG">
				</div>
			</div>
		</div>
	</div>
	</div>
	
	<hr>
	
	<div class="footer_box5" align="center">
		<div class="text5">
			<div class="box5_textbox1">
				<div>㈜프렌다&nbsp;|&nbsp;사업자 등록번호 : 261-81-04385</div>
				<div>통신판매업신고번호 : 2021-서울마포구-01088</div>
				<div>대표 : 2팀&nbsp;|&nbsp;개인정보 관리 책임자 : 2팀</div>
				<div>서울특별시 마포구 신수동 63-14 비트캠프 </div>
				<div>㈜프렌다는 통신판매중개자로서 거래당사자가 아니며,<br>호스트가 등록한 상품정보 및 거래에 대해 ㈜프렌다는 일체의 책임을 지지 않습니다.</div>
			</div>
			<div class="box5_textbox2">
				<div>Republic of Korea : 3F, bitcamp, 193, Tojeong-ro, Mapo-gu, Seoul, Republic of Korea</div>
				<div>Customer Support Center : +82 ) 070-0000-0000 ( AM 10:00 - PM 06:00 (GMT+9) ) ( Excluding weekends & public holidays )</div>
				<div>Flenda Inc. is a sales broker, we are not responsible for any product information and transactions.</div>
			</div>
		</div>
	</div>
	
	<hr>
	<div class="box5_agreement" align="center">
		<span><a href="useterms.do">이용약관</a></span>&nbsp;&nbsp;|&nbsp;
		<span><a href="privacyPol.do"><strong>개인정보 처리방침</strong></a></span>&nbsp;&nbsp;|&nbsp;
		<span><a href="locationbase.do">위치기반 서비스 이용약관</a></span>
	</div>
	
</div>

<script>
let roomid;
$('.button-6').click(function() {
	$('.btn_grp').toggleClass('hide');
});
$('.LuChatBtn').click(function() {
	 $('.btn_grp').toggleClass('hide');
});
	
$('.movebtn').click(function() {
	  if('${login.id}' == ''){
		alert('로그인 해주세요');
		return
	  }
  	  $('.chatWindow').toggleClass('active');
	  $('.LuChatBtn').toggleClass('active');
	  $('.LuChatBtn').removeClass('expanded');
	  $('.btn_grp').toggleClass('hide');
  	  
  	  if($('.chatWindow').hasClass('active')){
  		 $('.LuChatBtn').click(function() {
  		  	  $('.chatWindow').removeClass('active');
  		  	  $('.LuChatBtn').toggleClass('active');
			  onClose();
  		 });
  	  }
});
</script>

<script type="text/javascript">

 let user = '${login.id}'; 
 let ws;
function btnclick(value){
		let choice;
		if(user == ''){
			return
		}
 		switch(value){
		case 1:
			choice = "refurn-"+user;
			$(".chatWindow__chat").empty();
			break;
		case 2:
			choice = "goods-"+user;
			$(".chatWindow__chat").empty();
			break;
		case 3:
			choice = "tour-"+user;
			$(".chatWindow__chat").empty();
			break;
		case 4:
			choice = "rest-"+user;
			$(".chatWindow__chat").empty();
			break; 	
 		}

		 $.ajax({
			url:"chatUser.do",
			type: "post",
			data: {roomName:choice},
			success:function(data){
				
					let chat = {
							name:data,
							totalcount:2,
							category:choice
					}
					roomid = data;

					$.ajax({
						url:"createRoom.do",
						type: "post",
						data: chat,
						success:function(){

							ws = new WebSocket("ws://192.168.35.79:8090/flenda/echo.do");
							ws.onopen = onOpen(choice);
							ws.onclose = onClose;
							ws.onmessage = onMessage;

						},error:function(){
							alert("error2");
						}
					});

			},
			error:function(){
				alert("error1");
			}
		});
}		
</script>

<script type="text/javascript">
	function onOpen(evt){
		
		let roomName = evt;
		$(".chatWindow__chat").append(user+"<b>님 환영합니다. 문의를 남겨주세요, 담당자가 빠를 시일 내에 답변드리겠습니다.</b><br>");
		
      	$(".chatSendBtn").click(function() {
         	let msg = $('.chatWindow__question').val().trim(); 
         	ws.send(msg+"!%/"+roomName+"!%/"+"user");
				$(".chatWindow__chat").append('<div class="chat__question"><p class="chat__question__text">'+msg+'</p></div>');
            	$(".chatWindow__chat").scrollTop(99999999);
            	$(".chatWindow__question").val(""); 
            	$(".chatWindow__question").focus();
      	});
      	$(".chatWindow__question").keypress(function(event) {
         	if(event.which == "13"){
            	event.preventDefault();

            	let msg = $('.chatWindow__question').val().trim();
                	ws.send(msg+"!%/"+roomName+"!%/"+"user");
                	$(".chatWindow__chat").append('<div class="chat__question"><p class="chat__question__text">'+msg+'</p></div>');
                	$(".chatWindow__chat").scrollTop(99999999); 
                	$(".chatWindow__question").val(""); 
                	$(".chatWindow__question").focus(); 
         	}
      	}); 
	}
	function onMessage(msg){

      	let jsonData = JSON.parse(msg.data);
      	if(jsonData.message !=null){
        	$(".chatWindow__chat").append(jsonData.message+"<br>");
        	$(".chatWindow__chat").scrollTop(99999999);
      	}
	}
	function onClose(){
  		$.ajax({
			url:"delData.do",
			data:{roomId : roomid},
			type: "post",
			success:function(){

			},
			error:function(){
				alert("error");
			}
		}); 
	}
</script>