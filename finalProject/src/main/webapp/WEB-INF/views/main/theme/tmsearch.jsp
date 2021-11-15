<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String param = request.getParameter("param");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Theme searching page</title>

<!-- countdown -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 화면 상단 회색 background -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="./css/theme1.css">

<!-- pagination -->
<script type="text/javascript" src="./resources/pagination/jquery.twbsPagination.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


</head>
<body class="tmsearchPage">

<!-- 화면 background -->
<form id="searchFrm">
<div class="kv mb-5">
  <div class="container h-100">
    <div class="row justify-content-center align-items-center h-100">
      <div class="col-12">
		<div align="center">
			<table id="searchTable">
			<tr>
				<td align="right">
					<img src="./image/1downarrow.png" alt="down" id="menuicon" onclick="arrow(this.alt)" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
				</td>
				<td align="left" width="600px">
				<c:if test="${empty param}">
					<input type="text" id="search" name="search" placeholder="도시 및 상품을 검색하세요">
				</c:if>
				<c:if test="${not empty param}">
					<input type="text" id="search" name="search" placeholder="도시 및 상품을 검색하세요" value="<%=param%>">
				</c:if>
					<img alt="" src="./image/loupe.png" id="searchicon">
				</td> 
			</tr>
			</table>
  		</div>
	  </div>
    </div>
  </div>
</div>			

	<!-- 메뉴아이콘 누르면 열리는부분 -->
<div class="collapse" id="collapseExample" name="collapseExample">
  	<div class="card card-body" style="width: 1100px; margin: auto;">				
  		<table class="collapseTable">
   			<col width="130px"><col width="320px"><col width="150px"><col width="180px">		
   			<tr>
   			<th class="coll">지역</th>
   				<td class="coll">
   					<select class="form-select" aria-label="Default select example" name="city" id="city">
						  <option value="" selected >도시선택</option>
						  <option value="서울">서울</option>
						  <option value="부산">부산</option>
						  <option value="제주도">제주도</option>
						  <option value="가평">가평</option>
						  <option value="강릉">강릉</option>
						  <option value="속초">속초</option>
						  <option value="여수">여수</option>
						  <option value="포항">포항</option>
					</select>	
   				</td>
   			<th class="coll" style="text-align: right;">테마상품</th>
	   			<td class="coll">
	   				<select class="form-select" aria-label="Default select example" name="category" id="category">
						<option value="" selected>카테고리</option>
						<option value="시내투어">시내투어</option>
						<option value="버스투어">버스투어</option>
						<option value="자연투어">자연투어</option>
						<option value="이색투어">이색투어</option>
						<option value="나홀로투어">나홀로투어</option>
					</select>	
	   			</td>
   			</tr>
   					
   			<tr>
   			<th class="coll">교통편</th>
   				<td class="coll">
   					<input type="radio" id="_transpor" name="transpor" value="all" checked="checked">전체
	   				<input type="radio" id="_transpor" name="transpor" value="자동차"> 자동차
					<input type="radio" id="_transpor" name="transpor" value="도보"> 도보
					<input type="radio" id="_transpor" name="transpor" value="버스"> 버스
					<input type="radio" id="_transpor" name="transpor" value="택시"> 택시
   				</td>
   			<th class="coll" style="text-align: right;">최소인원</th>
   				<td class="coll">
	   				<select class="form-select" aria-label="Default select example" name="minPeople" id="minPeople">
						<option value="0" selected>인원선택</option>
						<option value="1">1~2명</option>
						<option value="3">3~6명</option>
						<option value="7">7~14명</option>
						<option value="15">15~30명</option>
						<option value="31">31명 이상</option>
					</select>
   				</td>
   				<td>
   					<button type="button" id="detailSearch" onclick="detailSearchBtn()">상세검색</button>
   				</td>
   			</tr>

   			<tr>
   				<th class="coll">정렬순서</th>
 				<td colspan="3" class="coll">
 					<input type="radio" class="btn-check" id="solt1" value="recent" name="soltinglist" autocomplete="off" checked="checked">
 					<label class="btn btn-outline-primary" for="solt1">최신순</label>
 					<input type="radio" class="btn-check" id="solt2" value="reviewCount" name="soltinglist" autocomplete="off">
 					<label class="btn btn-outline-primary" for="solt2">리뷰많은순</label>
 					<input type="radio" class="btn-check" id="solt3" value="reviewAvg" name="soltinglist" autocomplete="off">
 					<label class="btn btn-outline-primary" for="solt3">리뷰평점순</label>
 					<input type="radio" class="btn-check" id="solt4" value="highprice" name="soltinglist" autocomplete="off">
 					<label class="btn btn-outline-primary" for="solt4">높은가격순</label>
 					<input type="radio" class="btn-check" id="solt5" value="lowprice" name="soltinglist" autocomplete="off">
 					<label class="btn btn-outline-primary" for="solt5">낮은가격순</label>
 					<input type="radio" class="btn-check" id="solt6" value="recommended" name="soltinglist" autocomplete="off">
 					<label class="btn btn-outline-primary" for="solt6">추천순</label>
 				</td>
   			</tr>
  		</table>
	</div>
