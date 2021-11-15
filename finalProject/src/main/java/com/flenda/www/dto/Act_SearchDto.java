package com.flenda.www.dto;

import java.io.Serializable;

public class Act_SearchDto implements Serializable{
	private String input;
	private String daterange;
	private String category;
	private String price;
	private String time;
	private String orders;
	
	private String sdate;
	private String edate;
	
	private String sprice;
	private String eprice;
	
	private String stime;
	private String etime;
	
	private int pageNumber;
	
	public Act_SearchDto() {
	}

	public Act_SearchDto(String input, String daterange, String category, String price, String time, String orders,
			int pageNumber) {
		super();
		this.input = input;
		this.daterange = daterange;
		this.category = category;
		this.price = price;
		this.time = time;
		this.orders = orders;
		this.pageNumber = pageNumber;
	}

	public Act_SearchDto(String input, String daterange, String category, String price, String time, String orders,
			String sdate, String edate, String sprice, String eprice, String stime, String etime, int pageNumber) {
		super();
		this.input = input;
		this.daterange = daterange;
		this.category = category;
		this.price = price;
		this.time = time;
		this.orders = orders;
		this.sdate = sdate;
		this.edate = edate;
		this.sprice = sprice;
		this.eprice = eprice;
		this.stime = stime;
		this.etime = etime;
		this.pageNumber = pageNumber;
	}

	public String getInput() {
		return input;
	}

	public void setInput(String input) {
		this.input = input;
	}

	public String getDaterange() {
		return daterange;
	}

	public void setDaterange(String daterange) {
		this.daterange = daterange;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getOrders() {
		return orders;
	}

	public void setOrders(String orders) {
		this.orders = orders;
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

	public String getSprice() {
		return sprice;
	}

	public void setSprice(String sprice) {
		this.sprice = sprice;
	}

	public String getEprice() {
		return eprice;
	}

	public void setEprice(String eprice) {
		this.eprice = eprice;
	}

	public String getStime() {
		return stime;
	}

	public void setStime(String stime) {
		this.stime = stime;
	}

	public String getEtime() {
		return etime;
	}

	public void setEtime(String etime) {
		this.etime = etime;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	@Override
	public String toString() {
		return "Act_SearchDto [input=" + input + ", daterange=" + daterange + ", category=" + category + ", price="
				+ price + ", time=" + time + ", orders=" + orders + ", sdate=" + sdate + ", edate=" + edate
				+ ", sprice=" + sprice + ", eprice=" + eprice + ", stime=" + stime + ", etime=" + etime
				+ ", pageNumber=" + pageNumber + "]";
	}

}
