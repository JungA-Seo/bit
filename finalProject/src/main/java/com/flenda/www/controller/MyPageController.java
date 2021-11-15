package com.flenda.www.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.flenda.www.dto.ActivityDto;
import com.flenda.www.dto.BbsDto;
import com.flenda.www.dto.BbsParam;
import com.flenda.www.dto.CategoryDto;
import com.flenda.www.dto.MemberDto;
import com.flenda.www.dto.OrdersDto;
import com.flenda.www.dto.PicturesDto;
import com.flenda.www.dto.ReviewDto;
import com.flenda.www.dto.SearchParam;
import com.flenda.www.dto.ThemeDto;
import com.flenda.www.dto.WishDto;
import com.flenda.www.service.ActivityService;
import com.flenda.www.service.MainService;
import com.flenda.www.service.MemberService;
import com.flenda.www.service.MyPageService;
import com.flenda.www.service.ThemeService;
import com.flenda.www.util.ActivityUtil;

@Controller
public class MyPageController {
	
	@Autowired
	MyPageService service;
	
	@Autowired
	MemberService memService;
	
	@Autowired
	ActivityService aService;
	
	@Autowired
	MainService mService;
	
	@Autowired
	ThemeService tService;
	
	// 마이페이지_내가 쓴 글
	@RequestMapping(value = "mybbslist.do", method = RequestMethod.GET)
	public String mybbslist(Model model,  BbsParam param, HttpServletRequest req) {
		System.out.println("MyPageController mybbslist");
		MemberDto mem = (MemberDto)req.getSession().getAttribute("login");
		System.out.println("id = " + mem.getId());
		model.addAttribute("side_menu", "menu");
		
		param.setSearch(mem.getId());	// BbsParam에 id를 넣는다.
		// 리스트 불러오기
		List<BbsDto> list = service.getMypageBbsList(param);
		model.addAttribute("mybbslist", list);
		// 글의 총 수
		int totalCount = service.getMypageBbsCount(param);
		model.addAttribute("totalCount", totalCount);
		// 페이징
		model.addAttribute("pageNumber", param.getPageNumber() + 1);
		
		return "mybbslist.tiles";
	}
	
	
	
	// 마이페이지 -> 구매내역 
	// 구매내역 전체 불러오기    -> 현재 id값 가져온거 없음. 추후 보완해야함
	@RequestMapping(value = "buyhistory.do", method = { RequestMethod.POST, RequestMethod.GET})
	public String buyhistory (Model model) {
		System.out.println("MypageController buyhistory()");	
		model.addAttribute("side_menu", "menu");	
		return "buyhistory.tiles";
	}
	
	//마이페이지 -> 구매내역 전체리스트
	@ResponseBody
	@RequestMapping(value = "getreviewlist.do", method = { RequestMethod.POST, RequestMethod.GET})
	public Map<String, Object> getreviewlist (String id, SearchParam param) {
		System.out.println("MypageController getreviewlist()");
		System.out.println("getreviewlist id:" + id);
		
		//현재 페이지넘버
		int start , end;
		start = 1 + 10 * param.getPageNumber();  
		end = 10 + 10 * param.getPageNumber();
				
		param.setStart(start);
		param.setEnd(end);
		
		int totalCount = service.orderlistCount(id);
		
		List<OrdersDto> olist = service.getreviewlist(id);
		System.out.println("reviewlist olist:" + olist.toString());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("olist", olist);
 		map.put("totalCount", totalCount);
		map.put("param", param);
 		return map;
		
	}
	
