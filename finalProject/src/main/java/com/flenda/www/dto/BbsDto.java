/*
CREATE TABLE BBS(
SEQ NUMBER CONSTRAINT PK_BBS_SEQ PRIMARY KEY, -- 글 번호
ID VARCHAR2(50), -- 작성자
CATEGORY VARCHAR2(50) NOT NULL, -- 카테고리 (여행기, 잡담 등...)
TITLE VARCHAR2(300) NOT NULL, -- 제목
CONTENT CLOB NOT NULL, -- 내용
NEWFILENAME VARCHAR2(200), -- 이미지
ADDRESS VARCHAR2(100), -- 주소 (사용자가텍스트로직접입력하는용)
AREA VARCHAR2(50), -- 지역 (선택용)
WDATE DATE NOT NULL, -- 작성일
READCOUNT NUMBER, -- 조회수
LIKECOUNT NUMBER, -- 좋아요수
COMMENTCOUNT NUMBER, -- 댓글수
PROFILEIMG VARCHAR2(100) -- 작성자이미지
);
--

-- SEQ 생성
CREATE SEQUENCE SEQ_BBS
START WITH 1
INCREMENT BY 1;

-- FK생성
ALTER TABLE BBS
ADD CONSTRAINT FK_BBS_ID FOREIGN KEY (ID)
REFERENCES MEMBER(ID);

-- 테이블 삭제 (무결성)
DROP TABLE BBS
CASCADE CONSTRAINTS;

-- SEQ 삭제
DROP SEQUENCE SEQ_BBS;

*/

package com.flenda.www.dto;

import java.io.Serializable;

public class BbsDto implements Serializable{
	
	private int seq;	// 글 번호
	
	private String id;	// 아이디
	private String profileImg; // 작성자 이미지
	private String category;	// 글 종류 : 여행기, 잡담, 메모 ...
	private String title;	// 글 제목
	private String content;	// 글 내용
	
	private String newFilename;	// 파일명 (이미지 업로드용)
	private String address;	// 주소 (사용자 텍스트 입력)
	private String area;	// 지역 (선택용)
	
	private String wdate;	// 작성일
	
	private int readCount;	// 조회수
	private int likeCount;	// 좋아요수
	private int commentCount;	// 댓글수
	
	private int likeCheck;	// 좋아요 여부
		

	public BbsDto() {
	}
	
	public BbsDto(int seq, String id, String profileImg, String category, String title, String content,
			String newFilename, String address, String area, String wdate, int readCount,
			int likeCount, int commentCount, int likeCheck) {
		super();
		this.seq = seq;
		this.id = id;
		this.profileImg = profileImg;
		this.category = category;
		this.title = title;
		this.content = content;
		this.newFilename = newFilename;
		this.address = address;
		this.area = area;
		this.wdate = wdate;
		this.readCount = readCount;
		this.likeCount = likeCount;
		this.commentCount = commentCount;
		this.likeCheck = likeCheck;
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



	public String getCategory() {
		return category;
	}



	public void setCategory(String category) {
		this.category = category;
	}



	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.title = title;
	}



	public String getContent() {
		return content;
	}



	public void setContent(String content) {
		this.content = content;
	}



	public String getNewFilename() {
		return newFilename;
	}



	public void setNewFilename(String newFilename) {
		this.newFilename = newFilename;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public String getArea() {
		return area;
	}



	public void setArea(String area) {
		this.area = area;
	}


	public String getWdate() {
		return wdate;
	}



	public void setWdate(String wdate) {
		this.wdate = wdate;
	}



	public int getReadCount() {
		return readCount;
	}



	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}



	public int getLikeCount() {
		return likeCount;
	}



	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}



	public int getCommentCount() {
		return commentCount;
	}



	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}


	public int getLikeCheck() {
		return likeCheck;
	}


	public void setLikeCheck(int likeCheck) {
		this.likeCheck = likeCheck;
	}
	

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	@Override
	public String toString() {
		return "BbsDto [seq=" + seq + ", id=" + id + ", profileImg=" + profileImg + ", category=" + category
				+ ", title=" + title + ", content=" + content + ", newFilename=" + newFilename + ", address=" + address
				+ ", area=" + area + ", wdate=" + wdate + ", readCount=" + readCount + ", likeCount=" + likeCount
				+ ", commentCount=" + commentCount + ", likeCheck=" + likeCheck + "]";
	}

}