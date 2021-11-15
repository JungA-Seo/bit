<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:requestEncoding value="utf-8"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbsdetail</title>

<link rel="stylesheet" href="./css/bbs/bbsdetail.css">

</head>
<body>


<div class="bbsdetail">
	<div class="textText" align="left">
		<!-- prev / update / delete 버튼 : 상단에 놓을지 하단에 놓을지 생각 -->
		<div class="btn-list" align="right">
			<button type="button" class="btn btn-outline-secondary rounded-pill" onclick="history.go(-1)">이전</button>
			<c:if test="${login.id eq bbs.id || login.auth == 1}"> <!-- 로그인 id와 게시글 작성자 id가 같을 때 + 관리자일 때 수정 및 삭제 -->
				<button type="button" class="btn btn-outline-primary rounded-pill" onclick="location.href='bbsupdate.do?seq=${bbs.seq}'">수정</button>
				<button type="button" class="btn btn-outline-danger rounded-pill" onclick="deleteBbs()">삭제</button>
			</c:if>
		</div>
	</div>
	
	<div class="detailHeader">
		<div class="title_bar">
			<!-- 게시글 작성자(=저자) 프로필 이미지 -->
			<div class="author_img">
				<!-- 프로필 이미지 예시로 넣은 것 -->
				<c:set var="fileStr" value="${bbs.profileImg }" />
				<c:set var="length"  value="${fn:length(fileStr)}"/>
				<c:set var="filename"  value="${fn:substring(fileStr, length-3, length)}"/>
				<c:if test="${filename != 'tmp' && not empty bbs.profileImg }">
					<img src="http://localhost:8090/flenda/upload/${bbs.profileImg }" class="img">
				</c:if>
				<c:if test="${filename == 'tmp' || empty bbs.profileImg }">
					<img src='./image/noProfile.png' class='img'>
				</c:if>
			</div>
			<!-- 게시글 작성자 ID(닉네임 있으면 닉네임), 작성일 -->
			<div class="author_info">	<!-- controller의 "bbs" 임 -->
				<div class="user-id">
					<span id="id">${bbs.id}</span>
				</div>
				<div class="time">
					<span id="wdate">
						<c:set var = "wdate" value="${bbs.wdate }" /> ${fn:substring(wdate, 0, 16) }
					</span>
				</div>
			</div>
			<!-- 위치(사용자가 입력한 값) 및 조회 수-->
			<div class="etc_info">
				<div class="read-count">
					<div class="rcount">
						<span id="rcount">${bbs.readCount}</span>
					</div>
					<div class="rImg">
						<img src="./image/view.png">
					</div>
				</div>
				<div class="address">
					<div class="ar">
						<span id="address">${bbs.address}</span>
					</div>
					<div class="aImg">
						<img src="./image/pin.png">
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<hr>
	
	<div class="detailBody">
		<!-- 카테고리명 & 제목 -->
		<div class="community-title">
			<div class="name">
				<span id="category">
					${bbs.category}
				</span>
				<span id="title">
					${bbs.title}
				</span>
			</div>
		</div>
		
		<!-- 본문 (예산 포함 or 예산은 밑에 따로) -->
		<div class="community-content">
			${bbs.content}
		</div>
		
		<hr>
		
		<!-- 좋아요 수 & 댓글 수 -->
		<div class="counting">
			<div class="like-count">
				<div class="like-img">
					<!-- 좋아요버튼이미지넣기 -->
					<img src="./image/unlike.png" alt="off" onclick="clickLike(this.alt)" class="image" id="_likeimg">   
				</div>
				<div class="likeC">
					<span id="likeCount"></span>
				</div>
			</div>
			<div class="comment-count">
				<div class="comment-img">
					<img src="./image/reply.png" class="image">
				</div>
				<div class="commentC">
					<!-- 댓글 수 (ajax) -->
					<span id="replyCount"></span>
				</div>
			</div>
		</div>
		
	</div>
	
	<hr>
	<c:set var="fileStr" value="${login.newFilename }" />
	<c:set var="length"  value="${fn:length(fileStr)}"/>
	<c:set var="filename"  value="${fn:substring(fileStr, length-3, length)}"/>
	<!-- 댓글 작성 창 -->
	<div class="replyWrite">
		<!-- 현재 로그인 ID 프로필 이미지 -->
		<div class="login_img">
			<!-- 프로필 이미지 예시로 넣은 것 -->
			<c:if test="${filename != 'tmp' && not empty login.newFilename }">
			<img src="http://localhost:8090/flenda/upload/${login.newFilename }" class="img" name="#MemberDto의 프로필 이미지명 넣기">
			</c:if>
			<c:if test="${filename == 'tmp' || empty login.newFilename}">
			<img src="./image/noProfile.png" class="img" name="#MemberDto의 프로필 이미지명 넣기" >
			</c:if>
		</div>
		<!-- 댓글 작성 창 -->
		<div class="reply">
			<div class="rwrite">
				<textarea class="form-control" rows="2" id="reContent" placeholder="댓글을 남겨주세요."></textarea>
			</div>
			<div class="rwritebtn">
				<button type="button" class="btn btn-primary" id="replyWriteBtn">저장</button>
			</div>
		</div>
	</div>
	
	<!-- 전체 댓글 목록 -->
	<div class="replyList" id="reply_div">
		<%-- 
		<!-- 댓글 한 개 목록 -->
		<div class="replyOne" id="replyOne_div">
			<!-- 댓글 작성자 ID 프로필 이미지 -->
			<div class="rwriter_img">
				<!-- 프로필 이미지 예시로 넣은 것 -->
				<img src="./image/city/Seoul.png" class="img" name="#MemberDto의 프로필 이미지명 넣기">
			</div>
			<!-- 댓글 작성자 ID -->
			<div class="rwriter_info">
				<div class="rwriter-id">
					댓글 작성자 ID
				</div>
				<div class="rwdate">
					댓글 작성일
				</div>
				<div class="rDelete">
					<input type="button" class="replybutton" id="replyDelete" value="삭제">
				</div>
				<div class="rUpdate">
					<input type="button" class="replybutton" id="replyUpdate" value="수정">
				</div>
			</div>
			<div class="reply-content">
				댓글 내용
			</div>
		</div>
		--%>
	</div>
	
