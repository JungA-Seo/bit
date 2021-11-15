package com.flenda.www.controller;

import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flenda.www.dto.MemberDto;
import com.flenda.www.dto.Odr_SearchDto;
import com.flenda.www.dto.OrdersDto;
import com.flenda.www.dto.VisitDto;
import com.flenda.www.service.MainService;

@Controller
public class MainController {

	@Autowired
	MainService service;
	
	@RequestMapping(value = "main.do", method = RequestMethod.GET)
	public String main(Model model,HttpServletRequest req,HttpServletResponse rsp, HttpSession hs) throws Exception {
		System.out.println("MainController main");

		//오늘 날짜 지정
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		Date time = new Date();
		String today = format.format(time);
		System.out.println("오늘날짜 : "+today);

		//ip address 가져오기
		String ipAddress=req.getRemoteAddr();
		if(ipAddress.equalsIgnoreCase("0:0:0:0:0:0:0:1")){
		    InetAddress inetAddress= InetAddress.getLocalHost();
		    ipAddress=inetAddress.getHostAddress();
		}

		System.out.println("클라이언트IP 주소: "+ipAddress);
		//쿠키 생성
		Cookie[] cookies = req.getCookies();

		if(cookies.length == 1) { //쿠키값이 없을 경우 즉, 처음 접속했을 경우
			
			VisitDto visitDto = new VisitDto(today,ipAddress,"new");

			//ipcheck :  db에 ip 값이 없을 때 ip insert
			if(service.getCount(visitDto)==0) {
				System.out.println(ipAddress+" : 저장 성공");
				service.addIp(visitDto);
				//신규에 대한 데이터 삽입
			}

			//쿠키값 입력
			Cookie c = new Cookie("memberIp",ipAddress);
			c.setMaxAge(60*60*24*30); // 쿠키 기간 30일 , 즉 30일동안 기존 접속자로 인식

			rsp.addCookie(c);
			
		}else { // 쿠키값이 있을 경우, 즉 접속 이력이 있을 경우
				if(cookies.length == 2) { // 비로그인이고 기존 방문자일 경우
					VisitDto visitDto = new VisitDto(today,ipAddress,"old");
					System.out.println("비로그인 기존 방문자 접속");
					//ipcheck :  db에 ip 값이 없을 때 ip insert
					if(service.getCount(visitDto)==0) {
						System.out.println(ipAddress+" : 저장 성공");
						service.addIp(visitDto);
						//신규에 대한 데이터 삽입
					}
				}else if(cookies.length == 3) {//로그인이고 기존 방문자
					VisitDto visitDto = new VisitDto(today,ipAddress,"mem");
					System.out.println("로그인 후 기존 방문자 접속");
					//ipcheck :  db에 ip 값이 없을 때 ip insert
					if(service.getCount(visitDto)==0) {
						System.out.println(ipAddress+" : 저장 성공");
						service.addIp(visitDto);
						//신규에 대한 데이터 삽입
					}else {
						service.updateIp(visitDto);
						System.out.println("업데이트 성공");
					}
				}
		}
		//회원가입 시 세션으로 저장했던 아이디 값 호출
		MemberDto mDto = (MemberDto)hs.getAttribute("login");
		// 기존 방문 이력이 있고, 로그인 시 memberId 쿠키를 만듬으로 쿠키 길이 3으로 변경
		if(cookies.length == 2 && mDto != null) {
			Cookie c = new Cookie("memberId",mDto.getId());
			c.setMaxAge(60*60*24*30); // 쿠키 기간 30일 , 즉 30일동안 기존 접속자로 인식

			rsp.addCookie(c);
		}
		
		model.addAttribute("top_menu", "yes");
		return "main.tiles";
	}
	
	// 관리자 home 화면
	@RequestMapping(value = "management.do", method = RequestMethod.GET)
	public String management(Model model) {
		System.out.println("MainController management");
		model.addAttribute("top_menu", "no");
		int todayVisitCount = service.todayVisitCount();
		int todayRegiCount = service.todayRegiCount();
		int todaySales = service.todaySales();
		int todayWriteCount = service.todayWriteCount();
		int memberMale = service.getMemberMale();
		int memberFemale = service.getMemberFemale();
		System.out.println("todaySales : "+ todaySales);
		
		model.addAttribute("mm", memberMale); 
		model.addAttribute("mf", memberFemale); 
		model.addAttribute("twc", todayWriteCount); 
		model.addAttribute("ts", todaySales);
		model.addAttribute("trc", todayRegiCount);
		model.addAttribute("tvc", todayVisitCount);
		return "management.tiles";
	}
	// 관리자페이지 home 1년 매출(월단위) 통계
	@ResponseBody
	@RequestMapping(value = "homeSales.do", method = RequestMethod.GET)
	public List<OrdersDto> homeSales(Model model) {
		List<OrdersDto> list = service.getYearSales();

		return list;
	}
	
	// 사용자페이지 고객지원 개인정보영역
	@RequestMapping(value = "useterms.do", method = RequestMethod.GET)
	public String useterms(Model model) {
		System.out.println("useterms management");
		model.addAttribute("top_menu", "yes");
		return "useterms.tiles";
	}
	
	@RequestMapping(value = "privacyPol.do", method = RequestMethod.GET)
	public String privacyPol(Model model) {
		System.out.println("useterms management");
		model.addAttribute("top_menu", "yes");
		return "privacyPol.tiles";
	}
	
