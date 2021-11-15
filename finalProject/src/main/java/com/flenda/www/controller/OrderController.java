package com.flenda.www.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flenda.www.dto.ActivityDto;
import com.flenda.www.dto.MemberDto;
import com.flenda.www.dto.Odr_SearchDto;
import com.flenda.www.dto.OrdersDto;
import com.flenda.www.dto.PicturesDto;
import com.flenda.www.dto.RefundDto;
import com.flenda.www.dto.ThemeDto;
import com.flenda.www.service.ActivityService;
import com.flenda.www.service.MainService;
import com.flenda.www.service.MemberService;
import com.flenda.www.service.OrderService;
import com.flenda.www.service.ThemeService;

@Controller
public class OrderController {
	
	@Autowired
	OrderService service;
	
	@Autowired
	ActivityService aService;
	
	@Autowired
	MainService mService;
	
	@Autowired
	MemberService memService;
	
	@Autowired
	ThemeService tService;
	
	//액티비티 결제페이지
		@RequestMapping(value = "pay.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String pay(int seq, String date, String[] items, int totalPrice, Model model, int totalCount) {
			System.out.println("OptionController deleteOption");
			String fileName = "";
			List<PicturesDto> pics = mService.getPictures();
			for( PicturesDto pic : pics) {
				if(pic.getSellSeq() == seq) {
					fileName = pic.getNewFileName();
					break;
				}
			}
			ActivityDto act = aService.getActivity(seq);	
			System.out.println("seq : " + seq);
			System.out.println("date : " + date);
			for(String itme : items) {
				System.out.println("item : " + itme);
			}
			System.out.println("totalPrice : " + totalPrice);
			System.out.println("totalCount : " + totalCount);
			
			model.addAttribute("fileName", fileName);
			model.addAttribute("act", act);
			model.addAttribute("date", date);
			model.addAttribute("items", items);
			model.addAttribute("totalPrice", totalPrice);
			model.addAttribute("totalCount", totalCount);
			return "pay.tiles";
		}
		
		//테마여행 결제페이지
		@RequestMapping(value = "themepay.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String themepay(int sellSeq, String date, String[] items, int totalPrice, Model model, int totalCount) {
			System.out.println("OrderController themepay");
			String fileName = "";
			List<PicturesDto> pics = mService.getPictures();
			for( PicturesDto pic : pics) {
				if(pic.getSellSeq() == sellSeq) {
					fileName = pic.getNewFileName();
					break;
				}
			}
			ThemeDto tm = tService.tmdetail(sellSeq);	
			System.out.println("themepay seq : " + sellSeq);
			System.out.println("tm:" + tm.toString());
			System.out.println("themepay date : " + date);
			for(String itme : items) {
				System.out.println("themepay item : " + itme);
			}
			System.out.println("totalPrice : " + totalPrice);
			System.out.println("totalCount : " + totalCount);
			
			model.addAttribute("sellSeq", sellSeq);
			model.addAttribute("fileName", fileName);
			model.addAttribute("tm", tm );
			model.addAttribute("date", date);
			model.addAttribute("items", items);
			model.addAttribute("totalPrice", totalPrice);
			model.addAttribute("totalCount", totalCount);
			return "themepay.tiles";
		}
		
		@ResponseBody
		@RequestMapping(value = "payAf.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String payAf(OrdersDto order, int usePoint, int sellSeq) {
			System.out.println("OptionController payAf");
			System.out.println(order.toString());
			order.setOrderSeq(sellSeq);
			System.out.println("사용포인트 : "+usePoint);
			//포인트 차감
			if(usePoint != 0) {
				memService.deductPoint(new MemberDto(order.getId(),usePoint));
			}
			//판매수증가
			aService.addSellCount(order);
			
			//테마결제 null값 셋팅
			if(order.getMeetplace() == null) {
				order.setMeetplace("-");
			}
			if(order.getCategory() == null) {
				order.setCategory("-");
			}
			System.out.println("셋팅후 : " + order.toString());
			String msg = service.addOrder(order);
			return msg;
		}
		
		@ResponseBody
		@RequestMapping(value = "paythemeAf.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String paythemeAf(OrdersDto order, int usePoint, int sellSeq) {
			System.out.println("OrderController paythemeAf");
			System.out.println(order.toString());
			order.setOrderSeq(sellSeq);
			//포인트 차감
			if(usePoint != 0) {
				memService.deductPoint(new MemberDto(order.getId(),usePoint));
			}
			
			String msg = service.addOrder(order);
			return msg;
		}
		
