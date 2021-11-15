package com.flenda.www.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flenda.www.dao.ActivityDao;
import com.flenda.www.dao.MyPageDao;
import com.flenda.www.dto.Act_SearchDto;
import com.flenda.www.dto.ActivityDto;
import com.flenda.www.dto.OrdersDto;
import com.flenda.www.dto.SearchParam;

@Service
public class ActivityService {
	
	@Autowired
	ActivityDao dao;

//	관리자페이지
	public String addActivity(ActivityDto act) {
		return dao.addActivity(act)>0?"success":"fail";
	}
	
	public List<ActivityDto> getActivityList(SearchParam param){
		return dao.getActivityList(param);
	}
	
	public int getActCount(SearchParam param) {
		return dao.getActCount(param);
	}
	
	public ActivityDto getActivity(int seq) {
		return dao.getActivity(seq);
	}
	
	public int getSeq(String title) {
		return dao.getSeq(title);
	}
	
	public String updateActivity(ActivityDto act) {
		return dao.updateActivity(act)>0?"success":"fail";
	}
	public String deleteAct(int seq) {
		return dao.deleteAct(seq)>0?"success":"fail";
	}
	
// 사용자페이지
	public List<ActivityDto> main_getActivityList(Act_SearchDto search){
		String[] dateranges = search.getDaterange().split("-");
		search.setSdate(dateranges[0].trim().replace("/", ""));
		search.setEdate(dateranges[1].trim().replace("/", ""));

		String[] prices = search.getPrice().split("~");
		search.setSprice(prices[0]);
		search.setEprice(prices[1]);

		String[] times = search.getTime().split("~");
		search.setStime(times[0]);
		search.setEtime(times[1]);

		System.out.println(search.toString());
		
		return	dao.main_getActivityList(search);
	}
	public int allcount(Act_SearchDto search) {
		return dao.allcount(search);
	}
	public List<ActivityDto> referAct(String location, int seq){
		List<ActivityDto> newList = new ArrayList<ActivityDto>();
		List<ActivityDto> originalList = dao.referAct(location);
		for(ActivityDto act : originalList) {
			if(newList.size() == 3) {
				break;
			}
			if(act.getSellSeq() != seq) {
				newList.add(act);
			}
		}
		return newList;
	}
	public String addSellCount(OrdersDto order) {
		return dao.addSellCount(order)>0?"success":"fail";
	}
	public String addreivewNum(ActivityDto act) {
		return dao.addreivewNum(act)>0?"success":"fail";
	}
	public String addreviewAvg(ActivityDto act) {
		return dao.addreviewAvg(act)>0?"success":"fail";
	}
	public List<ActivityDto> main_refer(){
		return dao.main_refer();
	}
}