	@RequestMapping(value = "locationbase.do", method = RequestMethod.GET)
	public String locationbase(Model model) {
		System.out.println("useterms management");
		model.addAttribute("top_menu", "yes");
		return "locationbase.tiles";
	}
	
	
	//관리자페이지 통계 탑메뉴 3가지
	@RequestMapping(value = "statisic.do", method = RequestMethod.GET)
	public String statisic(Model model)  {
		model.addAttribute("top_menu","yes");
		return "statisic.tiles";
	}
	
	//관리자페이지 매출 통계로 이동
	@RequestMapping(value = "salesMain.do", method = RequestMethod.GET)
	public String salesMain(Model model) {
		model.addAttribute("top_menu","yes");
		return "salesMain.tiles";
	}
	
	//관리자페이지 방문자 통계로 이동
	@RequestMapping(value = "memberMain.do", method = RequestMethod.GET)
	public String memberMain(Model model) {
		model.addAttribute("top_menu","yes");
		return "memberMain.tiles";
	}
	
	//관리자페이지 신규가입자 통계로 이동
	@RequestMapping(value = "newMemberMain.do", method = RequestMethod.GET)
	public String newMemberMain(Model model) {
		model.addAttribute("top_menu","yes");
		return "newMemberMain.tiles";
	}
	
	
	//관리자페이지 통계-매출검색
	@ResponseBody
	@RequestMapping(value = "selectSales.do", method = RequestMethod.GET)
	public List<OrdersDto> selectSales(Model model,Odr_SearchDto dto)throws Exception {
		
		List<OrdersDto> tmp = new ArrayList<>();

		// 기간별 통계
		if(dto.getSdate()!=null && dto.getEdate()!=null) {
			//들어오는 값을 2021-01-01 > 20210101로 reform
			System.out.println("기간별 통계");
			String sForm = dto.getSdate().replace("-","");
			dto.setSdate(sForm);
			String eForm = dto.getEdate().replace("-","");
			dto.setEdate(eForm);

			tmp = service.getSelectSales(dto);
			for(OrdersDto list : tmp) {
				System.out.println("money : "+list.getMoney());
			}

		}
		
		// 주간 통계
		if(dto.getPeriod().equals("week") && dto.getSdate().equals("") && dto.getEdate().equals("")) {
			tmp = service.getWeekSales();
		}
				
		// 월별 통계
		if(dto.getPeriod().equals("month") && dto.getSdate().equals("") && dto.getEdate().equals("")) {
			tmp = service.getMonthSales();		
		}
		
		// 연별 통계
		if(dto.getPeriod().equals("year") && dto.getSdate().equals("") && dto.getEdate().equals("")) {
			tmp = service.getYearSalesStatisic();		
		}
		
		return tmp;
		
	}
	
	//관리자페이지 통계-방문자검색
	@ResponseBody
	@RequestMapping(value = "memberVisit.do", method = RequestMethod.GET)
	public Map<String,Object> memberVisit(Model model,Odr_SearchDto dto)throws Exception {
		
		 Map<String,Object> tmp = new HashMap<>();
		
		// 기간별 통계
		if(dto.getSdate()!=null && dto.getEdate()!=null) {
			//들어오는 값을 2021-01-01 > 20210101로 reform
			System.out.println("기간별 통계");
			String sForm = dto.getSdate().replace("-","");
			dto.setSdate(sForm);
			String eForm = dto.getEdate().replace("-","");
			dto.setEdate(eForm);
			
			tmp = service.getSelectVisit(dto);

		}
		// 주간 통계
		if(dto.getPeriod().equals("week") && dto.getSdate().equals("") && dto.getEdate().equals("")) {
			tmp = service.getWeekVisit();
		}
				
				// 월별 통계
		if(dto.getPeriod().equals("month") && dto.getSdate().equals("") && dto.getEdate().equals("")) {
			tmp = service.getMonthVisit();	
		}
		
		// 연별 통계
		if(dto.getPeriod().equals("year") && dto.getSdate().equals("") && dto.getEdate().equals("")) {
			tmp = service.getYearVisit();	
		}
		
		return tmp;
	}
	
	//관리자페이지 통계-신규가입자검색
	@ResponseBody
	@RequestMapping(value = "newRegiCount.do", method = RequestMethod.GET)
	public Map<String,Object> newRegiCount(Model model,Odr_SearchDto dto)throws Exception {
		
		Map<String,Object> tmp = new HashMap<>();

		// 기간별 통계
		if(dto.getSdate()!=null && dto.getEdate()!=null) {
			//들어오는 값을 2021-01-01 > 20210101로 reform
			System.out.println("기간별 통계");
			String sForm = dto.getSdate().replace("-","");
			dto.setSdate(sForm);
			String eForm = dto.getEdate().replace("-","");
			dto.setEdate(eForm);

			tmp = service.getSelectRegi(dto);
		}
		
		// 주간 통계
		if(dto.getPeriod().equals("week") && dto.getSdate().equals("") && dto.getEdate().equals("")) {
			tmp = service.getWeekRegi();
		}
				
		// 월별 통계
		if(dto.getPeriod().equals("month") && dto.getSdate().equals("") && dto.getEdate().equals("")) {
			tmp = service.getMonthRegi();	
		}
		
		// 연별 통계
		if(dto.getPeriod().equals("year") && dto.getSdate().equals("") && dto.getEdate().equals("")) {
			tmp = service.getYearRegi();	
		}
		return tmp;	
	}
}
