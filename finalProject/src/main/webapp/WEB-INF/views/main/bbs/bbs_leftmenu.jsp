<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="./css/bbs/bbs_leftmenu.css">

<div class="menu_table">
	<div class="shadow p-3 mb-5 bg-white rounded">
		<!-- 기본 메뉴 : 전체목록/월간BEST/자유게시판 -->
		<div class="primaryMenu">
			<ul class="nav flex-column">
				<li class="nav-item">
					<a class="nav-link active" aria-current="page" href="bbslist.do">전체목록</a>
				</li>
			</ul>
		</div>
		<hr>
		<!-- 카테고리별 메뉴 : 여행기/메모/잡담 -->
		<div class="categoryMenu">
			<div class="cText">
				<span>카테고리별</span>
			</div>
			<div class="cMenu">
				<ul class="nav flex-column">
					<li class="nav-item">
						<button type="button" class="btn btn-outline-secondary rounded-pill" onclick="categoryBtn(this.value)" value="여행기">여행기</button>
					</li>
					<li class="nav-item">
						<button type="button" class="btn btn-outline-secondary rounded-pill" onclick="categoryBtn(this.value)" value="메모">메모</button>
					</li>
					<li class="nav-item">
						<button type="button" class="btn btn-outline-secondary rounded-pill" onclick="categoryBtn(this.value)" value="잡담">잡담</button>
					</li>
				</ul>
			</div>
		</div>
		<hr>
		<!-- 순위별 메뉴 : 조회순/댓글순/좋아요순 -->
		<div class="ordersMenu">
			<div class="oText">
				<span>순위별</span>
			</div>
			<div  class="oMenu">
				<ul class="nav flex-column">
					<li class="nav-item">
						<button type="button" class="btn btn-outline-secondary rounded-pill" onclick="countBtn(this.value)" value="readCount">조회순</button>
					</li>
					<li class="nav-item">
						<button type="button" class="btn btn-outline-secondary rounded-pill" onclick="countBtn(this.value)" value="commentCount">댓글순</button>
					</li>
					<li class="nav-item">
						<button type="button" class="btn btn-outline-secondary rounded-pill" onclick="countBtn(this.value)" value="likeCount">좋아요순</button>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
// alert(${totalCount});

// 카테고리별 버튼
function categoryBtn(val) {
//	alert(val);
	location.href = "bbslist.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val() + "&category=" + val;
}

// 순위별 버튼
function countBtn(val) {
//	alert(val);
	location.href = "bbslist.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val() + "&order=" + val;
}
</script>