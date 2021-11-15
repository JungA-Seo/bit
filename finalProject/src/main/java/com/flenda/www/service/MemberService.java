package com.flenda.www.service;



import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flenda.www.dao.MemberDao;
import com.flenda.www.dto.MemberDto;
import com.flenda.www.dto.SearchParam;



@Service
public class MemberService {

	@Autowired
	MemberDao dao;
	
	 public String getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
//            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
//           StringBuilder sb = new StringBuilder();
//            sb.append("grant_type=authorization_code");
//            sb.append("&client_id=283fba8c8b4d06934c3d02b2f8fc3fd0");  //본인이 발급받은 key
//           sb.append("&redirect_uri=http://localhost:8090/flenda/loginKakao.do");     // 본인이 설정해 놓은 경로
//            sb.append("&code=" + authorize_code);
//            bw.write(sb.toString());
//            bw.flush();

            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
			
            //JAVA Stringg 타입을 JSON 타입으로 형변환 및 JSON 값 가져오기 
            JSONParser parser = new JSONParser();
            Object obj = parser.parse(result);
			JSONObject jsonObj = (JSONObject)obj;

			access_Token = (String)jsonObj.get("access_token");
			refresh_Token = (String)jsonObj.get("refresh_token");
			
			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);
			
            br.close();
//          bw.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return access_Token;
    } 
	 public String getUserInfo (String access_Token, HttpServletRequest req) {

         //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		 String msg = "";
         String reqURL = "https://kapi.kakao.com/v2/user/me";
         try {
             URL url = new URL(reqURL);
             HttpURLConnection conn = (HttpURLConnection) url.openConnection();
             conn.setRequestMethod("GET");

             //    요청에 필요한 Header에 포함될 내용
             conn.setRequestProperty("Authorization", "Bearer " + access_Token);

             int responseCode = conn.getResponseCode();
             System.out.println("responseCode : " + responseCode);

             BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

             String line = "";
             String result = "";

             while ((line = br.readLine()) != null) {
                 result += line;
             }
             System.out.println("response body : " + result);

             //JAVA Stringg 타입을 JSON 타입으로 형변환 및 JSON 값 가져오기 
             JSONParser parser = new JSONParser();
             Object obj = parser.parse(result);
 			 JSONObject jsonObj = (JSONObject)obj;
 			 
 			 JSONObject properties = (JSONObject)jsonObj.get("properties");
 			 JSONObject kakao_account = (JSONObject)jsonObj.get("kakao_account");
 			 
 			 String id = (Long)jsonObj.get("id") + "";
             String name = (String)properties.get("nickname");
             String email = (String)kakao_account.get("email");

             System.out.println("id : "+ id + " nickname : "+ name + " email : "+ email);
             int idcheck = dao.getId(id);
             if(idcheck == 0) {	// 카카오에서 온 아이디의 db 존재여부 확인 -> 1은 있음 // 0은 없음
	             boolean answer = dao.addMember(new MemberDto(id, "kakao", name, "", "", "", "", "", "", email, 4, 0));
	             if(answer) {
	            	 msg = "success";
	            	 MemberDto login = dao.login(new MemberDto(id, "kakao", "", "", "", "", "", "", "", "", 0, 0));
	            	 if(login != null) {
	            		req.getSession().setAttribute("login", login);
	       			  	req.getSession().setMaxInactiveInterval(60 * 60 * 24); 
	            	 }
	             }else {
	            	 msg = "fail";
	             }
             }else {
            	 msg = "success";
            	 MemberDto login = dao.login(new MemberDto(id, "kakao", "", "", "", "", "", "", "", "", 0, 0));
            	 if(login != null) {
            		req.getSession().setAttribute("login", login);
       			  	req.getSession().setMaxInactiveInterval(60 * 60 * 24); 
            	 }
             }
         } catch (Exception e) {
        	 msg = "fail";
             e.printStackTrace();
         }
         return msg;
     }

	public int getId(String id) {		
		return dao.getId(id);
	}
	
	/* 0816 */
	public int getEmail(MemberDto mem) {
		int result = dao.getEmail(mem);
		return result;
	}

	public boolean addMember(MemberDto mem) {
      if(mem.getBusinessNumber() != "-" && mem.getBusinessName() != "-") {
         // auth 2 판매자회원
         mem.setAuth(2);
         System.out.println(mem.toString());
      } 
      if(mem.getPwd() != "" && mem.getBusinessNumber() == "-") { 
         // auth 3 개인회원
         mem.setAuth(3);
         System.out.println(mem.toString());
      }
      if(mem.getPwd() == "") {   // naver,kakao
         // auth 4 네이버회원 
         mem.setAuth(4);
         mem.setPwd("naver");
      }
      return dao.addMember(mem);
   }
