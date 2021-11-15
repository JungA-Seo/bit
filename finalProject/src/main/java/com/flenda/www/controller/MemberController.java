package com.flenda.www.controller;


import java.io.File;
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

import com.flenda.www.dto.MemberDto;
import com.flenda.www.dto.SearchParam;
import com.flenda.www.service.MemberService;
import com.flenda.www.util.ActivityUtil;


@Controller
public class MemberController {

	@Autowired
	MemberService service;
	
	  @RequestMapping(value = "login.do", method = RequestMethod.GET) 
	  public String login(Model model) { 
		  System.out.println("MemberController login");
		  model.addAttribute("top_menu", "no");
	   return "login.tiles";
	  
	 }
	 
	 @RequestMapping(value ="loginKakao.do" , method = {RequestMethod.GET,RequestMethod.POST })
	 public String loginKakao(@RequestParam(value = "code", required = false) String code, Model model, HttpServletRequest req) {
		 System.out.println(code);
//		 String access_Token = service.getAccessToken(code);
//		 System.out.println("access_Token : "+ access_Token);
//		 String msg = service.getUserInfo(access_Token, req);
		 model.addAttribute("top_menu", "yes");
//		 model.addAttribute("msg", msg);
		 return "main.tiles";
	 }
	 
	@RequestMapping(value = "regi.do", method = {RequestMethod.GET,RequestMethod.POST })
	public String regi(String param, Model model) {
		model.addAttribute("personType", param);
		System.out.println("MemberController regi");
		System.out.println(param);
		
		return "regi.tiles";
	}

	@ResponseBody
	@RequestMapping(value = "getId.do", method = RequestMethod.POST)
	public String getId(MemberDto mem) {
		System.out.println("MemberController getId");

		int count = service.getId(mem.getId());
		String msg = "";
		if (count > 0) {
			msg = "YES"; // 사용할수없음
			System.out.println("존재하는 아이디");
		}
		else {
			msg = "NO";
			System.out.println("존재하지않는 아이디");
		}
		return msg;
	}
	
	/* 0816 */
	@ResponseBody
	@RequestMapping(value="getEmail.do", method = {RequestMethod.GET,RequestMethod.POST })
	public String getEmail(MemberDto mem) {
		System.out.println("MemberController getEmail");
		
		int count = service.getEmail(mem);
		String msg = "";
		if (count > 0) {
			msg = "YES"; // 사용할수없음
			System.out.println("존재하는 이메일");
		}
		else {
			msg = "NO";
			System.out.println("존재하지않는 이메일");
		}
		return msg;
	}
	
		@ResponseBody
	   @RequestMapping(value = "regiAf.do", method = {RequestMethod.GET,RequestMethod.POST })
	   public String regiAf(MemberDto dto, 
	                   @RequestParam(value = "fileload", required = false) MultipartFile fileload, 
	                   HttpServletRequest req ) {
	      System.out.println("MemberController regiAf");
	      if(dto.getBusinessName() == null) {
	         dto.setBusinessName("-");
	         
	      }
	      if(dto.getBusinessNumber() == null) {
	         dto.setBusinessNumber("-");
	      }
	   
	      //filename(원본) 취득
	         String filename = fileload.getOriginalFilename();
	         
	         // 서버 upload 경로설정
	         String fupload = req.getServletContext().getRealPath("/upload"); // 서버에 저장하는 폴더 경로 잡아주기
	         
	         System.out.println("server path fupload:" + fupload);
	         
	         //일반파일명 -> new파일명 변경
	         String newFilename = ActivityUtil.getNewFileName(filename);
	         dto.setNewFilename(newFilename);
	         
	         //파일업로드
	         File file = new File(fupload + "/" + newFilename);
	         String msg = "no";
	         try {
	            //파일 실제로 업로드
	            FileUtils.writeByteArrayToFile(file, fileload.getBytes());   // file와 fileload를 바이트단위로 넣기
	            System.out.println(dto.toString());
	            // DB에 저장
	            boolean b = service.addMember(dto);
	            if (b) {
	             msg = "yes";
	          }
	         } catch (Exception e) {
	            e.printStackTrace();
	         }         
	      return msg;
	   }

	
	 @RequestMapping(value ="logout.do", method={RequestMethod.GET,RequestMethod.POST })
	 public String logout(HttpServletRequest req) {
		 System.out.println("MemberController logout");
		 MemberDto mem = (MemberDto)req.getSession().getAttribute("login");
		 System.out.println(mem.toString());
	
		 req.getSession().invalidate(); //로그아웃
		 return "redirect:/main.do";
	 }
	 
