<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail</title>
<!-- 날짜범위선택 https://www.daterangepicker.com -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<style type="text/css">
td{
	text-align: left;
	padding: 5px;
}
</style>
</head>
<body>
<div style="margin-top: 50px; margin-left: 130px;">
	<div align="left" style="float: left;">
		<strong style="font-size: 25px">판매정보</strong>
	</div>
	<div align="right" style="margin-right: 180px; ">
		<button class="btn btn-outline-primary" onclick="location.href='actupdate.do?seq=${act.sellSeq}'">수정</button>
		<button class="btn btn-outline-danger" onclick="deleteAct()">삭제</button>
	</div>
	<hr width="90%">
	<table style="margin: 20px; margin-bottom: 70px;">
		<col width="400"><col width="400">
		<tr>
			<td>
				사업자명: ${act.businessName }
			</td>
			<td>
				사업자등록증: ${act.businessNumber }
			</td>
		</tr>
		<tr>
			<td>
				카테고리: ${act.category}
			</td>
			<td>
				주소: ${act.address }
			</td>
		</tr>
		<tr>
			<td>
				등록일: ${act.regidate}
			</td>
			<td>
				판매자아이디: ${act.hostId }
			</td>
		</tr>
		<tr>
			<td>
				판매제목: ${act.title}
			</td>
			<td>
				연락처: ${act.businessPhoneNum }
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div style="width: 700px;">판매자설명: ${act.hostintro }</div>
				<a href="main_actdetail.do?seq=${act.sellSeq }">(자세히 보기)</a>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				상품설명: <a href="main_actdetail.do?seq=${act.sellSeq }">(자세히 보기)</a>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				이용안내: <a href="main_actdetail.do?seq=${act.sellSeq }">(자세히 보기)</a>
			</td>
		</tr>
	</table>
	<div align="left" style="float: left;">
		<strong style="font-size: 25px">옵션정보</strong>
	</div>
	<div align="right" style="margin-right: 200px; ">
		<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">옵션등록</button>
	</div>
	<hr width="90%">
</div>

<table class="table table-hover" style="width: 80%; margin-left: 130px;" id="option_table">
</table>

<!-- 옵션등록 모달 -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">옵션등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table>
        	<tr>
        		<th>옵션설명</th>
        		<td>
        			<textarea rows="10" cols="10" id="content" class="form-control"></textarea>
        		</td>
        	</tr>
        	<tr>
        		<th>가격(원)</th>
        		<td>
        			<input type="text" id="price" class="form-control w-50" placeholder="숫자입력">
        		</td>
        	</tr>
        	<tr>
        		<th>하루최대판매인원(명)</th>
        		<td>
        			<input type="text" id="maxPpl" class="form-control w-50" placeholder="숫자입력">
        		</td>
        	</tr>
        	<tr>
        		<th>유효기간/운영시간</th>
        		<td>
        			<input type="text" id="daterange" name="daterange" size="35" placeholder="날짜 검색해주세요">
        		</td>
        	</tr>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">이전</button>
        <button type="button" class="btn btn-primary" onclick="addOption()">등록</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
