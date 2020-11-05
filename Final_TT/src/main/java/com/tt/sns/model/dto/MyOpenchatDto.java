package com.tt.sns.model.dto;

public class MyOpenchatDto {
	private String openname;
	private String userid;
	
	public MyOpenchatDto() {
		super();
	}

	public MyOpenchatDto(String openname, String userid) {
		super();
		this.openname = openname;
		this.userid = userid;
	}

	public String getOpenname() {
		return openname;
	}

	public void setOpenname(String openname) {
		this.openname = openname;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	
	
	
	
}