	 /* 0812 */
	 	@ResponseBody
		@RequestMapping(value = "loginAf.do", method = {RequestMethod.GET,RequestMethod.POST })
		public MemberDto loginAf(MemberDto dto, HttpServletRequest req) {
			System.out.println("MemberController loginAf"); //로그인 전
			  System.out.println(dto.toString());
			  
			 MemberDto login = service.login(dto); //로그인 후
			 
			 if (login != null && !login.getId().equals("")) {
			  req.getSession().setAttribute("login", login);
			  req.getSession().setMaxInactiveInterval(60 * 60 * 24); 
			  System.out.println(login.toString());
			} 
		 	return login;  
		 }
	 	
		@ResponseBody
		@RequestMapping(value = "loginApi.do", method = {RequestMethod.GET,RequestMethod.POST })
		public String loginApi(MemberDto dto, HttpServletRequest req) {
		System.out.println("MemberController loginApi"); //로그인 전
		System.out.println(dto.toString());
		String msg = "no";
		 boolean login = service.addMember(dto); //로그인 후
		 if(login == true) {
			 msg = "yes";
		 }
		  return msg; 
		}
		
		@ResponseBody
		@RequestMapping(value = "loginApiAf.do", method = {RequestMethod.GET,RequestMethod.POST })
		public String loginApiAf(String name, String email, String id,HttpServletRequest req) {
			System.out.println("MemberController loginApiAf");
	         System.out.println("name :" + name);
	         System.out.println("email :" + email);
	         System.out.println("id :" + id);         
	         String msg = "fail";
	         int idcheck = service.getId(id);
	         if(idcheck == 0) {   // 카카오에서 온 아이디의 db 존재여부 확인 -> 1은 있음 // 0은 없음
	            boolean answer = service.addMember(new MemberDto(id, "", name, "-", "-", "-", "-", "-", "", email, 4, 0));
	                if(answer) {
	                   msg = "success";
	                   MemberDto login = service.login(new MemberDto(id, "naver", "", "", "", "", "", "", "", "", 0, 0));
	                   if(login != null) {
	                     req.getSession().setAttribute("login", login);
	                        req.getSession().setMaxInactiveInterval(60 * 60 * 24); 
	                   }
	                }else {
	                   msg = "fail";
	                }
	         }else {
	            msg = "success";
	                  MemberDto login = service.login(new MemberDto(id, "naver", "", "", "", "", "", "", "", "", 0, 0));
	                  if(login != null) {
	                     req.getSession().setAttribute("login", login);
	                    req.getSession().setMaxInactiveInterval(60 * 60 * 24); 
	                  }
	         }
	         
	         return msg;
		}
		 /*0812 추가*/
			
		  @RequestMapping(value ="findId.do", method={RequestMethod.GET,RequestMethod.POST}) 
		  public String findId() { 
			  System.out.println("MemberController findId");
			  return "findId.tiles"; 
		  
		  }
			
		  @ResponseBody // ajax 사용시
		  @RequestMapping(value = "findIdAf.do", method={RequestMethod.GET,RequestMethod.POST}) 
		  public String findIdAf(String email) {
			  System.out.println("MemberController findIdAf");
			  String id = service.findId(email);
			  System.out.println("id : " + id);
			  return id;
		  }
		  
		  /* 비밀번호 찾기 */
		  @RequestMapping(value = "findPw.do", method ={RequestMethod.GET,RequestMethod.POST})
		  	public String findPwGET() throws Exception{
			  	System.out.println("MemberController findPw");
			  	return "find.tiles";
		  	}

		  @ResponseBody //  ajax 사용시
		  @RequestMapping(value = "findPwPost.do", method ={RequestMethod.GET,RequestMethod.POST})
		  	public String findPwPOST( MemberDto mem, HttpServletResponse resp) throws Exception{
			    System.out.println(mem.toString());
			    String answer = "";
			    if(service.checkIdEmail(mem)>0) {
			    	answer = service.findPw(resp, mem);
			    }else {
			    	answer = "fail";
			    }
		  		return answer;
		  }
		  
		  @ResponseBody //  ajax 사용시
		  @RequestMapping(value="deleteMember.do", method={RequestMethod.GET,RequestMethod.POST}) 
		  public int deleteMember(String id) {
		     System.out.println("MemberController deleteMember"); 
		     
		     int result = service.deleteMember(id);
			  
			 return result;
		  
		  }
		  
	     /* 관리자페이지  getMemberList.do */
		  @RequestMapping(value = "memManagement.do", method = RequestMethod.GET)
			public String memberManagement(){
				
				return "memManagement.tiles" ;
			}
		  
