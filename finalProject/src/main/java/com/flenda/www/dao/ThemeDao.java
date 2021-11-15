package com.flenda.www.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.flenda.www.dto.SearchParam;
import com.flenda.www.dto.ThemeDto;
import com.flenda.www.dto.ThemeSearchDto;

@Repository
public class ThemeDao {

	@Autowired
	SqlSession session;
	
	String ns = "Theme.";
	
	//테마관리자 전체리스트 불러오기
	public List<ThemeDto> tmlist(SearchParam param){
		
		List<ThemeDto> list = session.selectList(ns + "tmlist", param);
		
		return list;
	}
	
	//총 글의 갯수 불러오기 
	public int writeCount(SearchParam param) {
		return session.selectOne(ns + "writeCount", param);
	}
	
	
	//테마관리자 상품글작성
	public int tmwrite(ThemeDto dto) {
		return session.insert(ns + "tmwrite", dto);
	}
	public int getSeq(String title) {
		return session.selectOne(ns + "getSeq", title);
	}
	
	//테마관리자 상세보기 
	public ThemeDto tmdetail(int sellSeq) {
		
		ThemeDto dto = session.selectOne(ns + "tmdetail", sellSeq );
		
		return dto;
	}
	
	//테마글 삭제하기 
	public int deletetheme(int sellSeq) {
		return session.delete(ns + "deletetheme", sellSeq);
	}
	
	
	//테마판매글 수정하기
	public int updatetheme(ThemeDto dto) {
		return session.update(ns + "updatetheme", dto);
	}

	
//	------------------------user theme------------------------
	
	//user theme list 
	public List<ThemeDto> tmuserlist(ThemeSearchDto search){
		return session.selectList(ns + "tmuserlist", search);
	}
	//테마 user , 글의 총갯수
	public int tmuserCount(ThemeSearchDto search) {
		return session.selectOne(ns + "tmuserCount", search);
	}
	
	public int addreivewNum(ThemeDto tm) {
		return session.update(ns + "addreivewNum", tm);
	}
	public int addreviewAvg(ThemeDto tm) {
		return session.update(ns + "addreviewAvg", tm);
	}
	
	public int addhighprice(ThemeDto tm) {
		return session.update(ns + "addhighprice", tm);
	}
	
	public int addlowprice(ThemeDto tm) {
		return session.update(ns + "addlowprice", tm);
	}
	
	public List<ThemeDto> recommendList(String city, int sellSeq){
		return session.selectList(ns + "recommendList", city);
	}
	
	public List<ThemeDto> categoryList(String category, int sellSeq){
		return session.selectList(ns + "categoryList", category);
	}
	public List<ThemeDto> main_refer_theme(){
		return session.selectList(ns + "main_refer_theme");
	}
}