		//////////////////////////////////////////////////// ADMIN PAGE //////////////////////////////////////////////////////////////
		
		
		@RequestMapping(value = "orderHis.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String orderHis(Model model) {
			//결제 관리 및 환불 관리 버튼 2개 페이지로 이동(기본 시작은 결제 관리)
			model.addAttribute("top_menu","yes");
			return "orderHistory.tiles";
		}
		@RequestMapping(value = "payHistory.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String orderHistory(Model model) {
			//결제 관리 페이지로 이동
			model.addAttribute("top_menu","yes");
			
			return "payMain.tiles";
		}
		@RequestMapping(value = "refundHistory.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String refurnHistory(Model model, String seq) {
			//환불 관리 페이지로 이동
			//환불 관리 페이지로 오면서 결제 내역에서 환불 요청된 seq 번호 들고 옴
				System.out.println("refurnHistory seq : "+ seq);

					//seq가 있으면 환불 요청건이 있는 것이고 없으면 그냥 단순 페이지 이동
				if(seq!=null) {
					//getRefund xml 호출하기 위한 dto 생성 (para값이 dto임)
					RefundDto dto = new RefundDto(0, seq,"","","","","","","","","","","","");
					RefundDto refundDto = service.getRefund(dto);
					//값을 불러왔는데 값이 없으면 생성 기존에 잇으면 미생성 >> 결제 관리에서 같은 아이템으로 환불요청 2번 하기 방지용
					if(refundDto==null) {
						OrdersDto orderDto = service.getOrder(seq);
						service.addRefund(orderDto);
					}
				}
				model.addAttribute("top_menu","yes");
			return "refundMain.tiles";
		}

		@ResponseBody
		@RequestMapping(value = "payList.do", method = {RequestMethod.GET,RequestMethod.POST})
		public Map<String,Object> payList(Odr_SearchDto dto) {
			
			//스타트,엔드 데이트가 값이 없을 경우 all로 지정
			if(dto.getSdate().equals("") || dto.getSdate() == null) {
				dto.setSdate("all");
			}
			if(dto.getEdate().equals("") || dto.getEdate() == null) {
				dto.setEdate("all");
			}
			//2021-01-01 >> 20210101
			dto.setSdate(dto.getSdate().replace("-", ""));
			dto.setEdate(dto.getEdate().replace("-", ""));
			
			//Format 데이터 형식 지정  ex) yyyymmdd , yyyy:mm:dd .. 등등
			SimpleDateFormat day1 = new SimpleDateFormat ( "yyyyMMdd");
			//format 할 오늘의 날짜
			Date time = new Date();
			//오늘의 날짜를 yyyymmdd형식으로 바꿈
			String total = day1.format(time);
			
			System.out.println("time : "+total);
			System.out.println("셋팅전-"+dto.toString());
			// 기간 설정(오늘 어제 일주일 한달 클릭 시 ) 
			if(dto.getPeriod() !=null) {
				if(dto.getPeriod().equals("today")) {
					//오늘이면 sdate를 오늘로 설정
					dto.setSdate(total);
					dto.setEdate(total);
				}else if(dto.getPeriod().equals("yester")) {
					//어제면 오늘날짜를 정수화해서 하루 빼준 후 문자열화
					dto.setSdate(""+(Integer.parseInt(total)-1));
					dto.setEdate(""+(Integer.parseInt(total)-1));
				}else if(dto.getPeriod().equals("week")) {
					// 위와 형식 동일
					dto.setSdate(""+(Integer.parseInt(total)-7));
					dto.setEdate(total);
				}else if(dto.getPeriod().equals("month")) {
					// 위와 형식 동일
					dto.setSdate(""+(Integer.parseInt(total)-30));
					dto.setEdate(total);
				}
			}
			System.out.println("셋팅후-"+dto.toString());
			System.out.println();
			
			//페이지네이션
			int totalCount = service.getOrderPageCount(dto);
			System.out.println("totalCount : "+totalCount);
			System.out.println("dto : "+ dto);
			List<OrdersDto> list = service.getList(dto);
			System.out.println("list : " + list);

			Map<String,Object> map = new HashMap<>();
			map.put("list",list);
			map.put("count",totalCount);
			map.put("param",dto);
			
			return map;
		}
		