		  /*관리자페이지 리스트뿌리기*/
		  @ResponseBody
		  @RequestMapping(value="getMemberList.do",  method={RequestMethod.GET,RequestMethod.POST}) 
		  public Map<String,Object> getMemberList(SearchParam param, Model model) {
				System.out.println("MemberController getMemberList");
				model.addAttribute("top_menu", "no");
				
				System.out.println("param:" + param.toString());
				 
				if(param.getStartdate() != null && param.getEnddate() != null) {
				   param.setStartdate(param.getStartdate().replace("-", ""));
				   param.setEnddate(param.getEnddate().replace("-", ""));
				  }

				System.out.println("startdate:" + param.getStartdate());
				System.out.println("enddate:" + param.getEnddate());
				
				//현재 페이지넘버
				int start , end;
				start = 1 + 10 * param.getPageNumber();  
				end = 10 + 10 * param.getPageNumber();
				
				param.setStart(start);
				param.setEnd(end);
				
				//db에서 전체 목록 불러와서 list에 넣기. 
				List<MemberDto> list = service.getMemberList(param);
				
				for(int i = 0; i<list.size(); i++) {
					//판매자 회원가입 수정하기
						if(list.get(i).getBusinessName()==null) {
							list.get(i).setBusinessName("-");
							list.get(i).setBusinessNumber("-");
						}
						if(list.get(i).getAddress()==null) {
							list.get(i).setAddress("-");
						}
						if(list.get(i).getGender()==null) {
							list.get(i).setGender("-");
						}
				};
	
				
				System.out.println(list.toString());
				//search, choice값 체크
				model.addAttribute("param", param);
						
				//총 회원수
				int totalCount = service.memCount(param);
				System.out.println("총 회원수" +totalCount);
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("search", param);
				map.put("totalCount", totalCount);
				map.put("memberlist", list);
				
						
				//현재 페이지
//				model.addAttribute("pageNumber" , param.getPageNumber()+1);
//				
				return map;
			} 
		  
			/* 관리자페이지 회원정보수정 */
		  @RequestMapping(value="memUpdate.do",method={RequestMethod.GET,RequestMethod.POST}) 
		  public String memUpdate(String id, Model model) { 
			  System.out.println("MemberController memUpdate");
			  
			  MemberDto mem = service.getInfo(id);
			  model.addAttribute("mem", mem);
			  
		   return "memUpdate.tiles";
		  
		 }
		  
		  //관리자페이지 회원정보 수정 후 
		  @ResponseBody
		  @RequestMapping(value="memUpdateAf.do", method = {RequestMethod.GET,RequestMethod.POST}) 
		  public String memUpdateAf(Model model, MemberDto mem, 
				  					@RequestParam(value = "fileload", required = false) MultipartFile fileload, 
				  					HttpServletRequest req){
			  String msg = "no";
			  
			  System.out.println("memUpdateAf :" + mem.toString());
			  System.out.println("MemberController memUpdateAf");
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
			      } catch (Exception e) {
			         e.printStackTrace();
			      }  
			  }
			  // DB에 저장
			  boolean b = service.memUpdateAf(mem);
		      if (b) {
		    	 msg = "yes";
		 	  }
		  return msg;
		  }
		  
			/* 관리자페이지 회원등록화면으로 이동 */
		  @RequestMapping(value = "memInsert.do", method = RequestMethod.GET) 
		  public String memInsert() { 
			  System.out.println("MemberController memInsert");
		   return "memInsert.tiles";
		 }
			/* 관리자페이지 회원등록 후 */
			@ResponseBody
			@RequestMapping(value = "memInsertAf.do", method = {RequestMethod.GET,RequestMethod.POST })
			public String memInsertAf(MemberDto dto, 
								 @RequestParam(value = "fileload", required = false) MultipartFile fileload, 
								 HttpServletRequest req ) {
				System.out.println("MemberController memInsertAf");
				if(dto.getBusinessName() == null) {
					dto.setBusinessName("");
					
				}
				if(dto.getBusinessNumber() == null) {
					dto.setBusinessNumber("");
				}
			
				//filename(원본) 취득
			      String filename = fileload.getOriginalFilename();
			      
			      // 서버 upload 경로설정
			      String fupload = req.getServletContext().getRealPath("/upload"); // 서버에 저장하는 폴더 경로 잡아주기
			      
			      System.out.println("server path fupload:" + fupload);
			      
			      //일반파일명 -> new파일명 변경
			      String newFilename = ActivityUtil.getNewFileName(filename);
			      dto.setNewFilename(newFilename);
			      
			      //파일업로드
			      File file = new File(fupload + "/" + newFilename);
			      String msg = "no";
			      try {
			         //파일 실제로 업로드
			         FileUtils.writeByteArrayToFile(file, fileload.getBytes());   // file와 fileload를 바이트단위로 넣기
			         System.out.println(dto.toString());
			         // DB에 저장
			         boolean b = service.addMember(dto);
			         if (b) {
			 			msg = "yes";
			 		}
			      } catch (Exception e) {
			         e.printStackTrace();
			      }   		
				return msg;
			}
			
			
}