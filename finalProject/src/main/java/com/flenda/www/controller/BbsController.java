package com.flenda.www.controller;

import java.io.File;
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
import com.flenda.www.dto.LikecheckDto;
import com.flenda.www.dto.PicturesDto;
import com.flenda.www.dto.ReplyDto;
import com.flenda.www.service.BbsService;
import com.flenda.www.service.MainService;
import com.flenda.www.service.MemberService;
import com.flenda.www.util.ActivityUtil;

@Controller
public class BbsController {
	
	@Autowired
	BbsService service;
	
	@Autowired
	MainService mService;
	
	@Autowired
	MemberService memService;
	
	// 커뮤니티
	// 전체 게시글 목록
	@RequestMapping(value = "bbslist.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String bbslist(Model model, BbsParam param) {
		System.out.println("BbsController bbslist()");
		model.addAttribute("side_menu", "menu");
		
		int sn = param.getPageNumber();	// 0 1 2 3 4
		int start = 1 + sn * 10;		// 1	11
		int end = (sn + 1) * 10;		// 10	20
		
		param.setStart(start);
		param.setEnd(end);
		System.out.println(param.toString());
		
		// 리스트 불러오기
		List<BbsDto> list = service.getBbsList(param);
		model.addAttribute("bbslist", list);
		
		// 글의 총 수
		int totalCount = service.getBbsCount(param);
		model.addAttribute("totalCount", totalCount);
		System.out.println("totalCount : "+totalCount );
		// 페이징
		model.addAttribute("pageNumber", param.getPageNumber() + 1);
		
		// 검색
		model.addAttribute("search", param.getSearch());
		model.addAttribute("choice", param.getChoice());
		model.addAttribute("area", param.getArea());	// 이미지링크 클릭용 (지역)
		model.addAttribute("category", param.getCategory());	// 카테고리별 list 출력 (leftmenu)
		model.addAttribute("order", param.getOrder());			// 순위별 list 출력 (leftmenu)
		
		return "bbs.tiles";
	}
	
	// 게시글 작성
	@RequestMapping(value = "bbswrite.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String bbswrite(HttpServletRequest req, Model model) {
		System.out.println("BbsController bbswrite()");
		
		return "bbswrite.tiles";
	}
	
	@ResponseBody	// ajax 쓰려면 필수
	@RequestMapping(value = "bbswriteAf.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String bbswriteAf(BbsDto bbs,
							@RequestParam("fileload") MultipartFile multipartFile,
							HttpServletRequest req) {
		
		// newFilename이 null값일 때 다른 이름("") 주기	// 이거 없으면 작성완료 버튼 클릭 시 error !!
		if(bbs.getNewFilename() == null) {
			bbs.setNewFilename("");
		}
		
		// 여행기 작성시에 포인트 1000점 적용
		if(bbs.getCategory().equals("여행기")) {
			memService.add1000point(bbs.getId());
		}
		
		
		System.out.println("BbsController bbswriteAf()");
		System.out.println(multipartFile.toString());
		System.out.println(bbs.toString());
		
		String msg = "";
			
		
		// upload 경로 설정
		// server
		String uploadPath = req.getServletContext().getRealPath("/upload");
		
		String originalFilename = multipartFile.getOriginalFilename(); // 원본 파일명
		long fileSize = multipartFile.getSize();	//파일 사이즈
		
		System.out.println("originalFilename : " + originalFilename);
		System.out.println("fileSize : " + fileSize);
		System.out.println("uploadPath : " + uploadPath);
		
		String newfilename = ActivityUtil.getNewFileName(originalFilename);	// -> 하고 나서 set newfile~하고 값 찍어보고 넘겨주기. PicturesDto 필요없음
		bbs.setNewFilename(newfilename);
		//일반파일명 -> new파일명 변경
		System.out.println("newfilename : " + newfilename);
		
		File file = new File(uploadPath + "/" + newfilename);
		
		try {
			// 실제 업로드
			FileUtils.writeByteArrayToFile(file, multipartFile.getBytes());
			System.out.println(bbs.toString());
			// 게시글 등록
			msg = service.writeBbs(bbs);
			
		} catch (Exception e) {
			e.printStackTrace();
			msg = "fail";
		} 
		
		
		return msg;
	}
	
	// 게시글 상세
//	@ResponseBody	// 댓글 ajax
	@RequestMapping(value = "bbsdetail.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String bbsdetail(Model model, int seq) {
		System.out.println("BbsController bbsdetail()");
		
		// 게시글 조회 수(readCount) 증가
		service.readCount(seq);
		BbsDto bbs = service.getBbs(seq);
		model.addAttribute("bbs", bbs);
		
		return "bbsdetail.tiles";
	}
	
