package com.flenda.www.dto;

import java.io.Serializable;

/*
CREATE TABLE REFUND(
    REFUNDSEQ NUMBER PRIMARY KEY, --환불 번호
    ORDERNUM  VARCHAR2(50), -- 주문 번호
    ITEMNAME VARCHAR2(200) NOT NULL, --상품명
    CONDITION VARCHAR2(50) NOT NULL, -- 처리상태
    REFUNDPRICE NUMBER NOT NULL, -- 환불금액
    REQDATE DATE NOT NULL, -- 환불요청일
    FINISHDATE DATE NOT NULL, -- 환불완료일
    REFUNDREASON VARCHAR2(1000), --  환불사유
    PAYMETHOD VARCHAR2(50), -- 결제방법
    CARDNUM VARCHAR2(200), -- 카드번호
    BALANCE VARCHAR2(200), -- 취소 비용
	REFUNDPAY VARCHAR2(200),
	NAME VARCHAR2(50),
	EMAIL VARCHAR2(50)
);
--SEQ 생성
CREATE SEQUENCE RFN_SEQ
INCREMENT BY 1 
START WITH 1; 

-- FK 생성
ALTER TABLE REFUND
ADD CONSTRAINT FK_REFUND_ORDERNUM FOREIGN KEY(ORDERNUM)
REFERENCES ORDERS(ORDERNUM);

--테이블 삭제(무결성)
DROP TABLE REFUND
CASCADE CONSTRAINTS;
--SEQ 삭제
DROP SEQUENCE RFN_SEQ;
*/
public class RefundDto implements Serializable{
	private int refundSeq;
	private String orderNum;
	private String itemName;
	private String condition;
	private String refundPrice;
	private String reqDate;
	private String finishDate;
	private String refundReason;
	private String payMethod;
	private String cardNum;
	private String balance;
	private String refundPay;
	private String name;
	private String email;
	
	

	public RefundDto(int refundSeq, String orderNum, String itemName, String condition, String refundPrice,
			String reqDate, String finishDate, String refundReason, String payMethod, String cardNum, String balance,
			String refundPay, String name, String email) {
		super();
		this.refundSeq = refundSeq;
		this.orderNum = orderNum;
		this.itemName = itemName;
		this.condition = condition;
		this.refundPrice = refundPrice;
		this.reqDate = reqDate;
		this.finishDate = finishDate;
		this.refundReason = refundReason;
		this.payMethod = payMethod;
		this.cardNum = cardNum;
		this.balance = balance;
		this.refundPay = refundPay;
		this.name = name;
		this.email = email;
	}

	public RefundDto() {}


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

	public String getBalance() {
		return balance;
	}

	public void setBalance(String balance) {
		this.balance = balance;
	}

	public int getRefundSeq() {
		return refundSeq;
	}

	public void setRefundSeq(int refundSeq) {
		this.refundSeq = refundSeq;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public String getRefundPrice() {
		return refundPrice;
	}

	public void setRefundPrice(String refundPrice) {
		this.refundPrice = refundPrice;
	}

	public String getReqDate() {
		return reqDate;
	}

	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}

	public String getFinishDate() {
		return finishDate;
	}

	public void setFinishDate(String finishDate) {
		this.finishDate = finishDate;
	}

	public String getRefundReason() {
		return refundReason;
	}

	public void setRefundReason(String refundReason) {
		this.refundReason = refundReason;
	}

	public String getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	public String getCardNum() {
		return cardNum;
	}

	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}
	

	public String getRefundPay() {
		return refundPay;
	}

	public void setRefundPay(String refundPay) {
		this.refundPay = refundPay;
	}

	@Override
	public String toString() {
		return "RefundDto [refundSeq=" + refundSeq + ", orderNum=" + orderNum + ", itemName=" + itemName
				+ ", condition=" + condition + ", refundPrice=" + refundPrice + ", reqDate=" + reqDate + ", finishDate="
				+ finishDate + ", refundReason=" + refundReason + ", payMethod=" + payMethod + ", cardNum=" + cardNum
				+ ", balance=" + balance + ", refundPay=" + refundPay + ", name=" + name + ", email=" + email + "]";
	}


	
	
	
	
}
