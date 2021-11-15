/*
CREATE TABLE PICTURES(
	PICSEQ NUMBER PRIMARY KEY,	--사진번호
	SELLSEQ NUMBER,	--판매번호
	NEWFILENAME VARCHAR2(200) NOT NULL,	--파일이름
	REGIDATE DATE NOT NULL	--등록일
);
--SEQ 생성
CREATE SEQUENCE PICTURES_SEQ
INCREMENT BY 1
START WITH 1;

-- FK 생성
ALTER TABLE PICTURES
ADD CONSTRAINT FK_PICTURES_THEME_SELLSEQ FOREIGN KEY(SELLSEQ)
REFERENCES THEME(SELLSEQ);
-- FK 생성
ALTER TABLE PICTURES
ADD CONSTRAINT FK_PICTURES_ACT_SELLSEQ FOREIGN KEY(SELLSEQ)
REFERENCES ACTIVITY(SELLSEQ);

--테이블 삭제(무결성)
DROP TABLE PICTURES
CASCADE CONSTRAINTS;
--SEQ 삭제
DROP SEQUENCE PICTURES_SEQ;
*/
package com.flenda.www.dto;

import java.io.Serializable;

public class PicturesDto implements Serializable {
	
	private int picSeq;		//이미지번호
	private int sellSeq;	//판매번호
	private String newFileName;	//파일명
	private String regidate;	//등록일
	
	public PicturesDto() {
	}
	
	public PicturesDto(int picSeq, int sellSeq, String newFileName, String regidate) {
		super();
		this.picSeq = picSeq;
		this.sellSeq = sellSeq;
		this.newFileName = newFileName;
		this.regidate = regidate;
	}

	public PicturesDto(int sellSeq, String newFileName) {
		super();
		this.sellSeq = sellSeq;
		this.newFileName = newFileName;
	}

	public int getPicSeq() {
		return picSeq;
	}

	public void setPicSeq(int picSeq) {
		this.picSeq = picSeq;
	}

	public int getSellSeq() {
		return sellSeq;
	}

	public void setSellSeq(int sellSeq) {
		this.sellSeq = sellSeq;
	}

	public String getNewFileName() {
		return newFileName;
	}

	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}

	public String getRegidate() {
		return regidate;
	}

	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}

	@Override
	public String toString() {
		return "PicturesDto [picSeq=" + picSeq + ", sellSeq=" + sellSeq + ", newFileName=" + newFileName + ", regidate="
				+ regidate + "]";
	}
	
}