/* 0812 추가 */
	
	//이메일발송
	public void sendEmail(MemberDto mem, String div) throws Exception {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com"; //네이버 이용시 smtp.naver.com
		String hostSMTPid = "flenda222@gmail.com"; // 안되면 아이디만 남겨두기 
		String hostSMTPpwd = "vmffpsek222";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "flenda222@gmail.com";
		String fromName = "Flenda";
		String subject = "";
		String msg = "";

		if(div.equals("findpw")) {
			subject = "Flenda 임시 비밀번호 입니다.";
			msg += "<div align='center' style='font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += mem.getId() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += mem.getPwd() + "</p></div>";
			msg += "<div align='center'><a href='http://localhost:8090/flenda/login.do'><button style='padding: 10px; backgournd-color: #0064CD; border-radius: 50px; color: black; border-style: none; '>LOGIN</button></a></div>";
		}

		// 받는 사람 E-Mail 주소
		String mail = mem.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(587); //네이버 이용시 587

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}
	
	
	//비밀번호찾기
	public String findPw(HttpServletResponse resp, MemberDto mem) throws Exception {
		MemberDto ck = dao.readMember(mem.getId());
		String msg = "";
		// 임시 비밀번호 생성
		String pwd = "";
		for (int i = 0; i < 12; i++) {
			pwd += (char) ((Math.random() * 26) + 97);
		}
		System.out.println("pwd :"+pwd);
		mem.setPwd(pwd);
		// 비밀번호 변경
		int answer = dao.updatePwd(mem);
		if(answer > 0) {
			msg = "success";
		}else {
			msg = "fail";
		}
		// 비밀번호 변경 메일 발송
		sendEmail(mem, "findpw");
		return msg;
	}
	
	
	public String findId(String email) {
		return dao.findId(email); 
	}

	public MemberDto login(MemberDto mem) {		
		return dao.login(mem);
	}	
	public String add500point(String id) {
		return dao.add500point(id)>0?"success":"fail";
	}
	public int add1000point(String id) {
		return dao.add1000point(id);
	}
	
	public String getNewFilename(String id) {
		return dao.getNewFilename(id);
	}
	
	public String deductPoint(MemberDto mem) {
		return dao.deductPoint(mem)>0?"success":"fail";
	}
	
	public MemberDto readMember(String id) {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
		return dao.readMember(id);
	}
	public int checkIdEmail(MemberDto mem) {
		return dao.checkIdEmail(mem);
	}
	
	public int deleteMember(String id) {
	 	return dao.deleteMember(id);
	 }
	 
	public int pwdCheck(MemberDto mem) {
		int result = dao.pwdCheck(mem);
		return result;
	}
	
	public MemberDto getInfo(String id) {
		return dao.getInfo(id);
	}

	/* 회원정보수정 */
	public boolean updateInfo (MemberDto mem) {
		return dao.updateInfo(mem);
	}
	
	/* 관리자 페이지 */
	public List<MemberDto> getMemberList(SearchParam param) {
		return dao.getMemberList(param);
	} 
	
	/* 관리자페이지 회원 총 수 */
	public int memCount(SearchParam param) {
		return dao.memCount(param);
	}
	
	/* 관리자페이지 회원정보수정 */ 
	public boolean memUpdateAf (MemberDto mem) {
		return dao.memUpdateAf(mem);
	}
}