package com.flenda.www.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flenda.www.dao.MainDao;
import com.flenda.www.dto.Odr_SearchDto;
import com.flenda.www.dto.OrdersDto;
import com.flenda.www.dto.PicturesDto;
import com.flenda.www.dto.VisitDto;

@Service
public class MainService {

	@Autowired
	MainDao dao;
	
	public String addPictures(PicturesDto pic) {
		return dao.addPictures(pic)>0?"success":"fail";
	}
	
	public String updatePictures(PicturesDto pic) {
		return dao.updatePictures(pic)>0?"success":"fail";
	}
	
	public String deletePic(int seq) {
		return dao.deletePic(seq)>0?"success":"fail";
	}
	
	public int countPics(int seq) {
		return dao.countPics(seq);
	}
	public List<PicturesDto> getPictures(){
		return dao.getPictures();
	}
	
	public List<PicturesDto> getPic(int seq){
		return dao.getPic(seq);
	}
	
	public boolean addIp(VisitDto dto) {
		return dao.addIp(dto); 
	}
	
	public int getCount(VisitDto dto) {
		return dao.getCount(dto);
	}
	
	public boolean delIp(VisitDto dto) {
		return dao.delIp(dto);
	}

	public boolean updateIp(VisitDto dto) {
		return dao.updateIp(dto);
	}
	
	public int todayVisitCount() {
		return dao.todayVisitCount();
	
	}
	
	public int todayRegiCount() {
		return dao.todayRegiCount();
	}
	
	public int todaySales() {
		return dao.todaySales();
	}
	
	public int todayWriteCount() {
		return dao.todayWriteCount();
	}
	
	public int getMemberMale() {
		return dao.getMemberMale();
	}
	
	public int getMemberFemale() {
		return dao.getMemberFemale();
	}
	// Home 통계
	public List<OrdersDto> getYearSales(){
        List<OrdersDto> newList = new ArrayList<OrdersDto>();
        List<OrdersDto> originalList = dao.getYearSales();
        for(int i=1; i<=12; i++) {
           OrdersDto tmp = null;
           String date = "2021" + nvl(""+i);
           for(OrdersDto x : originalList) {
              if(date.equals(x.getMoneyDate())) {
                 tmp = new OrdersDto(x.getMoney(),x.getMoneyDate());
              }
           }
           if(tmp == null) {
              tmp = new OrdersDto("0",date);
           }
           newList.add(tmp);
        }
        return newList;
     }
	
	public String nvl(String seq) {
		return seq.length()==1?"0"+seq:seq;
	}

	
//////////////////////////////////////////기간별 매출//////////////////////////////////////////////////////////////	
	public List<OrdersDto> getSelectSales(Odr_SearchDto dto)throws Exception{
		//비어있는 리스트 생성
        List<OrdersDto> newList = new ArrayList<OrdersDto>();
		//데이터피커에 값이 있을 경우
        if(!dto.getSdate().equals("") && !dto.getEdate().equals("")) {
			
			//20210105 > 2021-01-05 로 변환
			String startDate1 = dto.getSdate().substring(0,4);
			String startDate2 = dto.getSdate().substring(4,6);
			String startDate3 = dto.getSdate().substring(6,8);
			String totalStartDate = startDate1+"-"+startDate2+"-"+startDate3;
			
			String endDate1 = dto.getEdate().substring(0,4);
			String endDate2 = dto.getEdate().substring(4,6);
			String endDate3 = dto.getEdate().substring(6,8);
			String totalEndDate = endDate1+"-"+endDate2+"-"+endDate3;
			
			//변환한 데이터를 Date화 한다.
			Date sdate = new SimpleDateFormat("yyyy-MM-dd").parse(totalStartDate);
			Date edate = new SimpleDateFormat("yyyy-MM-dd").parse(totalEndDate);
			
			//Date화한 날짜를 Calendar화
			Calendar startDate = Calendar.getInstance();
			startDate.setTime(sdate);
			Calendar endDate = Calendar.getInstance();
			endDate.setTime(edate);

			//System.out.println("cmpDate:"+cmpDate);
			
			//오늘 날짜와 환불완료 날짜를 Millis단위로 쪼개서 1000으로 나눔
			long diffSec = (endDate.getTimeInMillis() - startDate.getTimeInMillis()) / 1000;
			//나눈 값을 일 수로 지정 //(24)시간으로 나눔
			long diffDays = diffSec / (24*60*60); //일자수 차이
			
			// ex) 15일 차이면 14일이 되므로 1일 추가
			diffDays = diffDays+1;
//			System.out.println("getSelectSales 일 수 차이 : "+diffDays);
				
//			System.out.println("getSelectSales sdate : "+dto.getSdate());
//			System.out.println("getSelectSales edate : "+dto.getEdate());
			
			//db값 호출
			List<OrdersDto> originalList = dao.getSelectSales(dto);
			
			//sdate 와 edate의 차일을 조건문으로 돌린다.
			for(int i=1; i<=diffDays; i++) {
				// 빈 객체 생성
				OrdersDto tmp = null;
				// db값을 담은 데이터 루프
				for(OrdersDto list : originalList) {
					
					//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
					//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
					//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
					//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - startDate.getTimeInMillis()) / 1000;
					//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+1;
					
					if(i == Days) {
						// n일차에 값이 있음
						tmp = new OrdersDto(list.getMoney(),totalStartDate);
					}
				}
				if(tmp == null) {
					//n일차에 값이 없음
					tmp = new OrdersDto("0",totalStartDate);
				}	
				newList.add(tmp);
			}
		}
        return newList;
	}
	
//////////////////////////////////////////주간별 매출//////////////////////////////////////////////////////////////	
	
