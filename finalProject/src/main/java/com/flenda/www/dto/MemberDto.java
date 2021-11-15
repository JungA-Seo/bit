/*
CREATE TABLE MEMBER(
    SEQ NUMBER UNIQUE NOT NULL, 
    ID VARCHAR2(200) PRIMARY KEY, -- 회원 아이디 // 0817 수정
    PWD VARCHAR2(50) NOT NULL, -- 비밀번호
    NAME VARCHAR2(50) NOT NULL, -- 이름
    businessName VARCHAR2(50) NOT NULL, -- 회사/사업자명
    businessNumber VARCHAR2(200) NOT NULL, -- 사업자 등록 번호
    address VARCHAR2(100) NOT NULL,  -- 주소 
    gender VARCHAR2(10), -- 성별
    birthday VARCHAR2(50) NOT NULL, -- 생년월일
    newFilename VARCHAR2(200), --파일이름
    email VARCHAR2(100) NOT NULL, -- 이메일
    auth NUMBER NOT NULL, -- 권한 ( 개인 3, 판매자 2, 관리자 1, 소셜로그인 4)
    POINT NUMBER, -- 포인트  
    joindate DATE NOT NULL
);

--SEQ 생성
CREATE SEQUENCE MEM_SEQ
INCREMENT BY 1 
START WITH 1;

--테이블 삭제(무결성)
DROP TABLE MEMBER
CASCADE CONSTRAINTS;
--SEQ 삭제
DROP SEQUENCE MEM_SEQ;s
*/
package com.flenda.www.dto;

import java.io.Serializable;

public class MemberDto implements Serializable {
	
	private int seq;
	private String id;
	private String pwd;
	private String name;
	private String businessName;
	private String businessNumber;
	private String address;
	private String gender;
	private String birthday;
	private String newFilename;
	private String email;
	private int auth;
	private int point;
	private String joindate;

	public MemberDto() {
	}

	public MemberDto(int seq, String id, String pwd, String name, String businessName, String businessNumber,
			String address, String gender, String birthday, String newFilename, String email, int auth, int point,
			String joindate) {
		super();
		this.seq = seq;
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.businessName = businessName;
		this.businessNumber = businessNumber;
		this.address = address;
		this.gender = gender;
		this.birthday = birthday;
		this.newFilename = newFilename;
		this.email = email;
		this.auth = auth;
		this.point = point;
		this.joindate = joindate;
	}

	public MemberDto(String id, String pwd, String name, String businessName, String businessNumber, String address,
			String gender, String birthday, String newFilename, String email, int auth, int point) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.businessName = businessName;
		this.businessNumber = businessNumber;
		this.address = address;
		this.gender = gender;
		this.birthday = birthday;
		this.newFilename = newFilename;
		this.email = email;
		this.auth = auth;
		this.point = point;
	}
	
	public MemberDto(String id, int point) {
		super();
		this.id = id;
		this.point = point;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBusinessName() {
		return businessName;
	}

	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}

	public String getBusinessNumber() {
		return businessNumber;
	}

	public void setBusinessNumber(String businessNumber) {
		this.businessNumber = businessNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getNewFilename() {
		return newFilename;
	}

	public void setNewFilename(String newFilename) {
		this.newFilename = newFilename;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getJoindate() {
		return joindate;
	}

	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}

	@Override
	public String toString() {
		return "MemberDto [seq=" + seq + ", id=" + id + ", pwd=" + pwd + ", name=" + name + ", businessName="
				+ businessName + ", businessNumber=" + businessNumber + ", address=" + address + ", gender=" + gender
				+ ", birthday=" + birthday + ", newFilename=" + newFilename + ", email=" + email + ", auth=" + auth
				+ ", point=" + point + ", joindate=" + joindate + "]";
	}
	
}

	