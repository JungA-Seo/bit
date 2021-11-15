<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbsMlist</title>
<link rel="stylesheet" href="./css/bbs/bbsManager.css">
<!-- pagination -->
<script type="text/javascript" src="./resources/pagination/jquery.twbsPagination.min.js"></script>

<!-- datepicker 사용 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<script type="text/javascript">
// 검색
var search = "${search}";
var choice = "${choice}";

$(document).ready(function () {
	if(search != ""){
		$("#_choice").val( choice );
		$("#_search").val( search );
	}	
});
</script>

<div class="communityAll" align="center">
	<!-- 검색 -->
	<table>
		<col width="80"><col width="70"><col width="250">
		<tr>
			<th style="font-size: 15px; text-align: center;" >작성일</th>
			<td colspan="3">
				<input type="text" id="datepicker1" name="startdate" style="padding:auto; width: 150px; height: 35px">&nbsp;&nbsp; ~ &nbsp;&nbsp;
				 <input type="text" id="datepicker2" name="enddate" style="padding:auto; width: 150px; height: 35px">
			</td>
		</tr>
		<tr>
			<th style="font-size: 15px;  text-align: center;" >조건검색</th>
			<td style="width: 100px">
				<select class="form-select" aria-label="Default select example" name="choice" id="_choice" style="width: 150px;">
				  	<option selected>선택</option>
				  	<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="area">지역</option>
					<option value="writer">작성자</option>
				</select>
			</td>
			<td>
				<input type="text" id="_search" name="search" class="form-control" placeholder="검색" size="20">
			</td>
			<td>
				<button type="button" class="btn btn-primary" id="btnSearch">검색</button>
			</td>
		</tr>	
	</table>
	
	<!-- 새 글 작성 -->
	<div class="new">
		<div class="bbsAllCount">
			<p>[ 전체 게시글 수 : ${totalCount } 개 ]</p>
		</div>
		<div class="newnew">
			<button type="button" class="btn btn-primary rounded" id="_btnWrite" title="새 글 작성">새 글 작성</button>
		</div>
	</div>
	<c:if test="${empty bbsMlist}">
		<div align="center" >
			<br><br><br><br><br>
			<h1>작성된 게시글이 없습니다.</h1>
			<br><br><br><br><br>
		</div>
	</c:if>
	<c:if test="${not empty bbsMlist}">
		<!-- 전체 게시글 목록 -->
		<!-- 소제목 -->
		 
		<div class="communityOne">
			<div class="Header">
				<div class="SEQ">글 번호</div>
				<div class="ID">작성자</div>
				<div class="TITLE">제목</div>
				<div class="AREA">지역</div>
				<div class="READCOUNT">조회수</div>
				<div class="COMMENTCOUNT">댓글</div>
				<div class="LIKECOUNT">좋아요</div>
				<div class="WDATE">작성일</div>
				<div class="BUTTONS">관리</div>
			</div>
		</div>
		 
		 <!--
		<table>
			<colgroup>
				<col style="width: 7%">
				<col style="width: 10%">
				<col style="width: 28%">
				<col style="width: 7%">
				<col style="width: 8%">
				<col style="width: 8%">
				<col style="width: 8%">
				<col style="width: 14%">
				<col style="width: 10%">
			</colgroup>
			<tr align="center">
				<th>글 번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>지역</th>
				<th>조회수</th>
				<th>댓글</th>
				<th>좋아요</th>
				<th>작성일</th>
				<th>관리</th>
			</tr>
		</table>
		-->
		<c:forEach items="${bbsMlist}" var="dto" varStatus="i">
			<!-- 게시글 하나 -->
			 
			<div class="Body">
				<div class="bbsOne">
					<div class="Seq">
						<span>${dto.seq }</span>
					</div>
					<div class="Id">
						<span>${dto.id }</span>
					</div>
					<div class="Title">
						<a href="bbsdetail.do?seq=${dto.seq }">
							<span id="title">
								<c:set var = "title" value="${dto.title }" /> ${fn:substring(title, 0, 28)}
							</span>
						</a>
					</div>
					<div class="Area">
						<span>${dto.area }</span>
					</div>
					<div class="Readcount">
						<span>${dto.readCount }</span>
					</div>
					<div class="Commentcount">
						<span>${dto.commentCount }</span>
					</div>
					<div class="Likecount">
						<span>${dto.likeCount }</span>
					</div>
					<div class="Wdate">
						<span id="wdate">
							<c:set var = "wdate" value="${dto.wdate }" /> ${fn:substring(wdate, 0, 10) }
						</span>
					</div>
					<div class="Buttons">
						<div class="btn1">
							<button type="button" class="btn btn-outline-primary rounded" onclick="location.href='bbsMupdate.do?seq=${dto.seq}'">수정</button>
						</div>
						<div class="btn2">
							<button type="button" class="btn btn-outline-danger rounded" onclick="deleteBbs()">삭제</button>
						</div>
					</div>
				</div>
			</div>
			 
			 <!--
			<table>
				<colgroup>
					<col style="width: 7%">
					<col style="width: 10%">
					<col style="width: 28%">
					<col style="width: 7%">
					<col style="width: 8%">
					<col style="width: 8%">
					<col style="width: 8%">
					<col style="width: 14%">
					<col style="width: 10%">
				</colgroup>
				<tr align="center">
					<td style="text-align: center;">${dto.seq }</td>
					<td style="text-align: center;">${dto.id }</td>
					<td style="text-align: center;"><c:set var = "title" value="${dto.title }" /> ${fn:substring(title, 0, 28)}</td>
					<td style="text-align: center;">${dto.area }</td>
					<td style="text-align: center;">${dto.readCount }</td>
					<td style="text-align: center;">${dto.commentCount }</td>
					<td style="text-align: center;">${dto.likeCount }</td>
					<td style="text-align: center;"><c:set var = "wdate" value="${dto.wdate }" /> ${fn:substring(wdate, 0, 10) }</td>
					<td style="text-align: center;">
						버튼/버튼
					</td>
				</tr>
			</table>
			-->
		</c:forEach>
	</c:if>
	
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
//리스트가 없을 경우 (ex. 지역 상단 카드에서 충청도 클릭했는데 충청도 관련 글이 없을 경우)
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
		location.href = "bbsMlist.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val() + "&pageNumber=" + (page - 1);	
	}
});	


$("#btnSearch").click(function () {
	location.href = "bbsMlist.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val();	
});

//새 글 작성 button
$("#_btnWrite").click(function () {
//	alert("_btnWrite 버튼 클릭");
//	location.href = "bbswrite.do";
	
	if('${login.id}' == ""){
		alert("로그인이 필요한 서비스입니다.");
		location.href = "login.do";
	} else {
		location.href = "bbsMwrite.do";
	}
	
});

//게시글 삭제	// error .....
function deleteBbs() {
	let bseq = '${dto.seq}';
	$.ajax({
		url:"deleteBbs.do",
		type:"post",
		data:{ seq:bseq },
		success:function(msg){
			if(msg == 'success'){
				alert('성공적으로 삭제하였습니다');
				location.href = "bbsMlist.do";
			}else{
				alert('삭제 실패');
				location.href = "bbsMlist.do";
			}
		},
		error:function(){
			alert('error');
		}
	});
}
</script>

</body>
</html>