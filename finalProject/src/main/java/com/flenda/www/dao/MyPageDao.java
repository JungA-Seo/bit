package com.flenda.www.dao;

import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.flenda.www.dto.ActivityDto;
import com.flenda.www.dto.BbsDto;
import com.flenda.www.dto.BbsParam;
import com.flenda.www.dto.CategoryDto;
import com.flenda.www.dto.OrdersDto;
import com.flenda.www.dto.ReviewDto;
import com.flenda.www.dto.ThemeDto;
import com.flenda.www.dto.WishDto;

@Repository
public class MyPageDao {
	
	@Autowired
	SqlSession session;
	
	String ns = "MyPage.";
	
	
	// 내가 쓴 글 전체 목록
	public List<BbsDto> getMypageBbsList(BbsParam param) {
		return session.selectList(ns + "getMypageBbsList", param);
	}
	public int getMypageBbsCount(BbsParam param) {
		return session.selectOne(ns + "getMypageBbsCount", param);
	}

	//마이페이지 > 구매내역 > 리뷰작성
	public int addReview(ReviewDto rev) {
		return session.insert(ns + "addReview",rev);
	}
	public int checkReview(ReviewDto rev) {
		return session.selectOne(ns + "checkReview", rev);
	}
	
	// 검색페이지 > 상세페이지 > 후기
	public List<ReviewDto> getReivews(int seq){
		return session.selectList(ns + "getReivews", seq);
	}
	public int countReviews(int seq) {
		return session.selectOne(ns + "countReviews", seq);
	}
	public String avgReviews(int seq) {
		return session.selectOne(ns + "avgReviews", seq);
	}
	//마이페이지 > 구매내역 > 구매리스트 
	public List<OrdersDto> getreviewlist(String id){
		return session.selectList(ns + "getreviewlist", id);
	}
	
	//마이페이지 > 구매내역 > 전체 카운트
	public int orderlistCount(String id) {
		return session.selectOne(ns + "orderlistCount", id);
	}
	
	
	
	//위시리스트
	//찜하기 : 테마여행&액티비티 검색페이지 -> 찜하기
	public int addWish(WishDto wish) {
		return session.insert(ns + "addWish", wish);
	}
	//찜하기 : 테마여행&액티비티 검색페이지 -> 찜한거 지우기
	public int deleteWish(WishDto wish) {
		return session.delete(ns + "deleteWish", wish);
	}
	public List<WishDto> getWishList(){
		return session.selectList(ns + "getWishList");
	}
	public List<ActivityDto> mypageWishList(String id){
		return session.selectList(ns + "mypageWishList", id);
	}
	public List<ThemeDto> mypageThemeWishList(String id){
		return session.selectList(ns + "mypageThemeWishList", id);
	}
}
