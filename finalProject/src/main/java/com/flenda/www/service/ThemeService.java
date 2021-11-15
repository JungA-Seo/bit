package com.flenda.www.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flenda.www.dao.ThemeDao;
import com.flenda.www.dto.SearchParam;
import com.flenda.www.dto.ThemeDto;
import com.flenda.www.dto.ThemeSearchDto;

@Service
public class ThemeService{
	
	@Autowired
	ThemeDao dao;
	
	public List<ThemeDto> tmlist(SearchParam param){
		return dao.tmlist(param);
	}
	
	public int writeCount(SearchParam param) {
		return dao.writeCount(param);
	}
	
	public String tmwrite(ThemeDto dto) {
		return dao.tmwrite(dto)>0?"success":"fail";
	}
	public int getSeq(String title) {
		return dao.getSeq(title);
	}
	
	public ThemeDto tmdetail(int sellSeq) {
		return dao.tmdetail(sellSeq);
	}
	
	public String deletetheme(int sellSeq) {
		return dao.deletetheme(sellSeq)>0?"success":"fail";
	}
	
	
	public String updatetheme(ThemeDto dto) {
		return dao.updatetheme(dto)>0?"success":"fail";
	}
	
	
//	사용자 페이지
	public List<ThemeDto> tmuserlist(ThemeSearchDto search){
		return dao.tmuserlist(search);
	}
	
	public int tmuserCount(ThemeSearchDto search) {
		return dao.tmuserCount(search);
	}
	
	public String addreivewNum(ThemeDto tm) {
		return dao.addreivewNum(tm)>0?"success":"fail";
	}
	
	public String addreviewAvg(ThemeDto tm) {
		return dao.addreviewAvg(tm)>0?"success":"fail";
	}
	
	public String addhighprice(ThemeDto tm) {
		return dao.addhighprice(tm)>0?"success":"fail";
	}
	
	public String addlowprice(ThemeDto tm) {
		return dao.addlowprice(tm)>0?"success":"fail";
	}
	
	public List<ThemeDto> recommendList(String city, int sellSeq){
		
		//System.out.println("recommendList service city:" + city);
		//System.out.println("recommendList service sellSeq:" + sellSeq);
		
		List<ThemeDto> newlist = new ArrayList<ThemeDto>();
		List<ThemeDto> originalList = dao.recommendList(city, sellSeq);
		for (ThemeDto tm : originalList ) {
			  if(newlist.size() == 3) {
		            break;
		         }
			if(sellSeq != tm.getSellSeq()) {
				newlist.add(tm);
			}
		}
		
		System.out.println("dao:" + newlist.toString());
		
		return newlist;
	}
	
	public List<ThemeDto> categoryList(String category, int sellSeq){
		
		System.out.println("categoryList service category:" + category);
		System.out.println("categoryList service sellSeq:" + sellSeq);
		
		List<ThemeDto> newlist = new ArrayList<ThemeDto>();
		List<ThemeDto> originalList = dao.categoryList(category, sellSeq);
		for (ThemeDto tm : originalList ) {
			  if(newlist.size() == 3) {
		            break;
		         }
			if(sellSeq != tm.getSellSeq()) {
				newlist.add(tm);
			}
		}
		
		System.out.println("dao:" + newlist.toString());
		
		return newlist;
	}
	
	public List<ThemeDto> main_refer_theme(){
		return dao.main_refer_theme();
	}
}
