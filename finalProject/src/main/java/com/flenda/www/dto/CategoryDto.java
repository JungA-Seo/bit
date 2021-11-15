package com.flenda.www.dto;

public class CategoryDto {
	
	private int cseq;		// 카테고리번호
	private String id;
	private String cname;	// 카테고리이름
	private String cwdate;	// 카테고리등록일
	
	public CategoryDto() {
		
	}

	public CategoryDto(int cseq, String id, String cname, String cwdate) {
		super();
		this.cseq = cseq;
		this.id = id;
		this.cname = cname;
		this.cwdate = cwdate;
	}
	
	

	public CategoryDto(String id, String cname) {
		super();
		this.id = id;
		this.cname = cname;
	}

	public int getCseq() {
		return cseq;
	}

	public void setCseq(int cseq) {
		this.cseq = cseq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getCwdate() {
		return cwdate;
	}

	public void setCwdate(String cwdate) {
		this.cwdate = cwdate;
	}

	@Override
	public String toString() {
		return "CategoryDto [cseq=" + cseq + ", id=" + id + ", cname=" + cname + ", cwdate=" + cwdate + "]";
	}

	
	
	
}