</div>  <!-- collapseExample의 끝 -->  
</form> <!-- searchFrm끝 -->
<br>

<!-- ajax 테이블 -->
<div style="display: flex; justify-content: center;">
	<table id="themeList">	
	</table>
	
	<div id="benumain">	
	<table class="benu" >
		<tr>
			<td  style="padding: 10px;">
		<!-- 자동 슬라이드 웹배너 -->
				<div class="slideshow-container">
					<div class="mySlides fade">
						<div class="numbertext">1 / 3</div>
							<img src="./image/benu6.png" style="width:100%; height: 700px">
					</div>
							
					<div class="mySlides fade">
						<div class="numbertext">2 / 3</div>
							 <img src="./image/benu7.png" style="width:100%; height: 700px">
					</div>
							
					<div class="mySlides fade">
						<div class="numbertext">3 / 3</div>
						  <img src="./image/benu8.png" style="width:100%; height: 700px">
					</div> 
				</div>
			</td>
		</tr>
	</table>
	</div>
</div>
<script type="text/javascript">


//자동 슬라이드 웹배너
var slideIndex = 0;
showSlides();

function showSlides() {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  /* var dots = document.getElementsByClassName("dot"); */
  for (i = 0; i < slides.length; i++) {
     slides[i].style.display = "none";  
  }
  slideIndex++;
  if (slideIndex > slides.length) {slideIndex = 1}    
  /* for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  } */
 	slides[slideIndex-1].style.display = "block";  
 /*  dots[slideIndex-1].className += " active"; */ 
  setTimeout(showSlides, 3000); // 3초에 한번씩 바뀜 
}

</script>


<script type="text/javascript">

$(document).ready(function() {    //맨 처음 리스트 부름
	
	ajax(0);
});	

$("#searchicon").click(function() {
	//alert('click');
	ajax(0);
});
	
function detailSearchBtn(){
	//alert('btn click');
	ajax(0);
}
		
	let totalCount = 0;   //글의 총수
	let pageSize = 10;      //페이지의 크기 1 ~ 10   [1]~[10]
	let pageNumber = 1;      //현재페이지
	
