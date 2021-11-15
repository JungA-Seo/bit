<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- datepicker 사용 --> 
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- pagination -->
<script type="text/javascript" src="./resources/pagination/jquery.twbsPagination.min.js"></script>

<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style type="text/css">
tr{
	font-size: 15px;s
}
</style>
</head>
<body>

<!-- 상단 서칭부분 -->
<div align="center" style="margin-left: 60px ; margin-top:50px; margin-bottom:50px;">
	<form id="frm" method="get">
		<table>
		<col width="80"><col width="70"><col width="250">
			<tr>
				<th style="font-size: 15px; text-align: center;" >가입일 </th>
				<td colspan="3">
					<input type="text" id="datepicker1" name="startdate" style="padding:auto; width: 150px; height: 35px">&nbsp;&nbsp; ~ &nbsp;&nbsp;
					 <input type="text" id="datepicker2" name="enddate" style="padding:auto; width: 150px; height: 35px">
				</td>
			</tr>
			<tr>
				<th style="font-size: 15px;text-align: center;" >조건검색</th>
				<td style="width: 100px;" >
					<select class="form-select" aria-label="Default select example" name="choice" id="choice">
					  <option selected>선택</option>
					  <option value="id">ID</option>
					  <option value="name">이름</option>
					  <option value="email">이메일</option>
					  <option value="businessname">사업자명</option>
					  <option value="auth">등급</option>
					</select>
				</td>
				<td>
					<input type="text" style="margin-left: 10px;" id="search" name="search" class="form-control" placeholder="검색" size="20">
				</td>
				<td>
					<img alt="" src="./image/search.png" id="searchBtn" style="width: 30px; height: 30px;margin-left: 12px;">
				</td>
			</tr>	
		</table>
	</form>
</div>

<div align="right" style="margin-right: 100px; padding-bottom: 30px;">
<button type="button" class="btn btn-primary" id="insertBtn">회원등록</button>
</div>

<!-- ajax 테이블 -->
<div align="center">
<table class="table table-hover" style="width: 90%; font-size: 10pt;" id="member_List_table">
</table>
</div>

<!-- 페이징  -->
<br>
<div id="pagingMain" class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content:center;" ></ul>
    </nav>
   
</div>
<br>

<script type="text/javascript">
/* widget calendar */
$("#datepicker1,#datepicker2").datepicker({
            showMonthAfterYear:true,
            showOn:"both",
            buttonImage:"./image/calendar.png",
            buttonImageOnly:true,
            buttonText: "Select date",
            dateFormat:'yy-mm-dd',
            nextText:'다음 달',
            prevText:'이전 달',
            dayNamesMin:['일','월','화','수','목','금','토'],
            monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
  });
</script>

