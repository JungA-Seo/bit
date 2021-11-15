package com.flenda.www.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.flenda.www.dto.Act_SearchDto;
import com.flenda.www.dto.ActivityDto;
import com.flenda.www.dto.OrdersDto;
import com.flenda.www.dto.SearchParam;

@Repository
public class ActivityDao {
	
	@Autowired
	SqlSession session;
	
	String ns = "Activity.";
//	관리자페이지
	public int addActivity(ActivityDto act) {
		return session.insert(ns + "addActivity", act);
	}
	public List<ActivityDto> getActivityList(SearchParam param) {
		return session.selectList(ns + "getActivityList", param);
	}
	public int getActCount(SearchParam param) {
		return session.selectOne(ns + "getActCount", param);
	}
	
	public ActivityDto getActivity(int seq) {
		return session.selectOne(ns + "getActivity", seq);
	}
	
	public int getSeq(String title) {
		return session.selectOne(ns + "getSeq", title);
	}
	
	public int updateActivity(ActivityDto act) {
		return session.update(ns + "updateAct", act);
	}
	
	public int deleteAct(int seq) {
		return session.delete(ns + "deleteAct", seq);
	}

// 사용자페이지
	public List<ActivityDto> main_getActivityList(Act_SearchDto search){
		return session.selectList(ns + "main_getActivityList", search);
	}
	public int allcount(Act_SearchDto search) {
		return session.selectOne(ns + "allcount", search);
	}
	public List<ActivityDto> referAct(String location) {
		return session.selectList(ns + "referAct", location);
	}
	public int addSellCount(OrdersDto order) {
		return session.update(ns + "addSellCount", order);
	}
	public int addreivewNum(ActivityDto act) {
		return session.update(ns + "addreivewNum", act);
	}
	public int addreviewAvg(ActivityDto act) {
		return session.update(ns + "addreviewAvg", act);
	}
	public List<ActivityDto> main_refer(){
		return session.selectList(ns + "main_refer");
	}
}
