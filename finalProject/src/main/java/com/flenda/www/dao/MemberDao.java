package com.flenda.www.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.flenda.www.dto.MemberDto;
import com.flenda.www.dto.SearchParam;

@Repository
public class MemberDao {
	
	@Autowired
	SqlSession session;
	
	String ns = "Member.";
	
	public int getId(String id) {		
		return session.selectOne(ns+ "getId", id);		
	}
	/* 0816 */
	public int getEmail(MemberDto mem) {
		return session.selectOne(ns+ "getEmail", mem);
	}

	public boolean addMember(MemberDto mem) {
		 System.out.println(mem.toString());
		 int n = session.insert(ns + "addMember", mem); 
		 return n>0?true:false;
	}

	public MemberDto login(MemberDto mem) {		
		return session.selectOne(ns + "login", mem);
	}
	public int add500point(String id) {
		return session.update(ns + "add500point", id);
	}
	public int add1000point(String id) {
		return session.update(ns + "add1000point", id);
	}
	
	public String getNewFilename(String id) {
		return session.selectOne(ns + "getNewFilename", id);
	}
	
	public int deductPoint(MemberDto mem) {
		return session.update(ns + "deductPoint", mem);
	}
	
	/* 0812 추가 */
	public MemberDto find(MemberDto mem) {
		return session.selectOne(ns + "find", mem);
		
	}

	public void logout(MemberDto mem, HttpSession session) {
		System.out.println("로그아웃");
		session.invalidate();
	}
	
	public int updatePwd(MemberDto mem) {
		return session.update(ns +"updatePw", mem);
	}
	
	public String findId(String email) {
		return session.selectOne(ns+ "findId", email);
	}


	public MemberDto readMember(String id){
		MemberDto mem = session.selectOne(ns +"readMember", id); 
		return mem;
	}
	
	public int deleteMember(String id) {
		return session.delete(ns + "deleteMember", id); 
	}
	
	public int checkIdEmail(MemberDto mem) {
		return session.selectOne(ns + "checkIdEmail", mem);
	}
	
	public int pwdCheck(MemberDto mem) {
		int result = session.selectOne(ns+ "pwdCheck", mem);
		return result;
	}
	
	public MemberDto getInfo(String id) {
		return session.selectOne(ns + "getInfo", id);
	}

	/* 회원정보수정 */
	public boolean updateInfo (MemberDto mem) {
		 int n = session.update(ns + "updateInfo", mem); 
		 return n>0?true:false;
	}
	
	/* 관리자페이지 */
	public List<MemberDto> getMemberList(SearchParam param) {
		return session.selectList(ns + "getMemberList", param);
	}
	
	/* 관리자페이지 회원 총 수 */
	public int memCount(SearchParam param) {
		return session.selectOne(ns+ "memCount", param);
	}
	
	/* 관리자페이지 회원정보 수정 */
	public boolean memUpdateAf (MemberDto mem) {
		 int n = session.update(ns + "memUpdateAf", mem); 
		 return n>0?true:false;
	}
}