	//마이페이지-구매내역-리뷰등록
	@ResponseBody
	@RequestMapping(value = "checkReview.do", method = { RequestMethod.POST, RequestMethod.GET})
	public String checkReview(ReviewDto reivew) {
		return service.checkReview(reivew);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "addReview.do", method = { RequestMethod.POST, RequestMethod.GET})
	public String addReview (ReviewDto rev, Model model,
							@RequestParam(value = "fileload", required = false)	//파일 로드만 바이트타입으로 가져오는 것
								MultipartFile fileload,
								HttpServletRequest req) {
		
		System.out.println("MypageController addReview()");
		model.addAttribute("side_menu", "menu");
		
		// 포인트 500추가
		memService.add500point(rev.getId());
		
		System.out.println("addreview:" + rev.toString());
		if(rev.getUserImg()==null) {
			rev.setUserImg("");
		}
		
		String msg ="";
		
		//filename 취득 
		String filename = fileload.getOriginalFilename(); 	//업로드했을때 오리지날 파일네임(원본파일 명)
				
		//upload경로설정 
		String fupload = req.getServletContext().getRealPath("/upload");      // "/upload" 에다넣어준다. 서버에 저장 
		System.out.println("fupload:" + fupload);    //업로드가 됐는지 확인하기 위해서
		
		//파일명 변경 
		String newfilename = ActivityUtil.getNewFileName(filename);
		System.out.println("newfilename:" + newfilename);
		rev.setFileName(newfilename);  //db에 저장

		File file = new File(fupload + "/" + newfilename);   // 경로와 newfilename 을 넣어라. 
		
		try {
			//실제로 업로드 되는 부분 
			FileUtils.writeByteArrayToFile(file, fileload.getBytes());   // byte단위로 넣어라 
					
			//DB에 저장 
			msg = service.addReview(rev);
					
			} catch (Exception e) {
				e.printStackTrace();
				msg = "fail";
			}
		// 리뷰수, 평점저장하기
		if(msg.equals("success")) {
			int allreviews = service.countReviews(rev.getSellSeq());
			String avgreviews = service.avgReviews(rev.getSellSeq());
			if((rev.getSellSeq()/10000) == 2) {	// 액티비티일경우
				aService.addreivewNum(new ActivityDto(rev.getSellSeq(), allreviews, "", 0));
				aService.addreviewAvg(new ActivityDto(rev.getSellSeq(), 0, avgreviews, 0));
			}else {// 테마여행일경우
				tService.addreivewNum(new ThemeDto(rev.getSellSeq(), allreviews, "", 0, 0));
				tService.addreviewAvg(new ThemeDto(rev.getSellSeq(), 0, avgreviews, 0, 0));
			}
		}
		
		return msg;
	}
	
	// 검색페에지 > 상세페이지 > 리뷰검색
	@ResponseBody
	@RequestMapping(value = "getReviews.do", method = { RequestMethod.POST, RequestMethod.GET})
	public Map<String, Object> getReviews(int seq, int pageNum){
		System.out.println("MypageController getReviews");
		Map<String, Object> map = new HashMap<String, Object>();
		List<ReviewDto> pagingReview = new ArrayList<ReviewDto>();
		System.out.println("seq :" +seq);
		System.out.println("pageNum :" +pageNum);
		List<ReviewDto> reviews = service.getReivews(seq);
		int star5 = 0;
		int star4 = 0;
		int star3 = 0;
		int star2 = 0;
		int star1 = 0;
		int totalScore = 0;
		for (ReviewDto rev : reviews) {
			totalScore += rev.getRescore();
			if(rev.getRescore() == 5) {
				star5 += 1;
			}else if(rev.getRescore() == 4) {
				star4 += 1;
			}else if(rev.getRescore() == 3) {
				star3 += 1;
			}else if(rev.getRescore() == 2) {
				star2 += 1;
			}else if(rev.getRescore() == 1) {
				star1 += 1;
			}
			if(pagingReview.size() <= pageNum) {
				pagingReview.add(rev);
			}
		}
		double Avg = (double)totalScore/reviews.size();
		String avgStr = String.format("%.1f", Avg);
		int totalStar = star5 + star4 + star3 + star2 + star1;
		System.out.println(star5 + " " + star4 + " " + star3 + " " + star2 + " " + star1 + " " + totalStar);
		System.out.println(reviews.toString());
		System.out.println(avgStr);
		map.put("length", reviews.size());
		map.put("reviews", pagingReview);
		map.put("star5", star5);
		map.put("star4", star4);
		map.put("star3", star3);
		map.put("star2", star2);
		map.put("star1", star1);
		map.put("totalStar", totalStar);
		map.put("avg", avgStr);
		return map;
	}
	
	
	
	// 마이페이지_위시리스트
	@RequestMapping(value = "wishlist.do", method = RequestMethod.GET)
	public String wishlist(Model model) {
		System.out.println("MemberController wishlist");
		model.addAttribute("side_menu", "menu");
		return "wishlist.tiles";
	}
	
	
	//찜하기 : 테마여행&액티비티 검색페이지 -> 찜하기
	@ResponseBody
	@RequestMapping(value = "addWish.do", method = { RequestMethod.POST, RequestMethod.GET})
	public String addWish(WishDto wish) {
		System.out.println("MypageController addWish");
		System.out.println(wish.toString());
		String msg = "";
		msg = service.addWish(wish);
		return msg;
	}
	
