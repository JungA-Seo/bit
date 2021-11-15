<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String param = request.getParameter("param");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 날짜범위선택 https://www.daterangepicker.com -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
 
 <!-- pagination -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./resources/pagination/jquery.twbsPagination.min.js"></script>
 
<link rel="stylesheet" type="text/css" href="./css/main_activity_search1.css">
</head>
<body>
<form id="frm">
<div class="searchbar" align="center">
	<div class="rounded-pill" id="search_box">
		<span>
			<c:if test="${empty param}">
			<input type="text" id="input" name="input" class="inputBox" placeholder="지역을 검색해주세요" size="18">
			</c:if>
			<c:if test="${not empty param}">
			<input type="text" id="param" name="input" class="inputBox" placeholder="지역을 검색해주세요" size="18" value="<%=param%>">
			</c:if>
		</span>
		<span class="search_field">
			<input type="text" id="daterange" name="daterange" size="25" placeholder="날짜 검색해주세요">
			<img id="searchBtn" src="./image/searchBtn.jpg"  style="width: 70px; height: 70px;">
		</span>
	</div>
</div>
<div class="body">
	<div class="leftmenu">
		<div class="shadow p-3 mb-5 bg-body rounded selectBox">
			<div class="_category">
				<span class="subjects">카테고리</span>
				<hr style="color: #D8D8D8">
				<input value="all" type="radio" class="btn-check" name="category" id="option1" autocomplete="off" checked>
				<label class="btn btn-outline-primary rounded-pill" id="testing" for="option1">전체</label>		
				<input value="activity"type="radio" class="btn-check" name="category" id="option2" autocomplete="off">
				<label class="btn btn-outline-primary rounded-pill" for="option2">액티비티</label>
				<input value="ticket" type="radio" class="btn-check" name="category" id="option3" autocomplete="off">
				<label class="btn btn-outline-primary rounded-pill" for="option3">티켓</label>
				<input value="experience" type="radio" class="btn-check" name="category" id="option4" autocomplete="off">
				<label class="btn btn-outline-primary rounded-pill" for="option4">체험</label>
			</div>
			<div class="_price">
				<span class="subjects">투어비용(1인 기준)</span>
				<hr style="color: #D8D8D8">
				<input value="0~1000000" type="radio" class="btn-check" name="price" id="price1" autocomplete="off" checked>
				<label class="btn btn-outline-primary rounded-pill" for="price1">전체</label>
				<input value="0~50000" type="radio" class="btn-check" name="price" id="price2" autocomplete="off">
				<label class="btn btn-outline-primary rounded-pill" for="price2">5만원이하</label><br>		
				<input value="50000~100000"type="radio" class="btn-check" name="price" id="price3" autocomplete="off">
				<label class="btn btn-outline-primary rounded-pill" for="price3">5만원~10만원</label>
				<input value="100000~1000000" type="radio" class="btn-check" name="price" id="price4" autocomplete="off">
				<label class="btn btn-outline-primary rounded-pill" for="price4">10만원이상</label>
			</div>
			<div class="_time">
				<span class="subjects">시간대</span>
				<hr style="color: #D8D8D8">
				<div class="form-check">
				  <input value="0~23" class="form-check-input border" type="radio" name="time" id="flexRadioDefault1" checked>
				  <label class="form-check-label" for="flexRadioDefault1">전체</label>
				</div>
				<div class="form-check">
				  <input value="0~12"class="form-check-input border" type="radio" name="time" id="flexRadioDefault2" >
				  <label class="form-check-label" for="flexRadioDefault2">오전(낮 12시 이전)</label>
				</div>
				<div class="form-check">
				  <input value="12~18"class="form-check-input border" type="radio" name="time" id="flexRadioDefault3" >
				  <label class="form-check-label" for="flexRadioDefault3">오후(낮 12시 ~ 오후 6시)</label>
				</div>
				<div class="form-check">
				  <input value="18~0"class="form-check-input border" type="radio" name="time" id="flexRadioDefault4" >
				  <label class="form-check-label" for="flexRadioDefault4">저녁(오후 6시 이후)</label>
				</div>
			</div>
			<div class="_order">
				<span class="subjects">순서</span>
				<hr style="color: #D8D8D8">
					<input value="recommended" type="radio" class="btn-check" name="orders" id="order1" autocomplete="off" checked="checked">
					<label class="btn btn-outline-secondary rounded-pill" for="order1">추천순</label>
					<input value="score" type="radio" class="btn-check" name="orders" id="order2" autocomplete="off">
					<label class="btn btn-outline-secondary rounded-pill" for="order2">평점순</label>
					<input value="review" type="radio" class="btn-check" name="orders" id="order3" autocomplete="off">
					<label class="btn btn-outline-secondary rounded-pill" for="order3">리뷰순</label>
					<input value="sell" type="radio" class="btn-check" name="orders" id="order4" autocomplete="off">
					<label class="btn btn-outline-secondary rounded-pill" for="order4">판매량순</label>
					<input value="newitem" type="radio" class="btn-check" name="orders" id="order5" autocomplete="off">
					<label class="btn btn-outline-secondary rounded-pill" for="order5">최신순</label>
			</div>
		</div>
	</div>
	<div class="list_contents">
		 <div id="contents"></div>
		 <div id="pagingMain" class="container">
		    <nav aria-label="Page navigation">
		        <ul class="pagination" id="pagination"  style="justify-content:center;"></ul>
		    </nav>
		</div>
	</div>
	<div class="map_contents">
		<div id="map"></div>
	</div>