		@RequestMapping(value = "orderDetail.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String orderDetail(String seq, Model model) {
			// seq(orderNum)값으로 상세정보 데이터 삽입
			OrdersDto orderDto = service.getOrder(seq);
			MemberDto memberDto = memService.getInfo(orderDto.getId());
			System.out.println("odto : "+ orderDto);
			System.out.println("mdto : "+ memberDto);

			model.addAttribute("mDto", memberDto);
			model.addAttribute("dto", orderDto);
			return "orderDetail.tiles";
		}

		@ResponseBody
		@RequestMapping(value = "refundList.do", method = {RequestMethod.GET,RequestMethod.POST})
		public Map<String,Object> refundList(Odr_SearchDto dto) {
				System.out.println("refundList period : "+dto.getPeriod());
				
				//스타트,엔드 데이트가 값이 없을 경우 all로 지정
			if(dto.getSdate().equals("") || dto.getSdate() == null) {
				dto.setSdate("all");
			}
			if(dto.getEdate().equals("") || dto.getEdate() == null) {
				dto.setEdate("all");
			}
			
			dto.setSdate(dto.getSdate().replace("-", ""));
			dto.setEdate(dto.getEdate().replace("-", ""));
			
			System.out.println("dto : "+ dto);
			
			SimpleDateFormat day1 = new SimpleDateFormat ( "yyyyMMdd");
			Date time = new Date();
			String total = day1.format(time);
			
			if(dto.getPeriod() !=null) {
				if(dto.getPeriod().equals("today")) {
					dto.setSdate(total);
					dto.setEdate(total);
				}else if(dto.getPeriod().equals("yester")) {
					dto.setSdate(""+(Integer.parseInt(total)-1));
					dto.setEdate(""+(Integer.parseInt(total)-1));
				}else if(dto.getPeriod().equals("week")) {
					dto.setSdate(""+(Integer.parseInt(total)-7));
					dto.setEdate(total);
				}else if(dto.getPeriod().equals("month")) {
					dto.setSdate(""+(Integer.parseInt(total)-30));
					dto.setEdate(total);
				}
			}
			
			int totalCount = service.getRefundPageCount(dto);
			System.out.println("refund totalCount : "+totalCount);
			System.out.println("refund dto : "+ dto);
			List<RefundDto> list = service.refundList(dto);
			
			System.out.println("refund list : "+list);
			
			for(int i=0; i<list.size(); i++) {
				if(list.get(i).getReqDate().equals(list.get(i).getFinishDate())) {
					list.get(i).setFinishDate(" ");
				}
			}
			
			Map<String,Object> map = new HashMap<>();
			map.put("list",list);
			map.put("count",totalCount);
			map.put("param",dto);
			
			return map;
		}

		@ResponseBody
		@RequestMapping(value = "change.do", method = {RequestMethod.GET,RequestMethod.POST})
		public void refund(RefundDto dto,Model model) {
			System.out.println(" change dto : "+dto);
				//환불 관리에서 환불 신청 변경 시 db 변경
				service.conUpdate(dto);
				
				//만약 환불완료 했을 경우 환불완료시간 설정, 결제 관리에 해당 list 삭제
				if(dto.getCondition().equals("환불완료")) {
					service.updateFinishdate(dto);
					OrdersDto orderDto = service.getOrder(dto.getOrderNum());
					service.delOrder(orderDto);
				}
				
		}

