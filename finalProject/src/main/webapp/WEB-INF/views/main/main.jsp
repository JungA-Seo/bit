<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 검색창 -->
<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<!-- 네이버 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<link rel="stylesheet" type="text/css" href="./css/main.css">


<!-- 이벤트팝업 쿠키저장 -->
<script language="JavaScript">
 
  function setCookie( name, value, expiredays ) {
   var todayDate = new Date();
    todayDate.setDate( todayDate.getDate() + expiredays ); // 현재시간에 하루를 더함 
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toUTCString() + ";"  //표준 시간대 오프셋을 사용하여 날짜를 GMT (UTC)로 변환(1995 년 12 월 18 일 월요일 17:28:35 GMT)
   }

  function closePop() {
   if ( document.pop_form.chkbox.checked ){
    setCookie( "maindiv", "done" , 1 );
   
   }
   document.all['pop'].style.visibility = "hidden";
   $('#popupBack').hide();
  }
  
</script>


</head>
<body> 
<div class="search">
   <div class="wrapper">
      <div class="blackbackground">
         <div class="textbox">
            <div class="text1">이번엔,</div>
            <div class="text2"><strong>어디로 떠날까?</strong></div>
         </div>
         <div class="shadow-lg p-2 mb-3 bg-body rounded-pill">
             <div class="search_box">
                 <div class="dropdown">
                     <div class="default_option" style="font-size: 16px;">여행선택</div>  
                     <ul>
                       <li>테마여행</li>
                       <li>액티비티</li>
                     </ul>
                 </div>
                 <div class="search_field">
                   <input type="text" class="input" id="searchBox" placeholder="지역을 검색해주세요">
                   <i class="fas fa-search" id="searchBtn"></i>
                  </div>
             </div>
         </div>
      </div> 
   </div>
</div>