	// 좋아요 클릭
	@ResponseBody
	@RequestMapping(value = "checkLikecheck.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String checkLikecheck(LikecheckDto likecheck) {
		System.out.println("BbsController checkLikecheck()");
		System.out.println(likecheck.toString());	
		String msg = service.checkLikecheck(likecheck);
		
		// bbsDB로 좋아요 수 1증가 xml에서 SET LIKECOUNT = LIKECOUNT + 1
//		service.likeCount(0);
//		BbsDto bbs = service.getBbs(seq);	// 파라미터 없이 seq 어케 받아오냐
		// 좋아요 수(BBS DB에서 likeCount) 증가
		int seq = likecheck.getSeq_bbs();	// 이렇게?!
		System.out.println(seq);
		service.likeCountUp(seq);
		
		System.out.println(msg);		
		return msg;
	}
	
	//좋아요 취소
	@ResponseBody
	@RequestMapping(value = "delLikecheck.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String delLikecheck(LikecheckDto likecheck) {
		System.out.println("BbsController delLikecheck()");
		System.out.println(likecheck.toString());	
		String msg = service.delLikecheck(likecheck);
		
		// bbsDB로 좋아요 수 1감소 xml에서 SET LIKECOUNT = LIKECOUNT - 1
		// 좋아요 수(BBS DB에서 likeCount) 감소
		int seq = likecheck.getSeq_bbs();
		System.out.println(seq);
		service.likeCountDown(seq);
		
		System.out.println(msg);		
		return msg;
	}
	
	//좋아요 리스트
	@ResponseBody
	@RequestMapping(value = "getLikecheck.do", method = {RequestMethod.GET,RequestMethod.POST})
	public List<LikecheckDto> getLikecheck(int bbs_seq) {
		System.out.println("BbsController delLikecheck()");	
		List<LikecheckDto> list = service.getLikecheck(bbs_seq);
		System.out.println(list.toString());		
		return list;
	}
	
	
	// (게시글 번호에 따른) 전체 댓글 목록
	@ResponseBody
	@RequestMapping(value = "replylist.do", method = {RequestMethod.GET,RequestMethod.POST})
	public List<ReplyDto> replylist(int seq) {
		System.out.println("BbsController replylist()");
		System.out.println("seq = " + seq);
		
		List<ReplyDto> list = service.getReplyList(seq);
		System.out.println(list.toString());
		
		// // 댓글 수(BBS DB에서 commentCount ) -> ㄴㄴ 댓글 추가 삭제에서 완료함
	//	int replyCount = list.size();
	//	System.out.println("댓글 수 : " + replyCount);
	//	service.commentCount(seq);
		
		return list;
	}
	
	// 댓글 작성
	@ResponseBody
	@RequestMapping(value = "replywriteAf.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String replywrite(ReplyDto reply) {
		System.out.println("BbsController replywriteAf()");
		
		String msg = "";
		msg = service.writeReply(reply);
		// 댓글 수(BBS DB에서 commentCount) 증가
		int seq = reply.getSeq_bbs();
		System.out.println(seq);
		service.commentCountUp(seq);	// 댓글 삭제에서 commentCount -1하는 거 하고 주석 풀기
		
		return msg;
	}
	
	// 댓글 수정
	// 수정할 댓글 불러오기
	@ResponseBody
	@RequestMapping(value = "replyselect.do", method = {RequestMethod.GET,RequestMethod.POST})
	public ReplyDto replyselect(int rseq){
		System.out.println("BbsController replyselect()");
		System.out.println("rseq = " + rseq);
		
		ReplyDto reply = service.selectReply(rseq);
		
		System.out.println(reply.toString());
		
		return reply;
	}
	// 수정완료 버튼 클릭
	@ResponseBody
	@RequestMapping(value = "replyupdateAf.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String replyupdateAf(ReplyDto reply) {
		System.out.println("BbsController replyupdateAf()");
		System.out.println(reply.toString());
		
		String msg = "";
		msg = service.updateReply(reply);
		
		return msg;
		
	}
	
	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "replydelete.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String deleteReply(int rseq, int bbsSeq) {
		System.out.println("BbsController replydelete()");
		System.out.println("rseq = " + rseq);
		String deleteReply = service.deleteReply(rseq);
		// 댓글 수(BBS DB에서 commentCount) 감소
		// bbs의 seq (reply의 seq_bbs)를 가져올 방법이..
		System.out.println("bbsSeq : "+ bbsSeq);	// bbsdetail.jsp 댓글 삭제에서 bbs의 seq가져옴
		service.commentCountDown(bbsSeq);
		
