package com.flenda.www.dto;

import java.io.Serializable;


/*
CREATE TABLE REVIEW(
    reviewSeq NUMBER CONSTRAINT PK_REV_SEQ PRIMARY KEY, -- 후기 번호
    SELLSEQ NUMBER NOT NULL, -- 판매 번호
    ID VARCHAR2(50) NOT NULL, -- 아이디
    USERIMG VARCHAR2(200), -- 프로필 이미지
    CONTENT VARCHAR2(3000), -- 후기 내용
    FILENAME VARCHAR2(100), -- 후기 이미지
    REGIDATE DATE NOT NULL, -- 후기 작성일
    RESCORE NUMBER NOT NULL -- 후기 점수
)

--SEQ 생성
CREATE SEQUENCE REV_SEQ
INCREMENT BY 1 -- 1씩 증가
START WITH 1; -- 1부터 시작

-- REVIEW TABLE의 ID 값을 MEMBER TABLE의 PK인 ID와 연결
ALTER TABLE REVIEW
ADD CONSTRAINT FK_REV_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);

-- REVIEW TABLE의 SELLSEQ 값을 THEME TABLE의 PK인 SELLSEQ와 연결
ALTER TABLE REVIEW
ADD CONSTRAINT FK_REV_SEQ FOREIGN KEY(SELLSEQ)
REFERENCES THEME(SELLSEQ);

-- REVIEW TABLE의 SELLSEQ 값을 ACTIVITY TABLE의 PK인 SELLSEQ와 연결
ALTER TABLE REVIEW
ADD CONSTRAINT FK_REV_SEQ2 FOREIGN KEY(SELLSEQ)
REFERENCES ACTIVITY(SELLSEQ);
  
--테이블 삭제(무결성)
DROP TABLE REVIEW
CASCADE CONSTRAINTS;

--SEQ 삭제
DROP SEQUENCE REV_SEQ;
 */


public class ReviewDto implements Serializable {

	private int reviewSeq;  //리뷰번호 
	private int sellSeq;	//판매상품번호 
	private String id;		//리뷰작성자아이디
	private String userImg;	//작성자프로필사진
	private String content;	//리뷰내용 
	private String fileName;//리뷰작성시 이미지파일 
	private String regidate;//리뷰작성일
	private int rescore;	//리뷰별점 
	
	public ReviewDto() {
		
	}

	public ReviewDto(int reviewSeq, int sellSeq, String id, String userImg, String content, String fileName,
			String regidate, int rescore) {
		super();
		this.reviewSeq = reviewSeq;
		this.sellSeq = sellSeq;
		this.id = id;
		this.userImg = userImg;
		this.content = content;
		this.fileName = fileName;
		this.regidate = regidate;
		this.rescore = rescore;
	}

	public int getReviewSeq() {
		return reviewSeq;
	}

	public void setReviewSeq(int reviewSeq) {
		this.reviewSeq = reviewSeq;
	}

	public int getSellSeq() {
		return sellSeq;
	}

	public void setSellSeq(int sellSeq) {
		this.sellSeq = sellSeq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserImg() {
		return userImg;
	}

	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getRegidate() {
		return regidate;
	}

	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}

	public int getRescore() {
		return rescore;
	}

	public void setRescore(int rescore) {
		this.rescore = rescore;
	}

	@Override
	public String toString() {
		return "ReviewDto [reviewSeq=" + reviewSeq + ", sellSeq=" + sellSeq + ", id=" + id + ", userImg=" + userImg
				+ ", content=" + content + ", fileName=" + fileName + ", regidate=" + regidate + ", rescore=" + rescore
				+ "]";
	}
}
