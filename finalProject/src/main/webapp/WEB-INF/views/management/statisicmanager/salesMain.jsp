<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- chart사용 -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<!--  datepicker 사용  -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="./css/statistic.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>

<body>

	<div class="swrap">
		<div class="sTitle">
		
			<div><img alt="" src="./image/ssales.png" id="hand"></div>
			<div><p>매출 통계</p></div>
		</div>
		<div class="sTable">
			<div class="smethod">
				<label for="f-option" class="l-radio">
				    <input type="radio" name="selector" id="f-option" onclick="changePerios(this.value)" value="week" tabindex="1" checked="checked">
				    <span>주별</span>
			  	</label>
			  	<label for="s-option" class="l-radio">
				    <input type="radio" name="selector" id="s-option" onclick="changePerios(this.value)" value="month"  tabindex="2">
				    <span>월별</span>
			  	</label>
			    <label for="t-option" class="l-radio">
				    <input type="radio" name="selector" id="t-option" onclick="changePerios(this.value)" value="year" tabindex="3">
				    <span>연별</span>
			  </label>
			</div>
			<div class="speriod">
				<strong>기간</strong>			
						<input type="text" id="datepicker1" name="startdate">&nbsp;&nbsp; ~ &nbsp;&nbsp;<input type="text" id="datepicker2" name="enddate">
						<img alt="" src="./image/loupe.png" id="searchBtn">
			</div>
		</div>
	</div>
	
	<div class="graphBack">
	<div id="container"></div>
	</div>
	
	<div align="right" style="margin-right: 185px;">
		<div style=" width: 300px; box-shadow: 2px 2px 3px #696969;">
			<table class="table table-hover" id="statistic">

			</table>
		</div>
	</div>


<script type="text/javascript">
 let day = "week";
 function changePerios(data){
	 day = data;
	 $("#datepicker1").val("");
	 $("#datepicker2").val("");
	 ajax($("#datepicker1").val(),$("#datepicker2").val(),data);
 }

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

$(document).ready(function() {
	ajax($("#datepicker1").val(),$("#datepicker2").val(),day);
});

$("#searchBtn").click(function() {
	ajax($("#datepicker1").val(),$("#datepicker2").val(),day);
});

</script>
<script type="text/javascript">

function ajax(sdates,edates,periods){
 	$.ajax({
		url:"selectSales.do",
		data:{sdate:sdates, edate:edates, period:periods}, // sdate , edate , 주별 월별 연별 기간 상태
		success:function(list){
			
			//통계표 reset
			$("#statistic").empty();
			
			//pointStart 시점 만들기
			let arr = [];
			arr = list[0].moneyDate.split('-');
			
			//데이터 삽입할 배열 생성
			let tmp = [];
			
			//통계표 - 총 매출액 초기화
			let totalMoney=0;
			
			//배열에 데이터 삽입
			for(let i=0; i<list.length; i++){
				//차트 데이터 삽입
				tmp[i] = parseInt(list[i].money);
				//통계표 데이터 삽입
				totalMoney += tmp[i];
			}
			//차트 생성
			Highcharts.chart('container', {
		        
				title: {
		            text:' '
		    		
		        },
			    xAxis: {
			        type: 'datetime'
			    },
			    yAxis: {
			        title: {
			            text: '금액(원)'
			        }
			    },

			    plotOptions: {
			        series: {
			            //차트 시작 점
			            pointStart: Date.UTC(arr[0],arr[1]-1,arr[2]),
			            // 일 수 
			            pointInterval: 24 * 3600 * 1000
			        }
			    },
				//삽입한 데이터 차트화
			    series: [{
			    	name:"일 간 총 매출",
			        data:tmp,
			    }]
			});
			
			//나눌 기간
			let avg = list.length;
			//평균 소수점 포함
			let math = totalMoney/avg;
			//평균 소수점 제거
			let avgMoney = Math.floor(math);

			let str;
			str+= '<col width="100px"><col width="200px">';
			str+= '<tr>';
			str+= '<th>총 매출</th>';
			str+= '		<td>'+totalMoney+'원</td>';
			str+= '</tr>';
			str+= '	<tr>';
			str+= '	<th>평균 매출</th>';
			str+= '<td>'+avgMoney+'원</td>';
			str+= '	</tr>';
			$("#statistic").append(str);

			
			
			
			
		},
		error:function(){
			alert("salesMain error");
		} 
			
	});
	
};


</script>	
</body>
</html>