		return deleteReply;
	}
	
	// 게시글 수정
	@RequestMapping(value = "bbsupdate.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String bbsupdate(Model model, int seq) {
		System.out.println("BbsController bbsupdate()");
		System.out.println("seq = " + seq);
		
		BbsDto bbs = service.getBbs(seq);
		String newfilename = bbs.getNewFilename();
		System.out.println(newfilename);	// 찍힘
		
		model.addAttribute("bbs", bbs);
		model.addAttribute("newfilename", newfilename); 	// 
		
		return "bbsupdate.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "bbsupdateAf.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String bbsupdateAf(BbsDto bbs,
							@RequestParam("fileload") MultipartFile multipartFile,
							HttpServletRequest req) {
		// newFilename이 null값일 때 다른 이름("") 주기	// 이거 없으면 작성완료 버튼 클릭 시 error !!
		if(bbs.getNewFilename() == null) {
			bbs.setNewFilename("");
		}
		
		System.out.println("BbsController bbsupdateAf()");
		System.out.println(multipartFile.getOriginalFilename());
		System.out.println(bbs.toString());
		
		String msg = "";
		
		// multipartFile이 null이 아닐 때 (이미지 업로드(수정)했을 때)
		if(multipartFile.getOriginalFilename() != "") {
			// upload 경로 설정
			// server
			String uploadPath = req.getServletContext().getRealPath("/upload");
			
			String originalFilename = multipartFile.getOriginalFilename(); // 원본 파일명
			long fileSize = multipartFile.getSize();	//파일 사이즈
			
			System.out.println("originalFilename : " + originalFilename);
			System.out.println("fileSize : " + fileSize);
			System.out.println("uploadPath : " + uploadPath);
			
			String newfilename = ActivityUtil.getNewFileName(originalFilename);	// -> 하고 나서 set newfile~하고 값 찍어보고 넘겨주기. PicturesDto 필요없음
			bbs.setNewFilename(newfilename);
			//일반파일명 -> new파일명 변경
			System.out.println("newfilename : " + newfilename);
			
			File file = new File(uploadPath + "/" + newfilename);
			
			try {
				// 실제 업로드
				FileUtils.writeByteArrayToFile(file, multipartFile.getBytes());
				System.out.println(bbs.toString());
				// 게시글 등록 (DB저장)
				msg = service.updateBbs(bbs);
				
			} catch (Exception e) {
				e.printStackTrace();
				msg = "fail";
			}
		}
		// 이미지 수정 없을 때
		try {
			System.out.println(bbs.toString());
			// 게시글 등록 (DB저장)
			msg = service.updateBbs(bbs);
			
		} catch (Exception e) {
			e.printStackTrace();
			msg = "fail";
		} 
		
		return msg;
	}
	
	// 게시글 삭제
	@ResponseBody
	@RequestMapping(value = "deleteBbs.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String deleteBbs(int seq) {
		System.out.println("BbsController bbsdelete()");
	
		//댓글삭제(게시글seq에따른댓글도전부같이삭제)
		
		
		String msg = service.deleteBbs(seq);
		return msg;
	}
	
	
	//메인 > 베스트 여행기
	@ResponseBody
	@RequestMapping(value = "main_refer_bbs.do", method = {RequestMethod.GET,RequestMethod.POST})
	public List<BbsDto> main_refer_bbs(){
		System.out.println("BbsController main_refer_bbs");
		List<BbsDto> list = service.main_refer_bbs();
		return list;
	}
	
	
	
	
	
	
	/* 커뮤니티 관리자 페이지 */
	
	// 게시글 작성
	@RequestMapping(value = "bbsManager.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String bbsManager(HttpServletRequest req, Model model) {
		System.out.println("BbsController bbsManager()");
		return "bbsM.tiles";
	}
	
	
	// 전체 게시글 목록
	@ResponseBody
	@RequestMapping(value = "bbsMlist.do", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> bbsMlist(BbsParam param) {
		System.out.println("BbsController bbsMlist");
		param.setStartdate(param.getStartdate().replace("-", ""));
		param.setEnddate(param.getEnddate().replace("-", ""));
		System.out.println(param.toString());
		
		int sn = param.getPageNumber();	// 0 1 2 3 4
		int start = 1 + sn * 10;		// 1	11
		int end = (sn + 1) * 10;		// 10	20
		
		param.setStart(start);
		param.setEnd(end);
		
		Map<String, Object> map = new HashMap<String, Object>();
		// 리스트 불러오기
		List<BbsDto> list = service.getBbsList(param);
		map.put("list", list);
		
		// 글의 총 수
		int totalCount = service.getBbsCount(param);
		map.put("totalCount", totalCount);
		
		// 페이징
		map.put("pageNumber", param.getPageNumber() + 1);
		
		// 검색
		map.put("search", param);
		
		return map;
	}
	
	// 게시글 작성
	@RequestMapping(value = "bbsMwrite.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String bbsMwrite(HttpServletRequest req, Model model) {
		System.out.println("BbsController bbsMwrite()");
		
		return "bbsMwrite.tiles";
	}
	
	@ResponseBody	// ajax 쓰려면 필수
	@RequestMapping(value = "bbsMwriteAf.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String bbsMwriteAf(BbsDto bbs,
							@RequestParam("fileload") MultipartFile multipartFile,
							HttpServletRequest req) {
		
		// newFilename이 null값일 때 다른 이름("") 주기	// 이거 없으면 작성완료 버튼 클릭 시 error !!
		if(bbs.getNewFilename() == null) {
			bbs.setNewFilename("");
		}
		
		System.out.println("BbsController bbsMwriteAf()");
		System.out.println(multipartFile.toString());
		System.out.println(bbs.toString());
		
		String msg = "";
			
		
		// upload 경로 설정
		// server
		String uploadPath = req.getServletContext().getRealPath("/upload");
		
		String originalFilename = multipartFile.getOriginalFilename(); // 원본 파일명
		long fileSize = multipartFile.getSize();	//파일 사이즈
		
		System.out.println("originalFilename : " + originalFilename);
		System.out.println("fileSize : " + fileSize);
		System.out.println("uploadPath : " + uploadPath);
		
		String newfilename = ActivityUtil.getNewFileName(originalFilename);	// -> 하고 나서 set newfile~하고 값 찍어보고 넘겨주기. PicturesDto 필요없음
		bbs.setNewFilename(newfilename);
		//일반파일명 -> new파일명 변경
		System.out.println("newfilename : " + newfilename);
		
		File file = new File(uploadPath + "/" + newfilename);
		
		try {
			// 실제 업로드
			FileUtils.writeByteArrayToFile(file, multipartFile.getBytes());
			System.out.println(bbs.toString());
			// 게시글 등록
			msg = service.writeBbs(bbs);
			
		} catch (Exception e) {
			e.printStackTrace();
			msg = "fail";
		} 
		
		
		return msg;
	}
	// 게시글 수정
	@RequestMapping(value = "bbsMupdate.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String bbsMupdate(Model model, int seq) {
		System.out.println("BbsController bbsMupdate()");
//		model.addAttribute("side_menu", "menu");
		System.out.println("seq = " + seq);
		
		BbsDto bbs = service.getBbs(seq);
		String newfilename = bbs.getNewFilename();
		System.out.println(newfilename);	// 찍힘
		
		model.addAttribute("bbs", bbs);
		model.addAttribute("newfilename", newfilename); 	// 
		
		return "bbsMupdate.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "bbsMupdateAf.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String bbsMupdateAf(BbsDto bbs,
							@RequestParam("fileload") MultipartFile multipartFile,
							HttpServletRequest req) {
		// newFilename이 null값일 때 다른 이름("") 주기	// 이거 없으면 작성완료 버튼 클릭 시 error !!
		if(bbs.getNewFilename() == null) {
			bbs.setNewFilename("");
		}
		
		System.out.println("BbsController bbsMupdateAf()");
		System.out.println(multipartFile.getOriginalFilename());
		System.out.println(bbs.toString());
		
		String msg = "";
		
		// multipartFile이 null이 아닐 때 (이미지 업로드(수정)했을 때)
		if(multipartFile.getOriginalFilename() != "") {
			// upload 경로 설정
			// server
			String uploadPath = req.getServletContext().getRealPath("/upload");
			
			String originalFilename = multipartFile.getOriginalFilename(); // 원본 파일명
			long fileSize = multipartFile.getSize();	//파일 사이즈
			
			System.out.println("originalFilename : " + originalFilename);
			System.out.println("fileSize : " + fileSize);
			System.out.println("uploadPath : " + uploadPath);
			
			String newfilename = ActivityUtil.getNewFileName(originalFilename);	// -> 하고 나서 set newfile~하고 값 찍어보고 넘겨주기. PicturesDto 필요없음
			bbs.setNewFilename(newfilename);
			//일반파일명 -> new파일명 변경
			System.out.println("newfilename : " + newfilename);
			
			File file = new File(uploadPath + "/" + newfilename);
			
			try {
				// 실제 업로드
				FileUtils.writeByteArrayToFile(file, multipartFile.getBytes());
				System.out.println(bbs.toString());
				// 게시글 등록 (DB저장)
				msg = service.updateBbs(bbs);
				
			} catch (Exception e) {
				e.printStackTrace();
				msg = "fail";
			}
		}
		// 이미지 수정 없을 때
		try {
			System.out.println(bbs.toString());
			// 게시글 등록 (DB저장)
			msg = service.updateBbs(bbs);
			
		} catch (Exception e) {
			e.printStackTrace();
			msg = "fail";
		} 
		
		return msg;
	}
}