<div align="center">
   <div class="mainLine">
      <div class="act_ref">
      <div class="act_title" align="left">인기 액티비티</div>
         <div class="act_body" style="display: flex;"></div>
      </div>
      
      <div class="theme_ref">
         <div class="theme_title" align="left">추천 테마여행</div>
         <div class="theme_body" style="display: flex;"></div>
      </div>
      
      <!-- 캐러셀 -->
      <div class="banner" align="center">
         <div class="bannerIn">
            <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
              <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
              </div>
              <div class="carousel-inner">
                <div class="carousel-item active">
                  <img src="./image/benu3.png" class="d-inline w-100" alt="..." style="height: 200px;">
                </div>
                <div class="carousel-item">
                  <img src="./image/benu4.jpg" class="d-inline w-100" alt="..." style="height: 200px;">
                </div>
                <div class="carousel-item">
                  <img src="./image/benu5.jpg" class="d-inline w-100" alt="..." style="height: 200px;">
                </div>
              </div>
              <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
              </button>
              <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
              </button>
            </div>
         </div>
      </div>
      
      <div class="bbs_ref">
         <div class="bbs_title" align="left">베스트 여행기</div>
         <div class="bbs_body" style="display: flex;"></div>
      </div>
      
      <!-- 여행 정보 -->
      <div class="information_ref">
         <div class="information_title" align="left">Flenda의 여행 정보</div>
         <div class="information_body">
            <div class="inforitem facebook">
               <img alt="" src="./image/colorFacebook.png" id="colorFacebook" style="margin-right: 10px;">
                  <a href="https://ko-kr.facebook.com/" target="_blank" style="width: 30px; height: 30px;"><span style="font-size: 13pt;">Flenda 페이스북 페이지 ></span></a><br>
               <div style="margin-top: 20px;"><p style="font-size: 12pt; color:#828282; text-align: left;" >프렌다 페이스북 페이지에서 각 여행지별로 정리된 유용한 정보와 여행자분들을 위한 이벤트를 확인해보세요.</p></div>
            </div>
            <div class="inforitem instagram">
               <img alt="" src="./image/colorInstagram.png" id="colorInstagram" style="margin-right: 10px;">
                  <a href="https://instagram.com/flenda_official?utm_medium=copy_link" target="_blank" style="width: 30px; height: 30px;"><span style="font-size: 13pt;">Flenda 인스타그램 ></span></a><br>
               <div style="margin-top: 20px;"><p style="font-size: 12pt; color:#828282; text-align: left;" >세계 곳곳에서 활동중인 Flenda의 가이드님과 여행자분들이 보내주신 아름다운 사진을 감상해보세요.</p></div>
            </div>
            <div class="inforitem naver">
               <img alt="" src="./image/colorNaver.png" id="colorInstagram" style="margin-right: 10px;">
                  <a href="https://blog.naver.com/minki145" target="_blank" style="width: 30px; height: 30px;"><span style="font-size: 13pt;">Flenda 네이버 블로그 ></span></a><br>
               <div style="margin-top: 20px;"><p style="font-size: 12pt; color:#828282; text-align: left;" >Flenda의 네이버 블로그에서 리얼생생 여행정보, 여행후기, 추천 가이드 정보를 확인해 보세요.</p></div>
            </div>
         </div>
      </div>
      
      <!-- 파트너십 -->
      <div class ="partnership">
         <div class="partnershipText" align="left" style="margin-top: 30px; margin-left: 20px;">
            <span>Flenda 파트너</span>
         </div>
         <div class="partnershipNext" align="left" style="margin-left:20px; margin-bottom: 20px;">
            <span style="font-size: 14px; color: gray;">전세계의 파트너와 함께 다양한 프로모션을 제공해요</span>
         </div>
      
         <div class="partnershipButton" align="left" style="display: flex;"> <!-- style="margin-top: 20px;"  -->
             <div class="partnershipButton one">
                <button type="button" class="btn btn-link" style= "border:none margin-left: 5px;"  onclick="location.href='https://flyasiana.com'"><img alt="" src="image/asiana.png"  border="0"></button>
             </div>
             <div class="partnershipButton two">
                <button type="button"  class="btn btn-link" style= "border:none" onclick="location.href='https://www.asiamiles.com'"><img alt="" src="image/asiamiles.png"  border="0"></button>
             </div>
             <div class="partnershipButton three">
                <button type="button"  class="btn btn-link" style= "border:none" onclick="location.href='https://www.bigbustours.com'"><img alt="" src="image/bigbus.png"  border="0"></button>
             </div>
             <div class="partnershipButton four">
                <button type="button"  class="btn btn-link" style= "border:none " onclick="location.href='https://www.hongkongdisneyland.com/ko'"><img alt="" src="image/disneylandHK.png" style="height: 45px; width: 120px;" border="0"></button>
             </div>
             <div class="partnershipButton five">
                <button type="button"  class="btn btn-link" style= "border:none" onclick="location.href='https://www.koreanair.com/kr/ko'"><img alt="" src="image/koreanair.png"  border="0" ></button>
             </div>
             <div class="partnershipButton six">
                <button type="button"  class="btn btn-link" style= "border:none" onclick="location.href='https://www.raileurope.com'"><img alt="" src="image/raileurope.png"  border="0" ></button>
               </div>
         </div>
         <div class="partnershipButton" align ="left" style="display: flex;"> <!-- style="margin-top: 30px;" -->
            <div class="partnershipButton seven">
               <button type="button"  class="btn btn-link" style= "border:none" onclick="location.href='https://www.shopback.co.kr'"><img alt="" src="image/shopback.png"  border="0"></button>
            </div>
             <div class="partnershipButton eight">
               <button type="button"  class="btn btn-link" style= "border:none" onclick="location.href='https://www.airbnb.co.kr'"><img alt="" src="image/airbnb.png"  border="0"></button>   
            </div>
             <div class="partnershipButton nine">
               <button type="button"  class="btn btn-link" style= "border:none" onclick="location.href='https://www.yanolja.com/'"><img alt="" src="image/yanolja.png"  border="0"></button>
            </div>
         </div>
      </div>
      
      
   </div>
