<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbslist</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

<link rel="stylesheet" href="./css/bbs/bbslist.css">
<script type="text/javascript" src="./resources/pagination/jquery.twbsPagination.min.js"></script>
</head>

<body>
<script type="text/javascript">
// 검색
<%-- var search = "<%=search %>"; --%>
var search = "${search}";
var choice = "${choice}";

$(document).ready(function () {
	if(search != ""){
		$("#_choice").val( choice );
		
		document.getElementById("_search").value = search;
	}	
});
</script>

<div class="bbsmain">
	
	<!-- 검색 및 새 글 작성 버튼-->
	<div class="new">
		<!-- 검색 -->
		<div class="searchNow">
			<div class="searchSelect">
				<select class="select" id="_choice" name="choice">
					<option value="" selected="selected">선택</option>
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="area">지역</option>
					<option value="writer">작성자</option>
				</select>
			</div>
			<div class="searchInput">
				<input type="text" id="_search" name="search" placeholder="Search here" style="border:none">
				<button type="button" class="btn btn-link" id="btnSearch">
					<img src="./image/searching.png">
				</button>
			</div>
		</div>
		<!-- 새 글 작성 -->
		<div class="newnew">
			<button type="button" class="btn btn-primary rounded-pill" id="_btnWrite" title="새 글 작성">새 글 작성</button>
		</div>
	</div>
	
	<!-- 상단 지역카드 -->
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<!-- 이미지 버튼 -->
				<button type="button" onclick="areaBtn(this.value)" value="서울">
					<img src="./image/city/seoul.JPG" class="image" name="area">
				</button>
				<div class="imgTxt">
					<h3>서울</h3>
				</div>
			</div>
			<div class="swiper-slide">
				<button type="button" onclick="areaBtn(this.value)" value="인천">
					<img src="./image/city/Incheon_1.JPG" class="image" name="area">
				</button>
				<div class="imgTxt">
					<h3>인천</h3>
				</div>
			</div>
			<div class="swiper-slide">
				<button type="button" onclick="areaBtn(this.value)" value="경기도">
					<img src="./image/city/gyeonggi-do.JPG" class="image" name="area">
				</button>
				<div class="imgTxt">
					<h3>경기도</h3>
				</div>
			</div>
			<div class="swiper-slide">
				<button type="button" onclick="areaBtn(this.value)" value="강원도">
					<img src="./image/city/Gangwon-do_1.JPG" class="image" name="area">
				</button>
				<div class="imgTxt">
					<h3>강원도</h3>
				</div>
			</div>
			<div class="swiper-slide">
				<button type="button" onclick="areaBtn(this.value)" value="충청도">
					<img src="./image/city/Chungcheongdo.JPG" class="image" name="area">
				</button>
				<div class="imgTxt">
					<h3>충청도</h3>
				</div>
			</div>
			<div class="swiper-slide">
				<button type="button" onclick="areaBtn(this.value)" value="대전">
					<img src="./image/city/daejeon.JPG" class="image" name="area">
				</button>
				<div class="imgTxt">
					<h3>대전</h3>
				</div>
			</div>
			<div class="swiper-slide">
				<button type="button" onclick="areaBtn(this.value)" value="전라도">
					<img src="./image/city/Jeolla-do_1.JPG" class="image" name="area">
				</button>
				<div class="imgTxt">
					<h3>전라도</h3>
				</div>
			</div>
			<div class="swiper-slide">
				<button type="button" onclick="areaBtn(this.value)" value="광주">
					<img src="./image/city/Gwang-ju-1.JPG" class="image" name="area">
				</button>
				<div class="imgTxt">
					<h3>광주</h3>
				</div>
			</div>
			<div class="swiper-slide">
				<button type="button" onclick="areaBtn(this.value)" value="경상도">
					<img src="./image/city/gyeongsang-do.JPG" class="image" name="area">
				</button>
				<div class="imgTxt">
					<h3>경상도</h3>
				</div>
			</div>
			<div class="swiper-slide">
				<button type="button" onclick="areaBtn(this.value)" value="대구">
					<img src="./image/city/daegu.JPG" class="image" name="area">
				</button>
				<div class="imgTxt">
					<h3>대구</h3>
				</div>
			</div>
			<div class="swiper-slide">
				<button type="button" onclick="areaBtn(this.value)" value="울산">
					<img src="./image/city/ulsan.JPG" class="image" name="area">
				</button>
				<div class="imgTxt">
					<h3>울산</h3>
				</div>
			</div>
			<div class="swiper-slide">
				<button type="button" onclick="areaBtn(this.value)" value="부산">
					<img src="./image/city/busan.JPG" class="image" name="area">
				</button>
				<div class="imgTxt">
					<h3>부산</h3>
				</div>
			</div>
			<div class="swiper-slide">
				<button type="button" onclick="areaBtn(this.value)" value="제주도">
					<img src="./image/city/jeju-do.JPG" class="image" name="area">
				</button>
				<div class="imgTxt">
					<h3>제주도</h3>
				</div>
			</div>
		</div>
		
		<!-- 네비게이션 -->
		<div class="swiper-button-next swiper-button-white" ></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
		<div class="swiper-button-prev swiper-button-white"></div><!-- 이전 버튼 -->
		<!-- 네비게이션 : 슬라이드 버튼 밖으로 빼려면 container 밖에 있어야함 그리고 contain와 함께 새로운 div로 묶어줘야..-->
	</div>
	

	<!-- 게시판 메인 목록 -->	
	<div class="bbsmainlist">		
		<c:if test="${empty bbslist}"> <!-- ------------- -->
			<div align="center" >
				<br><br><br><br><br>
				<h1>작성된 글이 없습니다😢</h1> <!-- ------------- -->
				<br><br><br><br><br>
			</div>
		</c:if> <!-- ------------- -->
		<c:if test="${not empty bbslist}"> <!-- ------------- -->
			<c:forEach items="${bbslist}" var="dto" varStatus="i"> <!-- ------------- -->
				<c:set var="fileStr" value="${dto.newFilename }" />
				<c:set var="length"  value="${fn:length(fileStr)}"/>
				<c:set var="filename"  value="${fn:substring(fileStr, length-3, length)}"/>
				<!-- 게시글 한 개 목록 -->
				<div class="bbsone">
					<!-- 이미지 영역 -->
					<div class="community-img">
						<a href="bbsdetail.do?seq=${dto.seq }">
							<!-- newfilename 가져오기 -->
							<c:if test="${filename != 'tmp' && not empty dto.newFilename }">
								<img src="http://localhost:8090/flenda/upload/${dto.newFilename }">
							</c:if>
							<c:if test="${filename == 'tmp' || empty dto.newFilename}">
								<img src="./image/no_mainpic3.jpg">
							</c:if>
						</a>
					</div>
					<!-- 주제(카테고리), 제목, 컨텐츠, 작성일 -->
					<div class="community-info-box">
						<div class="community-title">
							<!-- 카테고리명: 여행기,메모,잡담 / 제목명: 사용자지정값 -->
							<div class="titles">
								<!-- detail이동 (이미지, 카테고리, 제목, 내용 클릭시) -->
								<a href="bbsdetail.do?seq=${dto.seq }">
									<span id="category" class="category">
										${dto.category }	<!-- 카테고리별 글자 색상 다르게 줄건지? -->
									</span>
									<span id="title">
										<c:set var = "title" value="${dto.title }" /> ${fn:substring(title, 0, 30)}
									</span>
								</a>
							</div>
						</div>
						<div class="community-wdate">
							<span id="regidate">
								<c:set var = "wdate" value="${dto.wdate }" /> ${fn:substring(wdate, 0, 16) }
							</span>
						</div>
						<div class="community-content">
							<a href="bbsdetail.do?seq=${dto.seq }">
								<span id="content">
									<!-- <c:out value='${dto.content.replaceAll("\\\<.*?\\\>"," ")}' escapeXml="false" /> -->
									<c:out value='${fn:substring(dto.content.replaceAll("\\\<.*?\\\>",""),0, 180)}' escapeXml="false" />...
								</span>
							</a>
						</div>
						<!-- 좋아요 수, 댓글 수 -->
						<div class="community-countbox">
							<span class="postText" id="ids">${dto.id }</span>
							<span class="postText">님이</span>
							<span class="postText" id="adds">${dto.address }</span>
							<span class="postText">에 남긴 포스트입니다.</span>
							<div class="comment-count">
								<div class="ccount">
									<span id="ccount">${dto.commentCount }</span>
								</div>
								<div class="ccountImg">
									<img src="./image/reply.png" class="image">
								</div>
							</div>
							<div class="like-count">
								<div class="lcount">
									<span id="lcount">${dto.likeCount }</span>
								</div>
								<div class="lcountImg">
									<img src="./image/unlike.png" class="image">
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
	</div>
	
	<!-- pagination -->
	<!-- 페이징 번호 넣을 영역 -->
	<div class="paging">
		<nav aria-label="Page navigation">
	        <ul class="pagination" id="pagination" style="justify-content:center;"></ul>
	    </nav>
	</div> 
	
