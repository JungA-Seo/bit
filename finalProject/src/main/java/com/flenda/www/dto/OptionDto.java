package com.flenda.www.dto;

import java.io.Serializable;

/*
CREATE TABLE OPTIONS(
    optionSeq NUMBER PRIMARY KEY, -- 옵션 번호
    sellSeq NUMBER, -- 판매 번호
    opcontent VARCHAR2(500), -- 옵션 내용
    startDate VARCHAR2(100) NOT NULL, -- 시작일(유효기간)
    endDate VARCHAR2(100) NOT NULL, -- 종료일(유효기간)
    maxPeople NUMBER NOT NULL, -- 최대 판매 인원
    opPrice NUMBER NOT NULL -- 가격
);
--SEQ 생성
CREATE SEQUENCE OPT_SEQ
INCREMENT BY 1 -- 1씩 증가
START WITH 1; -- 1부터 시작

-- OPTIONS TABLE의 SELLSEQ 값을 THEME TABLE의 PK인 SELLSEQ와 연결
ALTER TABLE OPTIONS
ADD  CONSTRAINT FK_OPT_SEQ FOREIGN KEY(SELLSEQ)
    REFERENCES THEME(SELLSEQ);
    
-- OPTIONS TABLE의 SELLSEQ 값을 ACTIVITY TABLE의 PK인 SELLSEQ와 연결
ALTER TABLE OPTIONS
ADD  CONSTRAINT FK_OPT_SEQ2 FOREIGN KEY(SELLSEQ)
    REFERENCES ACTIVITY(SELLSEQ); 
      
--테이블 삭제(무결성)
DROP TABLE OPTIONS
CASCADE CONSTRAINTS;
--SEQ 삭제
DROP SEQUENCE OPT_SEQ;
 */

public class OptionDto implements Serializable {

	private int optionSeq;		//옵션 번호
	private int sellSeq;		//판매 번호
	private String opcontent;	//옵션내용
	private String startDate;	//시작일(유효기간) 
	private String endDate;		//종료일(유효기간) 
	private int maxPeople;		//최대 판매 인원
	private int opPrice;		//가격	
	
	public OptionDto() {		
	}

	public OptionDto(int optionSeq, int sellSeq, String opcontent, String startDate, String endDate, int maxPeople,
			int opPrice) {
		this.optionSeq = optionSeq;
		this.sellSeq = sellSeq;
		this.opcontent = opcontent;
		this.startDate = startDate;
		this.endDate = endDate;
		this.maxPeople = maxPeople;
		this.opPrice = opPrice;
	}
	
	public OptionDto(int sellSeq, String opcontent, String startDate, String endDate, int maxPeople, int opPrice) {
		this.sellSeq = sellSeq;
		this.opcontent = opcontent;
		this.startDate = startDate;
		this.endDate = endDate;
		this.maxPeople = maxPeople;
		this.opPrice = opPrice;
	}

	public int getOptionSeq() {
		return optionSeq;
	}

	public void setOptionSeq(int optionSeq) {
		this.optionSeq = optionSeq;
	}

	public int getSellSeq() {
		return sellSeq;
	}

	public void setSellSeq(int sellSeq) {
		this.sellSeq = sellSeq;
	}

	public String getOpcontent() {
		return opcontent;
	}

	public void setOpcontent(String opcontent) {
		this.opcontent = opcontent;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getMaxPeople() {
		return maxPeople;
	}

	public void setMaxPeople(int maxPeople) {
		this.maxPeople = maxPeople;
	}

	public int getOpPrice() {
		return opPrice;
	}

	public void setOpPrice(int opPrice) {
		this.opPrice = opPrice;
	}

	@Override
	public String toString() {
		return "OptionDto [optionSeq=" + optionSeq + ", sellSeq=" + sellSeq + ", opcontent=" + opcontent
				+ ", startDate=" + startDate + ", endDate=" + endDate + ", maxPeople=" + maxPeople + ", opPrice="
				+ opPrice + "]";
	}
	
	
	
	
}
