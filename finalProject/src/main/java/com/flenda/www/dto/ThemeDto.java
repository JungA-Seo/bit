package com.flenda.www.dto;

import java.io.Serializable;


/*
CREATE TABLE THEME(
    SELLSEQ NUMBER PRIMARY KEY, -- 판매 번호
    BUSINESSNAME VARCHAR2(50) NOT NULL, -- 사업자 명
    BUSINESSNUMBER VARCHAR2(50) NOT NULL, -- 사업자 등록 번호
    HOSTID VARCHAR2(50), -- 호스트 아이디
    HOSTNUMBER VARCHAR2(20) NOT NULL, -- 연락처
    CATEGORY VARCHAR2(50) NOT NULL, -- 카테고리
    HOSTADDRESS VARCHAR2(300) NOT NULL, -- 사업체 주소
    HOSTINTRO VARCHAR2(1000), -- 호스트설명
    TITLE VARCHAR2(1000) NOT NULL, -- 판매 제목
    MINPEOPLE NUMBER(20) NOT NULL, -- 투어 최소 인원
    TRANSPOR VARCHAR2(500) NOT NULL, -- 이동 수단
    TIMETAKE VARCHAR2(50) NOT NULL, -- 소요 시간
    CANCLEPERIOD VARCHAR2(100) NOT NULL, -- 무료 취소 기간
    INCLUDED VARCHAR2(500), -- 포함사항
    UNINCLUDED VARCHAR2(500), -- 불포함사항
    MEETPLACE VARCHAR2(300), -- 만나는 장소
    FILENAME VARCHAR2(2000) NOT NULL, -- 이미지
    GOODSEXPLAIN CLOB, -- 상품 설명
    COURSEINTRO CLOB, -- 코스 소개
    USEINFO CLOB, -- 이용 안내
    REGIDATE DATE NOT NULL, -- 등록일
   	CITY VARCHAR2(20), -- 지역 
   	REVIEWNUM NUMBER, --리뷰수
    REVIEWAVG VARCHAR2(200), --평점
    HIGHPRICE NUMBER,  -- 높은가격
    LOWPRICE NUMBER 	--낮은가격 
);
--SEQ 생성
CREATE SEQUENCE TSELL_SEQ 
INCREMENT BY 1 -- 1씩 증가
START WITH 10001; -- 1부터 시작

-- FK 생성
ALTER TABLE THEME
ADD CONSTRAINT FK_THEME_HOSTID FOREIGN KEY(HOSTID)
REFERENCES MEMBER(ID);

--테이블 삭제(무결성)
DROP TABLE THEME
CASCADE CONSTRAINTS;

--SEQ 삭제
DROP SEQUENCE TSELL_SEQ;
select * from THEME
 */

public class ThemeDto implements Serializable{

	private int sellSeq;		 //판매번호
	private String businessName; //사업자명
	private String businessNumber;  //사업자 등록번호
	private String hostId;		 //호스트아이디	
	private String hostNumber;	//연락처
	private String category;	//카테고리
	private String hostAddress; //사업체주소 
	private String hostIntro;	//호스트설명 
	private String title;		//판매제목 
	private int minPeople;		//투어최소인원 
	private String transpor;	//이동 수단
	private String timetake;	//소요시간
	private String cancleperiod;//무료취소기간 
	private String included; 	//포함사항 
	private String unincluded;	//불포함사항
	private String meetplace;	//만나는장소
	private String goodsExplain;//상품설명	
	private String courseIntro; //코스소개
	private String useInfo;		//이용안내
	private String regidate;	//등록일
	private String city;		//도시
	private int reviewNum;		//리뷰갯수 
	private String reviewAvg;	//리뷰평균 
	private int highprice;		//높은가격
	private int lowprice;		//낮은가격
	
	public ThemeDto() {
	
	}