</div>
</form>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6fec700b25d3a20cd24c1f887074271e&libraries=services"></script> <!-- 카카오지도 -->
<script>
/* 맨처음 리스트 부름 */
$(document).ready(function() {
	$('#daterange').val('');
	ajax(0);
});
/* 검색 */
$("#searchBtn").click(function() {
	ajax(0);
});

let totalCount = 0;	//글의 총수
let pageSize = 10;		//페이지의 크기 1 ~ 10	[1]~[10]
let pageNumber = 1;		//현재페이지

function ajax(pageNum) {
	$('#pagingMain').empty();
	$('#contents').empty();
	
	let data = $('#frm')[0];
  	let dataForm = new FormData(data);
  	dataForm.append('pageNumber', pageNum);
	$.ajax({	// 비동기통신
		url:"main_searchActivity.do",
		type:"post",
	 	data:dataForm,
	 	processData: false,	//FormData API 사용시에 필요
	 	contentType: false,	//FormData API 사용시에 필요
		success:function(data){
		//	let str = JSON.stringify(data);	// 전체확인하기
		//	alert(str);
			/* 페이징 값변경 */
			totalCount = data.totalCount;
			pageNumber = data.search.pageNumber + 1;
			
			////////////////////////////지도 JS영역////////////////////////////////
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div
		    mapOption = {
		        center: new kakao.maps.LatLng(37.5556326132925, 126.992217614712), // 지도의 중심좌표
		        level: 9 // 지도의 확대 레벨
		    };  
		
			mapContainer.style.width = "900px";
			mapContainer.style.height = "1000px";
		 	
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption);
			
			$.each(data.list, function(index, item) {		
				var latitude = parseFloat(item.latitude);
				var longitude = parseFloat(item.longitude);
				var markerPosition  = new kakao.maps.LatLng( latitude , longitude ); 
				
				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    map: map,
					position: markerPosition
				});
				
		     	// 마커가 지도 위에 표시되도록 설정합니다
		       	/*  marker.setMap(map); */
		         
		     	// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		        var str = 	'<a href="main_actdetail.do?seq=' +item.sellSeq + '">' +
		        			'<div class="shadow-lg mb-5 bg-body rounded wrap">' + 
				            '    <div class="info">' + 
				            '        <div class="body">' + 
				            '            <div class="img">';
						            $.each(data.pics, function(index, pic) {
										if(item.sellSeq == pic.sellSeq){
					str +=     			'<img src="http://localhost:8090/flenda/upload/' + pic.newFileName + '" width="230" height="130">';
											return false;
										}
									});	
					str +=				'</div>' + 
				            '            <div class="desc">' +
            				'				 <div class="title">' + dots(item.title) + '</div>' +
				            '                <div class="jibun ellipsis">' + locations(item.address) +'<font style="font-size: 15px; color: blue; margin-left:40px;">★</font>&nbsp;' + item.reviewAvg + ' (후기 ' + item.reivewNum +'건)</div>';
											if(item.category == 'activity'){
									str +=	'<div class="jibun ellipsis"><b>소요시간 </b>' + item.timetake + '시간 <b style="margin-left:30px;">종류 </b>액티비티</div>' ;
									      	}
									      	if(item.category == 'ticket'){
						      		str +=	'<div class="jibun ellipsis"><b>소요시간 </b>' + item.timetake + '시간 <b style="margin-left:30px;">종류 </b>티켓</div>' ;
									      	}
									      	if(item.category == 'experience'){
						      		str +=	'<div class="jibun ellipsis"><b>소요시간 </b>' + item.timetake + '시간 <b style="margin-left:30px;">종류 </b>체험</div>' ;
									      	}
									      	if(item.category == '선택'){
						      		str +=	'<div class="jibun ellipsis"><b>소요시간 </b>' + item.timetake + '시간 <b style="margin-left:30px;">종류 </b>기타</div>' ;
									      	}
					str +=  '            </div>' + 
				            '        </div>' + 
				            '    </div>' +    
				            '</div></a>';

		        // 커스텀 오버레이가 표시될 위치입니다 
		        /* var position = new kakao.maps.LatLng( latitude , longitude );   */

		        // 커스텀 오버레이를 생성합니다
		        var overlay = new kakao.maps.CustomOverlay({
		        	yAnchor: 1,
		            position: marker.getPosition()
		        });
		        
		        var content = document.createElement('div');
		        content.className = 'overlay';
		        content.innerHTML = str;
		        		
		        var closeBtn = document.createElement('div');
		        closeBtn.innerHTML = "<img src='./image/placeholder1.png' width='39px' height='39px;'>";
		        closeBtn.onclick = function() {
		        	overlay.setMap(null);
		        };
		        
		        
		        content.appendChild(closeBtn);
		        		
		        overlay.setContent(content);
		        
		     	
		     	// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
		        kakao.maps.event.addListener(marker, 'click', function() {
		        	overlay.setMap(map);
		        });
			});
			
			
			//지도이동시키기
			let search_loc = $('input[name=input]').val();
			// 주소-좌표 변환 객체를 생성합니다
			if(search_loc != ''){
				var geocoder = new kakao.maps.services.Geocoder();
				geocoder.addressSearch(search_loc, function(result, status) {
					// 정상적으로 검색이 완료됐으면
				     if(status == kakao.maps.services.Status.OK) {
				    	var moveLatLon = new kakao.maps.LatLng(result[0].y, result[0].x);
				    	map.panTo(moveLatLon);
				     }
				});
			}
			
			
			
			$.each(data.list, function(index, item) {
				
				let showlist = 	'<a href="main_actdetail.do?seq=' +item.sellSeq + '">' +
								'<div class="card" style="max-width: 30rem; text-align: left; margin-left: 50px; margin-right: 20px; margin-bottom: 30px;">';
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
										'<div class="card-text"><font style="font-size: 14px;">⭐</font>평점&nbsp;&nbsp;' + item.reviewAvg + '&nbsp;&nbsp;<font style="font-size: 15px; color: #5882FA;">(후기 ' + item.reivewNum + '건)</font></div>' +
										'</div>' +
								      	<!-- 카드 제목 :card-title -->
								      	'<h5 class="card-title">' + dots(item.title) + '</h5>' +
								     	 <!-- 카드의 내용 글 :card-text -->
								      	'<div style="display: flex; justify-content: space-between;">' +
									      	'<div style="margin-right: 20px;">';
									      	if(item.category == 'activity'){
						showlist +=		      	'<div class="card-text"><font size="3"><b>종류 </b></font>&nbsp;&nbsp;액티비티</div>' ;
									      	}
									      	if(item.category == 'ticket'){
						showlist +=		      	'<div class="card-text"><font size="3"><b>종류 </b></font>&nbsp;&nbsp;티켓</div>' ;
									      	}
									      	if(item.category == 'experience'){
						showlist +=		      	'<div class="card-text"><font size="3"><b>종류 </b></font>&nbsp;&nbsp;체험</div>' ;
									      	}
									      	if(item.category == '선택'){
						showlist +=		      	'<div class="card-text"><font size="3"><b>종류 </b></font>&nbsp;&nbsp;기타</div>' ;
									      	}
						showlist +=		      	'<div class="card-text"><font size="3"><b>소요시간 </b></font>&nbsp;&nbsp;' + item.timetake + '시간</div>' +
									      	'</div>' +
									      	'<div>' +
										      	'<div class="priceRange" id="priceRange' + index + '"></div></a>' +
										      	'<img align="right" src="./image/dark_heart.png" alt="off" class="liked" id="liked' + item.sellSeq + '" onclick="liked(this.alt,' + item.sellSeq + ')" width="30px" height="30px">' +
									    	'</div>' +
									     '</div>' +
								    '</div>' +
							 	'</div>';
								 
				$("#contents").append(showlist);
				priceRange(item.sellSeq,index);
			});
			
			/* 위시리스트 체크 */
			$.each(data.wlist, function(index, wish) {
	      		if(wish.id == '${login.id}'){
	      			$('#liked'+wish.sellseq).attr('src','./image/red_heart.png');
	      			$('#liked'+wish.sellseq).attr('alt','on');
	      		}			 
			});
			
			
			
			/* 페이징 추가 */
			let paging = '<nav aria-label="Page navigation">' +
	        				'<ul class="pagination" id="pagination"  style="justify-content:center;"></ul>' +
	        			 '</nav>'
			$('#pagingMain').append(paging);
			let _totalPages = Math.floor(totalCount / 5);
			if(totalCount % 5 > 0){
				_totalPages++;
			}
			if(_totalPages == 0){
				_totalPages = 1;
			}
			$("#pagination").twbsPagination({
				startPage: pageNumber,
				totalPages: _totalPages,
				visiblePages: 5,
				initiateStartPageClick:false,
				first:'<span sris-hidden="true">«</span>',
				prev:"이전",
				next:"다음",
				last:'<span sris-hidden="true">»</span>',
				onPageClick:function(event, page){
					$('#daterange').val('');
					ajax(page-1);
				}
			});	
		    
		},
		error:function(){
			
		}
	});
}
</script>

<script>
function getToday(){
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + '/' + month + '/' + day;
}
function getEndday(){
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (2 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + '/' + month + '/' + day;
}
$(function() {
  $('#daterange').daterangepicker({
  	startDate: getToday(),
	endDate: getEndday(),
	locale: { format: 'YYYY/MM/DD' }
  }, function(start, end, label) {
    //	alert(start.format('YYYY/MM/DD') + ' ~ ' + end.format('YYYY/MM/DD'));
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
	});
}
function dots(str){
	let newStr = '';
	if(str.length > 16){
		newStr = str.substring(0, 17);
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
</script>
</body>
</html>