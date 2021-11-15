<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url(//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css);
.wishtop{
	font-family: 'Spoqa Han Sans Neo', 'sans-serif';
	margin-top: 20px;
	padding-left: 30px;
	text-align: left;
	display: flex;
}
.wishtop div{
	margin-right: 20px;
}
.wishlist{
	width: 100%;
	height: 100%;
	display: flex;
}
.wishtlist{
	width: 100%;
	height: 100%;
	display: flex;
}
.noWishList{
	font-size: 25px;
	font-family: 'Spoqa Han Sans Neo', 'sans-serif';
	margin: 200px 60px 20px 0px;
}
.liked{
	position: absolute;
	bottom: 5%;
	right: 5%;
}
</style>
</head>
<body>
	<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
		  <ol class="breadcrumb">
		    <li class="breadcrumb-item active" aria-current="page">마이페이지</li>
		    <li class="breadcrumb-item active" aria-current="page">위시리스트</li>
		  </ol>
	</nav>
	<div class="wishtop">
		<div><img alt="" src="./image/love.png" width="40px" height="40px"></div>
		<div><h3>내가 찜한 여행상품</h3></div>
	</div>
	<hr>
	<div class="wishbody">
		<div class="actwish_sub"></div>
		<div class="wishlist"></div>
		<div class="themewish_sub"></div>
		<div class="wishtlist"></div>
	</div>
<script type="text/javascript">
$(document).ready(function() {
	$.ajax({
		url:"mypageWishList.do",
		data:{ id:'${login.id}' },
		success:function(data){
			if(data.list != ''){
				let subject = '<div align="left" style="font-size:25px; margin-left: 20px;">액티비티여행</div>';
				$(".actwish_sub").append(subject);
				$.each(data.list, function(index, item) {
					let showlist = 	'<a href="main_actdetail.do?seq=' +item.sellSeq + '" style="text-decoration: none; color: black;">' +
									'<div class="card" style="max-width: 20rem; text-align: left; margin: 20px; width: 330px;">';
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
										      	'<div style="margin-right: 20px;">';
										      	if(item.category == 'activity'){
							showlist +=		      	'<div class="card-text"><font size="3"><b>종류 </b></font>&nbsp;액티비티</div>' ;
										      	}
										      	if(item.category == 'ticket'){
							showlist +=		      	'<div class="card-text"><font size="3"><b>종류 </b></font>&nbsp;티켓</div>' ;
										      	}
										      	if(item.category == 'experience'){
							showlist +=		      	'<div class="card-text"><font size="3"><b>종류 </b></font>&nbsp;체험</div>' ;
										      	}
										      	if(item.category == '선택'){
							showlist +=		      	'<div class="card-text"><font size="3"><b>종류 </b></font>&nbsp;기타</div>' ;
										      	}
							showlist +=		      	'<div class="card-text"><font size="3"><b>소요시간 </b></font>&nbsp;&nbsp;' + item.timetake + '시간</div>' +
										      	'</div>' +
										      	'<div>' +
										      		'<div class="priceRange" id="priceRange' + index + '"></div></a>' +
										      		'<img align="right" src="./image/dark_heart.png" alt="off" class="liked" id="liked' + item.sellSeq + '" onclick="liked(this.alt,' + item.sellSeq + ')" width="20px" height="20px">' +
										      	'</div>' +
										    '</div>' +
									    '</div>' +
								 	'</div>';			
									 
					$(".wishlist").append(showlist);
					priceRange(item.sellSeq,index);
				});
			}
			
			if(data.tlist != ''){
				let subject = '<div align="left" style="font-size:25px; margin-left: 20px;">테마여행</div>';
				$(".themewish_sub").append(subject);
				$.each(data.tlist, function(index, item) {
					let showlist = 	'<a href="tmuserdetail.do?sellSeq=' +item.sellSeq + '" style="text-decoration: none; color: black;">' +
									'<div class="card" style="max-width: 20rem; text-align: left; margin: 20px; width: 330px;">';
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
												'<div class="card-loc">' + locations(item.meetplace) + '</div>' +
												'<div class="card-text"><font style="font-size: 15px; color: blue;">★</font>평점&nbsp;' + item.reviewAvg + '&nbsp;<font style="font-size: 13px; color: #5882FA;">(후기 ' + item.reviewNum + '건)</font></div>' +
											'</div>' +
									      	<!-- 카드 제목 :card-title -->
									      	'<h5 class="card-title">' + dots(item.title) + '</h5>' +
									     	 <!-- 카드의 내용 글 :card-text -->
									      	'<div style="display: flex; justify-content: space-between;">' +
										      	'<div style="margin-right: 20px;">' +	    
											      	'<div class="card-text"><font size="3"><b>종류 </b></font>&nbsp;' + item.category + '</div>' +
										      		'<div class="card-text"><font size="3"><b>소요시간 </b></font>&nbsp;&nbsp;' + item.timetake + '시간</div>' +
										      	'</div>' +
										      	'<div>' +
										      		'<div class="priceRange" id="priceRange' + index + '"></div></a>' +
										      		'<img align="right" src="./image/dark_heart.png" alt="off" class="liked" id="liked' + item.sellSeq + '" onclick="liked(this.alt,' + item.sellSeq + ')" width="20px" height="20px">' +
										      	'</div>' +
										    '</div>' +
									    '</div>' +
								 	'</div>';			
									 
					$(".wishtlist").append(showlist);
					priceRange(item.sellSeq,index);
				});
			}
			
			if(data.tlist == '' && data.list == ''){
				let showlist = '<div class="noWishList">등록된 찜한 상품이 없습니다</div>' +
								'<span><button class="btn btn-outline-primary me-5 rounded-pill" type="button" onclick="moveToAct()">액티비티 둘러보기</button></span>' +
								'<span><button class="btn btn-outline-primary me-5 rounded-pill" type="button" onclick="moveToTheme()">테마여행 둘러보기</button></span>';
				$(".wishbody").append(showlist);
			}
			
			/* 위시리스트 체크 */
			$.each(data.wlist, function(index, wish) {
	      		if(wish.id == '${login.id}'){
	      			$('#liked'+wish.sellseq).attr('src','./image/red_heart.png');
	      			$('#liked'+wish.sellseq).attr('alt','on');
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
function dots(str){
	let newStr = '';
	if(str.length > 15){
		newStr = str.substring(0, 15);
	}else{
		return str;
	}
	return newStr + '...';
}
function liked(alt,num) {
	let id = '${login.id}';
	if(id == ''){
		alert('로그인 후, 사용가능합니다');
		return
	}
	
	if(alt == 'off'){
		$('#liked'+num).attr('src','./image/red_heart.png');
		$('#liked'+num).attr('alt','on');
		$.ajax({
			url:"addWish.do",
			data: {id:'${login.id}', sellseq:num },
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
		$('#liked'+num).attr('src','./image/dark_heart.png');
		$('#liked'+num).attr('alt','off');
		$.ajax({
			url:"deleteWish.do",
			data: {id:'${login.id}', sellseq:num },
			success:function(str){
				if(str == 'success'){
					alert('찜하기해제 성공!');
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
function moveToAct() {
	location.href="main_activity.do";
}
function moveToTheme() {
	location.href="tmsearch.do";
}
</script>
</body>
</html>