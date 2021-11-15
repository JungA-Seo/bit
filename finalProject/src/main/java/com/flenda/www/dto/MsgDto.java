/*
CREATE TABLE MSG_SAVE(
   NUM NUMBER PRIMARY KEY, -- seq
   ROOMID VARCHAR2(50), -- 방이름
   MSG VARCHAR2(2000) NOT NULL, -- 메세지
   WHO VARCHAR2(50) NOT NULL, -- 보내는이
   WDATE DATE NOT NULL-- 작성일
);
-- seq생성
CREATE SEQUENCE MSG_SEQ
START WITH 1 INCREMENT BY 1;

-- 테이블 삭제 (무결성)
DROP TABLE MSG_SAVE
CASCADE CONSTRAINTS;

-- SEQ 삭제
DROP SEQUENCE MSG_SEQ;
*/
package com.flenda.www.dto;

public class MsgDto {
	private int num;
	private String roomId;
	private String msg; 
	private String who;
	private String wdate;
	
	public MsgDto() {
	}
		
	
	public MsgDto(int num, String roomId, String msg, String who, String wdate) {
		super();
		this.num = num;
		this.roomId = roomId;
		this.msg = msg;
		this.who = who;
		this.wdate = wdate;
	}


	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getWho() {
		return who;
	}
	public void setWho(String who) {
		this.who = who;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}


	@Override
	public String toString() {
		return "MsgDto [num=" + num + ", roomId=" + roomId + ", msg=" + msg + ", who=" + who + ", wdate=" + wdate + "]";
	}
	
	
	
	
	
}