function ajax(pageNum){
	//alert("pageNum:"+ pageNum);
		
	$('#pagingMain').empty();
	$('#themeList').empty();		// 검색하고나서 새로운 리스트 보여줄때 리스트 초기화
	
	let data = $("#searchFrm")[0];
	let dataForm = new FormData(data);
	dataForm.append('pageNumber', pageNum);
	//alert(data);
	
	$.ajax({
		url : "tmuserlist.do",
		type: "post",
		data: dataForm,
		enctype: 'multipart/form-data',
		processData:false,
		contentType:false,
		cache:false,
		success:function( data ){
			//alert('success');
			
			/*페이징 값변경*/
			 totalCount = data.totalCount;
        	 pageNumber = data.search.pageNumber + 1;
        		//alert('totalCount:' + totalCount);
        		//alert('pageNumber:' + pageNumber);
			
		 	/*검색 고정*/
			$("#search").val(data.search.search);
			$("#city").val(data.search.city);
			$("#category").val(data.search.category)
			$("#transpor").val(data.search.transpor);
			$("#minPeople").val(data.search.minPeople);
			$("#soltlist").val(data.search.soltinglist);	 

			/* 게시판 셋팅 */
			let setting = '<tr>' +
							'<td style="padding: 5px">' ;

						  
			$('#themeList').append(setting);	
						  
			$.each(data.list, function(index, item) {
            let showlist =   '<div class="card mb-3" style="width: 900px; max-height: 220px;" >' +
								 '<div class="row g-0">' +
            						'<div class="col-md-4">' ;
            					  $.each(data.pics, function(index, pic) {
            		                     if(item.sellSeq == pic.sellSeq){
            		                        <!-- 카드 상단에 배치되는 이미지 : card-img-top -->
            		                        showlist +=   '<img class="img-fluid rounded-start" style="width: 250px; height:210px; margin-top:3px; margin-left:20px;" src="http://localhost:8090/flenda/upload/' + pic.newFileName + '" onclick="imageClick('+item.sellSeq +')">';     
      
            		                        return false;
            		                     }
            					 	 })
            		             
            			showlist += '</div>' +
            		   					 '<div class="col-md-8">' +
	          		    				  '<div class="card-body" align="left">' +
	            		 					'<span class="card-text"><h4 class="card-title" id="gotitle" onclick="titleclick('+ item.sellSeq +')"><b>' + dots(item.title) + '</b></h4><br></a><br>' +		/* 카드제목 */
	            		 					'<span class="card-text"><strong id="themeAvg" style="font-size: 20px;">테마평점:&nbsp;</strong><img src="./image/star.png" id="star">&nbsp;'+ item.reviewAvg +'점</span><br>' +
	            		 					'<span class="card-text" id="host">' + item.businessName +'</span><br>'+					/* 테마등록 사업자명*/
	            		 					'<span class="card-text"><small class="text-muted"><b>' + item.city +'</b></small></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +	/* 도시 */
	            		 					'<span class="card-text"><small class="text-muted"><b>' + item.category +'</b></small></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'  +	/* 카테고리 */
	            		 					'<span class="card-text"><small class="text-muted"><b>최소인원:</b>' + item.minPeople +'명</small></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'  +  /* 최소인원 */
	            		 					'<span class="card-text"><small class="text-muted"><b>교통편:</b>' + item.transpor +'</small></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'  +  /* 교통편 */
	            		 					'<span class="card-text"><small class="text-muted"><b>' + item.timetake +'시간소요</b></small></span><br>' +  /* 소요시간 */
	            		 					'<img align="right" src="./image/dark_heart.png" alt="off" class="liked" id="liked' + item.sellSeq + '" onclick="liked(this.alt,' + item.sellSeq + ')" width="30px" height="30px">' ;
            		 					
            		 					  $.each(data.opt, function(index, opt) {
                 		                     if(item.sellSeq == opt.sellSeq){
                 		                    	showlist += ' <span class="card-text"><small class="text-muted"><b>구매가능기간:</b>&nbsp;&nbsp;' + opt.startDate + ' ~ ' + opt.endDate + '</small></span><br>' ; 	/* 사용기한 */  		                    			
                 		                    				return false;
                 		                    }
                		                  });
            		 					  if(data.search.soltinglist == 'lowprice'){
            		 		showlist +=		 '<p class="card-text" align="right"><small class="text-muted">KRW <font size="5pt" color="#606ADC">' + item.lowprice + '원</font></small></p>' ;	/* 가격 */
            		 					  }else{
            		 		showlist +=		 '<p class="card-text" align="right"><small class="text-muted">KRW <font size="5pt" color="#606ADC">' + item.highprice + '원</font></small></p>' ;	/* 가격 */
            		 					  }
            		 		showlist +=	 '</div>' +
		            				   '</div>' +
		            				  '</div>' +
		            				'</div>' +
		            			'</td>' +
		            		'</tr>' ;
		            		
		            $('#themeList').append(showlist);	
		            		
			}); 
			
			/* 위시리스트 체크 */
			$.each(data.wlist, function(index, wish) {
	      		if(wish.id == '${login.id}'){
	      			$('#liked'+wish.sellseq).attr('src','./image/red_heart.png');
	      			$('#liked'+wish.sellseq).attr('alt','on');
	      		}			 
			});
			
			<!-- 페이징 -->
        	let newpaging =	'<tr>' +
	        					'<td>' + 
		            				'<div id="pagingMain" class="container">' +
		            					 '<nav aria-label="Page navigation">'+
		            						 '<ul class="pagination" id="pagination" style="justify-content:center ;" ></ul>'+
		            					 '</nav>'+
		            				'</div>' +
	        					'</td>' +
	        				'</tr>';


		 		 $('#themeList').append(newpaging);	
           
		 	
			
			if(data == null && data[0].sellSeq == ""){
				let add = '<tr><td colspan="2" style="text-align: center;">등록된 상품이 없습니다</td></tr>'
				$('#themeList').append(add);	
			}
			
			
			 /* 페이징 추가 */
	         let paging = '<nav aria-label="Page navigation">' +
	                       	'<ul class="pagination" id="pagination" style="justify-content:center;"></ul>' +
	                       '</nav>'
	         $('#pagingMain').append(paging);
	         let totalPages = Math.floor(totalCount / 5);
	       	 //alert("totalpages:" + totalPages);
	         
	         if(totalCount % 5 > 0){
	            totalPages++;
	         }
	         $("#pagination").twbsPagination({
	            startPage: pageNumber,     //시작시 표시되는 현재페이지 
	            totalPages: totalPages,		// 총 페이지 번호 수
	            visiblePages: 5,			// 하단에 보여지는 페이지 번호 수
	            initiateStartPageClick:false,  //onpageClick 자동 실행되지 않도록 한다.
	            first:'<span sris-hidden="true">«</span>',
	            prev:"이전",
	            next:"다음",
	            last:'<span sris-hidden="true">»</span>',
	            onPageClick:function(event, page){
	            	//alert("onpageClick:" + page);
	           		pageNumber = page;
	           		ajax(page-1);
	           		
	            }
	         });   

		}, //success 끝 
		error:function(){
			alert('ajax error');
		}
	
	
	
	}); //ajax끝 
}//function ajax 끝 	

function imageClick( sellSeq ){
	//alert('image click:' + sellSeq);
	location.href = "tmuserdetail.do?sellSeq=" + sellSeq;
}
//2차 수정 추가할곳
function titleclick ( sellSeq ){
	//alert('title click:' + sellSeq);
	location.href = "tmuserdetail.do?sellSeq=" + sellSeq;
}
function dots(str){
	let newStr = '';
	if(str.length > 17){
		newStr = str.substring(0, 18);
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

function arrow(alt) {				//화살표 누르면 펼쳐지기	
	if(alt=='down'){					// 펼칠때
		$('#menuicon').attr('src','./image/1uparrow.png');
		$('#menuicon').attr('alt','up');		
	}
	else{							// 줄일때	
		$('#menuicon').attr('src','./image/1downarrow.png');
		$('#menuicon').attr('alt','down');
	}
} 
</script>
</body>
</html>