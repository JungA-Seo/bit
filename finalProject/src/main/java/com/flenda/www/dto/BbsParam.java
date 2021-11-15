package com.flenda.www.dto;

import java.io.Serializable;

public class BbsParam implements Serializable{
	private String search;
	private String choice;
	private String startdate;	//시작날짜 
	private String enddate;		//끝날짜 
	
	
	private String area;	// 이미지링크 클릭용 (지역)
	private String category;	// left메뉴에서 카테고리별로 보기용
	private String order;		// left메뉴에서 순위별로 보기용
	
	private int pageNumber;
	
	private int start;
	private int end;
	
	public BbsParam() {
	}

	public BbsParam(String search, String choice, String startdate, String enddate, String area, String category,
			String order, int pageNumber, int start, int end) {
		super();
		this.search = search;
		this.choice = choice;
		this.startdate = startdate;
		this.enddate = enddate;
		this.area = area;
		this.category = category;
		this.order = order;
		this.pageNumber = pageNumber;
		this.start = start;
		this.end = end;
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

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
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

	@Override
	public String toString() {
		return "BbsParam [search=" + search + ", choice=" + choice + ", startdate=" + startdate + ", enddate=" + enddate
				+ ", area=" + area + ", category=" + category + ", order=" + order + ", pageNumber=" + pageNumber
				+ ", start=" + start + ", end=" + end + "]";
	}

}