		@RequestMapping(value = "refundDetail.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String refundDetail(RefundDto dto,Model model) throws Exception {
			model.addAttribute("top_menu","yes");
			// 환불 상세 보기 page
			
			//orderNum으로 환불dto 호출
			RefundDto refund = service.getRefund(dto);
			
			//System.out.println("REFUND rDTO: " + rDto);
			
			//
			OrdersDto order = service.getOrder(dto.getOrderNum());
			
			//오늘 날짜 부름
			Calendar getToday = Calendar.getInstance();
			getToday.setTime(new Date());//오늘 날짜
			
			//refund dto에 환불완료 일정 형식을 2021-01-01로 짜름
			String s_date = refund.getFinishDate().substring(0,11);
			//System.out.println("date : "+s_date);
			//System.out.println("getToday : "+getToday);
			
			//date 짜른 환불완료 일정을 date yyyy-mm-dd형식으로 변경 
			Date date = new SimpleDateFormat("yyyy-MM-dd").parse(s_date);
			
			// cmpDate 변수 calendar 생성( 오늘 날짜와 비교하기 위해 형식 맞추기)
			Calendar cmpDate = Calendar.getInstance();
			cmpDate.setTime(date);
			
			//System.out.println("cmpDate:"+cmpDate);
			
			//오늘 날짜와 환불완료 날짜를 Millis단위로 쪼개서 1000으로 나눔
			long diffSec = (getToday.getTimeInMillis() - cmpDate.getTimeInMillis()) / 1000;
			//나눈 값을 일 수로 지정 //(24)시간으로 나눔
			long diffDays = diffSec / (24*60*60); //일자수 차이

			//System.out.println("일 수 차이 : "+diffDays);
			//당일 취소 수수료 80% , 3일 전 취소 수수료 50% , 1주일 전 취소 수수료 20%
			//결제 금액
			int tMoney;
			//깍여야할 퍼센트
			double discount;
			//결제금액에서 깍아야할 값을 뺀 최종 환불금액
			double result;
			//깍아야할 값
			double bal;
			//7일차초과일 경우 ex) 1000 % 1000 해서 깍아야할 금액을 0원으로 만든다 1000-0 = 1000
			if(diffDays > 7 ) {
				//System.out.println("0%");
				tMoney = Integer.parseInt(refund.getRefundPrice());
				discount = 1;
				bal = tMoney%discount;
				result = tMoney - bal;
			//  6일,7일 일 경우 20%를 깍아야함 총 값에서 20%를 곱해서 급액을 뺌		
			}else if(diffDays == 6 || diffDays ==7) {
				//System.out.println("20%");
				tMoney = Integer.parseInt(refund.getRefundPrice());
				discount = 0.2;
				bal = tMoney*discount;
				result = tMoney - bal;

			}else if(diffDays == 3 || diffDays== 4 || diffDays== 5) {
				//System.out.println("50%");
				tMoney = Integer.parseInt(refund.getRefundPrice());
				discount = 0.5;
				bal = tMoney*discount;
				result = tMoney - bal;

			}else if(diffDays == 1 || diffDays ==2) {
				//System.out.println("80%");
				tMoney = Integer.parseInt(refund.getRefundPrice());
				discount = 0.8;
				bal = tMoney*discount;
				result = tMoney - bal;

			}else {
				//System.out.println("환불 불가");
				tMoney = Integer.parseInt(refund.getRefundPrice());
				discount = tMoney;
				bal = tMoney;
				result = tMoney - bal;

			}

				//System.out.println("refund before : "+refund);
			
				//refund dto에 총 값과 빼야할 수수료를 담고 db에 담는다.
				refund.setBalance(""+Math.round(bal));
				refund.setRefundPay(""+Math.round(result));
				//System.out.println("refund after : "+refund);
				service.updateBal(refund);
				service.updatePay(refund);
				
				//담고 부른 최종 refund값
				RefundDto refundAfter = service.getRefund(dto);
				//System.out.println("refundAfter : " +refundAfter);
				//System.out.println("order : "+order);
				//System.out.println("result : " +Math.round(result));
				
			model.addAttribute("order", order);
			model.addAttribute("result", Math.round(result));
			model.addAttribute("refundAfter", refundAfter);
			
			//상태가 환불 완료일 때 경로 바끔
			if(dto.getCondition().equals("환불완료"))
				return "completeRefund.tiles";
			else {
				
				return "refunding.tiles";
			}
		}
								//success 준말
		@RequestMapping(value = "refundSuc.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String refundSuc(RefundDto dto,Model model) {
			//상세보기에서 환불신청을 누른 경우!
			
			//환불 완료 했을 경우 상태를 환불 완료로 지정
			dto.setCondition("환불완료");
			
			System.out.println("refundSuccess dto : "+ dto);
			//환불 사유와 환불 완료 기간을 db에 담아준다
			service.updateRsn(dto);
			service.conUpdate(dto);
			OrdersDto orderDto = service.getOrder(dto.getOrderNum());
			service.delOrder(orderDto);
			
			
			model.addAttribute("top_menu","yes");
			return "refundMain.tiles";
		}
		
		@ResponseBody
		@RequestMapping(value = "delRefund.do", method = {RequestMethod.GET,RequestMethod.POST})
		public void delRefund(RefundDto dto) {
				System.out.println("delRefund dto : "+ dto);
				//환불 삭제
				service.delRefund(dto);

		}
		@ResponseBody
		@RequestMapping(value = "delOrder.do", method = {RequestMethod.GET,RequestMethod.POST})
		public void delOrder(OrdersDto dto) {
				System.out.println("delRefund dto : "+ dto);
				//결제 삭제
				service.delOrder(dto);		
		}		
}
