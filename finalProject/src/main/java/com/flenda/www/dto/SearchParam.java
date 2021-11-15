package com.flenda.www.dto;

import java.io.Serializable;

public class SearchParam implements Serializable{

	private String startdate;	//시작날짜 
	private String enddate;		//끝날짜 
	private String search;		//검색 
	private String choice;		//카테고리선택
	private int pageNumber;
	
	private int start;
	private int end;
	
	public SearchParam() {
	}

	public SearchParam(String startdate, String enddate, String search, String choice, int pageNumber, int start,
			int end) {
		super();
		this.startdate = startdate;
		this.enddate = enddate;
		this.search = search;
		this.choice = choice;
		this.pageNumber = pageNumber;
		this.start = start;
		this.end = end;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getChoice() {
		return choice;
	}

	public void setChoice(String choice) {
		this.choice = choice;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

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

	@Override
	public String toString() {
		return "SearchParam [startdate=" + startdate + ", enddate=" + enddate + ", search=" + search + ", choice="
				+ choice + ", pageNumber=" + pageNumber + ", start=" + start + ", end=" + end + "]";
	}

	
	}
