/*
CREATE TABLE WISH(
	WISHSEQ NUMBER PRIMARY KEY,
	ID VARCHAR2(100),
	SELLSEQ NUMBER,
	WDATE DATE NOT NULL
);

--SEQ 생성
CREATE SEQUENCE WISH_SEQ
INCREMENT BY 1 -- 1씩 증가
START WITH 1; -- 1부터 시작

-- FK 생성
ALTER TABLE WISH
ADD CONSTRAINT FK_WISH_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);

--테이블 삭제(무결성)  
DROP TABLE WISH
CASCADE CONSTRAINTS;

--SEQ 삭제
DROP SEQUENCE WISH_SEQ;
*/
package com.flenda.www.dto;

public class WishDto {
	
	private int wishseq;	// 위시번호 
	private String id;		// 아이디
	private int sellseq;	// 판매번호
	private String wdate;	// 등록일
	
	public WishDto() {
	}
	
	public WishDto(int wishseq, String id, int sellseq, String wdate) {
		super();
		this.wishseq = wishseq;
		this.id = id;
		this.sellseq = sellseq;
		this.wdate = wdate;
	}

	
	public WishDto(String id, int sellseq) {
		super();
		this.id = id;
		this.sellseq = sellseq;
	}

	public int getWishseq() {
		return wishseq;
	}

	public void setWishseq(int wishseq) {
		this.wishseq = wishseq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getSellseq() {
		return sellseq;
	}

	public void setSellseq(int sellseq) {
		this.sellseq = sellseq;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	@Override
	public String toString() {
		return "WishDto [wishseq=" + wishseq + ", id=" + id + ", sellseq=" + sellseq + ", wdate=" + wdate + "]";
	}
	
}
