package com.flenda.www.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.flenda.www.dto.OptionDto;
import com.flenda.www.dto.SearchParam;
import com.flenda.www.dto.PicturesDto;
import com.flenda.www.dto.ThemeDto;
import com.flenda.www.dto.ThemeSearchDto;
import com.flenda.www.dto.WishDto;
import com.flenda.www.service.MainService;
import com.flenda.www.service.MemberService;
import com.flenda.www.service.MyPageService;
import com.flenda.www.service.OptionService;
import com.flenda.www.service.ThemeService;
import com.flenda.www.util.ActivityUtil;


@Controller
public class ThemeController {

	@Autowired
	ThemeService service;
	
	@Autowired
	MainService mService;
	
	@Autowired
	OptionService oService;
	
	@Autowired
	MemberService memService;
	
	@Autowired
	MyPageService myService;
	
	//tmlist tiles로 
	@RequestMapping(value = "thememainList.do", method = RequestMethod.GET)
	public String thememainList(){
		
		return "thememainList.tiles" ;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "tmlist.do", method = { RequestMethod.POST, RequestMethod.GET})
	public Map<String,Object> tmlist(SearchParam param, Model model) {
		System.out.println("ThemeController tmlist()");
		model.addAttribute("top_menu", "no");
		
		//System.out.println("param:" + param.toString());
		 
		if(param.getStartdate() != null && param.getEnddate() != null) {
		   param.setStartdate(param.getStartdate().replace("-", ""));
		   param.setEnddate(param.getEnddate().replace("-", ""));
		  }

		//System.out.println("startdate:" + param.getStartdate());
		//System.out.println("enddate:" + param.getEnddate());
		
		//현재 페이지넘버
		int start , end;
		start = 1 + 10 * param.getPageNumber();  
		end = 10 + 10 * param.getPageNumber();
		
		param.setStart(start);
		param.setEnd(end);
		
		//db에서 전체 목록 불러와서 list에 넣기. 
		List<ThemeDto> list = service.tmlist(param);
		
		//search, choice값 체크
		model.addAttribute("param",param);
				
		//총 글의 갯수
		int totalCount = service.writeCount(param);
		//System.out.println("글총갯수" +totalCount);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", param);
		map.put("totalCount", totalCount);
		map.put("themelist", list);
		
				
//		//현재 페이지
//		model.addAttribute("pageNumber" , param.getPageNumber()+1);
//		
		return map;
	}
	
