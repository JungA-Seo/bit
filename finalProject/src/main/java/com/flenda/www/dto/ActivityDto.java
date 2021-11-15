/*
CREATE TABLE ACTIVITY(
    sellSeq NUMBER CONSTRAINT PK_ACT_SEQ PRIMARY KEY, -- 판매 번호
    businessName VARCHAR2(50) NOT NULL, -- 사업자 명
    businessNumber VARCHAR2(100) NOT NULL, -- 사업자 등록 번호
    hostId VARCHAR2(50) NOT NULL, -- 호스트 아이디
    businessPhoneNum VARCHAR2(50) NOT NULL, -- 연락처
    category VARCHAR2(200) NOT NULL, -- 카테고리
    address VARCHAR2(100) NOT NULL, -- 사업체 주소
    hostIntro VARCHAR2(2000), -- 호스트 설명
    title VARCHAR2(500) NOT NULL, -- 판매 제목
    maxPeople NUMBER NOT NULL, -- 최대 인원
    included VARCHAR2(200), -- 포함사항
    timetake VARCHAR2(50) NOT NULL, -- 소요 시간
    ticket VARCHAR2(100) NOT NULL, -- 바우처 여부
    goodsExplain CLOB, -- 상품설명
    useInfo CLOB, -- 이용 안내
    regidate DATE NOT NULL, -- 등록일
    latitude VARCHAR2(200) NOT NULL, --위도
    longitude VARCHAR2(200) NOT NULL, --경도
    reivewNum NUMBER, --리뷰수
    reviewAvg VARCHAR2(200), --평점
    countsell NUMBER --판매량
);
--SEQ 생성
CREATE SEQUENCE ASELL_SEQ
INCREMENT BY 1 -- 1씩 증가
START WITH 20000; -- 1부터 시작

-- FK 생성
ALTER TABLE ACTIVITY
ADD CONSTRAINT FK_ACTIVITY_HOSTID FOREIGN KEY(hostId)
REFERENCES MEMBER(ID);

--테이블 삭제(무결성)
DROP TABLE ACTIVITY
CASCADE CONSTRAINTS;

--SEQ 삭제
DROP SEQUENCE ASELL_SEQ;
*/
package com.flenda.www.dto;

import java.io.Serializable;

public class ActivityDto implements Serializable{

	private int sellSeq;		 //판매번호
	private String businessName; //사업자명
	private String businessNumber;  //사업자 등록번호
	private String hostId;		 //판매자ID	
	private String businessPhoneNum;	//사업자 연락처
	private String category;	//카테고리
	private String address; 	//사업체주소 
	private String hostintro;	//호스트설명 
	private String title;		//판매제목 
	private int maxPeople;		//최대인원
	private String included; 	//포함사항 
	private String timetake;	//소요시간
	private String ticket;	//바우처여부 
	private String goodsExplain;//상품설명	
	private String useInfo;		//이용안내
	private String regidate;	//등록일
	
	private String latitude;	//위도
	private String longitude;	//경도
	
	private int reivewNum; // 리뷰수 
	private String reviewAvg; // 평점
	private int countsell; // 판매량
	
	public ActivityDto() {
	}

	
	public ActivityDto(int sellSeq, String businessName, String businessNumber, String hostId, String businessPhoneNum,
			String category, String address, String hostintro, String title, int maxPeople, String included,
			String timetake, String ticket, String goodsExplain, String useInfo, String regidate, String latitude,
			String longitude, int reivewNum, String reviewAvg, int countsell) {
		super();
		this.sellSeq = sellSeq;
		this.businessName = businessName;
		this.businessNumber = businessNumber;
		this.hostId = hostId;
		this.businessPhoneNum = businessPhoneNum;
		this.category = category;
		this.address = address;
		this.hostintro = hostintro;
		this.title = title;
		this.maxPeople = maxPeople;
		this.included = included;
		this.timetake = timetake;
		this.ticket = ticket;
		this.goodsExplain = goodsExplain;
		this.useInfo = useInfo;
		this.regidate = regidate;
		this.latitude = latitude;
		this.longitude = longitude;
		this.reivewNum = reivewNum;
		this.reviewAvg = reviewAvg;
		this.countsell = countsell;
	}