</div>


<script type="text/javascript">

$(document).ready(function() {  
   getReplyList();	// 전체 댓글 목록 불러오기
   
   // 좋아요 상태 유지
   $.ajax({
		url:"getLikecheck.do",
		data:{ bbs_seq:'${bbs.seq}' },
		success:function( list ){
			// 좋아요 수
			$('#likeCount').html('좋아요 '+ list.length);
			
			let id = '${login.id}';
			
			$.each(list, function(index, item) {
				if(id == item.id){
					$('#_likeimg').attr('src','./image/like.png');
					$('#_likeimg').attr('alt','on');
				}
			});
		},
		error:function(){
			alert("error");
		}
	});
});


// 좋아요 기능
function clickLike(alt) {
//	alert(alt);
	let bseq = '${bbs.seq}';
	
	if('${login.id}' == ""){
		alert("로그인이 필요한 서비스입니다.");
		location.href = "login.do";
	} else {
		if(alt == 'off'){ // 좋아요 Off 상태일 때 버튼 클릭 -> 좋아요 On으로 전환
			$.ajax({
				url:"checkLikecheck.do",
				data:{ seq_bbs:bseq, id:'${login.id}' },
				success:function( msg ){
					if(msg == "success"){
						alert('좋아요!');
						$('#_likeimg').attr('src','./image/like.png');
						$('#_likeimg').attr('alt','on');
					}else{
						alert('없어');
						$('#_likeimg').attr('src','./image/unlike.png');
					}
				},
				error:function(){
					alert("error");
				}
			});
		}else{ // 좋아요 On 상태일 때 버튼 클릭 -> 좋아요 Off로 전환
			$.ajax({
				url:"delLikecheck.do",
				data:{ seq_bbs:bseq, id:'${login.id}' },
				success:function( msg ){
					if(msg == "success"){
						alert('좋아요 취소');
						$('#_likeimg').attr('src','./image/unlike.png');
						$('#_likeimg').attr('alt','off');
					}else{
						alert('체크있어');
						$('#_likeimg').attr('src','./image/like.png');
					}
				},
				error:function(){
					alert("error");
				}
			});
		}
	}
};


// 댓글작성
$("#replyWriteBtn").click(function() {
//	alert("replyWriteBtn 클릭");
	writeReply();
});
//댓글삭제       
$("#replyDelete").click(function() {
	replyDelete(rseq);
});
// 댓글수정
$("#replyUpdateComplete").click(function() {
	replyUpdate(rseq);
});
// 수정취소
$("#replyUpdateBack").click(function() {
	replyUpdateBack(rseq);
});

