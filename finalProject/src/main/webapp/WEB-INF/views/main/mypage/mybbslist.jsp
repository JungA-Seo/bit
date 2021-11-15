<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mybbslist</title>

<link rel="stylesheet" href="./css/mybbslist.css">
<script type="text/javascript" src="./resources/pagination/jquery.twbsPagination.min.js"></script>
</head>

<body>

<!-- 내가 쓴 글 전체 -->
<div align="center" class="mybbsmain">
	<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
		  <ol class="breadcrumb">
		    <li class="breadcrumb-item active" aria-current="page">마이페이지</li>
		    <li class="breadcrumb-item active" aria-current="page">내가 쓴 글</li>
		  </ol>
	</nav>
	<div class="mybbstop">
		<div><h3>내가 쓴 글</h3></div>
	</div>
	<hr>
	<!-- 내가 쓴 글 목록 -->
	<div class="mybbslist" align="center">
 		<c:if test="${empty mybbslist}">
			<div align="center">
				<br><br><br><br><br>
				<h2>작성된 글이 없습니다😥<br>지금 생생한 여행을 기록하시겠어요?</h2>
				<br>
				<button type="button" id="_goBbsList" class="btn btn-outline-dark btn-lg rounded-pill">커뮤니티로 이동하기</button>
				<br><br><br><br><br>
			</div>
		</c:if>
		<c:if test="${not empty mybbslist}">
			<c:forEach items="${mybbslist}" var="dto" varStatus="i">
				<c:set var="fileStr" value="${dto.newFilename }" />
				<c:set var="length"  value="${fn:length(fileStr)}"/>
				<c:set var="filename"  value="${fn:substring(fileStr, length-3, length)}"/>			
				<div class="card mybbsone" id="bbsone">
					<c:if test="${filename != 'tmp' && not empty dto.newFilename }">
						<img src="http://localhost:8090/flenda/upload/${dto.newFilename }" class="card-img-top">
					</c:if>
					<c:if test="${filename == 'tmp' || empty dto.newFilename}">
						<img src="./image/no_mainpic2.png" class="card-img-top">
					</c:if>
					<div class="card-body">
					<h5 class="card-title title">
			    		<c:set var = "title" value="${dto.title }" /> 
			    		${fn:substring(title, 0, 14)}
			    	</h5>
				    <p class="card-text area">
				    	[${dto.area }] ${fn:substring(dto.address, 0, 12)}
				    </p>
				    <p>
				    	👁 ${dto.readCount } / ❤ ${dto.likeCount } / 💬 ${dto.commentCount}
				    	<br>
				    	<c:set var = "wdate" value="${dto.wdate }" /> ${fn:substring(wdate, 0, 16) }
				    </p>
				    <a href="bbsdetail.do?seq=${dto.seq }" class="btn btn-outline-primary">상세</a>
				    <a href="bbsupdate.do?seq=${dto.seq }" class="btn btn-outline-secondary">수정</a>
				    <button class="btn btn-outline-danger" onclick="deleteBbs(${dto.seq })">삭제</button>
				  </div>
				</div>
			</c:forEach>
		</c:if>
		<!-- 페이징 -->
		<div class="paging">
			<nav aria-label="Page navigation">
		        <ul class="pagination" id="_pagination" style="justify-content:center;"></ul>
		    </nav>
		</div>
	</div>
</div>

<script type="text/javascript">
/* 게시판으로 이동 button */
$("#_goBbsList").click(function() {
	location.href = "bbslist.do";
});

//게시글 삭제
function deleteBbs(bbsseq) {
	$.ajax({
		url:"deleteBbs.do",
		type:"post",
		data:{ seq:bbsseq },
		success:function(msg){
			if(msg == 'success'){
				alert('성공적으로 삭제하였습니다');
				location.href = "mybbslist.do";
			}else{
				alert('삭제 실패');
				location.href = "mybbslist.do";
			}
		},
		error:function(){
			alert('error');
		}
	});
}


/* 페이징 */
let pageSize = 6;

let totalCount = ${totalCount};	// 글의 총 수
if(totalCount == '' || totalCount == null){
	totalCount = 0;
}
let pageNum = ${pageNumber};	// 현재 페이지
if(pageNum == '' || pageNum == null){
	pageNum = 0;
}

let _totalPages = totalCount / pageSize;
if(totalCount % pageSize > 0){
	_totalPages++;
}

if(_totalPages == 0){
	_totalPages = 1;
}

//$("#pagination").twbsPagination('destroy');	// 페이지 갱신 : 페이징을 갱신해 줘야 번호가 재설정된다.
$("#_pagination").twbsPagination({
	startPage: pageNum,
	totalPages: _totalPages,
	visiblePages: 5,
	first:'<span sria-hidden="true">«</span>',
	prev:"이전",
	next:"다음",
	last:'<span sria-hidden="true">»</span>',
	initiateStartPageClick:false,		// onPageClick 자동 실행되지 않도록 한다
	onPageClick:function(event, page){
		location.href = "mybbslist.do?pageNumber=" + (page - 1);
	}
});	
</script>
</body>
</html>