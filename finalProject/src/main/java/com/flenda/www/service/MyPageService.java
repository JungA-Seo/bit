package com.flenda.www.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flenda.www.dao.MyPageDao;
import com.flenda.www.dto.ActivityDto;
import com.flenda.www.dto.BbsDto;
import com.flenda.www.dto.BbsParam;
import com.flenda.www.dto.CategoryDto;
import com.flenda.www.dto.OrdersDto;
import com.flenda.www.dto.ReviewDto;
import com.flenda.www.dto.ThemeDto;
import com.flenda.www.dto.WishDto;

@Service
public class MyPageService {
	
	@Autowired
	MyPageDao dao;
	
	//마이페이지 > 내가 쓴 글
	public List<BbsDto> getMypageBbsList(BbsParam param) {
		return dao.getMypageBbsList(param);
	}
	public int getMypageBbsCount(BbsParam param) {
		return dao.getMypageBbsCount(param);
	}
	
	
	//마이페이지 > 구매내역 > 리뷰작성
	public String addReview(ReviewDto rev) {
		return dao.addReview(rev)>0?"success":"fail";
	}
	public String checkReview(ReviewDto rev) {
		return dao.checkReview(rev)>0?"success":"fail";
	}
	
	public List<ReviewDto> getReivews(int seq){
		return dao.getReivews(seq);
	}
	public int countReviews(int seq) {
		return dao.countReviews(seq);
	}
	public String avgReviews(int seq) {
		return dao.avgReviews(seq);
	}
	
	//마이페이지 > 구매내역 > 구매내역리스트
	public List<OrdersDto> getreviewlist(String id){
		 return dao.getreviewlist(id);
	}
	
	//마이페이지 > 구매내역 > 구매내역총갯수
	public int orderlistCount(String id) {
		return dao.orderlistCount(id);
	}
	
	
	
	
	
	
	//위시리스트
	//찜하기 : 테마여행&액티비티 검색페이지 -> 찜하기
	public String addWish(WishDto wish) {
		return dao.addWish(wish)>0?"success":"fail";
	}
	
	//찜하기 : 테마여행&액티비티 검색페이지 -> 찜한거 지우기
	public String deleteWish(WishDto wish) {
		return dao.deleteWish(wish)>0?"success":"fail";
	}
	public List<WishDto> getWishList(){
		return dao.getWishList();
	}
	public List<ActivityDto> mypageWishList(String id){
		return dao.mypageWishList(id);
	}
	public List<ThemeDto> mypageThemeWishList(String id){
		return dao.mypageThemeWishList(id);
	}
}
