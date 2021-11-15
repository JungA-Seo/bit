package com.flenda.www.dto;

public class Odr_SearchDto {
	private String choice;
	private String search;
	private String sdate;
	private String edate;
	private int pageNum;
	private String status;
	private String period;
	private int start;
	private int end;
	
	
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getChoice() {
		return choice;
	}
	public void setChoice(String choice) {
		this.choice = choice;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	
	public Odr_SearchDto() {
		// TODO Auto-generated constructor stub
	}
	
	public Odr_SearchDto(String choice, String search, String sdate, String edate, int pageNum, String status,
			String period, int start, int end) {
		super();
		this.choice = choice;
		this.search = search;
		this.sdate = sdate;
		this.edate = edate;
		this.pageNum = pageNum;
		this.status = status;
		this.period = period;
		this.start = start;
		this.end = end;
	}
	@Override
	public String toString() {
		return "Odr_SearchDto [choice=" + choice + ", search=" + search + ", sdate=" + sdate + ", edate=" + edate
				+ ", pageNum=" + pageNum + ", status=" + status + ", period=" + period + ", start=" + start + ", end="
				+ end + "]";
	}
	
	
	
	
}
