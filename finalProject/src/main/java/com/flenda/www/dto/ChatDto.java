package com.flenda.www.dto;

import java.io.Serializable;

/*
CREATE TABLE FINAL_CHAT(
	NUM NUMBER PRIMARY KEY, --seq
	NAME VARCHAR2(50) NOT NULL, -- 방이름
	TOTALCOUNT NUMBER(8) NOT NULL, --접속자총수
	REMAINCOUNT NUMBER(8) NOT NULL, --방에 현재접소자수
	CATEGORY VARCHAR2(50) NOT NULL --문의종류
);

CREATE SEQUENCE CHAT_SEQ
START WITH 1 INCREMENT BY 1; 

-- 테이블 삭제 (무결성)
DROP TABLE FINAL_CHAT
CASCADE CONSTRAINTS;

-- SEQ 삭제
DROP SEQUENCE CHAT_SEQ;
 */

public class ChatDto implements Serializable{
	
	private int num;
	private String name;
	private int totalcount;
	private int remaincount;
	private String category;
	
	public ChatDto() {
	}
	
	public ChatDto(int num, String name, int totalcount, int remaincount,String category) {
		super();
		this.num = num;
		this.name = name;
		this.totalcount = totalcount;
		this.remaincount = remaincount;
		this.category = category;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getTotalcount() {
		return totalcount;
	}

	public void setTotalcount(int totalcount) {
		this.totalcount = totalcount;
	}	
	
	public int getRemaincount() {
		return remaincount;
	}

	public void setRemaincount(int remaincount) {
		this.remaincount = remaincount;
	}
	
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "ChatDto [num=" + num + ", name=" + name +  ", totalcount=" + totalcount
				+ ", remaincount=" + remaincount +", category=" + category+"]";
	}

}
