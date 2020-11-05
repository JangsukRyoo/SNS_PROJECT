package com.tt.sns.model.dto;

public class OpenchatDto {
	private String openname;
	private String openpw;
	private String openlimit;
	
	public OpenchatDto() {
		super();
	}

	public OpenchatDto(String openname, String openpw, String openlimit) {
		super();
		this.openname = openname;
		this.openpw = openpw;
		this.openlimit = openlimit;
	}

	public String getOpenname() {
		return openname;
	}

	public void setOpenname(String openname) {
		this.openname = openname;
	}

	public String getOpenpw() {
		return openpw;
	}

	public void setOpenpw(String openpw) {
		this.openpw = openpw;
	}

	public String getOpenlimit() {
		return openlimit;
	}

	public void setOpenlimit(String openlimit) {
		this.openlimit = openlimit;
	}

	
	
}