	@RequestMapping(value = "tmwrite.do", method = RequestMethod.GET)
	public String tmwrite() {
		System.out.println("ThemeController tmwrite()");
		
		
		return "tmwrite.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "tmwriteAf.do", method = RequestMethod.POST)
	public String tmwriteAf(ThemeDto dto, 
							@RequestParam("fileload") List<MultipartFile> multipartFile, HttpServletRequest req) {
		
		System.out.println("ThemeController tmwriteAf()");
		
		//System.out.println("multipartfile :" + multipartFile.toString());
		System.out.println("tmwriteAf dto:" + dto.toString());
		String msg ="";
		
		msg = service.tmwrite(dto);
		
		// sellSeq 가져오기
		int sellSeq = service.getSeq(dto.getTitle());		
		// 서버경로
		String uploadPath = req.getServletContext().getRealPath("/upload");		
		for(MultipartFile mf : multipartFile) {
			String originalFilename = mf.getOriginalFilename(); // 원본 파일명
			long fileSize = mf.getSize();	//파일 사이즈
					
			System.out.println("originalFilename : " + originalFilename);
			System.out.println("fileSize : " + fileSize);
			
			String newfilename = ActivityUtil.getNewFileName(originalFilename);
			//일반파일명 -> new파일명 변경
			//System.out.println("newfilename : " + newfilename);
			
			String filepath = uploadPath + File.separator + newfilename;
			System.out.println("filepath:" + filepath);
			try {
				BufferedOutputStream os = new BufferedOutputStream(new FileOutputStream(new File(filepath)));
				os.write(mf.getBytes());
				os.close();
				PicturesDto pic = new PicturesDto(sellSeq, newfilename);
				System.out.println(pic.toString());
				msg = mService.addPictures(pic);	// 사진등록
						
				} catch (Exception e) {
					e.printStackTrace();
					msg = "fail";
				} 
			}
				
		return msg;
	
	}
	
	@RequestMapping(value = "tmdetail.do", method = { RequestMethod.POST, RequestMethod.GET})
	public String tmdetail(int sellSeq, Model model) {
		System.out.println("ThemeController tmdetail()");
		System.out.println("tmdetail seq:" + sellSeq);
		
		model.addAttribute("top_menu", "no");
	
		ThemeDto dto = service.tmdetail(sellSeq);
		System.out.println("tmdetail dto:" + dto.toString());
		model.addAttribute("tm", dto);
		
		return "tmdetail.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "deletetheme.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String deletetheme(int sellSeq) {
		System.out.println("ThemeController deletetheme()");
		//System.out.println("delete seq:" + seq);
		
		
		String msg = "";
		String deletetheme = "";
		String deleteOp = "";
		
		deletetheme = service.deletetheme(sellSeq);
		deleteOp = oService.deleteOps(sellSeq);
		
		if(deletetheme.equals("success") || deleteOp.equals("success")) {
			msg = "success";
		}else {
			msg = "fail";
		}
		return msg;
	}
	
	@RequestMapping(value = "themeupdate.do", method = RequestMethod.GET)
	public String themeupdate(Model model, int seq) {
		System.out.println("ThemeController actupdate()");
		
		ThemeDto dto = service.tmdetail(seq);
		int countPics = mService.countPics(seq);
		
		System.out.println("update 사진갯수:" + countPics);
		
		model.addAttribute("top_menu", "no");
		model.addAttribute("tm", dto);
		model.addAttribute("countPics", countPics);
		
		return "themeupdate.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "themeupdateAf.do", method = {RequestMethod.POST,RequestMethod.GET})
	public String themeupdateAf(ThemeDto dto, @RequestParam("fileload") List<MultipartFile> multipartFile, HttpServletRequest req) {
		System.out.println("ThemeController themeupdateAf()");
		
		System.out.println(multipartFile.get(0).getOriginalFilename());
		System.out.println(dto.toString());
		
		String msg ="";
		msg = service.updatetheme(dto);	// 테마 판매등록
		
		if(multipartFile.get(0).getOriginalFilename() != "") {	// multipartFile 빈값이 아니면(파일을 새로넣었을때),
			// 서버경로
			String uploadPath = req.getServletContext().getRealPath("/upload");		
			for(MultipartFile mf : multipartFile) {
				String originalFilename = mf.getOriginalFilename(); // 원본 파일명
				long fileSize = mf.getSize();	//파일 사이즈
				
				System.out.println("originalFilename : " + originalFilename);
				System.out.println("fileSize : " + fileSize);
				String newfilename = ActivityUtil.getNewFileName(originalFilename);
				//일반파일명 -> new파일명 변경
				System.out.println("newfilename : " + newfilename);
				String filepath = uploadPath + File.separator + newfilename;
				System.out.println("filepath:" + filepath);
				try {
					BufferedOutputStream os = new BufferedOutputStream(new FileOutputStream(new File(filepath)));
					os.write(mf.getBytes());
					os.close();
					PicturesDto pic = new PicturesDto(dto.getSellSeq(), newfilename);
					System.out.println(pic.toString());
					msg = mService.addPictures(pic);	// 사진등록
					
				} catch (Exception e) {
					e.printStackTrace();
					msg = "fail";
				} 
			} //for문 끝
		}//if문 
		return msg;
	}
	 
	
	@RequestMapping(value = "tmsearch.do", method = RequestMethod.GET)
	public String tmsearch(Model model, String param) {
		System.out.println("ThemeController tmsearch()");
		model.addAttribute("top_menu", "no");
		model.addAttribute("param", param);
		System.out.println("param : "+param);		
		return "tmsearch.tiles";
	}
	
	//테마 유저 리스트 
	@ResponseBody
	@RequestMapping(value = "tmuserlist.do", method = { RequestMethod.POST, RequestMethod.GET})
	public Map<String,Object> tmuserlist(ThemeSearchDto search) {
	
		System.out.println("ThemeController tmuserlist()");
		System.out.println("tmuserlist:" + search.toString());
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<ThemeDto> list = service.tmuserlist(search);
		List<PicturesDto> pics = mService.getPictures();
		List<OptionDto> opt = oService.tmuserOptionList();
		List<WishDto> wlist = myService.getWishList();
		int allcount = service.tmuserCount(search);
		
//		System.out.println(list.toString());
//		System.out.println(pics.toString());
//		System.out.println(opt.toString());
		System.out.println("tmuser allcount:" + allcount);
		
		map.put("list", list);
		map.put("pics", pics);
		map.put("opt", opt);
		map.put("totalCount", allcount);
		map.put("search", search);
		map.put("wlist", wlist);
		return map;
	
	}
	
//	테마여행 detail페이지로 가기 
	
	
	@RequestMapping(value = "tmuserdetail.do", method = RequestMethod.GET)
	public String tmuserdetail(int sellSeq, Model model) {
		System.out.println("ThemeController tmuserdetail()");
		model.addAttribute("top_menu", "no");
		
		//System.out.println("detail seq:" + sellSeq);
		
		
		ThemeDto theme = service.tmdetail(sellSeq);		//전체 theme dto 값 가져오기
		System.out.println("theme dto:" + theme.toString());
		model.addAttribute("theme", theme);
		
		String hostImg = memService.getNewFilename(theme.getHostId());
		System.out.println("hostImg:" + hostImg);
		model.addAttribute("hostImg", hostImg);
		
		List<PicturesDto> pics = mService.getPic(sellSeq);
		System.out.println("pics:" + pics.toString());
		model.addAttribute("pics", pics);
	
		
//		DecimalFormat df = new DecimalFormat("###,###");
//		int price = Integer.parseInt(df.format(300000));  
//		System.out.println("가격:"+price);
//		opt.setOpPrice(price);
		
		return "tmuserdetail.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "tmdetailOptions.do", method = {RequestMethod.GET,RequestMethod.POST})
	public List<OptionDto> detailOptions(String date, int sellSeq){
		System.out.println("ThemeController detailOptions() ");
		
		List<OptionDto> list = oService.detailOptions(date, sellSeq);
		System.out.println(list.toString());
		return list;
	}
	
	//테마유저상세페이지 footer 추천리스트
	@ResponseBody
	@RequestMapping(value = "recommendList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String,Object> recommendList(String city, int sellSeq){
		System.out.println("ThemeController recommendList()");
		System.out.println("recommendList city:" + city);
		System.out.println("recommendList sellSeq:" + sellSeq);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<ThemeDto> list = service.recommendList(city, sellSeq);
		List<PicturesDto> pics = mService.getPictures();
		List<WishDto> wlist = myService.getWishList();
		
		System.out.println("recommendList list:" + list.toString());
		System.out.println("recommendList pics:" + pics.toString());
		map.put("list", list);
		map.put("pics", pics);
		map.put("wlist", wlist);
		return map;
	}
	

	//테마유저상세페이지 footer 같은 카테고리 추천
	@ResponseBody
	@RequestMapping(value = "categoryList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String,Object> categoryList(String category, int sellSeq){
		System.out.println("ThemeController categoryList()");
		System.out.println("categoryList category:" + category);
		System.out.println("categoryList sellSeq:" + sellSeq);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<ThemeDto> list = service.categoryList(category, sellSeq);
		List<PicturesDto> pics = mService.getPictures();
		
		System.out.println("categoryList list:" + list.toString());
		System.out.println("categoryList pics:" + pics.toString());
		
		map.put("list", list);
		map.put("pics", pics);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "main_refer_theme.do", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> main_refer_theme(){
		System.out.println("ThemeController main_refer_theme");
		Map<String, Object> map = new HashMap<String, Object>();
		List<ThemeDto> list = service.main_refer_theme();
		List<PicturesDto> pics = mService.getPictures();		
		map.put("tlist", list);
		map.put("pics", pics);	
		return map;
	}
}
