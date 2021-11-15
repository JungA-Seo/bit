package com.flenda.www.dto;

import java.io.Serializable;

/*
CREATE TABLE ORDERS(
    ORDERSEQ NUMBER UNIQUE NOT NULL, -- SEQ
    ORDERNUM VARCHAR2(100) PRIMARY KEY, -- 주문 번호
    ID VARCHAR2(50), -- 구매자 아이디
    NAME VARCHAR2(50) NOT NULL, -- 구매자 이름
    EMAIL VARCHAR2(200), -- 구매자 이메일
    PHONE VARCHAR2(100) NOT NULL, -- 구매자 전화번호
    BANKNAME VARCHAR2(100), -- 은행이름
    CARDNAME VARCHAR2(100), -- 카드사명
    CARDNUM VARCHAR2(200), -- 카드번호
    ITEMNAME VARCHAR2(200) NOT NULL, -- 구매상품명
    PAYMETHOD VARCHAR2(50) NOT NULL, -- 결제방법
    PAIDMONEY VARCHAR2(200) NOT NULL, -- 결제금액
    TOTALCOUNT VARCHAR2(50) NOT NULL, -- 수량
    RESERVATIONDATE VARCHAR2(100), -- 예약일
    USERMEMO VARCHAR2(200), -- 요청사항
    ORDERDATE DATE NOT NULL, -- 구매일
    MEETPLACE VARCHAR2(500),  -- 만나는장소 (테마추가)
    CATEGORY VARCHAR2(50),    -- 카테고리	(테마추가)
    SELLSEQ NUMBER,           -- 상품번호 (테마추가)
    USEDATE VARCHAR2(100) --사용일
);
--SEQ 생성
CREATE SEQUENCE ORDER_SEQ
INCREMENT BY 1 -- 1씩 증가
START WITH 1; -- 1부터 시작
    
-- ORDERS TABLE의 ID 값을 MEMBER TABLE의 PK인 ID와 연결
ALTER TABLE ORDERS
ADD  CONSTRAINT FK_ORDERS_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);

--테이블 삭제(무결성)  
DROP TABLE ORDERS
CASCADE CONSTRAINTS;

--SEQ 삭제
DROP SEQUENCE ORDER_SEQ;
 */


public class OrdersDto implements Serializable{

	private int orderSeq;
	private String orderNum; 
	private String id;
	private String name;
	private String email;
	private String phone;
	private String bankName;
	private String cardName;
	private String cardNum;
	private String ItemName;
	private String payMethod;
	private String paidMoney;
	private String totalCount;
	private String reservationDate;
	private String userMemo;
	private String orderDate;
	private String meetplace;
	private String category;
	private int sellSeq;
	private String useDate;
	
	//매출통계용
	private String money; 
	private String moneyDate;
	
	public OrdersDto() {	
	}
	
	public OrdersDto(String moneyDate) {
		super();
		this.moneyDate = moneyDate;
	}
	
	public OrdersDto(String money, String moneyDate) {
		super();
		this.money = money;
		this.moneyDate = moneyDate;
	}
	
	public OrdersDto(int orderSeq, int sellSeq, String orderNum, String id, String name, String email, String phone,
			String bankName, String cardName, String cardNum, String itemName, String payMethod, String paidMoney,
			String totalCount, String reservationDate, String userMemo, String orderDate, String meetplace,
			String category, String useDate) {
		super();
		this.orderSeq = orderSeq;
		this.sellSeq = sellSeq;
		this.orderNum = orderNum;
		this.id = id;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.bankName = bankName;
		this.cardName = cardName;
		this.cardNum = cardNum;
		this.ItemName = itemName;
		this.payMethod = payMethod;
		this.paidMoney = paidMoney;
		this.totalCount = totalCount;
		this.reservationDate = reservationDate;
		this.userMemo = userMemo;
		this.orderDate = orderDate;
		this.meetplace = meetplace;
		this.category = category;
		this.useDate = useDate;
	}


	public int getOrderSeq() {
		return orderSeq;
	}


	public void setOrderSeq(int orderSeq) {
		this.orderSeq = orderSeq;
	}


	public int getSellSeq() {
		return sellSeq;
	}


	public void setSellSeq(int sellSeq) {
		this.sellSeq = sellSeq;
	}


	public String getOrderNum() {
		return orderNum;
	}


	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getBankName() {
		return bankName;
	}


	public void setBankName(String bankName) {
		this.bankName = bankName;
	}


	public String getCardName() {
		return cardName;
	}


	public void setCardName(String cardName) {
		this.cardName = cardName;
	}


	public String getCardNum() {
		return cardNum;
	}


	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}


	public String getItemName() {
		return ItemName;
	}


	public void setItemName(String itemName) {
		ItemName = itemName;
	}


	public String getPayMethod() {
		return payMethod;
	}


	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}


	public String getPaidMoney() {
		return paidMoney;
	}


	public void setPaidMoney(String paidMoney) {
		this.paidMoney = paidMoney;
	}


	public String getTotalCount() {
		return totalCount;
	}


	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}


	public String getReservationDate() {
		return reservationDate;
	}


	public void setReservationDate(String reservationDate) {
		this.reservationDate = reservationDate;
	}


	public String getUserMemo() {
		return userMemo;
	}


	public void setUserMemo(String userMemo) {
		this.userMemo = userMemo;
	}


	public String getOrderDate() {
		return orderDate;
	}


	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}


	public String getMeetplace() {
		return meetplace;
	}


	public void setMeetplace(String meetplace) {
		this.meetplace = meetplace;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}

	public String getUseDate() {
		return useDate;
	}

	public void setUseDate(String useDate) {
		this.useDate = useDate;
	}
	
	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
	}

	public String getMoneyDate() {
		return moneyDate;
	}

	public void setMoneyDate(String moneyDate) {
		this.moneyDate = moneyDate;
	}

	@Override
	public String toString() {
		return "OrdersDto [orderSeq=" + orderSeq + ", orderNum=" + orderNum + ", id=" + id + ", name=" + name
				+ ", email=" + email + ", phone=" + phone + ", bankName=" + bankName + ", cardName=" + cardName
				+ ", cardNum=" + cardNum + ", ItemName=" + ItemName + ", payMethod=" + payMethod + ", paidMoney="
				+ paidMoney + ", totalCount=" + totalCount + ", reservationDate=" + reservationDate + ", userMemo="
				+ userMemo + ", orderDate=" + orderDate + ", meetplace=" + meetplace + ", category=" + category
				+ ", sellSeq=" + sellSeq + ", useDate=" + useDate + "]";
	}
	
	public String statisic() {
		return "OrdersDto [ money="+money+", moneyDate="+moneyDate+"]";
	}
}
