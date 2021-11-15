package com.flenda.www.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.flenda.www.dto.Odr_SearchDto;
import com.flenda.www.dto.OrdersDto;
import com.flenda.www.dto.PicturesDto;
import com.flenda.www.dto.VisitDto;

@Repository
public class MainDao {
	
	@Autowired
	SqlSession session;
	
	String ns = "Main.";
	
	public int addPictures(PicturesDto pic) {
		return session.insert(ns + "addPictures", pic);
	}
	
	public int updatePictures(PicturesDto pic) {
		return session.insert(ns + "updatePictures", pic);
	}
	
	public int deletePic(int seq) {
		return session.delete(ns + "deletePic", seq);
	}
	
	public int countPics(int seq) {
		return session.selectOne(ns + "countPics", seq);
	}
	
	public List<PicturesDto> getPictures(){
		return session.selectList(ns + "getPictures");
	}
	
	public List<PicturesDto> getPic(int seq){
		return session.selectList(ns + "getPic", seq);
	}
	
	// 방문자통계	
	public boolean addIp(VisitDto dto) {
		int check = session.insert(ns+"addIp", dto);
		return check>0?true:false;
	}
	
	public int getCount(VisitDto dto) {
		return session.selectOne(ns+"getCount", dto);
	}
	
	public boolean delIp(VisitDto dto) {
		int check = session.delete(ns+"delIp", dto);
		return check>0?true:false;
	}
	
	public boolean updateIp(VisitDto dto) {
		int check = session.update(ns+"updateIp", dto);
		return check>0?true:false;
	}
	
	// home 통계
	public int todayVisitCount() {
		int count = session.selectOne(ns+"todayVisitCount");
		System.out.println("MainDao todayVisitCount : "+count);
		return count;
	}

	public int todayRegiCount() {
		int count = session.selectOne(ns+"todayRegiCount");
		System.out.println("MainDao todayRegiCount : "+count);
		return count;
	}
	
	public int todaySales() {
		int sales = session.selectOne(ns+"todaySales");
		return sales;
	}
	
	public int todayWriteCount() {
		int count = session.selectOne(ns+"todayWriteCount");
		System.out.println("MainDao todayWriteCount : "+count);
		return count;
		 
	}
	
	public int getMemberMale() {
		int count = session.selectOne(ns+"getMemberMale");
		return count;
	}
	
	public int getMemberFemale() {
		int count = session.selectOne(ns+"getMemberFemale");
		return count;
	}
	
	// 매출 통계
	// home 연도 체크
	public List<OrdersDto> getYearSales(){
		List<OrdersDto> list = session.selectList(ns+"getYearSales");
		return list;
	}
	
	public List<OrdersDto> getSelectSales(Odr_SearchDto dto){
		List<OrdersDto> list = session.selectList(ns+"getSelectSales",dto);
		return list;
	}

	public List<OrdersDto> getWeekSales(){
		List<OrdersDto> list = session.selectList(ns+"getWeekSales");
		return list;
	}
	public List<OrdersDto> getMonthSales(){
		List<OrdersDto> list = session.selectList(ns+"getMonthSales");

		return list;
	}
	
	//기간별 연도 체크
	public List<OrdersDto> getYearSalesStatisic(){
		List<OrdersDto> list = session.selectList(ns+"getYearSalesStatisic");

		return list;
	}
	
	
	//////////////////////////////// visit //////////////////////////////////////////
	public List<OrdersDto> getSelectVisit(Odr_SearchDto dto){
		List<OrdersDto> list = session.selectList(ns+"getSelectVisit",dto);
		return list;
	}
	
	public List<OrdersDto> getWeekVisit(String data){
		List<OrdersDto> list = session.selectList(ns+"getWeekVisit",data);
		return list;
	}
	
	public List<OrdersDto> getMonthVisit(String data){
		List<OrdersDto> list = session.selectList(ns+"getMonthVisit",data);
		return list;
	}
	
	public List<OrdersDto> getYearVisit(String data){
		List<OrdersDto> list = session.selectList(ns+"getYearVisit",data);
		return list;
	}
	
	
	////////////////////////////////regi //////////////////////////////////////////
	public List<OrdersDto> getSelectRegi(Odr_SearchDto dto){
		List<OrdersDto> list = session.selectList(ns+"getSelectRegi",dto);
		for(OrdersDto tmp : list) {
			System.out.println("Dao getSelectRegi count : "+tmp.getMoney());
		}
			System.out.println("Dao getSelectRegi list size : "+list.size());
		return list;
	}
	
	public List<OrdersDto> getWeekRegi(String data){
		List<OrdersDto> list = session.selectList(ns+"getWeekRegi",data);
//		for(OrdersDto tmp : list) {
//			System.out.println("Dao getWeekRegi count : "+tmp.getMoney());
//		}
			System.out.println("Dao getWeekRegi list size : "+list.size());
		return list;
	}
	
	public List<OrdersDto> getMonthRegi(String data){
		List<OrdersDto> list = session.selectList(ns+"getMonthRegi",data);
//		for(OrdersDto tmp : list) {
//			System.out.println("Dao getMonthRegi count : "+tmp.getMoney());
//		}
			System.out.println("Dao getMonthRegi list size : "+list.size());
		return list;
	}
	
	public List<OrdersDto> getYearRegi(String data){
		List<OrdersDto> list = session.selectList(ns+"getYearRegi",data);
//		for(OrdersDto tmp : list) {
//			System.out.println("Dao getYearRegi count : "+tmp.getMoney());
//		}
			System.out.println("Dao getYearRegi list size : "+list.size());
		return list;
	}
}