//게시글 삭제
function deleteBbs() {
	let bseq = '${bbs.seq}';
	$.ajax({
		url:"deleteBbs.do",
		type:"post",
		data:{ seq:bseq },
		success:function(msg){
			if(msg == 'success'){
				alert('성공적으로 삭제하였습니다');
				location.href = "bbslist.do";
			}else{
				alert('삭제 실패');
				location.href = "bbsdetail.do?seq=" + seq;
			}
		},
		error:function(){
			alert('error');
		}
	});
}

// 전체 댓글 목록 불러오기
function getReplyList() {
	console.log('getReplyList 댓글 불러오기');
	
	let bseq = '${bbs.seq}';
	
	$.ajax({
		url:"replylist.do",	// replyWriteAf.do 만들어야 함
		data:{ seq:bseq },
		success:function(list){
		//			alert('replylist.do success!');
		//			alert(list);
					
					// 댓글 수
					$('#replyCount').html('댓글 '+ list.length);
		
					let data = "";
					
					// 컨트롤러의 list를 each문 돌림 (item은 dto)
					$.each(list, function(index, item) {
						//댓글 프로필이미지 셋팅
						let idx = item.profile.indexOf(".");
						let tmp = item.profile.substring(idx+1);
						
						//날짜 셋팅
						let wdate = item.wdate.substr(0, 16);
						
						//댓글 형태 만들어준다.
						data += "<input type='hidden' id='seq" + item.rseq + "' value='" + item.rseq + "'>";
						
						data += "<hr>";
						data += "<div class='replyOne' id='_replyOneSeq" + item.rseq + "'>";	// id추가
						if(tmp != 'tmp'){
						data += 	"<div class='rwriter_img'><img src='http://localhost:8090/flenda/upload/" + item.profile + "' class='img' name='#MemberDto의 프로필 이미지명 넣기'></div>";
						}else{
						data += 	"<div class='rwriter_img'><img src='./image/noProfile.png' class='img' name='#MemberDto의 프로필 이미지명 넣기'></div>";	
						}
						data += 	"<div class='rwriter_info'>";
						data += 		"<div class='rwriter-id'>" + item.id + "</div>";
						data += 		"<div class='rwdate'>🕓 " + wdate + "</div>";
						
						/*
							로그인 id 권한이 1일 때 (관리자)		-> 관리자페이지에서 적용시키기
							or 로그인 id와 댓글 작성자 id가 같을 때
								-> 수정, 삭제 버튼 노출
							/
							댓글 작성자 id가 로그인 id와 다를 때
								-> 수정, 삭제 버튼 없음
						*/
						if('${login.id}' == item.id || '${login.auth}' == 1) {	
							data += 	"<div class='rDelete'><button class='btn btn-outline-secondary btn-sm' id='replyDelete" + item.rseq + "' onclick='replyDelete(this.value)' style='height: 28px; width: 90px;' value='" + item.rseq + "'>삭제</button></div>";
							data += 	"<div class='rUpdate'><button class='btn btn-outline-secondary btn-sm' id='replyUpdate" + item.rseq + "' onclick='replyUpdate(this.value)' style='height: 28px; width: 90px;' value='" + item.rseq + "'>수정</button></div>";
						}
						
						data += 	"</div>";
						data += 	"<div class='reply-content'>" + item.reply + "</div>";
						data += "</div>";
						data += "<div id='rpl" + item.rseq + "'></div>"; // 댓글 수정 폼 원하는대로 들어가게되면 지우기
						
						
						$("#reply_div").empty();	// 초기화
						$("#reply_div").append(data);	// reply_div 에 data 넣기
					});
				
		},
		error:function(){
			alert('getReplyList error');
		}
	});
	
}

