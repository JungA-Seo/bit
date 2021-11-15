/*
CREATE TABLE REPLY(
	RSEQ NUMBER PRIMARY KEY,	-- 댓글 번호
	ID VARCHAR2(50),
	PROFILE	VARCHAR2(100),	-- 프로필 이미지
	SEQ_BBS NUMBER,	-- 게시글 번호
	
	REPLY VARCHAR2(3000), -- 댓글 내용
	WDATE DATE NOT NULL	-- 작성일
);

CREATE SEQUENCE RSEQ_REPLY
START WITH 1
INCREMENT BY 1;

ALTER TABLE REPLY
ADD CONSTRAINT FK_REPLY_ID FOREIGN KEY (ID)
REFERENCES MEMBER(ID);

ALTER TABLE REPLY
ADD CONSTRAINT FK_REPLY_SEQ_BBS FOREIGN KEY (SEQ_BBS)
REFERENCES BBS(SEQ);

DROP TABLE REPLY
CASCADE CONSTRAINTS;

DROP SEQUENCE RSEQ_REPLY;
*/
package com.flenda.www.dto;

public class ReplyDto {
	
	private int rseq;	//	댓글 번호
	private int seq_bbs;	// 게시글 번호
	
	private String id;	// 댓글 작성자 id
	private String profile;	// 프로필이미지
	private String reply;	// 댓글 내용 (=댓글 본문)

	private String wdate;	// 댓글 작성일
	
	public ReplyDto() {
		
	}

	public ReplyDto(int rseq, int seq_bbs, String id, String profile, String reply, String wdate) {
		super();
		this.rseq = rseq;
		this.seq_bbs = seq_bbs;
		this.id = id;
		this.profile = profile;
		this.reply = reply;
		this.wdate = wdate;
	}

	public int getRseq() {
		return rseq;
	}

	public void setRseq(int rseq) {
		this.rseq = rseq;
	}

	public int getSeq_bbs() {
		return seq_bbs;
	}

	public void setSeq_bbs(int seq_bbs) {
		this.seq_bbs = seq_bbs;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	@Override
	public String toString() {
		return "ReplyDto [rseq=" + rseq + ", seq_bbs=" + seq_bbs + ", id=" + id + ", profile=" + profile + ", reply="
				+ reply + ", wdate=" + wdate + "]";
	}
	
	
	
	
	
	
	
}
