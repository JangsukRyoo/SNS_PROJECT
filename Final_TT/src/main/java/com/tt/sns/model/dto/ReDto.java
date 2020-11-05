package com.tt.sns.model.dto;

public class ReDto {
	private int re_no;
	private String substance;
	private int contentno;
	private String userid;
	private int count;
	private String re_userprofile;
	
	public ReDto() {
		super();
	}

	public ReDto(int re_no, String substance, int contentno, String userid, int count, String re_userprofile) {
		super();
		this.re_no = re_no;
		this.substance = substance;
		this.contentno = contentno;
		this.userid = userid;
		this.count = count;
		this.re_userprofile = re_userprofile;
	}

	public int getRe_no() {
		return re_no;
	}

	public void setRe_no(int re_no) {
		this.re_no = re_no;
	}

	public String getSubstance() {
		return substance;
	}

	public void setSubstance(String substance) {
		this.substance = substance;
	}

	public int getContentno() {
		return contentno;
	}

	public void setContentno(int contentno) {
		this.contentno = contentno;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getRe_userprofile() {
		return re_userprofile;
	}

	public void setRe_userprofile(String re_userprofile) {
		this.re_userprofile = re_userprofile;
	}
	
	
	
	
	
	

}