	public List<OrdersDto> getWeekSales() throws Exception{
        //db값 호출
		List<OrdersDto> originalList = dao.getWeekSales();
        //빈 리스트 생성
		List<OrdersDto> newList = new ArrayList<OrdersDto>();
        	
        //오늘 날짜 구하기
        	Date lastDay = new Date();
//        	System.out.println("getWeekSales lastDay : "+lastDay);
        	SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
//        	System.out.println("getWeekSales today : "+today );
        	form.format(lastDay);
        //오늘 날짜 Calendar 형식으로 변경
        	Calendar today = Calendar.getInstance();
        	today.setTime(lastDay);
//        	System.out.println("getWeekSales cForm : "+cForm );
        	
        //오늘로 부터 1주일 전 날짜 뽑기	
        	Calendar week = Calendar.getInstance();
            week.add(Calendar.DATE , -6);
        //시작일을 설정하기 위해 String화함
            String startDate = new SimpleDateFormat("yyyy-MM-dd").format(week.getTime());
            
//          System.out.println("일주일전 날짜 : "+startDate);
            
        //1주일 전 날짜와 오늘 날짜 차이 값 뽑기.
            long dif = (today.getTimeInMillis() - week.getTimeInMillis()) / 1000;
            long Day = dif / (24*60*60);
            Day = Day+1;
//          System.out.println("일주일 차이 : "+Days);
            
            //차일로 루프
            for(int i=1; i<=Day; i++) {
            	OrdersDto tmp = null;
            	for(OrdersDto list : originalList) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;
					//값이 같을 경우
					if(i==Days) {
						tmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	//값이 없을 경우
            	if(tmp==null) {
            		tmp = new OrdersDto("0",startDate);
            	}
            	newList.add(tmp);
            }
        	return newList;	
	}
	
//////////////////////////////////////////달 간 매출//////////////////////////////////////////////////////////////
	
	public List<OrdersDto> getMonthSales() throws Exception{
        
		List<OrdersDto> originalList = dao.getMonthSales();
        List<OrdersDto> newList = new ArrayList<OrdersDto>();
        	
        //오늘 날짜 구하기
        	Date lastDay = new Date();
//        	System.out.println("getWeekSales lastDay : "+lastDay);
        	SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
//        	System.out.println("getWeekSales today : "+today );
        	form.format(lastDay);
        //오늘 날짜 Calendar 형식으로 변경
        	Calendar today = Calendar.getInstance();
        	today.setTime(lastDay);
//        	System.out.println("getWeekSales cForm : "+cForm );
        	
        //오늘로 부터 한달 전 날짜 뽑기	
        	Calendar month = Calendar.getInstance();
        	month.add(Calendar.MONTH , -1);
        //시작일을 설정하기 위해 String화함
            String startDate = new SimpleDateFormat("yyyy-MM-dd").format(month.getTime());
            
//          System.out.println("한달전 날짜 : "+startDate);
            
        //1주일 전 날짜와 오늘 날짜 차이 값 뽑기.
            long dif = (today.getTimeInMillis() - month.getTimeInMillis()) / 1000;
            long Day = dif / (24*60*60);
            Day = Day+1;
//          System.out.println("한달 차이 : "+Days);
            
            for(int i=1; i<=Day; i++) {
            	OrdersDto tmp = null;
            	for(OrdersDto list : originalList) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - month.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						tmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(tmp==null) {
            		tmp = new OrdersDto("0",startDate);
            	}
            	newList.add(tmp);
            }
        	return newList;	
	}
	
//////////////////////////////////////////년도별 매출//////////////////////////////////////////////////////////////
	
	public List<OrdersDto> getYearSalesStatisic() throws Exception{
        
		List<OrdersDto> originalList = dao.getYearSalesStatisic();
        List<OrdersDto> newList = new ArrayList<OrdersDto>();
        	
        //오늘 날짜 구하기
        	Date lastDay = new Date();
//        	System.out.println("getWeekSales lastDay : "+lastDay);
        	SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
//        	System.out.println("getWeekSales today : "+today );
        	form.format(lastDay);
        //오늘 날짜 Calendar 형식으로 변경
        	Calendar today = Calendar.getInstance();
        	today.setTime(lastDay);
//        	System.out.println("getWeekSales cForm : "+cForm );
        	
        //오늘로 부터 한달 전 날짜 뽑기	
        	Calendar month = Calendar.getInstance();
        	month.add(Calendar.YEAR , -1);
        //시작일을 설정하기 위해 String화함
            String startDate = new SimpleDateFormat("yyyy-MM-dd").format(month.getTime());
            
//          System.out.println("한달전 날짜 : "+startDate);
            
        //1주일 전 날짜와 오늘 날짜 차이 값 뽑기.
            long dif = (today.getTimeInMillis() - month.getTimeInMillis()) / 1000;
            long Day = dif / (24*60*60);
            Day = Day+1;
//          System.out.println("한달 차이 : "+Days);
            
            for(int i=1; i<=Day; i++) {
            	OrdersDto tmp = null;
            	for(OrdersDto list : originalList) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - month.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						tmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(tmp==null) {
            		tmp = new OrdersDto("0",startDate);
            	}
            	newList.add(tmp);
            }
        	return newList;	
	}
	
//////////////////////////////////////////기간별 방문자//////////////////////////////////////////////////////////////	
	
	public Map<String,Object> getSelectVisit(Odr_SearchDto dto)throws Exception{

        List<OrdersDto> newList = new ArrayList<OrdersDto>();
        List<OrdersDto> oldList = new ArrayList<OrdersDto>();
        List<OrdersDto> memList = new ArrayList<OrdersDto>();
		if(!dto.getSdate().equals("") && !dto.getEdate().equals("")) {
			
			//20210105 > 2021-01-05 로 변환
			String startDate1 = dto.getSdate().substring(0,4);
			String startDate2 = dto.getSdate().substring(4,6);
			String startDate3 = dto.getSdate().substring(6,8);
			String totalStartDate = startDate1+"-"+startDate2+"-"+startDate3;
			
			String endDate1 = dto.getEdate().substring(0,4);
			String endDate2 = dto.getEdate().substring(4,6);
			String endDate3 = dto.getEdate().substring(6,8);
			String totalEndDate = endDate1+"-"+endDate2+"-"+endDate3;
			
			//변환한 데이터를 Date화 한다.
			Date sdate = new SimpleDateFormat("yyyy-MM-dd").parse(totalStartDate);
			Date edate = new SimpleDateFormat("yyyy-MM-dd").parse(totalEndDate);
			
			//Date화한 날짜를 Calendar화
			Calendar startDate = Calendar.getInstance();
			startDate.setTime(sdate);
			Calendar endDate = Calendar.getInstance();
			endDate.setTime(edate);

			//System.out.println("cmpDate:"+cmpDate);
			
			//오늘 날짜와 환불완료 날짜를 Millis단위로 쪼개서 1000으로 나눔
			long diffSec = (endDate.getTimeInMillis() - startDate.getTimeInMillis()) / 1000;
			//나눈 값을 일 수로 지정 //(24)시간으로 나눔
			long diffDays = diffSec / (24*60*60); //일자수 차이
			
			// ex) 15일 차이면 14일이 되므로 1일 추가
			diffDays = diffDays+1;
			System.out.println("getSelectSales 일 수 차이 : "+diffDays);
				
			System.out.println("getSelectSales sdate : "+dto.getSdate());
			System.out.println("getSelectSales edate : "+dto.getEdate());
			
			dto.setStatus("new");
			List<OrdersDto> nList1 = dao.getSelectVisit(dto);
			dto.setStatus("old");
			List<OrdersDto> oList1 = dao.getSelectVisit(dto);
			dto.setStatus("mem");
			List<OrdersDto> mList1 = dao.getSelectVisit(dto);
			
			for(int i=1; i<=diffDays; i++) {
				OrdersDto nTmp = null;
				OrdersDto oTmp = null;
				OrdersDto mTmp = null;
				for(OrdersDto list : nList1) {
					
					//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
					//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
					//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
					//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - startDate.getTimeInMillis()) / 1000;
					//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+1;
					
					if(i == Days) {
						// n일차에 값이 있음
						nTmp = new OrdersDto(list.getMoney(),totalStartDate);
					}
				}
				if(nTmp == null) {
					//n일차에 값이 없음
					nTmp = new OrdersDto("0",totalStartDate);
				}	
				newList.add(nTmp);
				
				///////
				for(OrdersDto list : oList1) {
					
					//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
					//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
					//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
					//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - startDate.getTimeInMillis()) / 1000;
					//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+1;
					
					if(i == Days) {
						// n일차에 값이 있음
						oTmp = new OrdersDto(list.getMoney(),totalStartDate);
					}
				}
				if(oTmp == null) {
					//n일차에 값이 없음
					oTmp = new OrdersDto("0",totalStartDate);
				}	
				oldList.add(oTmp);
				/////
				for(OrdersDto list : mList1) {
					
					//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
					//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
					//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
					//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - startDate.getTimeInMillis()) / 1000;
					//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+1;
					
					if(i == Days) {
						// n일차에 값이 있음
						mTmp = new OrdersDto(list.getMoney(),totalStartDate);
					}
				}
				if(mTmp == null) {
					//n일차에 값이 없음
					mTmp = new OrdersDto("0",totalStartDate);
				}	
				memList.add(mTmp);
				
				
			}
		}
		Map<String,Object> map = new HashMap<>();
		map.put("oldList", oldList);
		map.put("newList", newList);
		map.put("memList", memList);
        return map;
	}	
	
//////////////////////////////////////////주간별 방문자//////////////////////////////////////////////////////////////		
	
	public Map<String,Object> getWeekVisit() throws Exception{

        List<OrdersDto> newList = new ArrayList<OrdersDto>();
        List<OrdersDto> oldList = new ArrayList<OrdersDto>();
        List<OrdersDto> memList = new ArrayList<OrdersDto>();
        
		List<OrdersDto> nList1 = dao.getWeekVisit("new");
		List<OrdersDto> oList1 = dao.getWeekVisit("old");
		List<OrdersDto> mList1 = dao.getWeekVisit("mem");
        	
        //오늘 날짜 구하기
        	Date lastDay = new Date();
//        	System.out.println("getWeekSales lastDay : "+lastDay);
        	SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
//        	System.out.println("getWeekSales today : "+today );
        	form.format(lastDay);
        //오늘 날짜 Calendar 형식으로 변경
        	Calendar today = Calendar.getInstance();
        	today.setTime(lastDay);
//        	System.out.println("getWeekSales cForm : "+cForm );
        	
        //오늘로 부터 1주일 전 날짜 뽑기	
        	Calendar week = Calendar.getInstance();
            week.add(Calendar.DATE , -6);
        //시작일을 설정하기 위해 String화함
            String startDate = new SimpleDateFormat("yyyy-MM-dd").format(week.getTime());
            
//          System.out.println("일주일전 날짜 : "+startDate);
            
        //1주일 전 날짜와 오늘 날짜 차이 값 뽑기.
            long dif = (today.getTimeInMillis() - week.getTimeInMillis()) / 1000;
            long Day = dif / (24*60*60);
            Day = Day+1;
//          System.out.println("일주일 차이 : "+Days);
            
            for(int i=1; i<=Day; i++) {
				OrdersDto nTmp = null;
				OrdersDto oTmp = null;
				OrdersDto mTmp = null;
				
            	for(OrdersDto list : nList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						nTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(nTmp==null) {
            		nTmp = new OrdersDto("0",startDate);
            	}
            	newList.add(nTmp);
            	
            	
            	for(OrdersDto list : oList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						oTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(oTmp==null) {
            		oTmp = new OrdersDto("0",startDate);
            	}
            	oldList.add(oTmp);
            	
            	
            	for(OrdersDto list : mList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						mTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(mTmp==null) {
            		mTmp = new OrdersDto("0",startDate);
            	}
            	memList.add(mTmp);

            }
    		Map<String,Object> map = new HashMap<>();
    		map.put("oldList", oldList);
    		map.put("newList", newList);
    		map.put("memList", memList);
    		
    		return map;
	}
	
//////////////////////////////////////////한달 방문자//////////////////////////////////////////////////////////////	
	
	public Map<String,Object> getMonthVisit() throws Exception{

        List<OrdersDto> newList = new ArrayList<OrdersDto>();
        List<OrdersDto> oldList = new ArrayList<OrdersDto>();
        List<OrdersDto> memList = new ArrayList<OrdersDto>();
        
		List<OrdersDto> nList1 = dao.getMonthVisit("new");
		List<OrdersDto> oList1 = dao.getMonthVisit("old");
		List<OrdersDto> mList1 = dao.getMonthVisit("mem");
        	
        //오늘 날짜 구하기
        	Date lastDay = new Date();
//        	System.out.println("getWeekSales lastDay : "+lastDay);
        	SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
//        	System.out.println("getWeekSales today : "+today );
        	form.format(lastDay);
        //오늘 날짜 Calendar 형식으로 변경
        	Calendar today = Calendar.getInstance();
        	today.setTime(lastDay);
//        	System.out.println("getWeekSales cForm : "+cForm );
        	
        //오늘로 부터 1주일 전 날짜 뽑기	
        	Calendar week = Calendar.getInstance();
            week.add(Calendar.MONTH , -1);
        //시작일을 설정하기 위해 String화함
            String startDate = new SimpleDateFormat("yyyy-MM-dd").format(week.getTime());
            
//          System.out.println("일주일전 날짜 : "+startDate);
            
        //1주일 전 날짜와 오늘 날짜 차이 값 뽑기.
            long dif = (today.getTimeInMillis() - week.getTimeInMillis()) / 1000;
            long Day = dif / (24*60*60);
            Day = Day+1;
//          System.out.println("일주일 차이 : "+Days);
            
            for(int i=1; i<=Day; i++) {
				OrdersDto nTmp = null;
				OrdersDto oTmp = null;
				OrdersDto mTmp = null;
				
            	for(OrdersDto list : nList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						nTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(nTmp==null) {
            		nTmp = new OrdersDto("0",startDate);
            	}
            	newList.add(nTmp);
            	
            	
            	for(OrdersDto list : oList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						oTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(oTmp==null) {
            		oTmp = new OrdersDto("0",startDate);
            	}
            	oldList.add(oTmp);
            	
            	
            	for(OrdersDto list : mList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						mTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(mTmp==null) {
            		mTmp = new OrdersDto("0",startDate);
            	}
            	memList.add(mTmp);

            }
    		Map<String,Object> map = new HashMap<>();
    		map.put("oldList", oldList);
    		map.put("newList", newList);
    		map.put("memList", memList);
    		
    		return map;
	}
	
//////////////////////////////////////////연간 방문자//////////////////////////////////////////////////////////////		
	
	public Map<String,Object> getYearVisit() throws Exception{

        List<OrdersDto> newList = new ArrayList<OrdersDto>();
        List<OrdersDto> oldList = new ArrayList<OrdersDto>();
        List<OrdersDto> memList = new ArrayList<OrdersDto>();
        
		List<OrdersDto> nList1 = dao.getYearVisit("new");
		List<OrdersDto> oList1 = dao.getYearVisit("old");
		List<OrdersDto> mList1 = dao.getYearVisit("mem");
        	
        //오늘 날짜 구하기
        	Date lastDay = new Date();
//        	System.out.println("getWeekSales lastDay : "+lastDay);
        	SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
//        	System.out.println("getWeekSales today : "+today );
        	form.format(lastDay);
        //오늘 날짜 Calendar 형식으로 변경
        	Calendar today = Calendar.getInstance();
        	today.setTime(lastDay);
//        	System.out.println("getWeekSales cForm : "+cForm );
        	
        //오늘로 부터 1주일 전 날짜 뽑기	
        	Calendar week = Calendar.getInstance();
            week.add(Calendar.YEAR , -1);
        //시작일을 설정하기 위해 String화함
            String startDate = new SimpleDateFormat("yyyy-MM-dd").format(week.getTime());
            
//          System.out.println("일주일전 날짜 : "+startDate);
            
        //1주일 전 날짜와 오늘 날짜 차이 값 뽑기.
            long dif = (today.getTimeInMillis() - week.getTimeInMillis()) / 1000;
            long Day = dif / (24*60*60);
            Day = Day+1;
//          System.out.println("일주일 차이 : "+Days);
            
            for(int i=1; i<=Day; i++) {
				OrdersDto nTmp = null;
				OrdersDto oTmp = null;
				OrdersDto mTmp = null;
				
            	for(OrdersDto list : nList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						nTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(nTmp==null) {
            		nTmp = new OrdersDto("0",startDate);
            	}
            	newList.add(nTmp);
            	
            	
            	for(OrdersDto list : oList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						oTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(oTmp==null) {
            		oTmp = new OrdersDto("0",startDate);
            	}
            	oldList.add(oTmp);
            	
            	
            	for(OrdersDto list : mList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						mTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(mTmp==null) {
            		mTmp = new OrdersDto("0",startDate);
            	}
            	memList.add(mTmp);

            }
    		Map<String,Object> map = new HashMap<>();
    		map.put("oldList", oldList);
    		map.put("newList", newList);
    		map.put("memList", memList);
    		
    		return map;
	}
	
//////////////////////////////////////////기간별 가입//////////////////////////////////////////////////////////////		
	
	public Map<String,Object> getSelectRegi(Odr_SearchDto dto)throws Exception{

        List<OrdersDto> maleList = new ArrayList<OrdersDto>();
        List<OrdersDto> femaleList = new ArrayList<OrdersDto>();
        List<OrdersDto> secretList = new ArrayList<OrdersDto>();
        
		if(!dto.getSdate().equals("") && !dto.getEdate().equals("")) {
			
			//20210105 > 2021-01-05 로 변환
			String startDate1 = dto.getSdate().substring(0,4);
			String startDate2 = dto.getSdate().substring(4,6);
			String startDate3 = dto.getSdate().substring(6,8);
			String totalStartDate = startDate1+"-"+startDate2+"-"+startDate3;
			
			String endDate1 = dto.getEdate().substring(0,4);
			String endDate2 = dto.getEdate().substring(4,6);
			String endDate3 = dto.getEdate().substring(6,8);
			String totalEndDate = endDate1+"-"+endDate2+"-"+endDate3;
			
			//변환한 데이터를 Date화 한다.
			Date sdate = new SimpleDateFormat("yyyy-MM-dd").parse(totalStartDate);
			Date edate = new SimpleDateFormat("yyyy-MM-dd").parse(totalEndDate);
			
			//Date화한 날짜를 Calendar화
			Calendar startDate = Calendar.getInstance();
			startDate.setTime(sdate);
			Calendar endDate = Calendar.getInstance();
			endDate.setTime(edate);

			//System.out.println("cmpDate:"+cmpDate);
			
			//오늘 날짜와 환불완료 날짜를 Millis단위로 쪼개서 1000으로 나눔
			long diffSec = (endDate.getTimeInMillis() - startDate.getTimeInMillis()) / 1000;
			//나눈 값을 일 수로 지정 //(24)시간으로 나눔
			long diffDays = diffSec / (24*60*60); //일자수 차이
			
			// ex) 15일 차이면 14일이 되므로 1일 추가
			diffDays = diffDays+1;
			System.out.println("getSelectSales 일 수 차이 : "+diffDays);
				
			System.out.println("getSelectSales sdate : "+dto.getSdate());
			System.out.println("getSelectSales edate : "+dto.getEdate());
			
			dto.setStatus("male");
			List<OrdersDto> maleList1 = dao.getSelectRegi(dto);
			dto.setStatus("female");
			List<OrdersDto> femaleList1 = dao.getSelectRegi(dto);
			dto.setStatus("secret");
			List<OrdersDto> secretList1 = dao.getSelectRegi(dto);
			
			for(int i=1; i<=diffDays; i++) {
				OrdersDto maleTmp = null;
				OrdersDto femaleTmp = null;
				OrdersDto secretTmp = null;
				for(OrdersDto list : maleList1) {
					
					//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
					//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
					//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
					//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - startDate.getTimeInMillis()) / 1000;
					//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+1;
					
					if(i == Days) {
						// n일차에 값이 있음
						maleTmp = new OrdersDto(list.getMoney(),totalStartDate);
					}
				}
				if(maleTmp == null) {
					//n일차에 값이 없음
					maleTmp = new OrdersDto("0",totalStartDate);
				}	
				maleList.add(maleTmp);
				
				///////
				for(OrdersDto list : femaleList1) {
					
					//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
					//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
					//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
					//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - startDate.getTimeInMillis()) / 1000;
					//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+1;
					
					if(i == Days) {
						// n일차에 값이 있음
						femaleTmp = new OrdersDto(list.getMoney(),totalStartDate);
					}
				}
				if(femaleTmp == null) {
					//n일차에 값이 없음
					femaleTmp = new OrdersDto("0",totalStartDate);
				}	
				femaleList.add(femaleTmp);
				/////
				for(OrdersDto list : secretList1) {
					
					//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
					//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
					//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
					//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - startDate.getTimeInMillis()) / 1000;
					//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+1;
					
					if(i == Days) {
						// n일차에 값이 있음
						secretTmp = new OrdersDto(list.getMoney(),totalStartDate);
					}
				}
				if(secretTmp == null) {
					//n일차에 값이 없음
					secretTmp = new OrdersDto("0",totalStartDate);
				}	
				secretList.add(secretTmp);
			}
		}
		Map<String,Object> map = new HashMap<>();
		map.put("maleList", maleList);
		map.put("femaleList", femaleList);
		map.put("secretList", secretList);
		return map;
	}
	
//////////////////////////////////////////주간 가입//////////////////////////////////////////////////////////////		
	
	public Map<String,Object> getWeekRegi() throws Exception{

        List<OrdersDto> maleList = new ArrayList<OrdersDto>();
        List<OrdersDto> femaleList = new ArrayList<OrdersDto>();
        List<OrdersDto> secretList = new ArrayList<OrdersDto>();
        
		List<OrdersDto> maleList1 = dao.getWeekRegi("male");
		List<OrdersDto> femaleList1 = dao.getWeekRegi("female");
		List<OrdersDto> secretList1 = dao.getWeekRegi("secret");

        //오늘 날짜 구하기
        	Date lastDay = new Date();
//        	System.out.println("getWeekSales lastDay : "+lastDay);
        	SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
//        	System.out.println("getWeekSales today : "+today );
        	form.format(lastDay);
        //오늘 날짜 Calendar 형식으로 변경
        	Calendar today = Calendar.getInstance();
        	today.setTime(lastDay);
//        	System.out.println("getWeekSales cForm : "+cForm );
        	
        //오늘로 부터 1주일 전 날짜 뽑기	
        	Calendar week = Calendar.getInstance();
            week.add(Calendar.DATE , -6);
        //시작일을 설정하기 위해 String화함
            String startDate = new SimpleDateFormat("yyyy-MM-dd").format(week.getTime());
            
//          System.out.println("일주일전 날짜 : "+startDate);
            
        //1주일 전 날짜와 오늘 날짜 차이 값 뽑기.
            long dif = (today.getTimeInMillis() - week.getTimeInMillis()) / 1000;
            long Day = dif / (24*60*60);
            Day = Day+1;
//          System.out.println("일주일 차이 : "+Days);
            
            for(int i=1; i<=Day; i++) {
				OrdersDto mTmp = null;
				OrdersDto fTmp = null;
				OrdersDto sTmp = null;
				
            	for(OrdersDto list : maleList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						mTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(mTmp==null) {
            		mTmp = new OrdersDto("0",startDate);
            	}
            	maleList.add(mTmp);
            	
            	
            	for(OrdersDto list : femaleList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						fTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(fTmp==null) {
            		fTmp = new OrdersDto("0",startDate);
            	}
            	femaleList.add(fTmp);
            	
            	
            	for(OrdersDto list : secretList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						sTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(sTmp==null) {
            		sTmp = new OrdersDto("0",startDate);
            	}
            	secretList.add(sTmp);

            }
    		Map<String,Object> map = new HashMap<>();
    		map.put("maleList", maleList);
    		map.put("femaleList", femaleList);
    		map.put("secretList", secretList);
    		
    		return map;
	}
	
//////////////////////////////////////////한달 가입//////////////////////////////////////////////////////////////		
	
	public Map<String,Object> getMonthRegi() throws Exception{

        List<OrdersDto> maleList = new ArrayList<OrdersDto>();
        List<OrdersDto> femaleList = new ArrayList<OrdersDto>();
        List<OrdersDto> secretList = new ArrayList<OrdersDto>();
        
		List<OrdersDto> maleList1 = dao.getMonthRegi("male");
		List<OrdersDto> femaleList1 = dao.getMonthRegi("female");
		List<OrdersDto> secretList1 = dao.getMonthRegi("secret");

        //오늘 날짜 구하기
        	Date lastDay = new Date();
//        	System.out.println("getWeekSales lastDay : "+lastDay);
        	SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
//        	System.out.println("getWeekSales today : "+today );
        	form.format(lastDay);
        //오늘 날짜 Calendar 형식으로 변경
        	Calendar today = Calendar.getInstance();
        	today.setTime(lastDay);
//        	System.out.println("getWeekSales cForm : "+cForm );
        	
        //오늘로 부터 1주일 전 날짜 뽑기	
        	Calendar week = Calendar.getInstance();
            week.add(Calendar.MONTH , -1);
        //시작일을 설정하기 위해 String화함
            String startDate = new SimpleDateFormat("yyyy-MM-dd").format(week.getTime());
            
//          System.out.println("일주일전 날짜 : "+startDate);
            
        //1주일 전 날짜와 오늘 날짜 차이 값 뽑기.
            long dif = (today.getTimeInMillis() - week.getTimeInMillis()) / 1000;
            long Day = dif / (24*60*60);
            Day = Day+1;
//          System.out.println("일주일 차이 : "+Days);
            
            for(int i=1; i<=Day; i++) {
				OrdersDto mTmp = null;
				OrdersDto fTmp = null;
				OrdersDto sTmp = null;
				
            	for(OrdersDto list : maleList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						mTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(mTmp==null) {
            		mTmp = new OrdersDto("0",startDate);
            	}
            	maleList.add(mTmp);
            	
            	
            	for(OrdersDto list : femaleList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						fTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(fTmp==null) {
            		fTmp = new OrdersDto("0",startDate);
            	}
            	femaleList.add(fTmp);
            	
            	
            	for(OrdersDto list : secretList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						sTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(sTmp==null) {
            		sTmp = new OrdersDto("0",startDate);
            	}
            	secretList.add(sTmp);

            }
    		Map<String,Object> map = new HashMap<>();
    		map.put("maleList", maleList);
    		map.put("femaleList", femaleList);
    		map.put("secretList", secretList);
    		
    		return map;
	}
	
//////////////////////////////////////////연간 가입//////////////////////////////////////////////////////////////		
	
	public Map<String,Object> getYearRegi() throws Exception{

        List<OrdersDto> maleList = new ArrayList<OrdersDto>();
        List<OrdersDto> femaleList = new ArrayList<OrdersDto>();
        List<OrdersDto> secretList = new ArrayList<OrdersDto>();
        
		List<OrdersDto> maleList1 = dao.getYearRegi("male");
		List<OrdersDto> femaleList1 = dao.getYearRegi("female");
		List<OrdersDto> secretList1 = dao.getYearRegi("secret");

        //오늘 날짜 구하기
        	Date lastDay = new Date();
//        	System.out.println("getWeekSales lastDay : "+lastDay);
        	SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
//        	System.out.println("getWeekSales today : "+today );
        	form.format(lastDay);
        //오늘 날짜 Calendar 형식으로 변경
        	Calendar today = Calendar.getInstance();
        	today.setTime(lastDay);
//        	System.out.println("getWeekSales cForm : "+cForm );
        	
        //오늘로 부터 1주일 전 날짜 뽑기	
        	Calendar week = Calendar.getInstance();
            week.add(Calendar.YEAR , -1);
        //시작일을 설정하기 위해 String화함
            String startDate = new SimpleDateFormat("yyyy-MM-dd").format(week.getTime());
            
//          System.out.println("일주일전 날짜 : "+startDate);
            
        //1주일 전 날짜와 오늘 날짜 차이 값 뽑기.
            long dif = (today.getTimeInMillis() - week.getTimeInMillis()) / 1000;
            long Day = dif / (24*60*60);
            Day = Day+1;
//          System.out.println("일주일 차이 : "+Days);
            
            for(int i=1; i<=Day; i++) {
				OrdersDto mTmp = null;
				OrdersDto fTmp = null;
				OrdersDto sTmp = null;
				
            	for(OrdersDto list : maleList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						mTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(mTmp==null) {
            		mTmp = new OrdersDto("0",startDate);
            	}
            	maleList.add(mTmp);
            	
            	
            	for(OrdersDto list : femaleList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						fTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(fTmp==null) {
            		fTmp = new OrdersDto("0",startDate);
            	}
            	femaleList.add(fTmp);
            	
            	
            	for(OrdersDto list : secretList1) {
				//Date값을 넣을 Calendar값 기입
					Calendar gap = Calendar.getInstance();
					
				//20210101 > 2021-01-01
					String listmoney1 = list.getMoneyDate().substring(0,4);
					String listmoney2 = list.getMoneyDate().substring(4,6);
					String listmoney3 = list.getMoneyDate().substring(6,8);
					String listMoneyDate = listmoney1+"-"+listmoney2+"-"+listmoney3;
					
				//Date화
					Date listdate = new SimpleDateFormat("yyyy-MM-dd").parse(listMoneyDate);
				//Date값 Calendar에 넣어 해당 날짜 확인
					gap.setTime(listdate);
					
					long Sec = (gap.getTimeInMillis() - week.getTimeInMillis()) / 1000;
				//나눈 값을 일 수로 지정 //(24)시간으로 나눔
					long Days = Sec / (24*60*60); //일자수 차이
					Days = Days+2;

					if(i==Days) {
						sTmp = new OrdersDto(list.getMoney(),startDate);
					}
            	}
            	if(sTmp==null) {
            		sTmp = new OrdersDto("0",startDate);
            	}
            	secretList.add(sTmp);

            }
    		Map<String,Object> map = new HashMap<>();
    		map.put("maleList", maleList);
    		map.put("femaleList", femaleList);
    		map.put("secretList", secretList);
    		
    		return map;
	}
}