</div>


<!— 참고사이트:https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=hyoyeol&logNo=70174463583 —>
<!— 이벤트 모달 팝업창 —>
<div id="popupBack">
   <div id="pop">
   <!-- 이미지캐러셀 -->
         <div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
           <div class="carousel-inner">
             <div class="carousel-item active">
               <img src="./image/jejupopup.png" class="d-block w-100" >
             </div>
             <div class="carousel-item">
               <img src="./image/covidpopup.png" class="d-block w-100" >
             </div>
           </div>
           
           <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
             <span class="carousel-control-prev-icon" aria-hidden="true"></span>
             <span class="visually-hidden">Previous</span>
           </button>
           <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
             <span class="carousel-control-next-icon" aria-hidden="true"></span>
             <span class="visually-hidden">Next</span>
           </button> 
         </div>
      <!— 이미지캐러셀 끝 —>   
    
       <div class="close">
           <form name="pop_form">
              <div id="check"><input type="checkbox" name="chkbox" value="checkbox">&nbsp;&nbsp;오늘 그만볼래요</div>
              <div id="close"><a href="javascript:closePop();">닫기</a></div>
           </form>
       </div>
   </div> 
</div>
 <!-- End Modal -->


<script>
$(document).ready(function(){
   let msg = '${msg}';
   if(msg == 'success'){
      alert('환영합니다');
   }
   
   $(".default_option").click(function(){
     $(".dropdown ul").addClass("active");
   });

   $(".dropdown ul li").click(function(){
     var text = $(this).text();
     $(".default_option").text(text);
     $(".dropdown ul").removeClass("active");
   });
});

$('#searchBtn').click(function() {
   let option = $('.default_option').text();
   let search = $('#searchBox').val();
    if(option == '액티비티'){
       location.href = "main_activity.do?param=" + search;
    }
    if(option == '테마여행'){
       location.href = "tmsearch.do?param=" + search; 
    }
});
/* 네이버 로그인 후, 정보저장 */
var naver_id_login = new naver_id_login("0BAfgZNxnePTC9ReDt79", "http://localhost:8090/flenda/main.do");
// 네이버 사용자 프로필 조회
naver_id_login.get_naver_userprofile("naverSignInCallback()");
// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
function naverSignInCallback() {
   let memSeq = naver_id_login.oauthParams.access_token;  // 접근 토큰 값 출력
  let memEmail = naver_id_login.getProfileData('email');
  let memName = naver_id_login.getProfileData('name');
  $.ajax({
     url:"loginApiAf.do",
     data: { name:memName, email:memEmail, id:memSeq },
     success:function(msg){
        if(msg == 'success'){
           alert(naver_id_login.getProfileData('name')+ "님 로그인되었습니다");
           location.href="main.do";
        }
     },
     error:function(){
        alert('error_loginApiAf');
     }
  });
}


