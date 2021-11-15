<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/home.css">
<link rel="stylesheet" href="./css/sb-admin-2.min.css">
<link rel="stylesheet" href="./vendor/chart.js/Chart.min.js">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

</head>
<body>
	
<div class="container-fluid">

                   <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">금일 통계</h1>
    </div>

    <!-- Content Row -->
    <div class="row">

        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                금일 매출</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">${ts}</div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                금일 방문자 수</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">${tvc}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
      		<div class="card border-left-info shadow h-100 py-2">
                   <div class="card-body">
                       <div class="row no-gutters align-items-center">
                           <div class="col mr-2">
                               <div class="text-xs font-weight-bold text-info text-uppercase mb-1">금일 가입자 수
                               </div>
                               <div class="row no-gutters align-items-center">
									<div class="h5 mb-0 font-weight-bold text-gray-800">${trc}</div>
                               </div>
                           </div>
                       </div>
                   </div>
               </div>
           </div>

           <!-- Pending Requests Card Example -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-warning shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                   		<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">금일 작성된 게시글</div>
                                        <div class="row no-gutters align-items-center">
									<div class="h5 mb-0 font-weight-bold text-gray-800">${twc}</div>
                                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
	</div>
                <!-- Content Row -->

    <div class="row">

        <!-- Area Chart -->
<div class="col-xl-8 col-lg-7">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">sales</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area">
                                        <canvas id="myAreaChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>

        <!-- Pie Chart -->
        <div class="col-xl-4 col-lg-5">
            <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-primary">gender</h6>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                    <div class="chart-pie pt-4 pb-2"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                        <canvas id="myPieChart" width="826" height="500" style="display: block; height: 320px; width: 551px;" class="chartjs-render-monitor"></canvas>
                    </div>
   					<div class="mt-4 text-center small">
                       <span class="mr-2">
                           <i class="fas fa-circle text-primary"></i>남여성비
                       </span>


					</div>
				</div>
			</div>
		</div>
	</div>
</div>                   
	
<script type="text/javascript">
$(document).ready(function() {
	ajax();
});

  let ctx = document.getElementById("myPieChart").getContext('2d');
    let myPieChart = new Chart(ctx, {
      type: 'pie',
      data: {
        labels: ["남자", "여자"],
        datasets: [{
          data: [${mm}, ${mf} ],
          backgroundColor: ['#006acd', '#ED6652'],
        }],
      },
    });
    
	function ajax(){
		$.ajax({
			url:"homeSales.do",
			success:function(list){
				let arr = [];
				for (let i = 0; i < list.length; i++) {
				    arr[i]=list[i].money;
				}
			    let sales = document.getElementById("myAreaChart");
			    let myLineChart = new Chart(sales, {
			      type: 'line',
			      data: {
			        labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			        datasets: [{
			          label: "월 별 매출",
			          lineTension: 0.3,
			          backgroundColor: "rgba(78, 115, 223, 0.05)",
			          borderColor: "rgba(78, 115, 223, 1)",
			          pointRadius: 3,
			          pointBackgroundColor: "rgba(78, 115, 223, 1)",
			          pointBorderColor: "rgba(78, 115, 223, 1)",
			          pointHoverRadius: 3,
			          pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
			          pointHoverBorderColor: "rgba(78, 115, 223, 1)",
			          pointHitRadius: 10,
			          pointBorderWidth: 2,
			          data: arr,
			        }],
			      },
			      options: {
			        maintainAspectRatio: false,
			        layout: {
			          padding: {
			            left: 10,
			            right: 25,
			            top: 25,
			            bottom: 0
			          }
			        },
			        scales: {
			          xAxes: [{
			            time: {
			              unit: 'date'
			            },
			            gridLines: {
			              display: false,
			              drawBorder: false
			            },
			            ticks: {
			              maxTicksLimit: 12
			            }
			          }]
			
			        }
			      }
			    });
			},
			error:function(){
				alert("fail");
			}
		});
	}

</script>	
	
</body>
</html>