<script type="text/javascript">
$(document).ready(function() {
	
	ajax($("#choice").val(),$("#search").val(),0,$("#datepicker1").val(),$("#datepicker2").val());

});	

	//검색버튼 클릭시
	$("#searchBtn").click(function() {
		ajax($("#choice").val(),$("#search").val(),0,$("#datepicker1").val(),$("#datepicker2").val());
	});

	let totalCount = 0;   //글의 총수
	let pageSize = 10;      //페이지의 크기 1 ~ 10   [1]~[10]
	let pageNumber = 1;      //현재페이지

	function ajax(Tchoice, Tsearch, TpageNumber, Tstartdate, Tenddate){
		//alert("enddate:" + Tenddate);
			
		$('#pagingMain').empty();
		$('#member_List_table').empty();		// 검색하고나서 새로운 리스트 보여줄때 리스트 초기화
		
		$.ajax({
			url : "getMemberList.do",
			type: "post",
			data: { choice:Tchoice, search:Tsearch, pageNumber:TpageNumber, startdate:Tstartdate, enddate:Tenddate },
			success:function( memlist ){
				//alert('success');
				
				/*검색 고정*/
				$("#choice").val(memlist.search.choice);
				$("#search").val(memlist.search.search);
				$("#datepicker1").val(memlist.search.startDate);
			    $("#datepicker2").val(memlist.search.endDate);
				
				/*페이징 값변경*/
				 totalCount = memlist.totalCount;
	        	 pageNumber = memlist.search.pageNumber + 1;
	      
				/* 게시판 셋팅 */
				let setting = '<colgroup><col style="width: 80px"><col style="width: 80px"><col style="width: 80px;"><col style="width: 80px;"><col style="width: 80px;"><col style="width: 120px;"><col style="width: 80px;">' +
								'<col style="width: 80px"><col style="width: 90px"><col style="width: 50px"><col style="width: 70px"><col style="width: 50px"><col style="width: 120px"></colgroup>' +
							  '<tr align="center"><th>번호</th><th>아이디</th><th>이름</th><th>사업자명</th><th>사업자등록번호</th><th>주소</th><th>성별</th><th>생일</th><th>이메일</th><th>등급</th><th>포인트</th><th>가입일</th><th>관리</th></tr>';
				
				$('#member_List_table').append(setting);	
				
				if(memlist == null && memlist[0].seq == ""){
					let add = '<tr><td colspan="9" style="text-align: center;">등록된 회원이 없습니다</td></tr>'
					$('#member_List_table').append(add);	
				}
				
				/* 게시판리스트 추가 */
				$.each(memlist.memberlist, function(index,dto){
					let str = '<tr>' +
								'<td style="text-align: center;">' + (index+1) + '</td>' +
								'<td style="text-align: center;">' + dto.id.substring(0, 17) +'</td>' +
								'<td style="text-align: center;">' + dto.name + '</td>' +
								'<td style="text-align: center;">' + dto.businessName + '</td>' +
								'<td style="text-align: center;">' + dto.businessNumber + '</td>' +
								'<td style="text-align: center;">' + dto.address + '</td>' +
								'<td style="text-align: center;">' + dto.gender + '</td>' +
								'<td style="text-align: center;">' + dto.birthday + '</td>' +
								'<td style="text-align: center;">' + dto.email + '</td>' +
								'<td style="text-align: center;">' + dto.auth + '</td>' +
								'<td style="text-align: center;">' + dto.point + '</td>' +
								'<td style="text-align: center;">' + dto.joindate.substring(0, 11) + '</td>'+
								'<td style="text-align: center;">' +
									'<button type="button" class="btn btn-outline-primary" onclick="memupdateBtn(this.value)" style="font-size: 9pt" value="' + dto.id + '">수정</button>&nbsp;' +
									'<button type="button" class="btn btn-outline-warning" onclick="memdeleteBtn(this.value)" style="font-size: 9pt" value="' + dto.id + '">삭제</button>' +
								'</td>'+
							   '</tr';
					$('#member_List_table').append(str);
				});
				
				 /* 페이징 추가 */
		         let paging = '<nav aria-label="Page navigation">' +
		                       '<ul class="pagination" id="pagination"  style="justify-content:center;"></ul>' +
		                     '</nav>'
		         $('#pagingMain').append(paging);
		         
		         let totalPages = Math.floor(totalCount / 10);
 
		         if(totalCount % 10 > 0){
		            totalPages++;
		         }
		         $("#pagination").twbsPagination({
		            startPage: pageNumber,
		            totalPages: totalPages,
		            visiblePages: 10,
		            initiateStartPageClick:false,
		            first:'<span sris-hidden="true">«</span>',
		            prev:"이전",
		            next:"다음",
		            last:'<span sris-hidden="true">»</span>',
		            onPageClick:function(event, page){
		            	ajax($("#choice").val(),$("#search").val(),(page-1),$("#datepicker1").val(),$("#datepicker2").val());
		            }
		         });   

		
			}, //success의 끝
			error:function(){
				alert('error');
			}
		
		
		});  //ajax끝 
	} //function ajax 끝	


$("#insertBtn").click(function(){
	location.href = "memInsert.do";
});

	
function memupdateBtn(checkid){

	location.href = "memUpdate.do?id=" + checkid;
}

function memdeleteBtn(deleteId){
	Swal.fire({
		  title: '회원삭제를 하시겠습니까?',
		  text: '확인을 누르시면 회원삭제가 완료됩니다',
		  showCancelButton: true,
		  confirmButtonText: 'YES',
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url:"deleteMember.do",
					data: { id:deleteId },
					success:function( result ){
						alert("success");
						if(result == 1){
							Swal.fire('회원삭제가 완료되었습니다', '', 'success').then((result) => {
			                   if (result.isConfirmed) {
			                      location.href ="memManagement.do";
			                   }
				            });
						}else{
							alert('회원삭제 실패');
						}
					}, error:function(){
						alert("error");
					} 		
				});
			}
		});
}	
</script>

</body>
</html>