/* 추천액티비티 */
$(document).ready(function() {
   $.ajax({
      url:"main_refer.do",
      success:function(data){
         $.each(data.list, function(index, item) {
            if(index == 5){   return }
            let showlist =    '<a href="main_actdetail.do?seq=' +item.sellSeq + '">' +
                        '<div class="card mainC" style="max-width: 16rem; text-align: left; margin: 20px; width: 330px; text-decoration: none;">';
                  $.each(data.pics, function(index, pic) {
                     if(item.sellSeq == pic.sellSeq){
                        <!-- 카드 상단에 배치되는 이미지 : card-img-top -->
                        showlist +=   '<img class="card-img-top" src="http://localhost:8090/flenda/upload/' + pic.newFileName + '">';      
                        return false;
                     }
                  });   
            
                           <!-- 카드본문:card-body -->
                  showlist +=   '<div class="card-body">' +
                              '<div style="display:flex; justify-content: space-between;">' +
                                 '<div class="card-loc">' + locations(item.address) + '</div>' +
                                 '<div class="card-text"><font style="font-size: 15px; color: blue;">⭐</font>평점&nbsp;' + item.reviewAvg + '&nbsp;<font style="font-size: 13px; color: #5882FA;">(후기 ' + item.reivewNum + '건)</font></div>' +
                              '</div>' +
                                 <!-- 카드 제목 :card-title -->
                                 '<h5 class="card-title" style="font-size: 18px;">' + dots(item.title) + '</h5>' +
                                 <!-- 카드의 내용 글 :card-text -->
                                 '<div style="display: flex; justify-content: space-between;">' +
                                    '<div style="margin-right: 20px;">' +
                                    '<div class="card-text"><font size="2"><b>종류 </b></font>&nbsp;&nbsp;' + item.category + '</div>' +
                                    '<div class="card-text"><font size="2"><b>소요시간 </b></font>&nbsp;&nbsp;' + item.timetake + '시간</div>' +
                                    '<div class="card-text-p" id="priceRange' + item.sellSeq + '"><font size="3"><b></b></font>&nbsp;&nbsp;</div>' +
                                    '</div>' +
                                    '<div>' +
                              //      '<div class="priceRange" id="priceRange' + index + '"></div>' +
                                    '</div>' +
                                '</div>' +
                            '</div>' +
                         '</div>' +
                         '</a>';         
                         
            $(".act_body").append(showlist);
            priceRange(item.sellSeq);
         });
         
      },
      error:function(){
         alert('error_main_refer');
      }
   });
   
   $.ajax({
      url:"main_refer_theme.do",
      success:function(data){
         $.each(data.tlist, function(index, item) {
            if(index == 5){   return }
            let showlist =    '<a href="tmuserdetail.do?sellSeq=' +item.sellSeq + '">' +
                        '<div class="card" style="max-width: 16rem; text-align: left; margin: 16px; width: 330px;">';
                  $.each(data.pics, function(index, pic) {
                     if(item.sellSeq == pic.sellSeq){
                        <!-- 카드 상단에 배치되는 이미지 : card-img-top -->
                        showlist +=   '<img class="card-img-top" src="http://localhost:8090/flenda/upload/' + pic.newFileName + '">';      
                        return false;
                     }
                  });   
            
                           <!-- 카드본문:card-body -->
                  showlist +=   '<div class="card-body">' +
                              '<div style="display:flex; justify-content: space-between;">' +
                                 '<div class="card-loc">' + locations(item.meetplace) + '</div>' +
                                 '<div class="card-text"><font style="font-size: 15px; color: blue;">⭐</font>평점&nbsp;' + item.reviewAvg + '&nbsp;<font style="font-size: 13px; color: #5882FA;">(후기 ' + item.reviewNum + '건)</font></div>' +
                              '</div>' +
                                 <!-- 카드 제목 :card-title -->
                                 '<h5 class="card-title" style="font-size: 18px;">' + dots(item.title) + '</h5>' +
                                 <!-- 카드의 내용 글 :card-text -->
                                 '<div style="display: flex; justify-content: space-between;">' +
                                    '<div style="margin-right: 20px;">' +
                                    '<div class="card-text"><font size="2"><b>종류 </b></font>&nbsp;&nbsp;' + item.category + '</div>' +
                                    '<div class="card-text"><font size="2"><b>소요시간 </b></font>&nbsp;&nbsp;' + item.timetake + '시간</div>' +
                                    '<div class="card-text-p" id="priceRange' + item.sellSeq + '"><font size="3"><b></b></font>&nbsp;&nbsp;</div>' +
                                    '</div>' +
                                    '<div>' +
                              //      '<div class="priceRange" id="priceRange' + item.sellSeq + '"></div>' +
                                    '</div>' +
                                '</div>' +
                            '</div>' +
                         '</div>' +
                         '</a>';         
                         
            $(".theme_body").append(showlist);
            priceRange(item.sellSeq);
         });
         
      },
      error:function(){
         alert('error_main_refer_theme');
      }
   });
   
   $.ajax({
      url:"main_refer_bbs.do",
      success:function(list){
         $.each(list, function(index, bbs) {
            if(index == 5){   return }
            let showlist =    '<a href="bbsdetail.do?seq=' +bbs.seq + '">' +
            					'<div class="card" style="text-align: left; margin: 20px; width: 16rem;">';
            				if(bbs.newFilename.substring(bbs.newFilename.length-3, bbs.newFilename.length) != 'tmp'){ 
				 	showlist += '<img class="card-img-top" src="http://localhost:8090/flenda/upload/' + bbs.newFilename + '">' ;           	
				            }else{
					showlist += '<img class="card-img-top" src="./image/no_mainpic2.png">';           	
				            }      
				               <!-- 카드본문:card-body -->
					showlist +=   '<div class="card-body">' +
                                 '<div class="bbs_card_title" style="font-size: 18px; font-weight: bold;">' +
                                 '<span id="category" class="category">' + bbs.category + '</span>' +
                                 '<span id="title">' + dots(bbs.title) + '</span>' +
                              '</div>' +
                              '<div class="bbs_card_loc">' +
                                 '<span class="postText"><font size="2"><strong>' + bbs.id + '</strong></font></span>' +
                                 '<span class="postText"><font size="2">님이<br></font></span>' +
                                 '<span class="postText"><font size="2"><strong><b>' + bbs.address + '</b></strong></font></span>' +
                                 '<span class="postText"><font size="2">에 남긴 포스트입니다.</font></span>' +
                              '</div>' +
                              '<div class="bbs_card_icons">' + 
                                 '<div class="replyCount">' +
                                    '<img src="./image/reply.png" class="image" width="20px;" height="20px;">' +
                                    '<span>' + bbs.commentCount + '</span>' +
                                 '</div>' +
                                 '<div class="likeCount">' +
                                    '<img src="./image/unlike.png" class="image" width="20px;" height="20px;">' +
                                    '<span>' + bbs.likeCount + '</span>' +
                                 '</div>' +
                              '</div>' +
                            '</div>' +
                         '</div>' +
                         '</a>';
                         
            $(".bbs_body").append(showlist);
         });
         
      },
      error:function(){
         alert('error_main_refer_bbs');
      }
   });
});
function locations(address) {
   let arr = address.split(' ');
   return arr[0] + ' ' + arr[1];
}
function priceRange(sellSeq){
   let range = '';
   $.ajax({
      url:"getPriceRange.do",
      data:{seq:sellSeq},
      success:function(str){
         $('#priceRange'+sellSeq).html(str+'원/인');
      },
      error:function(){
         alert('error_getPriceRange');
      }
   })
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

<script type="text/javascript">
<!-- 팝업 모달 -->
function setCookie(name, value, expiredays){
   var today = new Date();

   console.log(today.getDate())

   today.setDate(today.getDate() + expiredays); // 현재시간에 하루를 더함 

   document.cookie = name + '=' + escape(value) + '; expires=' + today.toGMTString();

}
   
function getCookie(name) {

   var cookie = document.cookie;
   
   if (document.cookie != "") {
      var cookie_array = cookie.split("; ");
      console.log(cookie_array)
      for ( var index in cookie_array) {
         var cookie_name = cookie_array[index].split("=");
         if (cookie_name[0] == "mycookie") {
            return cookie_name[1];
         }
      }
   }
   return;
}

</script>

<!-- 팝업모달창 -->

 <script>
cookiedata = document.cookie;   
if ( cookiedata.indexOf("maindiv=done") < 0 ){     
 document.all['pop'].style.visibility = "visible";
 $('#popupBack').show(); 
 }
 else {
  document.all['pop'].style.visibility = "hidden";
  $('#popupBack').hide();
}
</script>
</body>
</html>