	public ActivityDto(String businessName, String businessNumber, String hostId, String businessPhoneNum,
			String category, String address, String hostintro, String title, int maxPeople, String included,
			String timetake, String ticket, String goodsExplain, String useInfo, String latitude, String longitude) {
		super();
		this.businessName = businessName;
		this.businessNumber = businessNumber;
		this.hostId = hostId;
		this.businessPhoneNum = businessPhoneNum;
		this.category = category;
		this.address = address;
		this.hostintro = hostintro;
		this.title = title;
		this.maxPeople = maxPeople;
		this.included = included;
		this.timetake = timetake;
		this.ticket = ticket;
		this.goodsExplain = goodsExplain;
		this.useInfo = useInfo;
		this.latitude = latitude;
		this.longitude = longitude;
	}	
	
	public ActivityDto(int sellSeq, int reivewNum, String reviewAvg, int countsell) {
		super();
		this.sellSeq = sellSeq;
		this.reivewNum = reivewNum;
		this.reviewAvg = reviewAvg;
		this.countsell = countsell;
	}

	public int getSellSeq() {
		return sellSeq;
	}

	public void setSellSeq(int sellSeq) {
		this.sellSeq = sellSeq;
	}

	public String getBusinessName() {
		return businessName;
	}

	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}

	public String getBusinessNumber() {
		return businessNumber;
	}

	public void setBusinessNumber(String businessNumber) {
		this.businessNumber = businessNumber;
	}

	public String getHostId() {
		return hostId;
	}

	public void setHostId(String hostId) {
		this.hostId = hostId;
	}

	public String getBusinessPhoneNum() {
		return businessPhoneNum;
	}

	public void setBusinessPhoneNum(String businessPhoneNum) {
		this.businessPhoneNum = businessPhoneNum;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getHostintro() {
		return hostintro;
	}

	public void setHostintro(String hostintro) {
		this.hostintro = hostintro;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getMaxPeople() {
		return maxPeople;
	}

	public void setMaxPeople(int maxPeople) {
		this.maxPeople = maxPeople;
	}

	public String getIncluded() {
		return included;
	}

	public void setIncluded(String included) {
		this.included = included;
	}

	public String getTimetake() {
		return timetake;
	}

	public void setTimetake(String timetake) {
		this.timetake = timetake;
	}

	public String getTicket() {
		return ticket;
	}

	public void setTicket(String ticket) {
		this.ticket = ticket;
	}

	public String getGoodsExplain() {
		return goodsExplain;
	}

	public void setGoodsExplain(String goodsExplain) {
		this.goodsExplain = goodsExplain;
	}

	public String getUseInfo() {
		return useInfo;
	}

	public void setUseInfo(String useInfo) {
		this.useInfo = useInfo;
	}

	public String getRegidate() {
		return regidate;
	}

	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	
	public int getReivewNum() {
		return reivewNum;
	}

	public void setReivewNum(int reivewNum) {
		this.reivewNum = reivewNum;
	}

	public String getReviewAvg() {
		return reviewAvg;
	}

	public void setReviewAvg(String reviewAvg) {
		this.reviewAvg = reviewAvg;
	}
	
	public int getCountsell() {
		return countsell;
	}


	public void setCountsell(int countsell) {
		this.countsell = countsell;
	}

	@Override
	public String toString() {
		return "ActivityDto [sellSeq=" + sellSeq + ", businessName=" + businessName + ", businessNumber="
				+ businessNumber + ", hostId=" + hostId + ", businessPhoneNum=" + businessPhoneNum + ", category="
				+ category + ", address=" + address + ", hostintro=" + hostintro + ", title=" + title + ", maxPeople="
				+ maxPeople + ", included=" + included + ", timetake=" + timetake + ", ticket=" + ticket
				+ ", goodsExplain=" + goodsExplain + ", useInfo=" + useInfo + ", regidate=" + regidate + ", latitude="
				+ latitude + ", longitude=" + longitude + ", reivewNum=" + reivewNum + ", reviewAvg=" + reviewAvg
				+ ", countsell=" + countsell + "]";
	}

}