$(document).ready(function() {

	$('#option_table').empty();
	let sellseq = '${act.sellSeq}';
	$.ajax({
		url:"getOptionList.do",
		type:"post",
		data:{ seq:sellseq },
		success:function(olist){
			/* 게시판 셋팅 */
			let setting = '<colgroup><col style="width: 50px"><col style="width: 80px"><col style="width: 150px;"><col style="width: 150px;">' +
							'<col style="width: 90px"><col style="width: 70px"><col style="width: 80px"><col style="width: 60px"></colgroup>' +
						  '<tr><th>번호</th><th>옵션코드</th><th>옵션설명</th><th>유효기간</th><th>사용시간</th><th>가격(원)</th><th>최대판매개수(일)</th><th>관리</th></tr>';
			
			$('#option_table').append(setting);	
			
			if(olist == null && olist[0].sellSeq == ""){
				let add = '<tr><td colspan="9" style="text-align: center;">등록된 판매옵션이 없습니다</td></tr>'
				$('#option_table').append(add);	
			}
			/* 게시판리스트 추가 */
			$.each(olist, function(index,dto){
				let str = '<tr>' +
							'<td style="text-align: center;">' + (index+1) + '</td>' +
							'<td style="text-align: center;">' + dto.optionSeq + '</td>' +
							'<td style="text-align: center;">' + dto.opcontent +'</td>' +
							'<td style="text-align: center;">' + YYYYMMDD(dto.startDate) + ' ~ ' + YYYYMMDD(dto.endDate) + '</td>' +
							'<td style="text-align: center;">' + HHMM(dto.startDate) + ' ~ ' + HHMM(dto.endDate) + '</td>' +
							'<td style="text-align: center;">' + dto.opPrice + '</td>'+
							'<td style="text-align: center;">' + dto.maxPeople + '</td>'+
							'<td style="text-align: center;">' +
								'<button type="button" class="btn btn-outline-danger" onclick="deleteBtn('+ dto.optionSeq +')" style="width: 78px; height: 30px; font-size: 9pt">삭제</button>' +
							'</td>'+
						   '</tr';
				$('#option_table').append(str);
			});
		},
		error:function(){
			alert('error');	
		}
	});
});

function deleteAct() {
	let sellseq = '${act.sellSeq}';
	$.ajax({
		url:"deleteAct.do",
		type:"post",
		data: { seq:sellseq },
		success:function(msg){
			if(msg == 'success'){
				alert('성공적으로 판매정보를 삭제하였습니다');
				location.href = "activity.do";
			}else{
				alert('판매정보삭제 실패하셨습니다');
				location.href = "actdetail.do?seq=" + seq;
			}
		},
		error:function(){
			alert('error');
		}
	});
}

function addOption() {
	let seq = '${act.sellSeq}';
	$.ajax({
		url:"addOption.do",
		type:"post",
		data: { sellSeq:seq, opcontent:$('#content').val(), maxPeople:$('#maxPpl').val(), opPrice:$('#price').val(), daterange:$('#daterange').val() },
		success:function(msg){
			if(msg == 'success'){
				alert('성공적으로 옵션등록하였습니다');
				location.href = "actdetail.do?seq=" + seq;
			}else{
				alert('옵션등록 실패하셨습니다');
				location.href = "actdetail.do?seq=" + seq;
			}
		},
		error:function(){
			alert('error');
		}
	});
}

function deleteBtn(optionSeq) {
	let seq = '${act.sellSeq}';
	$.ajax({
		url:"deleteOption.do",
		type:"post",
		data: { seq:optionSeq },
		success:function(msg){
			if(msg == 'success'){
				alert('성공적으로 옵션삭제하였습니다');
				location.href = "actdetail.do?seq=" + seq;
			}else{
				alert('옵션삭제 실패하셨습니다');
				location.href = "actdetail.do?seq=" + seq;
			}
		},
		error:function(){
			alert('error');
		}
	});
}

$(function() {
  $('#daterange').daterangepicker({
  	timePicker: true,
	timePicker24Hour: true,
  	startDate: new Date,
	endDate: new Date,
	locale: { format: 'YYYY/MM/DD HH:mm' }
  }, function(start, end, label) {
    	alert(start.format('YYYY/MM/DD') + ' ~ ' + end.format('YYYY/MM/DD'));
  });
});
function YYYYMMDD(dates) {
	let year = dates.substring(0, 4);
	let month = dates.substring(4, 6);
	let day = dates.substring(6, 8);
	
	return year + "/" + month + "/" + day ;
}
function HHMM(dates) {
	let hour = dates.substring(9, 11);
	let min = dates.substring(11, 13);
	return hour + ":" + min ;
}
function dots(str){
	let newStr = '';
	if(str.length > 15){
		newStr = str.substring(0, 16);
	}else{
		return str;
	}
	return newStr + '...';
}
</script>
</body>
</html>