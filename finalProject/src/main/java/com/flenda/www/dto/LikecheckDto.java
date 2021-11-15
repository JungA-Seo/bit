/*

DROP TABLE LIKECHECK
CASCADE CONSTRAINTS;

DROP SEQUENCE LSEQ_LIKECHECK;

CREATE TABLE LIKECHECK(
  LSEQ NUMBER PRIMARY KEY,
  ID VARCHAR2(50),
  SEQ_BBS NUMBER
);

CREATE SEQUENCE LSEQ_LIKECHECK
START WITH 1
INCREMENT BY 1;

ALTER TABLE LIKECHECK
ADD CONSTRAINT FK_LIKECHECK_ID FOREIGN KEY (ID)
REFERENCES MEMBER(ID);

ALTER TABLE LIKECHECK
ADD CONSTRAINT FK_LIKECHECK_SEQ_BBS FOREIGN KEY (SEQ_BBS)
REFERENCES BBS(SEQ);

*/

package com.flenda.www.dto;

public class LikecheckDto {
	
	private int lseq;	// 좋아요 번호(pk)
	private String id;	// 좋아요 한 id
	private int seq_bbs;	// 커뮤니티 게시글 번호
	
	public LikecheckDto() {
		
	}
	
	public LikecheckDto(int lseq, String id, int seq_bbs) {
		super();
		this.lseq = lseq;
		this.id = id;
		this.seq_bbs = seq_bbs;
	}

	public int getLseq() {
		return lseq;
	}

	public void setLseq(int lseq) {
		this.lseq = lseq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getSeq_bbs() {
		return seq_bbs;
	}

	public void setSeq_bbs(int seq_bbs) {
		this.seq_bbs = seq_bbs;
	}

	@Override
	public String toString() {
		return "LikecheckDto [lseq=" + lseq + ", id=" + id + ", seq_bbs=" + seq_bbs + "]";
	}
	
	
	
	
	
}
