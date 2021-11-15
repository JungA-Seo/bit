package com.flenda.www.dto;

import java.io.Serializable;
/*
CREATE TABLE FINAL_CHATMEMBER(
	NUM NUMBER PRIMARY KEY, -- seq
	ID VARCHAR2(50), -- 유저아이디
	ROOM VARCHAR2(50) NOT NULL, --현재접속중인 채팅룸
	PRIROOM VARCHAR2(50) --이전접속한 채팅룸
);
--seq생성
CREATE SEQUENCE CHAT_MEMBER_SEQ
START WITH 1 INCREMENT BY 1;
-- fk생성
ALTER TABLE FINAL_CHATMEMBER
ADD CONSTRAINT FK_CHAT_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);

-- 테이블 삭제 (무결성)
DROP TABLE FINAL_CHATMEMBER
CASCADE CONSTRAINTS;

-- SEQ 삭제
DROP SEQUENCE CHAT_MEMBER_SEQ;
*/

public class ChatMemberDto implements Serializable {

	private int num;
	private String id;
	private String room;
	private String priroom;
	
	
	public ChatMemberDto() {
	}
		
	public ChatMemberDto(int num, String id, String room, String priroom) {
		super();
		this.num = num;
		this.id = id;
		this.room = room;
		this.priroom = priroom;
	}

	public String getRoom() {
		return room;
	}

	public void setRoom(String room) {
		this.room = room;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPriroom() {
		return priroom;
	}

	public void setPriroom(String priroom) {
		this.priroom = priroom;
	}

	@Override
	public String toString() {
		return "ChatMemberDto [num=" + num + ", id=" + id + ", room=" + room + ", priroom=" + priroom + "]";
	}
}
