package com.flenda.www.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.flenda.www.dto.Act_SearchDto;
import com.flenda.www.dto.ActivityDto;
import com.flenda.www.dto.MemberDto;
import com.flenda.www.dto.OptionDto;
import com.flenda.www.dto.PicturesDto;
import com.flenda.www.dto.SearchParam;
import com.flenda.www.dto.ThemeDto;
import com.flenda.www.dto.WishDto;
import com.flenda.www.service.ActivityService;
import com.flenda.www.service.MainService;
import com.flenda.www.service.MemberService;
import com.flenda.www.service.MyPageService;
import com.flenda.www.service.OptionService;
import com.flenda.www.util.ActivityUtil;


@Controller
public class ActivityController {
	
	@Autowired
	ActivityService service;
	
	@Autowired
	MainService mService;
	
	@Autowired
	OptionService oService;
	
	@Autowired
	MemberService memService;
	
	@Autowired
	MyPageService myService;
	
	// 관리자페이지 액티비티
	@RequestMapping(value = "activity.do", method = RequestMethod.GET)
	public String activity(Model model) {
		System.out.println("ActivityController activity");
		model.addAttribute("top_menu", "no");
		return "activity.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "managemnetAct.do", method = { RequestMethod.POST, RequestMethod.GET})
	public Map<String,Object> managemnetAct(SearchParam param) {
		System.out.println("ActivityController managemnetAct()");
		
		System.out.println("param:" + param.toString());
		 
		if(param.getStartdate() != null && param.getEnddate() != null) {
		   param.setStartdate(param.getStartdate().replace("-", ""));
		   param.setEnddate(param.getEnddate().replace("-", ""));
		  }
		System.out.println("param:" + param.toString());
		//db에서 전체 목록 불러와서 list에 넣기. 
		List<ActivityDto> list = service.getActivityList(param);
						
		//총 글의 갯수
		int totalCount = service.getActCount(param);
		System.out.println("글총갯수" +totalCount);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", param);
		map.put("totalCount", totalCount);
		map.put("list", list);
			
		return map;
	}
	
	
	@RequestMapping(value = "actwrite.do", method = RequestMethod.GET)
	public String actwrite(Model model) {
		System.out.println("ActivityController actwrite");
		model.addAttribute("top_menu", "no");
		
		return "actwrite.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "actwriteAf.do", method = {RequestMethod.POST,RequestMethod.GET})
	public String actwriteAf(ActivityDto act, @RequestParam("fileload") List<MultipartFile> multipartFile, HttpServletRequest req) {
		System.out.println("ActivityController actwriteAf()");
		System.out.println(multipartFile.toString());
		System.out.println(act.toString());
		String msg ="";
		msg = service.addActivity(act);	// 액티비티판매 등록
		// 서버경로
		String uploadPath = req.getServletContext().getRealPath("/upload");
		
		// sellSeq 가져오기
		int sellSeq = service.getSeq(act.getTitle());
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
	
	@RequestMapping(value = "actdetail.do", method = RequestMethod.GET)
	public String actdetail(Model model,int seq) {
		System.out.println("ActivityController actwrite");
		model.addAttribute("top_menu", "no");
		ActivityDto act = service.getActivity(seq);
		model.addAttribute("act", act);
		return "actdetail.tiles";
	}
	
	@RequestMapping(value = "actupdate.do", method = RequestMethod.GET)
	public String actupdate(Model model, int seq) {
		System.out.println("ActivityController actupdate");
		ActivityDto act = service.getActivity(seq);
		int countPics = mService.countPics(seq);
		model.addAttribute("top_menu", "no");
		model.addAttribute("act", act);
		model.addAttribute("countPics", countPics);
		return "actupdate.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "deletePic.do", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> deletePic(int sellSeq) {
		System.out.println("ActivityController deletePic");
		Map<String, Object> map = new HashMap<String, Object>();
		String msg = mService.deletePic(sellSeq);
		map.put("msg", msg);
		int countPics = mService.countPics(sellSeq);
		map.put("countPics", countPics);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "actupdateAf.do", method = {RequestMethod.POST,RequestMethod.GET})
	public String actupdateAf(ActivityDto act, @RequestParam("fileload") List<MultipartFile> multipartFile, HttpServletRequest req) {
		System.out.println("ActivityController actwriteAf()");
		System.out.println(multipartFile.get(0).getOriginalFilename());
		System.out.println(act.toString());
		String msg ="";
		msg = service.updateActivity(act);	// 액티비티판매 등록
		
		if(multipartFile.get(0).getOriginalFilename() != "") {	// multipartFile 빈값이 아니면,
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
					PicturesDto pic = new PicturesDto(act.getSellSeq(), newfilename);
					System.out.println(pic.toString());
					msg = mService.updatePictures(pic);	// 사진등록
					
				} catch (Exception e) {
					e.printStackTrace();
					msg = "fail";
				} 
			}
		}
		return msg;
	}
	
	@ResponseBody
	@RequestMapping(value = "deleteAct.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String deleteAct(int seq) {
		System.out.println("ActivityController deleteAct");
		String msg = "";
		String deleteAct = "";
		String deleteOp = "";
		deleteAct = service.deleteAct(seq);
		deleteOp = oService.deleteOps(seq);
		if(deleteAct.equals("success") || deleteOp.equals("success")) {
			msg = "success";
		}else {
			msg = "fail";
		}
		return msg;
	}
	
	// 사용자페이지 액티비티
	@RequestMapping(value = "main_activity.do", method = RequestMethod.GET)
	public String main_activity(Model model, String param) {
		System.out.println("ActivityController main_activity");
		model.addAttribute("top_menu", "no");
		model.addAttribute("param", param);
		System.out.println("param : "+param);
		return "main_activity.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "main_searchActivity.do", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> searchActivity(Act_SearchDto search) {
		System.out.println("ActivityController searchActivity");
		System.out.println(search.toString());
		if(search.getDaterange().equals("")) {
			search.setDaterange("all-all");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		List<ActivityDto> list = service.main_getActivityList(search); 
		List<PicturesDto> pics = mService.getPictures();
		List<WishDto> wlist = myService.getWishList();
//		System.out.println(list.toString());
		int allcount = service.allcount(search);
		map.put("list", list);
		map.put("pics", pics);
		map.put("search",search);
		map.put("totalCount", allcount);
		map.put("wlist", wlist);
		return map;
	}
	
	@RequestMapping(value = "main_actdetail.do", method = RequestMethod.GET)
	public String main_actdetail(Model model,int seq) {
		System.out.println("ActivityController main_activity");
		model.addAttribute("top_menu", "no");
		ActivityDto act = service.getActivity(seq);
		String hostImg = memService.getNewFilename(act.getHostId());
		List<PicturesDto> pics = mService.getPic(seq);
		int min = oService.getMinPrice(seq);
		model.addAttribute("hostImg", hostImg);
		model.addAttribute("act", act);
		model.addAttribute("pics", pics);
		model.addAttribute("minprice", min);
		return "main_actdetail.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "detailOptions.do", method = {RequestMethod.GET,RequestMethod.POST})
	public List<OptionDto> detailOptions(String date, int seq){
		System.out.println("ActivityController detailOptions");
		List<OptionDto> list = oService.detailOptions(date, seq);
		System.out.println(list.toString());
		return list;
	}
	//추천액티비티
	@ResponseBody
	@RequestMapping(value = "referenceAct.do", method = {RequestMethod.GET,RequestMethod.POST})
	public  Map<String, Object> referenceAct(String location, int seq){
		System.out.println("ActivityController referenceAct");
		String[] address = location.split(" ");
		System.out.println("location : "+address[0]);
		System.out.println("seq : "+seq);
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<ActivityDto> list = service.referAct(address[0],seq);
		List<PicturesDto> pics = mService.getPictures();
		List<WishDto> wlist = myService.getWishList();
		map.put("list", list);
		map.put("pics", pics);
		map.put("wlist", wlist);
		return map;
	}
	@ResponseBody
	@RequestMapping(value = "main_refer.do", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> main_refer(){
		System.out.println("ActivityController main_refer");
		Map<String, Object> map = new HashMap<String, Object>();
		List<ActivityDto> list = service.main_refer();
		List<PicturesDto> pics = mService.getPictures();		
		map.put("list", list);
		map.put("pics", pics);	
		return map;
	}
}