	//찜하기 : 테마여행&액티비티 검색페이지 -> 찜한거 지우기
	@ResponseBody
	@RequestMapping(value = "deleteWish.do", method = { RequestMethod.POST, RequestMethod.GET})
	public String deleteWish(WishDto wish) {
		System.out.println("MypageController deleteWish");
		System.out.println(wish.toString());
		String msg = "";
		msg = service.deleteWish(wish);
		return msg;
	}
	//찜하기 : 마이페이지 -> 위시리스트
	@ResponseBody
	@RequestMapping(value = "mypageWishList.do", method = { RequestMethod.POST, RequestMethod.GET})
	public Map<String,Object> mypageWishList(String id) {
		System.out.println("MypageController deleteWish");
		System.out.println("위시리스트 아이디:"+id);
		Map<String, Object> map = new HashMap<String, Object>();
		List<ActivityDto> list = service.mypageWishList(id);
		List<ThemeDto> tlist = service.mypageThemeWishList(id);
		List<PicturesDto> pics = mService.getPictures();
		List<WishDto> wlist = service.getWishList();
		map.put("list", list);
		map.put("tlist", tlist);
		map.put("pics", pics);
		map.put("wlist", wlist);
		
		return map;
	}
	
	
	
	
	//패스워드 체크 화면으로 이동
	@RequestMapping(value="check.do", method = {RequestMethod.GET,RequestMethod.POST}) 
	public String check(Model model) {
	 System.out.println("MypageController check");
	  model.addAttribute("side_menu", "menu"); 
	  
	  return "pwdCheck.tiles";
	}
	
	//개인정보 수정 전 패스워드 체크
	@ResponseBody
	@RequestMapping(value="pwdCheck.do", method = {RequestMethod.GET,RequestMethod.POST}) 
	public int pwdCheck(Model model, MemberDto mem) {
	  System.out.println("MypageController pwdCheck");
  
	  System.out.println(mem.toString());
	  model.addAttribute("side_menu", "menu");
	  
	  int result = memService.pwdCheck(mem);
	  
	  return result;
	}
	
	//개인정보 수정 전 화면
	@RequestMapping(value="myInfo.do", method = {RequestMethod.GET,RequestMethod.POST}) 
	public String myInfo(Model model, String id) {
	  System.out.println("MypageController myInfo");
	  model.addAttribute("side_menu", "menu");
	  
	  MemberDto mem = memService.getInfo(id);
	  model.addAttribute("mem", mem);
	  
	  return "myInfo.tiles";
		  
	}
	
	//개인정보 수정 후 
	@ResponseBody
	@RequestMapping(value="updateInfo.do", method = {RequestMethod.GET,RequestMethod.POST}) 
	public String updateInfo(Model model, MemberDto mem, 
			  					@RequestParam(value = "fileload", required = false) MultipartFile fileload, 
			  					HttpServletRequest req){
		  String msg = "no";
		  
		  System.out.println("updateInfo :" + mem.toString());
		  System.out.println("MultipartFile :" + fileload.toString());
		  System.out.println("MypageController updateInfo");
		  if(mem.getBusinessName() == null) {
			  mem.setBusinessName("");
				
			}
			if(mem.getBusinessNumber() == null) {
				mem.setBusinessNumber("");
			}
		  
		  
		  if(fileload.getSize() != 0) {
			//filename(원본) 취득
		      String filename = fileload.getOriginalFilename();
		      // 서버 upload 경로설정
		      String fupload = req.getServletContext().getRealPath("/upload"); // 서버에 저장하는 폴더 경로 잡아주기
		      
		      System.out.println("server path fupload:" + fupload);
		      
		      //일반파일명 -> new파일명 변경
		      String newFilename = ActivityUtil.getNewFileName(filename);
		      mem.setNewFilename(newFilename);
		      
		      //파일업로드
		      File file = new File(fupload + "/" + newFilename);
		     
		      try {
		         //파일 실제로 업로드
		         FileUtils.writeByteArrayToFile(file, fileload.getBytes());   // file와 fileload를 바이트단위로 넣기
		         System.out.println(mem.toString());
		         // DB에 저장
		         
		      } catch (Exception e) {
		         e.printStackTrace();
		      }  
		  }
		  // DB에 저장
		  	boolean b = memService.updateInfo(mem);
	         if (b) {
	 			msg = "yes";
	 		}
	  return msg;
	}
}