</div>



<script type="text/javascript">
let totalCount = ${totalCount};	// 서버로부터 총 글의 수를 취득
//alert(totalCount);
let nowPage = ${pageNumber};	// 서버로부터 현재 페이지를 취득
//alert(nowPage);

let pageSize = 10;

let _totalPages = totalCount / pageSize;
if(totalCount % pageSize > 0){
	_totalPages++;
}
// 리스트가 없을 경우 (ex. 지역 상단 카드에서 충청도 클릭했는데 충청도 관련 글이 없을 경우)
if(_totalPages == 0){
	_totalPages = 1;
}
//alert(_totalPages);

//$("#pagination").twbsPagination('destroy');	// 페이지 갱신 : 페이징을 갱신해 줘야 번호가 재설정된다.
$("#pagination").twbsPagination({
	startPage: nowPage,
	totalPages: _totalPages,
	visiblePages: 10,
	first:'<span sria-hidden="true">«</span>',
	prev:"이전",
	next:"다음",
	last:'<span sria-hidden="true">»</span>',
	initiateStartPageClick:false,		// onPageClick 자동 실행되지 않도록 한다
	onPageClick:function(event, page){
		location.href = "bbslist.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val() + "&pageNumber=" + (page - 1) + "&area=${area}" + "&category=${category}" + "&order=${order}";	
	}
});	


