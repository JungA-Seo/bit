package com.flenda.www.dto;

import java.io.Serializable;

public class ThemeSearchDto implements Serializable {

	private String search;
	private String city;
	private String category;
	private String transpor;
	private int minPeople;
	private String soltinglist;
	private int pageNumber;
	
	public ThemeSearchDto() {
		
	}

	public ThemeSearchDto(String search, String city, String category, String transpor, int minPeople,
			String soltinglist, int pageNumber) {
		super();
		this.search = search;
		this.city = city;
		this.category = category;
		this.transpor = transpor;
		this.minPeople = minPeople;
		this.soltinglist = soltinglist;
		this.pageNumber = pageNumber;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getTranspor() {
		return transpor;
	}

	public void setTranspor(String transpor) {
		this.transpor = transpor;
	}

	public int getMinPeople() {
		return minPeople;
	}

	public void setMinPeople(int minPeople) {
		this.minPeople = minPeople;
	}

	public String getSoltinglist() {
		return soltinglist;
	}

	public void setSoltinglist(String soltinglist) {
		this.soltinglist = soltinglist;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	@Override
	public String toString() {
		return "ThemeSearchDto [search=" + search + ", city=" + city + ", category=" + category + ", transpor="
				+ transpor + ", minPeople=" + minPeople + ", soltinglist=" + soltinglist + ", pageNumber=" + pageNumber
				+ "]";
	}
	
	
}