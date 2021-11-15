/*
CREATE TABLE VISIT(
   USERIP VARCHAR2(50) NOT NULL,
   VISITTIME DATE NOT NULL,
   STATUS VARCHAR2(10) NOT NULL
)
*/
package com.flenda.www.dto;

public class VisitDto {
	private String visitTime;
	private String userIp;
	private String status;
	
	public VisitDto() {
	}

	public VisitDto(String visitTime, String userIp, String status) {
		super();
		this.visitTime = visitTime;
		this.userIp = userIp;
		this.status = status;
	}
	
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getVisitTime() {
		return visitTime;
	}

	public void setVisitTime(String visitTime) {
		this.visitTime = visitTime;
	}

	public String getUserIp() {
		return userIp;
	}

	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}

	@Override
	public String toString() {
		return "VisitDto [visitTime=" + visitTime + ", userIp=" + userIp + ", status=" + status + "]";
	}
	
	
	
}
