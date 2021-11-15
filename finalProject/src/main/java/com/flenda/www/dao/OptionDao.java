package com.flenda.www.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.flenda.www.dto.OptionDto;

@Repository
public class OptionDao {
	
	@Autowired
	SqlSession session;
	
	String ns = "Option.";
	
	public int addOption(OptionDto option) {
		return session.insert(ns + "addOption", option);
	}
	
	public List<OptionDto> getOptionList(int seq){
		return session.selectList(ns + "getOptionList", seq);
	}
	public int deleteOption(int seq) {
		return session.delete(ns + "deleteOption", seq);
	}
	public int deleteOps(int seq) {
		return session.delete(ns + "deleteOps", seq);
	}
	public List<OptionDto> detailOptions(OptionDto option){
		return session.selectList(ns + "detailOptions", option);
	}
	public OptionDto getOption(int seq) {
		return session.selectOne(ns + "getOption", seq);
	}
	public int getMinprice(int seq) {
		return session.selectOne(ns + "getMinprice", seq);
	}
	public int getMaxprice(int seq) {
		return session.selectOne(ns + "getMaxprice", seq);
	}
	public List<OptionDto> tmuserOptionList() {
		return session.selectList(ns + "tmuserOptionList");
	}
}