// 댓글 쓰기
function writeReply() {
	let userImg = '${login.newFilename}'; // 프로필이미지
	let bseq = '${bbs.seq}';
//	alert("bseq = " + bseq);
	if('${login.id}' == ""){
		alert("로그인이 필요한 서비스입니다.");
		location.href = "login.do";
	} else {
		$.ajax({
			url:"replywriteAf.do",
			type:"GET",
			data : {id:'${login.id}', seq_bbs:bseq, reply:$("#reContent").val(), profile:userImg },
			success:function(str){
				//	alert('success');
					if (str.trim() == "yes") {
						alert("댓글이 추가되었습니다.");
						location.href = "bbsdetail.do?seq=" + ${bbs.seq};
					} else {
					//	alert("댓글내용을 작성해 주세요.");
					}
					getReplyList();
			},
			error : function() {
				alert('writeReply error');
			}
		});
	}
}

// 댓글 삭제
function replyDelete(rseq) {
	alert("rseq = " + rseq);
	
	$.ajax({
		url: "replydelete.do",
		data: { rseq:rseq, bbsSeq:'${bbs.seq}' },
		success: function(msg) {
				if (msg == "success") {		// delete에선 trim 없어도 됨
					alert("댓글이 삭제되었습니다.");
					location.href = "bbsdetail.do?seq=" + ${bbs.seq};
				} else {
					alert("댓글 삭제 실패");
				}
			},
		error: function() {
			alert('replyDelete error');
		}
	});
}

// 수정할 댓글 불러오기
function replyUpdate(rseq) {
	
//	alert('replyUpdate 버튼 클릭 -> 수정할 댓글 불러오기');
//	alert("rseq = " + rseq);
	
	$.ajax({
		url: "replyselect.do",
		data: {rseq:rseq},	// rseq:'${rlist.rseq}'
		success: function(dto) {
		//	alert('replyupdate (replyselect) 실행');
			
			let datas = "";
			
			$("#_replyOneSeq" + dto.rseq).empty();
			
			//댓글 프로필이미지
			let idx = dto.profile.indexOf(".");
			let tmp = dto.profile.substring(idx+1);
			// 댓글 리스트 폼과 같으나 수정완료/취소 버튼 & 댓글내용->댓글수정텍스트창으로만 바꾼 것
			datas += "<div class='replyOne' id='_replyOneSeq" + dto.rseq + "'>";	// id추가
			datas += "	<div class='login_img'>";
			if(tmp != 'tmp'){
			datas += "		<img src='http://localhost:8090/flenda/upload/" + dto.profile + "' class='img' name='#MemberDto의 프로필 이미지명 넣기'>";
			}else{
			datas += "		<img src='./image/noProfile.png' class='img' name='#MemberDto의 프로필 이미지명 넣기'>";	
			}
			datas += "	</div>";
			datas += "	<div class='replyEdit'>";
			datas += "		<div class='redit'>";
			datas += "			<textarea class='form-control' rows='2' id='reContent_edit'>" + dto.reply.replaceAll('<br>', '\n') + "</textarea>";
			datas += "		</div>";
			datas += "		<div class='reditbtn'>";
			datas += "			<div class='editcompletebtn'>";
			datas += "				<button type='button' class='btn btn-outline-primary btn-sm'  id='replyUpdateComplete' onclick='replyUpdateComplete(" + dto.rseq + ")'>수정완료</button>";
			datas += "			</div>";
			datas += "			<div class='editbackbtn'>";
			datas += "				<button type='button' class='btn btn-outline-secondary btn-sm' id='replyUpdateBack' onclick='replyUpdateBack(" + dto.rseq + ")'>취소</button>";
			datas += "			</div>";
			datas += "		</div>";
			datas += "	</div>";
			datas += "</div>";
			
			$("#_replyOneSeq" + dto.rseq).append(datas);
			
		},
		error: function() {
			alert('replyUpdate error');
		}
	});
}

//댓글 수정 완료
function replyUpdateComplete(rseq) {
	$.ajax({
		url:"replyupdateAf.do",
		data: { rseq: rseq, reply: $("#reContent_edit").val() },
		type:"get",
		success : function(msg) {
		//	alert('replyUpdateComplete 성공');
			
			console.log(msg.trim()); 
			
			if (msg.trim() == "success") {
				alert("댓글이 수정되었습니다.");
				location.href = "bbsdetail.do?seq=" + ${bbs.seq};
			} else {
				alert("댓글수정이 실패되었습니다..");
			}
		},
		error : function() {
			alert('replyUpdateComplete Error');
		}
	});
}

//댓글 수정 취소 
function replyUpdateBack() { 
	location.href = "bbsdetail.do?seq=" + ${bbs.seq};
}

</script>
</body>
</html>