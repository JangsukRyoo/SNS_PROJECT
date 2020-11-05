package com.tt.sns.model.dto;

public class DmDto {
	private int dm_no;
	private String dm_user_id;
	private String dm_receiver;
	private String dm_status;
	
	public DmDto() {
		super();
	}

	public DmDto(int dm_no, String dm_user_id, String dm_receiver, String dm_status) {
		super();
		this.dm_no = dm_no;
		this.dm_user_id = dm_user_id;
		this.dm_receiver = dm_receiver;
		this.dm_status = dm_status;
	}

	public String getDm_user_id() {
		return dm_user_id;
	}

	public void setDm_user_id(String dm_user_id) {
		this.dm_user_id = dm_user_id;
	}

	public String getDm_receiver() {
		return dm_receiver;
	}

	public void setDm_receiver(String dm_receiver) {
		this.dm_receiver = dm_receiver;
	}


	public int getDm_no() {
		return dm_no;
	}


	public void setDm_no(int dm_no) {
		this.dm_no = dm_no;
	}
	
	


	public String getDm_status() {
		return dm_status;
	}

	public void setDm_status(String dm_status) {
		this.dm_status = dm_status;
	}

	@Override
	public String toString() {
		return "DmDto [dm_no=" + dm_no + ", dm_user_id=" + dm_user_id + ", dm_receiver=" + dm_receiver + ", dm_status="
				+ dm_status + "]";
	}

	
	
	
	
}