	public ThemeDto(int sellSeq, String businessName, String businessNumber, String hostId, String hostNumber,
			String category, String hostAddress, String hostIntro, String title, int minPeople, String transpor,
			String timetake, String cancleperiod, String included, String unincluded, String meetplace,
			String goodsExplain, String courseIntro, String useInfo, String regidate, String city, int reviewNum,
			String reviewAvg, int highprice, int lowprice) {
		super();
		this.sellSeq = sellSeq;
		this.businessName = businessName;
		this.businessNumber = businessNumber;
		this.hostId = hostId;
		this.hostNumber = hostNumber;
		this.category = category;
		this.hostAddress = hostAddress;
		this.hostIntro = hostIntro;
		this.title = title;
		this.minPeople = minPeople;
		this.transpor = transpor;
		this.timetake = timetake;
		this.cancleperiod = cancleperiod;
		this.included = included;
		this.unincluded = unincluded;
		this.meetplace = meetplace;
		this.goodsExplain = goodsExplain;
		this.courseIntro = courseIntro;
		this.useInfo = useInfo;
		this.regidate = regidate;
		this.city = city;
		this.reviewNum = reviewNum;
		this.reviewAvg = reviewAvg;
		this.highprice = highprice;
		this.lowprice = lowprice;
	}

	public ThemeDto(int sellSeq, int reviewNum, String reviewAvg, int highprice, int lowprice) {
		super();
		this.sellSeq = sellSeq;
		this.reviewNum = reviewNum;
		this.reviewAvg = reviewAvg;
		this.highprice = highprice;
		this.lowprice = lowprice;
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

	public String getHostNumber() {
		return hostNumber;
	}

	public void setHostNumber(String hostNumber) {
		this.hostNumber = hostNumber;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getHostAddress() {
		return hostAddress;
	}

	public void setHostAddress(String hostAddress) {
		this.hostAddress = hostAddress;
	}

	public String getHostIntro() {
		return hostIntro;
	}

	public void setHostIntro(String hostIntro) {
		this.hostIntro = hostIntro;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getMinPeople() {
		return minPeople;
	}

	public void setMinPeople(int minPeople) {
		this.minPeople = minPeople;
	}

	public String getTranspor() {
		return transpor;
	}

	public void setTranspor(String transpor) {
		this.transpor = transpor;
	}

	public String getTimetake() {
		return timetake;
	}

	public void setTimetake(String timetake) {
		this.timetake = timetake;
	}

	public String getCancleperiod() {
		return cancleperiod;
	}

	public void setCancleperiod(String cancleperiod) {
		this.cancleperiod = cancleperiod;
	}

	public String getIncluded() {
		return included;
	}

	public void setIncluded(String included) {
		this.included = included;
	}

	public String getUnincluded() {
		return unincluded;
	}

	public void setUnincluded(String unincluded) {
		this.unincluded = unincluded;
	}

	public String getMeetplace() {
		return meetplace;
	}

	public void setMeetplace(String meetplace) {
		this.meetplace = meetplace;
	}

	public String getGoodsExplain() {
		return goodsExplain;
	}

	public void setGoodsExplain(String goodsExplain) {
		this.goodsExplain = goodsExplain;
	}

	public String getCourseIntro() {
		return courseIntro;
	}

	public void setCourseIntro(String courseIntro) {
		this.courseIntro = courseIntro;
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

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public int getReviewNum() {
		return reviewNum;
	}

	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}

	public String getReviewAvg() {
		return reviewAvg;
	}

	public void setReviewAvg(String reviewAvg) {
		this.reviewAvg = reviewAvg;
	}

	public int getHighprice() {
		return highprice;
	}

	public void setHighprice(int highprice) {
		this.highprice = highprice;
	}

	public int getLowprice() {
		return lowprice;
	}

	public void setLowprice(int lowprice) {
		this.lowprice = lowprice;
	}

	@Override
	public String toString() {
		return "ThemeDto [sellSeq=" + sellSeq + ", businessName=" + businessName + ", businessNumber=" + businessNumber
				+ ", hostId=" + hostId + ", hostNumber=" + hostNumber + ", category=" + category + ", hostAddress="
				+ hostAddress + ", hostIntro=" + hostIntro + ", title=" + title + ", minPeople=" + minPeople
				+ ", transpor=" + transpor + ", timetake=" + timetake + ", cancleperiod=" + cancleperiod + ", included="
				+ included + ", unincluded=" + unincluded + ", meetplace=" + meetplace + ", goodsExplain="
				+ goodsExplain + ", courseIntro=" + courseIntro + ", useInfo=" + useInfo + ", regidate=" + regidate
				+ ", city=" + city + ", reivewNum=" + reviewNum + ", reviewAvg=" + reviewAvg + ", highprice="
				+ highprice + ", lowprice=" + lowprice + "]";
	}


}