$("#btnSearch").click(function () {
	location.href = "bbslist.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val();	
});

//새 글 작성 button
$("#_btnWrite").click(function () {
//	alert("_btnWrite 버튼 클릭");
//	location.href = "bbswrite.do";
	
	if('${login.id}' == ""){
		alert("로그인이 필요한 서비스입니다.");
		location.href = "login.do";
	} else {
		location.href = "bbswrite.do";
	}
	
});

//slide 지역카드
new Swiper('.swiper-container', {

	slidesPerView : 5, // 동시에 보여줄 슬라이드 갯수
	spaceBetween : 10, // 슬라이드간 간격
	slidesPerGroup : 5, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음
	allowTouchMove : false, // 버튼 아닌 곳 클릭했을 때 이동을 방지
	
	// 그룹수가 맞지 않을 경우 빈칸으로 메우기
	// 3개가 나와야 되는데 1개만 있다면 2개는 빈칸으로 채워서 3개를 만듬
	// loopFillGroupWithBlank : true,

	loop : true, // 무한 반복

	pagination : { // 페이징
		el : '.swiper-pagination',
		clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
	},
	navigation : { // 네비게이션
		nextEl : '.swiper-button-next', // 다음 버튼 클래스명
		prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
	},
});

//지역카드 클릭
function areaBtn(val) {
	// alert(val);
	location.href = "bbslist.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val() + "&area=" + val;
}

</script>
</body>
</html>